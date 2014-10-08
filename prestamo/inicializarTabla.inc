<?PHP
/********* TITULO DE LAS COLUMNAS DE LA TABLA CON LOS RESULTADOS DE LA CONSULTA *********/
// Oculta o Hace visible la flecha que indica la columna por la cual se ordena el resultado
$numRta=16; //n�mero de columnas de la respuestas
for($j=1; $j<$numRta; $j++) {
	if($j==$iSort){ 
			if($sDirection==" DESC ") { $flecha[$j]="<img src='".$ruta_raiz."/iconos/flechadesc.gif' border=0 alt=''>"; }
			else                      { $flecha[$j]="<img src='".$ruta_raiz."/iconos/flechaasc.gif'  border=0 alt=''>"; }
	}
	else{ $flecha[$j]=""; }
}       
for($j=1; $j<$numRta; $j++) {
	$href[1][$j]="href=\"javascript: ordenar($j); \"";           //formEnvio.php
	$href[0][$j]="href=\"".$sFileName."?".$form_params.$j."&\""; //prestamo.php
}
$j=0;
if($sFileName=="formEnvio.php") { $j=1; } 
 ?>
<tr  align="center">
    <th id="r19" style="display:<?=$tipoRespuesta[$opcionMenu][19];?>"><input type="checkbox" name="rta_" value="checkbox" onClick="javascript: seleccionarRta();"></small></th>
	<th id="r0"  style="display:<?=$tipoRespuesta[$opcionMenu][0]; ?>"><small><a  <?=$href[$j][1]?>> <?=$flecha[1]?> Radicado</a></small></th>
	<th id="r1"  style="display:<?=$tipoRespuesta[$opcionMenu][1]; ?>"><small><a >Expediente</a></small></th>	  
	<th id="r2"  style="display:<?=$tipoRespuesta[$opcionMenu][2]; ?>"><small><a  <?=$href[$j][3]?>> <?=$flecha[3]?> Usuario</a></small></th>
	<th id="r3"  style="display:<?=$tipoRespuesta[$opcionMenu][3]; ?>"><small><a  <?=$href[$j][4]?>> <?=$flecha[4]?> Dependencia</a></small></th>
	<th id="r4"  style="display:<?=$tipoRespuesta[$opcionMenu][4]; ?>"><small><a  <?=$href[$j][5]?>> <?=$flecha[5]?> Fecha<br>Solicitud</a></small></th>	 
	<th id="r5"  style="display:<?=$tipoRespuesta[$opcionMenu][5]; ?>"><small><a  <?=$href[$j][6]?>> <?=$flecha[6]?> Fecha<br>Prestamo</a></small></th>
	<th id="r6"  style="display:<?=$tipoRespuesta[$opcionMenu][6]; ?>"><small><a  <?=$href[$j][7]?>> <?=$flecha[7]?> Fecha<br>Cancelaci&oacute;n</a></small></th>
	<th id="r7"  style="display:<?=$tipoRespuesta[$opcionMenu][7]; ?>"><small><a  <?=$href[$j][8]?>> <?=$flecha[8]?> Fecha<br>Vencimiento</a></small></th>	 
	<th id="r8"  style="display:<?=$tipoRespuesta[$opcionMenu][8]; ?>"><small><a  <?=$href[$j][9]?>> <?=$flecha[9]?> Fecha<br>Devoluci&oacute;n</a></small></th>	 
	<th id="r9"  style="display:<?=$tipoRespuesta[$opcionMenu][9]; ?>" title="<?=$ayudaDifFecha?>"><small><a >Tiempo<br>Espera</font></a></small></th>	 
	<th id="r10" style="display:<?=$tipoRespuesta[$opcionMenu][10];?>"><small><a  <?=$href[$j][10]?>><?=$flecha[10]?> Requerimiento</a></small></th>
	<th id="r11" style="display:<?=$tipoRespuesta[$opcionMenu][11];?>"><small><a  <?=$href[$j][11]?>><?=$flecha[11]?> No Pag.</a></small></th>
	<th id="r12" style="display:<?=$tipoRespuesta[$opcionMenu][12];?>"><small><a  <?=$href[$j][12]?>><?=$flecha[12]?> Estado</a></small></th>
	<th id="r13" style="display:<?=$tipoRespuesta[$opcionMenu][13];?>"><small><a  <?=$href[$j][13]?>><?=$flecha[13]?> Usuario<br>Prestamo</a></small></th>
	<th id="r14" style="display:<?=$tipoRespuesta[$opcionMenu][14];?>"><small><a  <?=$href[$j][14]?>><?=$flecha[14]?> Usuario<br>Cancela</a></small></th>
	<th id="r15" style="display:<?=$tipoRespuesta[$opcionMenu][15];?>"><small><a  <?=$href[$j][15]?>><?=$flecha[15]?> Usuario<br>Recibe</a></small></th>
	<th id="r16" style="display:<?=$tipoRespuesta[$opcionMenu][16];?>"><small><a >Archivado</a></small></th>		 		 
	<th id="r17" style="display:<?=$tipoRespuesta[$opcionMenu][17];?>"><small><a >Ver Hist&oacute;rico</a></small></th>
	<th id="r18" style="display:<?=$tipoRespuesta[$opcionMenu][18];?>"><small><a >Acci&oacute;n</a></small></th>
</tr> 
