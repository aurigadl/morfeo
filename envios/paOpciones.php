<?php
session_start();

    $ruta_raiz = "..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");


if($_GET['swListar']) $swListar =  $_GET['swListar'];
if($_GET['accion_sal']) $accion_sal =  $_GET['accion_sal'];

?>
<table class="table table-bordered" cellpadding="2">
<tr> 
<?php
if ($swListar)  {
?>
<td width='50%'    >
  <small><b>Listar Por </b>
	<a href='<?= $pagina_actual?>?<?=$encabezado?>98&ordcambio=1' alt='Ordenar Por Leidos' >
	Enviados a Correspondencia</a>/<a href='<?=$pagina_actual?>?<?=$encabezado?>99&ordcambio=1'  alt='Ordenar Por Listos para Enviar'>
	Por Enviar</a></small></td>
</td>
<?php
} 
?>
<td width='50%' align="center"  > 
	<?php
	if($accion_sal)
	{
	?>
	<input type=submit value="<?=$accion_sal?>" name=Enviar id=Enviar valign='middle' class='btn btn-primary' onclick="Marcar(2);">
	<?php
	}
	?>
	</td>
</tr>
</table>

<script>
function Marcar(tipoAnulacion)
{
	marcados = 0;

	for(i=0;i<document.formEnviar.elements.length;i++)
	{
		if(document.formEnviar.elements[i].checked==1)
		{
			marcados++;
		}
	}
	if(marcados>=1)
	{
		document.formEnviar.submit();
	}
	else
	{
		alert("Debe seleccionar un radicado");
	}
}
		<!-- Funcion que activa el sistema de marcar o desmarcar todos los check  -->
		function markAll()
		{
			if(document.formEnviar.elements['checkAll'].checked)
			for(i=1;i<document.formEnviar.elements.length;i++)
			document.formEnviar.elements[i].checked=1;
			else
			for(i=1;i<document.formEnviar.elements.length;i++)
			document.formEnviar.elements[i].checked=0;
		}
</script>

