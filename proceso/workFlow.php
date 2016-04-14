<?
if(!$ruta_raiz){
session_start();
 $ruta_raiz="..";
 
if (!$_SESSION['dependencia'])
header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
define('ADODB_ASSOC_CASE', 1);
$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];

  include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");
	if (!$db) $db = new ConnectionHandler($ruta_raiz);
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	
	include_once "$ruta_raiz/htmlheader.inc.php";
}
if(!$numeroExpediente) $numeroExpediente = $numExpediente;



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
 $top=30;
 $left=30;
 foreach($nodos as $etapas){
    if($etapas["POSLEFT"]){
     $posL = explode(".",str_replace("px","",$etapas["POSLEFT"]));
     $posLeft = $posL[0];
     $posT = explode(".",str_replace("px","",$etapas["POSTOP"]));
     $posTop = $posT[0];
     
    }else{
     $posLeft = $left;
     $posTop = $top;
    }
		$dClass =
		"#nodo".$etapas["CODIGO"]." {
		  left:".$posLeft."px;
		  top:".$posTop."px;
		}\n";
	$top = $top + 100;	
	if($left==30)$left = 550;	else $left = 30;
	
	fputs($fp, $dClass);	
 }
 fclose($fp);
?>
<link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/demo-all.css">
<link rel="stylesheet" href="<?=$ruta_raiz ?>/proceso/demo.css">
<link rel="stylesheet" href="<?=$nodosCss?>">
<div class="statemachine-demo" id="statemachine-demo" style="height:100%" >
<span id="resultado"></span>
	<?php
		foreach($nodos as $etapas){
		if($etapas["CODIGO"]==$codFld) {
		   $datoss = "<br>(Aqui va el proceso)"; 
		   $classNodo = "w wActual";
		}else{ 
		   $datoss = "";
		   $classNodo = "w";
		}
		?>
			<div class="<?=$classNodo?>" id="nodo<?=$etapas["CODIGO"]?>"><?=$etapas["DESCRIP"]?><?=$datoss?></div>
		<?
		}
		?>

</div>

			    <?php
						include "$ruta_raiz/proceso/jqueryDraw.php";
						?>
