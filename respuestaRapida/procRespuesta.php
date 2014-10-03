<?php

echo "estoy guardando como anexo"; exit;
    session_start();

    define('ARCHIVO_PDF', 7);
    define('NO_DEFINIDO', 0);
    define('ADODB_ASSOC_CASE', 0);
    define('NO_SELECCIONO', 0);
    define('SMARTY_DIR', $ruta_libs . 'libs/');

    foreach ($_POST as $key => $valor)   ${$key} = $valor;
    
    if($_SESSION["krd"])
      $krd = $_SESSION["krd"];

    $ruta_raiz = "..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
    
    $encabe = session_name()."=".session_id()."&krd=$krd";
    $enviar_error = $encabe . 
                    '&radicado=' . $radPadre . 
                    '&radicadopadre' . $radPadre . 
                    '&asunto=' . $asunto .
                    '&error_radicacion=1';
    
    $selecciono_rad = $tipo_radicado != NO_SELECCIONO;
    
    // Si no Selecciono tipo de radicado enviarlo a formulario inicial
    if ($selecciono_rad) {
      $tipo_radicado = $_POST['tipo_radicado'];
    } else {
      $redireccionar = 'Location: index.php?' . $enviar_error;
      header($redireccionar);
      exit();
    }

    // envio de respuesta via email
    // Obtiene los datos de la respuesta rapida.
    $ruta_libs = $ruta_raiz."/respuestaRapida/";
    $fecharad = date("Y-m-d h:i");
    
    //formato para fecha en documentos
    function fechaFormateada($FechaStamp){
        $ano = date('Y', $FechaStamp); //<-- Ano
        $mes = date('m', $FechaStamp); //<-- número de mes (01-31)
        $dia = date('d', $FechaStamp); //<-- Día del mes (1-31)
        $dialetra = date('w', $FechaStamp); //Día de la semana(0-7)
          
        $arreglo_dias = array();
        $arreglo_dias[] = 'domingo';
        $arreglo_dias[] = 'lunes';
        $arreglo_dias[] = 'martes';
        $arreglo_dias[] = 'miercoles';
        $arreglo_dias[] = 'jueves';
        $arreglo_dias[] = 'viernes';
        $arreglo_dias[] = 'sabado';
        
        $dialetra = (isset($arreglo_dias[$dialetra]))? $arreglo_dias[$dialetra] : null;

        $arreglo_meses['01'] = 'enero';
        $arreglo_meses['02'] = 'febrero';
        $arreglo_meses['03'] = 'marzo';
        $arreglo_meses['04'] = 'abril';
        $arreglo_meses['05'] = 'mayo';
        $arreglo_meses['06'] = 'junio';
        $arreglo_meses['07'] = 'julio';
        $arreglo_meses['08'] = 'agosto';
        $arreglo_meses['09'] = 'septiembre';
        $arreglo_meses['10'] = 'octubre';
        $arreglo_meses['11'] = 'noviembre';
        $arreglo_meses['12'] = 'diciembre';

        $mesletra = (isset($arreglo_meses[$mes]))? $arreglo_meses[$mes] : null;

        return htmlentities("$dialetra, $dia de $mesletra de $ano");
    }


    $pos = strpos('salidaRespuesta',$_SERVER['HTTP_REFERER']);

    if ($pos !== false){
      header("Location: index.php?$encabe");
    }

    // Si no es nuevo radique el anexo
    if (!$editar) {
      require './radicar_respuesta.php';
    } else {
      require './radicar_anexo.php';
    }
    
    header("Location: salidaRespuesta.php?$encabe&nurad=$nurad".$errores);
?>
