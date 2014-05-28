<?
if($mostrarTable)
{
?>
<table class="table table-bordered">
<?
}
?>
<?
if (!$k)  {
?> 
	<tr >
	<td height="21" align="center" > <?=$verrad_sal?></td>
	<td height="21" align="center" > <?=$verrad_padre?></td>
<?
} else {
?>
	<tr >
	<td ><?=$verrad_sal?></td>
	<td ><?=$verrad_padre?></td>
<?
}
?>
	</tr><tr>
	<td colspan=5  >
	Destinatario<label class=input><input type=text name=nombre_us id=nombre_us value='<?=$nombre_us?>' size=20 maxlength="40" ></label>
	Direccion<label class=input><input type=text name=direccion_us id=direccion_us value='<?=$direccion_us?>' class=e_cajas size=15 ></label> 
	<?
	if($cantidadDestinos>=1)
		$nombreDestinos = "destino$cantidadDestinos";
	else
		$nombreDestinos = "destino";
	?>
	Municipio<label class=input><input type=text name='<?=$nombreDestinos?>' value='<?=strtoupper($destino)?>' size=20 ></label>
	Deptartamento<label class=input><input type=text name='departamento_us' id='departamento_us' value='<?=strtoupper($departamento_us)?>' size=10 ></label>
	Pais<label class=input><input type=text name='pais_us' id='pais_us' value='<?=$pais_us?>' size=10  ></label>
	<input type=hidden name=dir_codigo id=dir_codigo value='<?=$dir_codigo?>' size=5 >
	</td>
</tr>

<?
if (!$k)  {
?>
	<tr  >
	<td height="21" colspan="5" >Asunto
	<label class=input><input type=text disabled name=ra_asun value='<?=$ra_asun?>'  size=120  >
	</td>
</tr>
<tr  >
	<td height="21" colspan="5">Observaciones o Desc Anexos
	<label class=input><input type=text name=observaciones value='<?=$observaciones?>' size=50 >
</TD></TR>
<?
}
?>
<?
if($mostrarTable)
{
?>
</table>
<?
}
?>