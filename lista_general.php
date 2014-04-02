<?php
session_start();

    $ruta_raiz = "."; 
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
/*************************************************************************************/
/* ORFEO GPL:Sistema de Gestion Documental		http://www.orfeogpl.org	     */
/*	Idea Original de la SUPERINTENDENCIA DE SERVICIOS PUBLICOS DOMICILIARIOS     */
/*				COLOMBIA TEL. (57) (1) 6913005  orfeogpl@gmail.com   */
/* ===========================                                                       */
/*                                                                                   */
/* Este programa es software libre. usted puede redistribuirlo y/o modificarlo       */
/* bajo los terminos de la licencia GNU General Public publicada por                 */
/* la "Free Software Foundation"; Licencia version 2. 			             */
/*                                                                                   */
/* Copyright (c) 2005 por :	  	  	                                     */
/* SSPS "Superintendencia de Servicios Publicos Domiciliarios"                       */
/*   Jairo Hernan Losada  jlosada@gmail.com                Desarrollador             */
/*   Sixto Angel Pinzón López --- angel.pinzon@gmail.com   Desarrollador             */
/* C.R.A.  "COMISION DE REGULACION DE AGUAS Y SANEAMIENTO AMBIENTAL"                 */ 
/*   Liliana Gomez        lgomezv@gmail.com                Desarrolladora            */
/*   Lucia Ojeda          lojedaster@gmail.com             Desarrolladora            */
/* D.N.P. "Departamento Nacional de Planeación"                                      */
/*   Hollman Ladino       hollmanlp@gmail.com                Desarrollador          */
/*                                                                                   */
/* Colocar desde esta lInea las Modificaciones Realizadas Luego de la Version 3.5    */
/*  Nombre Desarrollador   Correo     Fecha   Modificacion                           */
/*************************************************************************************/
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
<table border=0>
<tr  class=odd>
 <td><b>Asunto</b></td><td><?=$ra_asun ?></td>
</tr>
<tr  cellspace=0 cellpad=0>
<td><b>Fecha Radicado</b></td><td> <?=$radi_fech_radi ?>, &nbsp;&nbsp;</td>
</tr>
<tr  cellspace=0 cellpad=0>
<td><b>Hojas </b></td><td> <?=$radi_nume_hoja ?> </td><td><b>  Folios</b></td><td><?=$radi_nume_folio?></td><td><b>   Anexos:</b></td><td> <?=$radi_nume_anexo?></td>
</tr>
<tr>
<td><b>
Descripcion Anexos</b></td><td> <?=$radi_desc_anex ?></td><td><b> Anexo/Asociado</b></td><td>
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
</td><td><b>Referencia / Oficio</b></td><td><?=$cuentai ?></td>
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
<tr><td><b>Imagen</b></td><td>	<span class='vinculos'><?=$imagenv ?></span> </td><td><b>Estado Actual</b></td><td>
		<span ><?=$descFldExp?></span>&nbsp;&nbsp;&nbsp;
		<? 
			if($verradPermisos == "Full" or $datoVer=="985")
	  		{
	  	?>
  <input type=button name=mostrar_causal value='...' class="btn btn-primary btn-xs" onClick="modFlujo('<?=$numExpediente?>',<?=$texp?>,<?=$codigoFldExp?>)">
		<?
			}
		?>
		</Td><td><b>
	, Nivel de Seguridad</b></td><td>
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
	</td><tr>
	<tr>
	<th>Clasificacion Documental</th><td>
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
	</td><td><b>
	Tema</b></td><td><?=$sector_nombre?>
	
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
   </td><td><b> Sub-Tema</b></td>
    <?
	$causal_nombre_grb = $causal_nombre;
	$dcausal_nombre_grb = $dcausal_nombre;
	$$ddca_causal_nombre_grb = $ddca_causal_nombre;
	?><td>
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
	  </td></tr><td><b>
    Poblacion</b><td> <?=$tema_nombre ?>
      <? 
	  if ($verradPermisos == "Full"  or $datoVer=="985") {
	  ?>
      <input type=button name="mostrar_temas" id='mostrar_temas'  value='...' class="btn btn-primary btn-xs" onClick="ver_temas();">
      <?
	  }
}
	  ?>
	  </td></tr></table>
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
  <td   ><?=$nomRemDes["x1"] ?> </td>
	<td  ><?=$dirDireccion["x1"] ?></td>
	<td  ><?=$dirDpto["x1"]."/".$dirMuni["x1"] ?></td>
	<td   ><?=$email["x1"] ?> </td>
	<td   ><?=$telefono["x1"] ?> </td>
</tr>
<tr> 
	<td   > <?=$nomRemDes["x2"]?></td>
  <td  > <?=$dirDireccion["x2"] ?></td>
 <td  > <?=$dirDpto["x2"]."/".$dirMuni["x2"] ?></td>
	<td   ><?=$email["x2"] ?> </td>
	<td   ><?=$telefono["x2"] ?> </td>
 
</tr>
<tr>
	<td   > <?=$nombret_us3 ?> -- <?=$cc_documento_us3?></td>
  <td  > <?=$direccion_us3 ?></td>
  <td  > <?=$dpto_nombre_us3."/".$muni_nombre_us3 ?></td>
  	<td   ><?=$email["x3"] ?> </td>
	<td   ><?=$telefono["x3"] ?> </td>

</tr>
</table>
