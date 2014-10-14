<table border=0 width="100%">
	<tr><td width=140>
			<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">Expediente <b class="caret"></b> </a>
			<ul class="dropdown-menu">
				<li>
					<a href="#" onClick="insertarExpediente();">Incluir en...</a>
				</li>
				<li>
					<a href="#" onClick="excluirExpediente();">Excluir de...</a>
				</li>
				<li>
					<a href="#">Sticker Expediente<?=$numExpediente?></a>
				</li>
				<li>
					<a href="#" onClick="verTipoExpediente('<?=$num_expediente?>',<?=$codserie?>,<?=$tsub?>,<?=$tdoc?>,'MODIFICAR');">Crear Nuevo Expediente</a>
				</li>
				<li>
					<a href="#" onClick="Responsable('<?=$num_expediente?>');">Cambiar Responsable</a>
				</li>
				<li>
					<a href="#" onClick="CambiarE(2,'<?=$num_expediente?>');">Cerrar Expediente</a>
				</li>
				<li>
					<a href="#" onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
				</li>
			</ul>
    </td>
    <td width=300>

    <?=$num_expediente?>
    <input name="num_expediente" type="hidden" size="30" maxlength="18" id='num_expediente' value="<?=$num_expediente?>" class="tex_area" >
     Cod :   <? echo $param1;?>
     Responsable:  <? echo $responsable;?>
     </td>
	<?

  ?>
    <input type="hidden" name='funExpediente' id='funExpediente' value="" >
    <input type="hidden" name='menu_ver_tmp' id='menu_ver_tmp' value="4" >
<?
	// CONSULTA SI EL EXPEDIENTE TIENE UNA CLASIFICACION TRD

	error_reporting(7);
	$codserie = "";
	$tsub = "";
	include_once ("$ruta_raiz/include/tx/Expediente.php");
	$trdExp 	= new Expediente($db);

	$mrdCodigo 	= $trdExp->consultaTipoExpediente("$numExpediente");
	$trdExpediente 	= $trdExp->descSerie." / ".$trdExp->descSubSerie;
	error_reporting(7);
	$resultadoExp = 0;
	?>
<?
if($num_expediente !=""){
?>
    <Tr><td>Clasificacion D.</td><td><?php print $arrTRDExp['serie']." / ".$arrTRDExp['subserie']; ?>
  </td></tr>
	<tr>
	<td><a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"> Proceso <b class="caret"> </b> </a>

	<ul class="dropdown-menu">
			<li>
				<a href="#" onClick="verHistExpediente('<?=$num_expediente?>');">Historial del Proceso/Exp</a>
			</li>
			<li>
				<a href="#" onClick="verWorkFlow('<?=$num_expediente?>','<?=$texp?>');">Ver WorkFlow</a>
			</li>
			<li>
				<a href="#" onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
			</li>
		</ul>
		</td><td>
					<?php
			if( $arrTRDExp['proceso'] != "" ) {
			  echo $arrTRDExp['proceso']." / ".$arrTRDExp['terminoProceso'];
			}
			?>
</td></tr>

<?
if($descPExpediente){
	$expediente->consultaTipoExpediente($num_expediente);
	include_once ("$ruta_raiz/include/tx/Flujo.php");
	$objFlujo = new Flujo($db, $texp, $usua_doc);
	$kk = $objFlujo->getArista($texp, $codigoFldExp);
	$aristasSig = $objFlujo->aristasSig;
 $frm = array();
 $iA = 0;
 $ventana = "Default";
 foreach($aristasSig as $key => $arista){
  if(trim($arista["FRM_NOMBRE"])){
    $ventana = "Max";
    If(!$numeroExpediente) $numeroExpediente = $numExpedente;
    $frm[$iA]["FRM_NOMBRE"] = $arista["FRM_NOMBRE"];
    $frm[$iA]["FRM_LINK"] = $arista["FRM_LINK"];
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroRadicado}","$verrad", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINK"]);

		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroRadicado}","$numRad", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINKSELECT"]);
		$iA++;
	}
 }
}
?>
  <tr><td>
<a class="dropdown-toggle" data-toggle="dropdown" href="#">
Estado <b class="caret"></b>
  </a>
		<ul class="dropdown-menu">
			<?php
			if($usuaPermExpediente) {
				?>
				<li>
					<a href="#" onClick="verHistExpediente('<?=$num_expediente?>');"></a>
				</li>
				<li>
					<a href="#" onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
				</li>

				<li>
					<a href="#" onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
				</li>
					<?
				}
				?>
				<li>
					<a href="#" onClick="modFlujo('<?=$num_expediente?>',<?=$texp?>,<?=$codigoFldExp?>,'<?=$ventana?>')">Modificar Estado</a>
				</li>
				</ul>
			 </li>
			<?
			if($frm){
				foreach($frm as $arista){
			?>
				</Td><td>
					<li >
					<a class="dropdown-toggle" data-toggle="dropdown" href="#"><?=$descFldExp?>
				<b class="caret"></b>
					</a>
				<ul class="dropdown-menu ">
				<li>
				<a href="#" onClick="window.open('<?=$arista["FRM_LINK"]?>','frm<?=date('ymdhis')?>','fullscreen=yes, scrollbars=auto')"><?=$arista["FRM_NOMBRE"]?></a>
			</li>
			</lu>
			</td>
			<?php
			}
			}else{
				?>

	</B></Td><td><?=$descFldExp?>
	</td><?
	}
	?>
	</tr>
	<tr><td>
		Fecha Inicio: </td><td><?php print $arrTRDExp['fecha']; ?></td>
 </tr>
</table>
<?
} ?>
