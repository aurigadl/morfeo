<?
session_start();
if(!$ruta_raiz)$ruta_raiz = "..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
$numeroExpediente = $numExpediente;
/**
* Paggina de modFlujoExp.php
* Por Correlibre.org 2012/01
* Se añadio compatibilidad con variables globales en Off
* @autor Jairo Losada 2012-05
* @licencia GNU/GPL V 3
*/

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

include_once "$ruta_raiz/htmlheader.inc.php";
define('ADODB_ASSOC_CASE', 1);
$verrad         = "";
$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$usua_nomb       = $_SESSION["usua_nomb"];
$codusuario     = $_SESSION["codusuario"];

include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");
require_once    ("$ruta_raiz/class_control/Mensaje.php");
if (!$db) $db = new ConnectionHandler($ruta_raiz);
//$db->conn->debug=true;
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

  if(!$ruta_raiz) $ruta_raiz="..";
 $verradEntra=$verrad;
  include_once($ruta_raiz."/include/tx/Historico.php");
  include_once ("$ruta_raiz/include/tx/Flujo.php");
  include_once ("$ruta_raiz/include/tx/Expediente.php");    
  $objHistorico= new Historico($db);
	
	$expediente = new Expediente($db);
	$expediente->consultaTipoExpediente($numeroExpediente);
	$procAutomatico = $expediente->pAutomatico;
	$descFldExp 	= $expediente->descFldExp;
	//$db->conn->debug = true;
	$texp = $expediente->codigoTipoExp;
	
	$codProceso = $texp;
	$objFlujo = new Flujo($db, $texp, $usua_doc);
	$nodos = $objFlujo->getNodos($texp);
	$aristas = $objFlujo->getAristas($texp);
	//var_dump($aristas);
	$codFld = $objFlujo->actualNodoExpediente($numeroExpediente);
	$objFlujo->depeCodi = $dependencia;
	
	$objFlujo->usuaCodi = $codusuario;
	$arrEtapas = split('-', $flujo);
	
	$kk = $objFlujo->getArista($codProceso, $codFld);
	$frmNombre = $objFlujo->frmNombre;
	$frmLink = $objFlujo->frmLink;
	$frmLinkSelect = $objFlujo->frmLinkSelect;
	
	$frmLink = str_replace("{numeroRadicado}","$numRad", $frmLink);
	$frmLink = str_replace("{numeroExpediente}","$numeroExpediente", $frmLink);
	$frmLink = str_replace("{dependencia}","$dependencia", $frmLink);
	$frmLink = str_replace("{documentoUsuario}","$usua_doc", $frmLink);
	$frmLink = str_replace("{nombreUsuario}","$usua_nomb", $frmLink);
	
	$frmLinkSelect = str_replace("{numeroRadicado}","$numRad", $frmLinkSelect);
	$frmLinkSelect = str_replace("{numeroExpediente}","$numeroExpediente", $frmLinkSelect);
	$frmLinkSelect = str_replace("{dependencia}","$dependencia", $frmLinkSelect);
	$frmLinkSelect = str_replace("{documentoUsuario}","$usua_doc", $frmLinkSelect);
	$frmLinkSelect = str_replace("{nombreUsuario}","$usua_nomb", $frmLinkSelect);

 $nodosCss = "$ruta_raiz/bodega/tmp/nodos_p$texp.css";
 
 $fp = fopen($nodosCss, "w");
 $top=3;
 $left=3;
 foreach($nodos as $etapas){
   
		$dClass =
		"#nodo".$etapas["CODIGO"]." {
		left:".$left."em;
		top:".$top."em;
		}";
	$top = $top + 10;	
	if($left==3)$left = 50;	else $left = 3;
	
	fputs($fp, $dClass);	
 }
 fclose($fp);
?>
		<link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/demo-all.css">
    <link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/demo.css">
    <link rel="stylesheet" href="<?=$nodosCss?>">
    			<SCRIPT LANGUAGE="JavaScript">
			function fnSubmit() {
				window.document.form2.submit();
				return;
			}
			</SCRIPT>      
		<div class="statemachine-demo" id="statemachine-demo">
				<?php
					foreach($nodos as $etapas){
					?>
					<div class="w" style="bgColor:green;" id="nodo<?=$etapas["CODIGO"]?>"><?=$etapas["DESCRIP"]?></div>
				<?php
					}
				?>
		</div>
      <!-- DEP -->

	  <!-- <script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jquery-1.9.0.js"></script>
		<script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jquery-ui-1.9.2-min.js"></script> -->

		<!-- /JS -->
		<?php
	  include "$ruta_raiz/proceso/jqueryDraw.php";
	  ?>
		<!--  demo code -->
	  <!--<script src="<?=$ruta_raiz ?>/proceso/demo-jquery.js"></script> -->