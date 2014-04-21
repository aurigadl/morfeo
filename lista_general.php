<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
Copyright (C) 2013 Infometrika Ltda.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
session_start();

    $ruta_raiz = "."; 
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

$lkGenerico = "&usuario=$krd&nsesion=".trim(session_id())."&nro=$verradicado"."$datos_envio";
?>
<script>
function regresar()	
{	//window.history.go(0);
	window.location.reload();
}
function CambiarE(est,numeroExpediente) {
        window.open("<?=$ruta_raiz?>/archivo/cambiar.php?<?=session_name()?>=<?=session_id()?>&numRad=<?=$verrad?>&expediente="+ numeroExpediente +"&est="+ est +"&","Cambio Estado Expediente","height=100,width=100,scrollbars=yes");
}
function modFlujo(numeroExpediente,texp,codigoFldExp)
{
<?php
        $isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
                                                        WHERE RADI_NUME_RADI = '$numrad'";
        $rsDepR = $db->conn->Execute($isqlDepR);
        $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
        $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
        $ind_ProcAnex="N";
?>
window.open("<?=$ruta_raiz?>/flujo/modFlujoExp.php?<?=session_name()?>=<?=session_id()?>&codigoFldExp="+codigoFldExp+"&numeroExpediente="+numeroExpediente+"&numRad=<?=$verrad?>&texp="+texp+"&ind_ProcAnex=<?=$ind_ProcAnex?>&codusua=<?=$codusua?>","TexpE<?=$fechaH?>","height=250,width=750,scrollbars=yes");
}

</script>
<table border=0 cellspace=0 colspacing=0 cellspacing=0>
<tr  class=odd>
 <td><small><b>Asunto</b></small></td><td><small><?=$ra_asun ?></small></td>
<td><small><b>Fecha Documento</b></small></td><td><small> <?=$radi_fech_radi ?>, &nbsp;&nbsp;</small></td>
</tr>
<tr  cellspace=0 cellpad=0>
<td><small><b>Hojas </b></small></td><td><small> <?=$radi_nume_hoja ?> </small></td><td><small><b>  Folios</b></small></td><td><small><?=$radi_nume_folio?></small></td><td><small><b>   Anexos:</b></small></td><td><small> <?=$radi_nume_anexo?></small></td>
</tr>
<tr>
<td><small><b>
Descripci&oacute;n Anexos</b></small></td><td><small> <?=$radi_desc_anex ?></small></td><td><small><b> Anexo/Asociado</b></small></td><td><small>
	<?	
	if($radi_tipo_deri!=1 and $radi_nume_deri)
	   {	echo $radi_nume_deri;
           	 /*
		  * Modificacion acceso a documentos
		  * @author Liliana Gomez Velasquez
		  * @since 10 noviembre 2009
		 */
		 $resulVali = $verLinkArchivo->valPermisoRadi($radi_nume_deri);
                 $verImg = $resulVali['verImg'];
		 if ($verImg == "SI"){
		        echo "<br>(<a class='vinculos' href='$ruta_raiz/verradicado.php?verrad=$radi_nume_deri &session_name()=session_id()&krd=$krd' target='VERRAD$radi_nume_deri_".date("Ymdhi")."'>Ver Datos</a>)";}	
                 else {
                      echo "<br>(<a class='vinculos' href='javascript:noPermiso()'> Ver Datos</a>)"; 
                 }
	   }
	 if($verradPermisos == "Full" or $datoVer=="985")
		{
	?>
		<input type=button name=mostrar_anexo value='...'  class="btn btn-primary btn-xs" onClick="verVinculoDocto();">
	<?
		}
	?>
</small></td><td><small><b>Referencia / Oficio</b></small></td><td><small><?=$cuentai ?></small></td>
</tr>

    <?
		$muniCodiFac = "";
		$dptoCodiFac = "";
		if($sector_grb==6 and $cuentai and $espcodi)
		{	if($muni_us2 and $codep_us2)
			{	$muniCodiFac = $muni_us2;
				$dptoCodiFac = $codep_us2;
			}
			else
			{	if($muni_us1 and $codep_us1)
				{	$muniCodiFac = $muni_us1;
					$dptoCodiFac = $codep_us1;
				}
			}
	?>
		<a href="./consultaSUI/facturacionSUI.php?cuentai=<?=$cuentai?>&muniCodi=<?=$muniCodiFac?>&deptoCodi=<?=$dptoCodiFac?>&espCodi=<?=$espcodi?>" target="FacSUI<?=$cuentai?>"><span class="vinculos">Ver Facturacion</span></a>
	<?
		}
	?>
<tr><td><small><b>Imagen</b></small></td><td><small>	<span class='vinculos'><?=$imagenv ?></span> </small></td><td><small><b>Estado Actual</b></small></td><td><small>
		<span ><?=$descFldExp?></span>&nbsp;&nbsp;&nbsp;
		<? 
			if($verradPermisos == "Full" or $datoVer=="985")
	  		{
	  	?>
  <input type=button name=mostrar_causal value='...' class="btn btn-primary btn-xs" onClick="modFlujo('<?=$numExpediente?>',<?=$texp?>,<?=$codigoFldExp?>)">
		<?
			}
		?>
		</Td><td><small><b>
	, Nivel de Seguridad</b></small></td><td><small>
	<?
		if($nivelRad==1)
		{	echo "Confidencial";	}
		else 
		{	echo "P&uacute;blico";	}
		if($verradPermisos == "Full" or $datoVer=="985")
	  	{	$varEnvio = "krd=$krd&numRad=$verrad&nivelRad=$nivelRad";
	?>
		<input type=button name=mostrar_causal value='...' class="btn btn-primary btn-xs" onClick="window.open('<?=$ruta_raiz?>/seguridad/radicado.php?<?=$varEnvio?>','Cambio Nivel de Seguridad Radicado', 'height=220, width=300,left=350,top=300')">
	<?
		}
	?>
	</small></td><tr>
	<tr>
	<th>Clasificaci&oacute;n Documental</th><td><small>
	<?
		if(!$codserie) $codserie = "0";
		if(!$tsub) $tsub = "0";
		if(trim($val_tpdoc_grbTRD)=="///") $val_tpdoc_grbTRD = "";
	?>
		<?=$serie_nombre ?><font color=black>/</font><?=$subserie_nombre ?><font color=black>/</font><?=$tpdoc_nombreTRD ?>
	<?
		if($verradPermisos == "Full" or $datoVer=="985") {
	?>
		<input type=button name=mosrtar_tipo_doc2 value='...' class="btn btn-primary btn-xs" onClick="ver_tipodocuTRD(<?=$codserie?>,<?=$tsub?>);">
	</small></td><td><small><b>
	Tema</b></small></td><td><small><?=$sector_nombre?>
	
      <? 
		$nombreSession = session_name();
		$idSession = session_id();
		if ($verradPermisos == "Full"  or $datoVer=="985") {
	  		$sector_grb = (isset($sector_grb)) ? $sector_grb : 1;
	  		$causal_grb = (isset($causal_grb) ||$causal_grb !='') ? $causal_grb : 0;
	  		$deta_causal_grb = (isset($deta_causal_grb) || $deta_causal_grb!='') ? $deta_causal_grb : 0;
	  		
			$datosEnviar = "'$ruta_raiz/causales/mod_causal.php?" . 						$nombreSession . "=" . $idSession .
					"&krd=" . $krd . 
					"&verrad=" . $verrad . 
					"&sector=" . $sector_grb . 
					"&sectorCodigoAnt=" . $sector_grb . 
					"&sectorNombreAnt=" . $sector_nombre . 
					"&causal_grb=" . $causal_grb . 
					"&causal_nombre=" . $causal_nombre . 
					"&deta_causal_grb=" . $deta_causal_grb .
					"&ddca_causal_grb=" . $ddca_causal .  
					"&ddca_causal_nombre=". $ddca_causal_nombre . "'";
	  ?>
      <input type=button name="mostrar_causal" value="..." class="btn btn-primary btn-xs" onClick="window.open(<?=$datosEnviar?>,'Tipificacion_Documento','height=300,width=750,scrollbars=no')">
      <input type="hidden" name="mostrarCausal" value="N">
      <?
	   }
	   ?>
   </small></td><td><small><b> Sub-Tema</b></small></td>
    <?
	$causal_nombre_grb = $causal_nombre;
	$dcausal_nombre_grb = $dcausal_nombre;
	$$ddca_causal_nombre_grb = $ddca_causal_nombre;
	?><td><small>
      <?=$causal_nombre ?>
      / 
      <?=$dcausal_nombre ?>
      / 
      <?=$ddca_causal_nombre ?>
      / 
      <? 
	  if ($verradPermisos == "Full"  or $datoVer=="985" ) {
	  ?>
      	<input type=button name="mostrar_causal" value="..." class="btn btn-primary btn-xs" onClick="window.open(<?=$datosEnviar?>,'Tipificacion_Documento','height=300,width=750,scrollbars=no')">
      <?
	  } 
	  ?>
	  </small></td></tr><td><small><b>
    Poblaci&oacute;n</b><td><small> <?=$tema_nombre ?>
      <? 
	  if ($verradPermisos == "Full"  or $datoVer=="985") {
	  ?>
      <input type=button name="mostrar_temas" id='mostrar_temas'  value='...' class="btn btn-primary btn-xs" onClick="ver_temas();">
      <?
	  }
}
	  ?>
	  </small></td></tr></table>
</form>
<table width="80%" class="table table-bordered ">
<tr>
 <th  class='alert alert-info'>Nombre</th>
 <th  class='alert alert-info'>Direccion</th>
 <th  class='alert alert-info'>Ciudad / Departamento</th>
 <th  class='alert alert-info'>Mail</th>
 <th  class='alert alert-info'>Telefono</th>
</tr>
<tr> 
  <td   ><?=$nomRemDes["x1"] ?> </small></td>
	<td  ><?=$dirDireccion["x1"] ?></small></td>
	<td  ><?=$dirDpto["x1"]."/".$dirMuni["x1"] ?></small></td>
	<td   ><?=$email["x1"] ?> </small></td>
	<td   ><?=$telefono["x1"] ?> </small></td>
</tr>
<tr> 
	<td   > <?=$nomRemDes["x2"]?></small></td>
  <td  > <?=$dirDireccion["x2"] ?></small></td>
 <td  > <?=$dirDpto["x2"]."/".$dirMuni["x2"] ?></small></td>
	<td   ><?=$email["x2"] ?> </small></td>
	<td   ><?=$telefono["x2"] ?> </small></td>
 
</tr>
<tr>
	<td   > <?=$nombret_us3 ?> -- <?=$cc_documento_us3?></small></td>
  <td  > <?=$direccion_us3 ?></small></td>
  <td  > <?=$dpto_nombre_us3."/".$muni_nombre_us3 ?></small></td>
  	<td   ><?=$email["x3"] ?> </small></td>
	<td   ><?=$telefono["x3"] ?> </small></td>

</tr>
</table>
