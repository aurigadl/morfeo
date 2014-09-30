<?php

session_start();

// Modificado SGD 20-Septiembre-2007

/**

  * Paggina Cuerpo.php que muestra el contenido de las Carpetas

	* Creado en la SSPD en el año 2003

  * 

	* Se añadio compatibilidad con variables globales en Off

  * @autor Jairo Losada 2009-05

  * @licencia GNU/GPL V 3

  */



foreach ($_GET as $key => $valor)   ${$key} = $valor;

foreach ($_POST as $key => $valor)   ${$key} = $valor;

$nomcarpeta=$_GET["nomcarpeta"];

if($_GET["tipo_carp"])  $tipo_carp = $_GET["tipo_carp"];



define('ADODB_ASSOC_CASE', 2);

?>

<html>

<head>

<link rel="stylesheet" href="../estilos/orfeo.css">

</head>

<body bgcolor="#FFFFFF" topmargin="0" >

<form action="qsql.php" method=post>

<?
$isql=str_replace('\"','"',$isql);
$isql=str_replace("\'","'",$isql);
$isql=trim($isql);
?>

<textarea name=isql COLS=60 ROWS=10>



<?=$isql?>

</textarea>

<input type=submit VALUE=ENVIAR>

<?

	if($isql){

	include_once "../include/db/ConnectionHandler.php";

	require_once("../class_control/Mensaje.php");

	if (!$db) $db = new ConnectionHandler("..");

  $db->conn->debug = true;

	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

	$pager = new ADODB_Pager($db,$isql,'adodb', true,$orderNo,$orderTipo);

		$pager->checkAll = false;

		$pager->checkTitulo = true;

		$pager->toRefLinks = $linkPagina;

		$pager->toRefVars = $encabezado;

		$pager->descCarpetasGen=$descCarpetasGen;

		$pager->descCarpetasPer=$descCarpetasPer;

		$pager->Render($rows_per_page=200,$linkPagina,$checkbox=chkAnulados);

	}

	?>

</form>

</body>

</html>
