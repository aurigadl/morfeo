<?
session_start();
echo "Post<hr>";
print_r($_POST);
echo "Get<hr>";
print_r($_GET);
if($_POST["nombreProceso"]) $nombreProceso = $_POST["nombreProceso"];
if($_POST["codserie"]) $codserie = $_POST["codserie"];
if($_POST["tsub"]) $tsub = $_POST["tsub"];
if($_GET["accion"]) $accion = $_GET["accion"];

error_reporting(0);
session_start();
error_reporting(0);
$ruta_raiz = "../../..";
$salida = 0;
$queryProc = $accion;
if ( $accion == 1 ) {
	$tituloCrear = "Creaci&oacute;n de flujo - seleccionar Proceso ";	
	$action =  'creaEtapa.php?&crear=1';
}else if ( $accion == 2 ) {
	$tituloCrear = "Modificaci&oacute;n de flujo - seleccionar Proceso";		
	$action =  'creaEtapa.php?&crear=0';
}elseif ( $accion == 3 ) {
	$tituloCrear = "Consulta de flujo - seleccionar Proceso";			
	$action =  'modEtapas.php';
}

?>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="../../../estilos/orfeo.css">

</head>
<body>
<?
    include "$ruta_raiz/config.php";
	include_once "$ruta_raiz/include/db/ConnectionHandler.php";
    $db = new ConnectionHandler( "$ruta_raiz" );
    if (!defined('ADODB_FETCH_ASSOC'))define('ADODB_FETCH_ASSOC',2);
    $ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
?>
<form name='frmCrear' action='<?=$action?>' method="post">
<table width="93%"  border="1" align="center">
  	<tr bordercolor="#FFFFFF">
    <td colspan="2" class="titulos4">
	<center>
	<p><B><span class=etexto>ADMINISTRACI&Oacute;N DE FLUJOS</span></B> </p>
	<p><B><span class=etexto> <?=$tituloCrear ?></span></B> </p></center>
	</td>
	</tr>
</table>
<table border=1 width=93% class=t_bordeGris align="center">
<?
?>
	<tr class=timparr>
			<td class="titulos2" height="26">Proceso</td>
			<td class="listado2" height="1">
				<?
				 	include_once "$ruta_raiz/include/query/flujos/queryProcesos.php";									
					$rsDep = $db->conn->Execute( $sql );
					
					print $rsDep->GetMenu2( "proceso", "", false, false, 0," class='select'" );
			?>
		</td>
	</tr>
</table>

<table border=1 width=93% class=t_bordeGris align="center">
	<tr class=timparr>
	      <td height="30" colspan="2" class="listado2"><span class="celdaGris"> <span class="e_texto1">
		  <center> <input class="botones" type="submit" Value="Continuar"> </center> </span> </span></td>
	      <td height="30" colspan="2" class="listado2"><span class="celdaGris"> <span class="e_texto1">
	<center><a href='mnuFlujosBasico.php?<?=session_name()."=".session_id()."&$encabezado"?>'><input class="botones" type=button name=Cancelar id=Cancelar Value=Cancelar></a></center>  </span> </span></td>
	</tr>
</table>
</form>
</body>
</html>
