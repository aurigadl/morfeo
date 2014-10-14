<?php
session_start();
ini_set('display_errors',1);
error_reporting(E_ALL ^ E_NOTICE);

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

$copias = empty($copias)? 0: $copias;


if('NO DEFINIDO' != $tpdoc_nombreTRD ){
    $process = "Proceso ". $tpdoc_nombreTRD;
}
$numExp=$_GET['numExp'];
$entidad_corto=$_SESSION['entidad'];
$entidad_corto="CRA";
$noRad = $_REQUEST['nurad'];
$noRadBarras="*$noRad*";
$dirPlantilla=$ruta_raiz.'/conf/stickers/expedientes/'.$entidad_corto.'.php';
$dirLogo=$ruta_raiz.'/img/'.$entidad_corto.'.jpg';
	include_once ("$ruta_raiz/include/tx/Expediente.php");
	$trdExp 	= new Expediente($db);
	$mrdCodigo 	= $trdExp->consultaTipoExpediente($numExp);
	$serie=utf8_decode($trdExp->descSerie);
	$subSerie=utf8_decode($trdExp->descSubSerie);
	$isql="select count(radi_nume_folio) from radicado where radi_nume_radi in (select radi_nume_radi from sgd_exp_expediente where sgd_exp_numero='2014900069900004E')";
	$rs=$db->conn->Execute($isql);
	$numFoliosExp=$rs->fields["COUNT"];
include ($dirPlantilla);

?>

