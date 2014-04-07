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
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
?>
<html>
<head><title>..:: Cambio de Estado de un Proceso / Procedimiento ::..</title></head>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<script>
function verificaModificacion(){
  var modificado = document.modFlujoExp.estadoModificado2.value;
  if( modificado == '1'){
  <?php 
  if ( $grabarFlujo  ) {
  ?>
   alert("El cambio se ejecuto con exito." );
   opener.regresar(); 
	window.close();
	<?php 
	} 
	?>
	}else{
		<?php 
	if ( $grabarFlujo  ) {
	?>
		alert("No se pudo realizar el cambio de etapa, por favor verifique datos." );
		opener.regresar(); 
		window.close();
	<?php 
} 
 ?>
   }
}
</script>
<?
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
	//$db->conn->debug = true;
	$codProceso = $texp;
	$objFlujo = new Flujo($db, $texp, $usua_doc);
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


?>
<body onload="verificaModificacion()">
<CENTER>
<form name=modFlujoExp  method='post' action='modFlujoExp.php?<?=session_name()?>=<?=trim(session_id())?>&numeroExpediente=<?=$numeroExpediente?>&krd=<?=$krd?>&texp=<?=$texp?>&numRad=<?=$numRad?>&<?="&mostrar_opc_envio=$mostrar_opc_envio&nomcarpeta=$nomcarpeta&carpeta=$carpeta&leido=$leido"?>'>
<table border=0 width 100% class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox">
  <input type=hidden name=ver_flujo value="Si ver fLUJO">
  <input type=hidden name=nomcarpeta value="<?=$nomcarpeta?>">
  <tr> 
    <td class="titulos2"> Estado Actual
	 </td>
      <TD width="323" ><?=$descFldExp?>
      </td>
  </tr>
  <tr> 
    <td class="titulos2"> Etapa(s) Siguiente(s)
	 </td>
      <TD width="323" >
        <?
 	
	
	
	//var_dump($arrEtapas);
	$expEstadoActual = ($_GET['codigoFldExp'] != null) ? $_GET['codigoFldExp'] : $arrEtapas[0];
	
	$arrayAristas =$objFlujo->aristasSiguiente($expEstadoActual);
	$fldCodigos = "999999, ";
	$arrayNodos = $objFlujo->nodosSig;
	if($procAutomatico)
	{
	$k = 0;
	if($arrayNodos)
	{
	?>
	<label class="select">
	<select name="flujo"  class="select"><?
	
		foreach ($arrayNodos as $value){
			$fldCodigos .= "$value ,";
			$aristaS = $arrayAristas[$k];
			$whereFlujos = " and SGD_FEXP_CODIGO in ($fldCodigos 999999)";
			if($procAutomatico==1)
			{
			$isql = "select * FROM SGD_FEXP_FLUJOEXPEDIENTES 
					where SGD_PEXP_CODIGO='$texp'  
					 and SGD_FEXP_CODIGO in ($value)
					 ORDER BY 	SGD_FEXP_ORDEN";	
			}else 
			{
			$isql = "select * FROM SGD_FEXP_FLUJOEXPEDIENTES 
					where SGD_PEXP_CODIGO='$texp'  
					 ORDER BY 	SGD_FEXP_ORDEN";		
			}
			
			$rs=$db->query($isql);
			$nombre_flujo = $rs->fields["SGD_FEXP_DESCRIP"];
			$ordenFlujo = $rs->fields["SGD_FEXP_ORDEN"];
			$terminoFlujo = $rs->fields["SGD_FEXP_TERMINOS"];
			if($codigo_flujo==$codigoFldExp) 
			{
				$datoss = " selected ";
			}
			else
			{
				$datoss = " ";
			}
			?>
			<option value=<?=$value?>-<?=$aristaS?>  <?=$datoss?>> <?=$ordenFlujo?> - <?=$nombre_flujo?> -><?=$terminosFlujo?> </option>
			<?
			$k++;
		}
	?>
	</select>
  </label>
<?
			$grabarDisabled = 'visibility:visible';
	}else { //No hay mas etapas en el proceso
		echo "<SPAN class=leidos>El proceso no tiene m&aacute;s etapas, por lo tanto no se puede hacer ning&uacute;n cambio.</span>";
			$grabarDisabled = 'visibility:hidden';		
	}
	}else 
	{
		$concatCodigoFlujo = $db->conn->Concat("SGD_FEXP_CODIGO","'-000'");
		$isql = "Select SGD_FEXP_DESCRIP, $concatCodigoFlujo
				  FROM SGD_FEXP_FLUJOEXPEDIENTES 
				  Where SGD_PEXP_CODIGO='$texp'  
					 ORDER BY 	SGD_FEXP_ORDEN";
		$rs=$db->query($isql);
		if($rs){
			print $rs->GetMenu2("flujo", "$flujo", "0:-- Seleccione --", false,"","class='select'");
			$grabarDisabled = 'visibility:visible';
			
	
			
		}else {
			echo "<SPAN class=leidos>El proceso no tiene m&aacute;s etapas.</span>";
			$grabarDisabled = 'visibility:hidden';
			
		}
	}
if(!$modificar)
{
}
else 
{
	echo "<SPAN class=leidos>No puede cambiar el Estado del Expediente.</span>";
}
if($grabarFlujo)
{
  /**  INTENTA ACTUALIZAR LA CAUSAL 
    *  Si esta no esta entonces simplemente le insertef
	*/
  if(!$ddca_causal) 
  	$ddca_causal=0;
		
	if(!$deta_causal) 
	
	$objFlujo = new Flujo($db, $texp,$usua_doc);
       $objFlujo->depeCodi = $dependencia;
        $objFlujo->usuaCodi = $codusuario;

	list ($estadoNuevo, $aristaActual) = split('-', $flujo);
	
	
	$expEstadoActual = $objFlujo->actualNodoExpediente($numeroExpediente);
	$observa .= " ($flujo_nombre)";
	$estadoModificado = $objFlujo->cambioNodoExpediente($numeroExpediente,$numRad,$estadoNuevo,$aristaActual,0,"Cambio Manual. ($flujo_nombre)",$_GET['texp']);
	echo "<input type='hidden' value='$estadoModificado' name='estadoModificado2'>";
   }
   ?>
      </td>
  </tr>
	<TR ><TD width="100%" colspan=2>
				
	        <label class="textarea">
					<i class="icon-append fa fa-comment"></i>
					<textarea name="observa" rows="4"></textarea>
					</label>
			</TD></TR>

  </td></tr>
	<tr><TD colspan=2 align=center>
	<input type=submit name=grabarFlujo value='Grabar Cambio' class='btn btn-primary btn-xs' style="<?=$grabarDisabled?>">
	<input name="cerrar" type="button" class="btn btn-primary btn-xs" id="envia22" onClick="opener.regresar(); window.close();" value=" Cerrar ">

	</TD></tr>
</table>
</form>
<?PHP
if(trim($frmNombre)<>""){
?>
<table class="table-bordered table-striped  table-hover smart-form has-tickbox" width="90%">
<tr>
<td><?=$frmNombre ?></td>
<td><a href='<?=$frmLink ?>' target='frmFrame'><?=$frmNombre ?></a></td>
<td><a href='<?=$frmLinkSelect ?>' target='frmFrame'>Listado</a></td>
</tr>
<tr><td colspan=3>
  <center>
   <iframe src='<?=$frmLink ?>' width=95% height='800' name=frmFrame> </iframe>
  </center>
</td></tr>
</table>
<?php
}
?>
</CENTER>

</body>
</html>
