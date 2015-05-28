<?PHP
/********* FILA DE LA TABLA CON LOS RESULTADOS *********/
// Inicializa algunas de las variables

$antfldEXPEDIENTE=$antfldEXP;
$antfldARCHIVADO=$antfldARCH;
$form_params_hist = "radicado=".$antfldRADICADO."&krd=".tourl($krd);
$cadRadicado="<div align=\"right\">".$antfldRADICADO."</div>";
if($antfldPATH!="") {
	$cadRadicado="<a class='vinculos' href='".$ruta_raiz."/bodega".$antfldPATH."' target='Imagen'>".$antfldRADICADO."</a>";
}
// Fila con los resultados
?>
<tr >
    <td id="r19" style="display:<?=$tipoRespuesta[$opcionMenu][19];?>"   align="right"><small><input type="checkbox" name="rta_<?=$y; ?>" value="<?=$fldPRESTAMO_ID; ?>"></small></td>
	<td id="r0"  style="display:<?=$tipoRespuesta[$opcionMenu][0]; ?>"  ><small><?= $cadRadicado?></small></td>
	<td id="r1"  style="display:<?=$tipoRespuesta[$opcionMenu][1]; ?>"  ><small><?= $antfldEXPEDIENTE; ?></small></td>	 
	<td id="r2"  style="display:<?=$tipoRespuesta[$opcionMenu][2]; ?>"  ><small><?= tohtml($antfldNOMBRE); ?></small></td>	 
	<td id="r3"  style="display:<?=$tipoRespuesta[$opcionMenu][3]; ?>"  ><small><?= tohtml($antfldDEPENDENCIA); ?></small></td>	 
	<td id="r4"  style="display:<?=$tipoRespuesta[$opcionMenu][4]; ?>"  ><small><?= substr($antfldF_PEDIDO,0,10)."<br>".substr($antfldF_PEDIDO,11,18); ?></small></td>	 
	<td id="r5"  style="display:<?=$tipoRespuesta[$opcionMenu][5]; ?>"  ><small><?= substr($antfldF_PRESTADO,0,10)."<br>".substr($antfldF_PRESTADO,11,18); ?></small></td>	 
	<td id="r6"  style="display:<?=$tipoRespuesta[$opcionMenu][6]; ?>"  ><small><?= substr($antfldF_CANC,0,10)."<br>".substr($antfldF_CANC,11,18); ?></small></td>	 
	<td id="r7"  style="display:<?=$tipoRespuesta[$opcionMenu][7]; ?>"  ><small><?= substr($antfldF_VENCIDO,0,10)."<br>".substr($antfldF_VENCIDO,11,18); ?></small></td>	 
	<td id="r8"  style="display:<?=$tipoRespuesta[$opcionMenu][8]; ?>"  ><small><?= substr($antfldF_DEVUELTO,0,10)."<br>".substr($antfldF_DEVUELTO,11,18); ?></small></td>
	<td id="r9"  style="display:<?=$tipoRespuesta[$opcionMenu][9]; ?>"   title="<?=$ayudaDifFecha?>"><div align="center"><small><?= $antdifFecha; ?></div></small></td>
	<td id="r10" style="display:<?=$tipoRespuesta[$opcionMenu][10];?>"  ><small><?= tohtml($antfldREQUERIMIENTO); ?></small></td>
	<td id="r11" style="display:<?=$tipoRespuesta[$opcionMenu][11];?>"  ><small><?= tohtml($antfldNumPag); ?></small></td>
	<td id="r12" style="display:<?=$tipoRespuesta[$opcionMenu][12];?>"  ><small><?= tohtml($antfldESTADO); ?></small></td>
	<td id="r13" style="display:<?=$tipoRespuesta[$opcionMenu][13];?>"  ><small><?= tohtml($antfldLOGIN_PRES); ?></small></td>
	<td id="r14" style="display:<?=$tipoRespuesta[$opcionMenu][14];?>"  ><small><?= tohtml($antfldLOGIN_CANC); ?></small></td>
	<td id="r15" style="display:<?=$tipoRespuesta[$opcionMenu][15];?>"  ><small><?= tohtml($antfldLOGIN_RX); ?></small></td>
	<td id="r16" style="display:<?=$tipoRespuesta[$opcionMenu][16];?>"  ><div align="center"><small><?= $antfldARCHIVADO; ?></div></small></td>
	<td id="r17" style="display:<?=$tipoRespuesta[$opcionMenu][17];?>"  ><small><a href="historico.php?<?=$form_params_hist?>&">Ver hist&oacute;rico</a></small></td>
	<td id="r18" style="display:<?=$tipoRespuesta[$opcionMenu][18];?>"  ><a><small>xxxxxxx<?=$antaccion?></a></small></td>
	<td style="display:none"  ><small id="use_paswor_dmd5" ><?= tohtml($antfldPASWORDMD5); ?></small></td>	 
	<!--<td style="display:block"  ><small id="use_id" ><?= tohtml($antfldIDUSER); ?></small></td>	   -->   
</tr>
<?PHP?>		 
