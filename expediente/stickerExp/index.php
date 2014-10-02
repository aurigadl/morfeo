<?php
session_start();

//ini_set('display_errors',1);
//error_reporting(E_ALL ^ E_NOTICE);

$ruta_raiz 		= "../..";
include_once "$ruta_raiz/config.php";
$verradicado        = $_GET["verrad"];
define('ADODB_ASSOC_CASE', 1);
foreach ($_GET as $key=>$valor) ${$key} = $valor;

$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];
$tip3Nombre     = $_SESSION["tip3Nombre"];
$tip3desc       = $_SESSION["tip3desc"];
$tip3img        = $_SESSION["tip3img"];

include_once "$ruta_raiz/include/db/ConnectionHandler.php";
if ($verradicado) $verrad = $verradicado;

$numrad = $verrad;
$db     = new ConnectionHandler($ruta_raiz);

include $ruta_raiz.'/ver_datosrad.php';
$copias = empty($copias)? 0: $copias;


if('NO DEFINIDO' != $tpdoc_nombreTRD ){
    $process = "Proceso ". $tpdoc_nombreTRD;
}

$entidad_corto=$_SESSION['entidad'];
$noRad = $_REQUEST['nurad'];
$noRadBarras="*$noRad*";
$dirPlantilla=$ruta_raiz.'/conf/stickers/'.$entidad_corto.'.php';
$dirLogo=$ruta_raiz.'/img/'.$entidad_corto.'.jpg';
include ($dirPlantilla);
?>

