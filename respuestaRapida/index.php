<?php
session_start();
//error_reporting(E_ALL);
//ini_set('display_errors', '1');

$ruta_raiz = "..";
if (!$_SESSION['dependencia'])
    header ("Location: ".$ruta_raiz."/cerrar_session.php");

$ruta_libs = "../respuestaRapida/";

define('SMARTY_DIR', $ruta_libs.'libs/');
require (SMARTY_DIR.'Smarty.class.php');
require_once 'libs/htmlpurifier/HTMLPurifier.auto.php';

//formato para fecha en documentos
function fechaFormateada($FechaStamp){
  $ano      = date('Y', $FechaStamp); //<-- Ano
  $mes      = date('m', $FechaStamp); //<-- número de mes (01-31)
  $dia      = date('d', $FechaStamp); //<-- Día del mes (1-31)
  $dialetra = date('w', $FechaStamp); //Día de la semana(0-7)

  switch ($dialetra) {
  case 0 :
    $dialetra = "domingo";
    break;
  case 1 :
    $dialetra = "lunes";
    break;
  case 2 :
    $dialetra = "martes";
    break;
  case 3 :
    $dialetra = "miércoles";
    break;
  case 4 :
    $dialetra = "jueves";
    break;
  case 5 :
    $dialetra = "viernes";
    break;
  case 6 :
    $dialetra = "Sábado";
    break;
  }

  switch ($mes) {
  case '01' :
    $mesletra = "enero";
    break;
  case '02' :
    $mesletra = "febrero";
    break;
  case '03' :
    $mesletra = "marzo";
    break;
  case '04' :
    $mesletra = "abril";
    break;
  case '05' :
    $mesletra = "mayo";
    break;
  case '06' :
    $mesletra = "junio";
    break;
  case '07' :
    $mesletra = "julio";
    break;
  case '08' :
    $mesletra = "agosto";
    break;
  case '09' :
    $mesletra = "septiembre";
    break;
  case '10' :
    $mesletra = "octubre";
    break;
  case '11' :
    $mesletra = "noviembre";
    break;
  case '12' :
    $mesletra = "diciembre";
    break;
  }

  return htmlentities("$dialetra, $dia de $mesletra de $ano");
}

// Include the CKEditor class
include_once "$ruta_raiz/ckeditor/ckeditor_php5.php";

// Create a class instance.
$CKEditor = new CKEditor();

// Path to the CKEditor directory.
$CKEditor->basePath = $ruta_raiz."/ckeditor/";

$smarty = new Smarty;
$smarty->template_dir = './templates';
$smarty->compile_dir = './templates_c';
$smarty->config_dir = './configs/';
$smarty->cache_dir = './cache/';

$smarty->left_delimiter = '<!--{';
$smarty->right_delimiter = '}-->';


function byteSize($bytes) {
  $size = $bytes / 1024;
  if($size < 1024){
    $size = number_format($size, 2);
    $size .= ' KB';
  }
  else
  {
    if($size / 1024 < 1024)
    {
      $size = number_format($size / 1024, 2);
      $size .= ' MB';
    }
    else if ($size / 1024 / 1024 < 1024)
    {
      $size = number_format($size / 1024 / 1024, 2);
      $size .= ' GB';
    }
  }
  return $size;
}

if (isset($_SESSION["krd"]))
  $krd = $_SESSION["krd"];
else
  $krd = "";
if (isset($_GET["radicadopadre"])){
  $radicado = $_GET["radicadopadre"];
  //Necesario para procesar plantillas
  $_SESSION["radicaResLinea"] = $radicado;
}else{
  $radicado = $_SESSION["radicaResLinea"];
}

include_once ($ruta_raiz."/include/db/ConnectionHandler.php");

$db = new ConnectionHandler("$ruta_raiz");
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
//$db->conn->debug = true;
define('ADODB_ASSOC_CASE', 1);
$verrad         = "";
$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];
$encabezado   = session_name()."=".session_id();
$encabezado .= "&krd= $krd";

$isql   = "
  SELECT
  USUA_EMAIL,
  USUA_EMAIL_1,
  USUA_EMAIL_2,
  DEPE_CODI,
  USUA_CODI,
  USUA_NOMB,
  USUA_LOGIN,
  USUA_DOC
  FROM
  USUARIO
  WHERE
  USUA_LOGIN ='$krd' ";

$rs   = $db->conn->Execute($isql);
if (!$rs){
  echo "ERROR, datos invalidos";
  exit(0);
}


$emails = array();
while (!$rs->EOF) {

  $emails[] = trim(strtolower($rs->fields["USUA_EMAIL"]));
  $temEmail = trim(strtolower($rs->fields["USUA_EMAIL_1"]));
  $temEmai  = trim(strtolower($rs->fields["USUA_EMAIL_2"]));
  //buscamos el correo que inicie con web para colocarlo como primero
  if(substr($temEmail, 0, 3)== 'web'){
    array_unshift($emails, $temEmail);
  }else{
    $emails[] = $temEmail;
  }

  if(substr($temEmai, 0, 3)== 'web'){
    array_unshift($emails, $temEmai);
  }else{
    $emails[] = $temEmai;
  }

  $usuacodi  = $rs->fields["USUA_CODI"];
  $depecodi  = $rs->fields["DEPE_CODI"];
  $usuanomb  = $rs->fields["USUA_NOMB"];
  $usualog   = $rs->fields["USUA_LOGIN"];
  $codigoCiu = $rs->fields["USUA_DOC"];
  $rs->MoveNext();
}
//Eliminamos los campos vacios en el array
$emails   =  array_filter($emails);

# informacion remitente
$name  = "";
$email = "";

$isql  = "SELECT D.* FROM SGD_DIR_DRECCIONES D
  WHERE D.RADI_NUME_RADI = $radicado";
$rs = $db->conn->Execute($isql);

$name       = $rs->fields["SGD_DIR_NOMREMDES"];
$email      = $rs->fields["SGD_DIR_MAIL"];
$municicodi = $rs->fields["MUNI_CODI"];
$depecodi2  = $rs->fields["DPTO_CODI"];

$name     = strtoupper($name);
$depcNomb = strtoupper($depcNomb);
$fecha1   = time();
$fecha    = ucfirst(fechaFormateada($fecha1));

$asunto = "<p><strong>Bogota, $fecha</strong>".
  "<br/><br/><br/>".
  "Se&ntilde;or(a)<br/>".
  "<strong>".
  "$name</strong><br/>"
  .$email."<br/><br/><br/></p>";

$asunto = "<strong>Bogota, $fecha</strong><br /><br /><br />Se&ntilde;or(a)<br /><strong>$name</strong><br />$email<br /><br />";

$sqlD = " SELECT
  a.MUNI_NOMB,
  b.DPTO_NOMB
  FROM
  MUNICIPIO a, DEPARTAMENTO b
  WHERE (a.ID_PAIS = 170)
  AND (a.ID_CONT = 1)
  AND (a.DPTO_CODI = $depecodi2)
  AND (a.MUNI_CODI = $municicodi)
  AND (a.DPTO_CODI=b.DPTO_CODI)
  AND (a.ID_PAIS=b.ID_PAIS)
  AND (a.ID_CONT=b.ID_CONT)";

$descripMuniDep = $db->conn->Execute($sqlD);
$depcNomb       = $descripMuniDep->fields["MUNI_NOMB"];
$muniNomb       = $descripMuniDep->fields["DPTO_NOMB"];

$destinatario   = trim($email);

$sql1     = " select
  anex_tipo_ext as ext
  from
  anexos_tipo";

$exte = $db->conn->Execute($sql1);

while(!$exte->EOF){
  $val  = $exte->fields["EXT"];
  $extn .= empty($extn)? $val : "|".$val;
  //arreglo para validar la extension
  $exte->MoveNext();
};

$sqlSubstDesc =  $db->conn->substr."(anex_desc, 0, 50)";

//adjuntar  la imagen html al radicado
$desti = "
  SELECT
  RADI_PATH
  FROM
  RADICADO
  WHERE
  RADI_NUME_RADI = $radicado";

$rssPatth    = $db->conn->Execute($desti);
$pathPadre   = $rssPatth->fields["RADI_PATH"];

$post        = strpos(strtolower($pathPadre),'bodega');
$pathPadre   = substr($pathPadre,$post + 6);
$rutaPadre   = trim($ruta_raiz.'/bodega/'.$pathPadre);

if(is_file($rutaPadre)
  and substr($rutaPadre, -4) == "html" )
{
  $gestor     = fopen($rutaPadre, "r");
  $archtml    = fread($gestor, filesize($rutaPadre));

  $archtml    = preg_replace('/<img (.+?)>/', ' ',$archtml);
  $archtml    = preg_replace('COLOR: red;', ' ',$archtml);
  $config     = HTMLPurifier_Config::createDefault();
  $purifier   = new HTMLPurifier();
  $clean_html = $purifier->purify($archtml);

  $asunto .= "<br><br><hr><br>
  $clean_html" ;
}

//Plantillas guardadas
$perPlanilla = 3;//$_SESSION["usua_perm_resplantilla"];

if($perPlanilla > 2){
  $permPlnatill[] = array("nombre" => "Generales"   , "codigo" => 3 );
}

if ($perPlanilla > 1) {
  $permPlnatill[] = array("nombre" => "Dependencia" , "codigo" => 2);
}

$permPlnatill[]   = array("nombre" => "Personales"  , "codigo" => 1);

 $sql21       ="SELECT
                      ID,
                      PLAN_PLANTILLA,
                      PLAN_NOMBRE,
                      PLAN_FECHA,
                      DEPE_CODI,
                      USUA_CODI,
                      PLAN_TIPO
                    FROM
                      SGD_PLAN_PLANTILLAS";
$db->conn->debug = true;
$plant = $db->conn->Execute($sql21);

while(!$plant->EOF){

  $grupDepende    = array();
  $grupGeneral    = array();
  $grupPersonal   = array();

  $plan_id        = $plant->fields["ID"];
  $plan_nombre    = $plant->fields["PLAN_NOMBRE"];
  $plan_fecha     = $plant->fields["PLAN_FECHA"];
  $plan_tipo      = $plant->fields["PLAN_TIPO"];
  $plan_depend    = $plant->fields["DEPE_CODI"];
  $plan_usurio    = $plant->fields["USUA_CODI"];
  $plan_plantilla = $plant->fields["PLAN_PLANTILLA"];

  $plan_plantilla = str_replace('"', "'", $plan_plantilla);
  $plan_plantilla = str_replace("\r", '' , $plan_plantilla);
  $plan_plantilla = str_replace("\n", '' , $plan_plantilla);
  $plan_plantilla = str_replace("\t", '' , $plan_plantilla);
  include "combinaCampos.php";

  if($plan_tipo == 3){
    $showInput = ($perPlanilla >= $plan_tipo)? true : false;
    $carpetas['Generales'][] = array("id"=> $plan_id, "nombre"=> $plan_nombre , "ruta"=> $plan_plantilla, "show"=> $showInput);
  }elseif ($plan_tipo == 2 and $plan_depend == $depecodi) {
    $showInput = ($perPlanilla >= $plan_tipo)? true : false;
    $carpetas['Dependencia'][] = array("id"=> $plan_id, "nombre"=> $plan_nombre , "ruta"=> $plan_plantilla, "show"=> $showInput);
  }elseif ($plan_tipo == 1 and $plan_depend == $depecodi and$plan_usurio == $usuacodi) {
    $carpetas['Personales'][] = array("id"=> $plan_id, "nombre"=> $plan_nombre , "ruta"=> $plan_plantilla, "show"=> true);
  }
  $plant->MoveNext();

};

$smarty->assign("sid"              , SID); //Envio de session por get
$smarty->assign("usuacodi"         , $usuacodi);
$smarty->assign("extn"             , $extn);
$smarty->assign("depecodi"         , $depecodi);
$smarty->assign("codigoCiu"        , $codigoCiu);
$smarty->assign("radPadre"         , $radicado);
$smarty->assign("rutaPadre"        , $rutaPadre);
$smarty->assign("usuanomb"         , $usuanomb);
$smarty->assign("usualog"          , $usualog);
$smarty->assign("destinatario"     , $destinatario);
$smarty->assign("asunto"           , $asunto);
$smarty->assign("emails"           , $emails);
$smarty->assign("carpetas"         , $carpetas);
$smarty->assign("perm_carps"       , $permPlnatill);
$smarty->display('index.tpl');

// Replace a textarea element with an id (or name) of "textarea_id".
$CKEditor->config['height'] = 575;
$CKEditor->replace("texrich");
?>
