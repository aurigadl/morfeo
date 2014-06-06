<?php
  session_start();
  define ('YEAR_INICIO', 0);
  define ('YEAR_LENGTH', 4);
  define ('RADI_LENGTH', 3);
  define ('RADI_INICIO', 4);
  define ('TIPO_TXT',    8);
  define ('APP_NO_INTEGRADA',    0);
  
  $ruta_raiz = '../';
  
  if (!$_SESSION['dependencia'])
    header("Location: $ruta_raiz/cerrar_session.php");
  
  foreach ($_GET as $key => $valor)
    ${$key} = $valor;
  foreach ($_POST as $key => $valor)
    ${$key} = $valor;
  
  $krd         = $_SESSION['krd'];
  $dependencia = $_SESSION['dependencia'];
  $usua_doc    = $_SESSION['usua_doc'];
  $codusuario  = $_SESSION['codusuario'];
  $tpNumRad    = $_SESSION['tpNumRad'];
  $tpPerRad    = $_SESSION['tpPerRad'];
  $tpDescRad   = $_SESSION['tpDescRad'];
  $tip3Nombre  = $_SESSION['tip3Nombre'];
  $dependencia = $_SESSION['dependencia'];
  $ln          = $_SESSION['digitosDependencia'];
  $lnr         = 11 + $ln;
  
  if (isset($radPadre)) {
    $directorio_ano  = substr($radPadre, YEAR_INICIO, YEAR_LENGTH);
    $depe_radi_padre = substr($radPadre, RADI_INICIO, RADI_LENGTH);
  } else {
    var_dump('Error');
    exit();
  }
  
  /** * Retorna la cantidad de bytes de una expresion como 7M, 4G u 8K.
   *
   * @param char $var
   * @return numeric
   */
  function return_bytes($val) {
    $val    = trim($val);
    $ultimo = strtolower($val{strlen($val) - 1});
    switch ($ultimo) {
      // El modificador 'G' se encuentra disponible desde PHP 5.1.0
      case 'g':
        $val *= 1024;
      case 'm':
        $val *= 1024;
      case 'k':
        $val *= 1024;
    }
    return $val;
  }
  
  $fechaHoy = Date('Y-m-d');
  
  include_once($ruta_raiz . '/class_control/anexo.php');
  include_once($ruta_raiz . '/class_control/anex_tipo.php');
  
  if (!$db)
    $db = new ConnectionHandler($ruta_raiz);
  
  $sqlFechaHoy = $db->conn->OffsetDate(0, $db->conn->sysTimeStamp);
  
  $anex =& new Anexo($db);
  $anexTip =& new Anex_tipo($db);
  
  if (!$tpradic)
    $tpradic = 'null';
  
  $codigo = (empty($anexo))? null : $anexo;
  
  $nuevo = ($codigo)? 'no' : 'si';
  // Si es nuevo busque el ultimo anexo para asignar el codigo de radicacion
  if ($nuevo == "si") {
    $auxnumero = $anex->obtenerMaximoNumeroAnexo($radPadre);
    
    // Busca el ultimo radicado
    do {
      $auxnumero += 1;
      $codigo = trim($numrad) . trim(str_pad($auxnumero, 5, "0", STR_PAD_LEFT));
    } while ($anex->existeAnexo($codigo));
  } else {
    $bien      = true;
    $auxnumero = substr($codigo, -4);
    $codigo    = trim($numrad) . trim(str_pad($auxnumero, 5, "0", STR_PAD_LEFT));
  }
  
  $anex_salida = ($radicado_salida) ? 1 : 0;
  
  $bien = 'si';
  
  if ($bien and $tipo) {
    $anexTip->anex_tipo_codigo($tipo);
    $ext               = $anexTip->get_anex_tipo_ext();
    $ext               = strtolower($ext);
    $auxnumero         = str_pad($auxnumero, 5, "0", STR_PAD_LEFT);
    $archivo           = trim($numrad . "_" . $auxnumero . "." . $ext);
    $archivoconversion = trim("1") . trim(trim($numrad) . "_" . trim($auxnumero) . "." . trim($ext));
  }
  
  $numero_anexo = $radPadre . $codigo;
  
  if (!$radicado_rem) $radicado_rem = 7;
  
  $directorio     = '../bodega/' . $directorio_ano . '/' . $depe_radi_padre . '/docs/';
  $archivo_final  = $numero_anexo . '.txt';
  $archivo_grabar = $directorio . $archivo_final;
  $file_content   = fopen($archivo_grabar, 'w');
  $write_result   = fwrite($file_content, $respuesta);
  $closing_result = fclose($file_content);
  $tamano         = filesize($archivo_grabar);
  $tamano         = return_bytes($tamano);
  $descr          = 'Pdf Respuesta';
  
  $anex_salida = 1;
  $tabla_anexos = 'anexos';
  $anexo_record['sgd_rem_destino']  = $radicado_rem;
  $anexo_record['anex_radi_nume']   = $radPadre;
  $anexo_record['anex_codigo']      = $numero_anexo;
  $anexo_record['anex_tipo']        = TIPO_TXT;
  $anexo_record['anex_tamano']      = $tamano;
  $anexo_record['anex_solo_lect']   = "'$auxsololect'";
  $anexo_record['anex_creador']     = "'$krd'";
  $anexo_record['anex_desc']        = "'$descr'";
  $anexo_record['anex_numero']      = $auxnumero;
  $anexo_record['anex_nomb_archivo']= "'$archivo_final'";
  $anexo_record['anex_borrado']     = "'N'";
  $anexo_record['anex_salida']      = $anex_salida;
  $anexo_record['sgd_dir_tipo']     = $radicado_rem;
  $anexo_record['anex_depe_creador']= $dependencia;
  $anexo_record['sgd_tpr_codigo']   = 0;
  $anexo_record['anex_fech_anex']   = $sqlFechaHoy;
  $anexo_record['sgd_apli_codi']    = APP_NO_INTEGRADA;
  $anexo_record['sgd_trad_codigo']  = $tpradic;
  $anexo_record['sgd_exp_numero']   = "'$expAnexo'";
  $filtro = "anex_radi_nume = '$numero_anexo'";
  
  $numero_campos = count($anexo_record);
  $i = 0;
  
  $sql_insert = 'INSERT into ' . $tabla_anexos . ' (';
  $sql_update = 'UPDATE '  . $tabla_anexos . ' set ';
  $sql_values = 'VALUES (';
  
  foreach ($anexo_record as $campo => $valor) {
    $i++;

    $sql_insert .= ($i != $numero_campos) ? $campo . ', ' : $campo . ') ';
    $sql_update .= ($i != $numero_campos) ? $campo . '=' . $valor . ', ' : $campo . '=' . $valor . ' ';
    $sql_values .= ($i != $numero_campos) ? $valor . ', ' : $valor . ')';
  }
  
  $sql_insert .= $sql_values;
  $sql_update .= 'WHERE ' . $filtro;
  
  // Si es nuevo insertar de otra forma actualizar.
  $result = ($nuevo == 'si')? $db->conn->Execute($sql_insert) : $db->conn->Execute($sql_update);
  
  $enviar_editar = "index.php?PHPSESSID=" . session_id() .
                    "&radicadopadre=" . $radicadopadre .
                    "&krd=" . $krd .
                    "&editar=" . $editar .
                    "&anexo=" . $anexo;
  
  if ($result && $nuevo == 'no') {
    echo 'Actualizo';
  }
?>
