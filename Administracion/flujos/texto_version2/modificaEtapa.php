<?
session_start();

/**
  * Paggina Cuerpo.php que muestra el contenido de las Carpetas
	* Modificaciones y Adaptciones por www.correlibre.org 
  * 
	* Se añadio compatibilidad con variables globales en Off
  * Arreglo de Funcionalidad
  *
  * @autor Jairo Losada 2009-08
  * @licencia GNU/GPL V 3
  */
  
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

if($_GET["crear"]) $crear = $_GET["crear"];
if($_GET["proceso"]) $proceso = $_GET["proceso"];
if($_GET["etapaCreaArista"]) $etapaCreaArista = $_GET["etapaCreaArista"];
if($_GET["etapaAModificar"]) $etapaAModificar = $_GET["etapaAModificar"];

if($_POST["nombreEtapa"]) $nombreEtapa = $_POST["nombreEtapa"];
if($_POST["etapaInicial"]) $etapaInicial = $_POST["etapaInicial"];
if($_POST["etapaFinal"]) $etapaFinal = $_POST["etapaFinal"];
if($_POST["terminoEtapa"]) $terminoEtapa = $_POST["terminoEtapa"];
if($_POST["nombreProceso"]) $nombreProceso = $_POST["nombreProceso"];
if($_POST["proceso"]) $proceso = $_POST["proceso"];
if($_POST["clickboton"]) $clickboton = $_POST["clickboton"];
if($_POST["descripcionArista"]) $descripcionArista = $_POST["descripcionArista"];
if($_POST["tipificacion"]) $tipificacion = $_POST["tipificacion"];
if($_POST["ClickCrea"]) $ClickCrea = $_POST["ClickCrea"];
if($_POST["clickboton"]) $clickboton = $_POST["clickboton"];
if($_POST["ordenEtapa"]) $ordenEtapa = $_POST["ordenEtapa"];
if($_POST["etapaAModificar"]) $etapaAModificar = $_POST["etapaAModificar"];
if($_POST["Button"]) $Button = $_POST["Button"];

$ruta_raiz = "../../..";
include "$ruta_raiz/config.php";
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler( "$ruta_raiz" );
if (!defined('ADODB_FETCH_ASSOC'))define('ADODB_FETCH_ASSOC',2);
$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
$entrada = 0;
$modificaciones = 0;
$salida = 0;

	$subtitulo = "MODIFICAR ETAPA";
	$nombreBoton = "Modificar";
	$clickBoton = false;

?>
<html>
<head>
<title>Modificaci&oacute;n de Etapa</title>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>

<script language="JavaScript">
<!--
	function validarDatos()
	{ 
		if(document.frmCrearEtapa.nombreEtapa.value == "" && document.frmCrearEtapa.ordenEtapa.value == "" && document.frmCrearEtapa.terminoEtapa.value == "")
        {      
        	 var confirmaNoCambios = confirm("Si deja campos vacion no se haran cambios a la etapa, eso es lo que desea?." );
        		if( confirmaNoCambios ){
					f_close();
				}else{
                document.frmCrearEtapa.nombreEtapa.focus();
                return false;
        		}	
        }
        
         var terminos = document.frmCrearEtapa.terminoEtapa.value;
        var terminosInt = parseInt(terminos);
        
        if( terminos != '' && isNaN(terminosInt) )
        {       alert("Solo puede ingresar números en el campo de duracion de la etapa." );
                document.frmCrearEtapa.terminoEtapa.focus();
                return false;
        }
        if( terminosInt < 0 )
        {       alert("No puede ingresar valores negativos en el campo de duracion de la etapa." );
                document.frmCrearEtapa.terminoEtapa.focus();
                return false;
        }
		<?  $clickBoton = true; ?>
	 	document.form1.submit();
	}
	
function Start(URL, WIDTH, HEIGHT)
{
 windowprops = "top=0,left=0,location=no,status=no, menubar=no,scrollbars=yes, resizable=yes,width=";
 windowprops += WIDTH + ",height=" + HEIGHT;
 preview = window.open(URL , "preview", windowprops);
}

function cerrar(){
	window.opener.regresar();
	window.close();
}


function regresar(){
	f_close();
}
//-->
</script>

</head>
<body>
<?
//	include "$ruta_raiz/debugger.php";
	
	if( $_GET['proceso'] != '' ){
		$procesoSelected = $_GET['proceso'];
	}
	if( $_GET['etapaAModificar'] != '' ){
		$etapaAModificar = $_GET['etapaAModificar'];
		$queryModifica = "SELECT SGD_FEXP_DESCRIP, SGD_FEXP_ORDEN, SGD_FEXP_TERMINOS FROM SGD_FEXP_FLUJOEXPEDIENTES WHERE SGD_FEXP_CODIGO = " .$etapaAModificar;
		$rs = $db->conn->query( $queryModifica );
		$nombreEtapa = $rs->fields['SGD_FEXP_DESCRIP'];
		$ordenEtapa = $rs->fields['SGD_FEXP_ORDEN'];
		$terminoEtapa = $rs->fields['SGD_FEXP_TERMINOS'];
	}
	if ( $_POST['nombreEtapa'] != '' && $clickBoton ){
			include "$ruta_raiz/include/tx/Proceso.php";
	 		$flujo = new EtapaFlujo( $db );
	 		
	 		$flujo->initEtapa( $nombreEtapa, $ordenEtapa, $terminoEtapa, $procesoSelected );	
				$resultadoInsercion = $flujo-> modificaEtapa( $etapaAModificar  );
	}
?>
<form name='frmCrearEtapa' action='modificaEtapa.php?&crear=<?=$crear?>' method="post" form="smart-form">
<table width="93%"   class="table table-bordered"   align="center">
  	<tr >
    <td colspan="2" >
	<center>
	ADMINISTRACI&Oacute;N DE FLUJOS</span></br>
  <?=$subtitulo?></center>
	</td>
	</tr>
</table>
<table  class="table table-bordered"   width=80%  >
	<tr >
			<td  >Nombre Etapa:</td>
			<td  >
				<label class="input state-success"><input type=text name=nombreEtapa value='<?=$nombreEtapa?>'></label>
		</td>

	</tr>
	<tr >
			<td  >Orden:</td>
			<td  >
				<label class="input state-success"><input type=text name=ordenEtapa value='<?=$ordenEtapa?>'></label>
		</td>

	</tr>
	<tr >
			<td   width="25%">T&eacute;rminos (d&iacute;as)</td>
			<td   width="25%">
				<label class="input state-success"><input type=text name=terminoEtapa value='<?=$terminoEtapa?>'></label>
			</td>

	</tr>
</table>

<input name='proceso' type='hidden' value='<?=$procesoSelected?>'>
<input type=hidden id="etapaAModificar" name="etapaAModificar" value='<?=$etapaAModificar?>'>


<table  class="table table-bordered"  width=93%  align="center">
	<tr >
	      <td height="30" colspan="2" > 
		  <center> <input  class="btn btn-primary btn-xs" type="submit" Value=<?=$nombreBoton?> onClick=" return validarDatos();"> </center> </td>
	      <td height="30" colspan="2" >
			<center><input  class="btn btn-primary btn-xs" type=button name=Cerrar id=Cerrar Value=Cerrar onclick='cerrar();'></a></center> 
		  </td>
	</tr>
</table>
<?
  if( $clickBoton ){
?>
		<center>
			<table class=borde_tab>
				<tr>
					<td class=titulos2>
					   <?=$resultadoInsercion?>
					</td>
				</tr>
			</table>
		</center>
<?
}
?>
</form>
</body>
</html>
