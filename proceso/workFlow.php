<!doctype html>
<?
session_start();
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
	$left = $left + 5;	
	fputs($fp, $dClass);	
 }
 fclose($fp);
?>
<html>
    <head>
		<meta http-equiv="content-type" content="text/html;charset=utf-8" />		
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
		<link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/demo-all.css">
    <link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/demo.css">
    <link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/<?=$nodosCss?>">
    			<SCRIPT LANGUAGE="JavaScript">
			function fnSubmit() {
				window.document.form2.submit();
				return;
			}
			</SCRIPT>      
    </head>
    <body data-demo-id="home" data-library="jquery" >
    <?=$descFldExp?>
		<div class="demo statemachine-demo" id="statemachine-demo">
				<?php
					foreach($nodos as $etapas){
					?>
					<div class="w" style="bgColor:green;" id="nodo<?=$etapas["CODIGO"]?>"><?=$etapas["DESCRIP"]?></div>
				<?php
					}
				?>
		</div>
      <!-- DEP -->

	  <script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jquery-1.9.0.js"></script>
		<script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jquery-ui-1.9.2-min.js"></script>
    <script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jquery.ui.touch-punch.min.js"></script>
		<!-- /DEP -->
	  
    <!-- for demo dropdown. not a jsplumb dependency -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
				
		<!-- JS -->
		<!-- support lib for bezier stuff -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jsBezier-0.6.js"></script>
        <!-- jsplumb geom functions -->   
        <script src="<?=$ruta_raiz ?>/js/jsplumb/lib/jsplumb-geom-0.1.js"></script>
		<!-- jsplumb util -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/util.js"></script>
        <!-- base DOM adapter -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/dom-adapter.js"></script>
		<!-- main jsplumb engine -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/jsPlumb.js"></script>
        <!-- endpoint -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/endpoint.js"></script>
        <!-- connection -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/connection.js"></script>
        <!-- anchors -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/anchors.js"></script>
		<!-- connectors, endpoint and overlays  -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/defaults.js"></script>
        <!-- bezier connectors -->
        <script src="<?=$ruta_raiz ?>/js/jsplumb/src/connectors-bezier.js"></script>
		<!-- state machine connectors -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/connectors-statemachine.js"></script>
		<!-- SVG renderer -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/renderers-svg.js"></script>
		<!-- canvas renderer -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/renderers-canvas.js"></script>
		<!-- vml renderer -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/renderers-vml.js"></script>
        
        <!-- jquery jsPlumb adapter -->
		<script src="<?=$ruta_raiz ?>/js/jsplumb/src/jquery.jsPlumb.js"></script>
		<!-- /JS -->
		<?php
	  include "$ruta_raiz/proceso/jqueryDraw.php";
	  ?>
		<!--  demo code -->
	  <!--<script src="<?=$ruta_raiz ?>/proceso/demo-jquery.js"></script> -->

    <form name=form2 action=<?="workFlow.php?verrad=$verrad&numeroExpediente=$numExpediente&".session_name()."=".session_id() ?> method=POST >
    </form>
    </body>
</html>