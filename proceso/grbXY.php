<?
session_start();
ini_set('display_errors', '1');
$ruta_raiz = "..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
/**
* Paggina de modFlujoExp.php
* Por Correlibre.org 2012/01
* Se añadio compatibilidad con variables globales en Off
* @autor Jairo Losada 2012-05
* @licencia GNU/GPL V 3
*/

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

define('ADODB_ASSOC_CASE', 1);
$verrad         = "";
$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$usua_nomb       = $_SESSION["usua_nomb"];
$codusuario     = $_SESSION["codusuario"];

$pPosLeft =$_POST["valorLeft"];
$pPosTop = $_POST["valorTop"];
$codigoProceso = $_POST["codigoProceso"];
$codigoNodo = $_POST["codigoNodo"];

include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");

if (!$db) $db = new ConnectionHandler($ruta_raiz);
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	//$db->conn->debug = true;
  include_once ("$ruta_raiz/include/tx/Flujo.php");
  include_once ("$ruta_raiz/include/tx/Proceso.php");
	//$objFlujo = new Flujo($db, $texp, $usua_doc);
	$proceso = new Proceso($db, $texp, $usua_doc);
	
	// var_dump($objProceso);
	//$nodos = $objFlujo->getNodos($codigoProceso);
	//$aristas = $objFlujo->getAristas($codigoProceso);
	
	// var_dump($nodos);
  echo "</center>";
	echo $proceso->modificaNodoPos( $codigoNodo, $codigoProceso, $pPosLeft, $pPosTop );

?>