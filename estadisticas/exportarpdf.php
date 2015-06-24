<?php
session_start();

$ruta_raiz = "..";

include_once "$ruta_raiz/include/db/ConnectionHandler.php";

$db = new ConnectionHandler($ruta_raiz);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);


$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$nomcarpeta = $_GET["carpeta"];
$tipo_carpt = $_GET["tipo_carpt"];

if($_GET["orderNo"]) $orderNo=$_GET["orderNo"];
if($_GET["orderTipo"]) $orderTipo=$_GET["orderTipo"];
if($_GET["dependencia_busq"]) $dependencia_busq=$_GET["dependencia_busq"];
if($_GET["fecha_ini"])    $fecha_ini=$_GET["fecha_ini"];
if($_GET["fecha_fin"])    $fecha_fin=$_GET["fecha_fin"];
if($_GET["codus"])        $codus=$_GET["codus"];
if($_GET["tipoRadicado"]) $tipoRadicado=$_GET["tipoRadicado"];
if($_GET["tipoEstadistica"]) $tipoEstadistica=$_GET["tipoEstadistica"];
if($_GET["codUs"])        $codUs=$_GET["codUs"];
if($_GET["fecSel"])       $fecSel=$_GET["fecSel"];
if($_GET["genDetalle"])   $genDetalle=$_GET["genDetalle"];
if($_GET["generarOrfeo"]) $generarOrfeo=$_GET["generarOrfeo"];
if($_GET["dependencia_busqOri"]) $dependencia_busqOri=$_GET["dependencia_busqOri"];
if($_GET["codserie"]) $codserie=$_GET["codserie"];
if($_GET["tsub"]) $tsub=$_GET["tsub"];

if(!$tipoEstadistica) $tipoEstadistica = $_SESSION["tipoEstadistica"];

switch($tipoEstadistica){
       case "19";
	  include "$ruta_raiz/include/query/estadisticas/consulta019.php";
         break;
}

$queryE = $queryETodosDetalle;
	$rsE = $db->conn->query($queryE);
	include ("tablaHtmlPDF.php");
$ruta_exportar = $tabla_generada;

require_once "$ruta_raiz/dompdf/dompdf_config.inc.php";
                              
$dompdf = new DOMPDF();
//$dompdf->load_html( file_get_contents( "$ruta_exportar") ); /* La ruta donde se encuentra el archivo de presentación */ 
$dompdf->load_html( $ruta_exportar ); /* La ruta donde se encuentra el archivo de presentación */ 
$dompdf->render();
$dompdf->stream("mi_archivo.pdf");


?>
