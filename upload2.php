<?php
session_start();

$ruta_raiz = ".";
if (!$_SESSION['dependencia'])
  header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$tpNumRad    = $_SESSION["tpNumRad"];
$tpPerRad    = $_SESSION["tpPerRad"];
$tpDescRad   = $_SESSION["tpDescRad"];
$tip3Nombre  = $_SESSION["tip3Nombre"];
$dependencia = $_SESSION["dependencia"];
$ln          = $_SESSION["digitosDependencia"];
$lnr         = 11+$ln;

    /** * Retorna la cantidad de bytes de una expresion como 7M, 4G u 8K.
     *
     * @param char $var
     * @return numeric
     */
    function return_bytes($val)
    {	$val = trim($val);
        $ultimo = strtolower($val{strlen($val)-1});
        switch($ultimo)
        {	// El modificador 'G' se encuentra disponible desde PHP 5.1.0
            case 'g':	$val *= 1024;
            case 'm':	$val *= 1024;
            case 'k':	$val *= 1024;
        }
        return $val;
    }

    $fechaHoy = Date("Y-m-d");

    include_once("$ruta_raiz/class_control/anexo.php");
    include_once("$ruta_raiz/class_control/anex_tipo.php");

    if (!$db)	$db = new ConnectionHandler($ruta_raiz);
    //$db->conn->debug = true;
    $sqlFechaHoy= $db->conn->OffsetDate(0,$db->conn->sysTimeStamp);
    $anex       = & new Anexo($db);
    $anexTip    = & new Anex_tipo($db);

    if (!$aplinteg)
        $aplinteg='null';
    if (!$tpradic)
        $tpradic='null';
    if(!$cc){
      
      $nuevo = ($codigo)? 'no' : 'si';
      
      $auxsololect = ($sololect)? 'S' : 'N';
        //$db->conn->BeginTrans();
        if($nuevo_archivo==true){
            $auxnumero=$anex->obtenerMaximoNumeroAnexo($numrad);
            do {
              $auxnumero++;
              $codigo = trim($numrad).trim(str_pad($auxnumero,5,"0",STR_PAD_LEFT));
            }while ($anex->existeAnexo($codigo));
        } else {
          $bien = true;
          $auxnumero=substr($codigo,-4);
          $codigo = trim($numrad).trim(str_pad($auxnumero,5,"0",STR_PAD_LEFT));
        }

        $anex_salida = ($radicado_salida)? 1 : 0;

        $bien = "si";
        if ($bien and $tipo){	
            $anexTip->anex_tipo_codigo($tipo);
            
            $ext=$anexTip->get_anex_tipo_ext();
            $ext = strtolower($ext);
            $auxnumero = str_pad($auxnumero,5,"0",STR_PAD_LEFT);
            $archivo=trim($numrad."_".$auxnumero.".".$ext);
            $archivoconversion=trim("1").trim(trim($numrad)."_".trim($auxnumero).".".trim($ext));
        }
    if(!$radicado_rem)
            $radicado_rem=7;
    
    $tamano = ($_FILES['userfile1']['size'])? ($_FILES['userfile1']['size']/1000) : 0;
     
     if ($nuevo_archivo == true) {

        include "$ruta_raiz/include/query/queryUpload2.php";

        $expAnexo = ($expIncluidoAnexo)? $expIncluidoAnexo : null;
        
        if(!$anex_salida && $tpradic) $anex_salida=1;
        
        $isql = "insert
                    into anexos
                        (sgd_rem_destino
                        ,anex_radi_nume
                        ,anex_codigo
                        ,anex_tipo
                        ,anex_tamano   
                        ,anex_solo_lect
                        ,anex_creador
                        ,anex_desc
                        ,anex_numero
                        ,anex_nomb_archivo   
                        ,anex_borrado
                        ,anex_salida 
                        ,sgd_dir_tipo
                        ,anex_depe_creador
                        ,sgd_tpr_codigo
                        ,anex_fech_anex
                        ,SGD_APLI_CODI
                        ,SGD_TRAD_CODIGO
                        ,SGD_EXP_NUMERO)
                     values (
                           $radicado_rem  
                         ,$numrad         
                         ,$codigo    
                         ,$tipo    
                         ,$tamano     
                         ,'$auxsololect'
                         ,'$krd'     
                         ,'$descr' 
                         ,$auxnumero 
                         ,'$archivoconversion'
                         ,'N'         
                         ,$anex_salida
                         ,$radicado_rem
                         ,$dependencia
                         ,0
                         ,$sqlFechaHoy
                         ,$aplinteg    
                         ,$tpradic
                         ,'$expAnexo')";
            $nuevo_archivo = false;
            $subir_archivo = true;
         }else{
          $nuevo_archivo = false;
          $subir_archivo = ($_FILES['userfile1']['size'])? "   anex_nomb_archivo  ='1$archivo'
                                                                   ,anex_tamano       = $tamano
                                                                   ,anex_tipo         = $tipo, " : 0;
          
          $isql = "update 
                anexos set 
                      $subir_archivo 
                      anex_salida=$anex_salida
                    , sgd_rem_destino=$radicado_rem
                    , sgd_dir_tipo=$radicado_rem
                    , anex_desc='$descr'
                    , SGD_TRAD_CODIGO = $tpradic
                    , SGD_APLI_CODI = $aplinteg  
                where 
                    anex_codigo= '$codigo'";
         }
         
        $_POST['subir_archivo'] = $subir_archivo;
        $_POST['nuevo_archivo'] = $nuevo_archivo;
        $_POST['codigo']        = $codigo;
         $bien = $db->conn->query($isql);

        //Si actualizo BD correctamente 
         if ($bien){
             $respUpdate="OK";
             $bien2 = false;
             if ($subir_archivo){	
                 $directorio        = "./bodega/".substr(trim($archivo),0,4)."/".intval(substr(trim($archivo),4,$ln))."/docs/";
                 //echo "directorio ". $directorio ;
                 $userfile1_Temp    = $_FILES['userfile1']['tmp_name'];
                 $bien2             = move_uploaded_file($userfile1_Temp,$directorio.trim(strtolower($archivoconversion)));
                 
                 //Si intento anexar archivo y Subio correctamente
                 if ($bien2){
                    $resp1 = "OK";
                    //$db->conn->CommitTrans();
                 }else{ 
                     $resp1="ERROR";
                   //  $db->conn->RollbackTrans();
                 }
             }else {
                 //$db->conn->CommitTrans();
             }
         }else{
            //$db->conn->RollbackTrans();
         }
    }

    include "nuevo_archivo.php";
?>
