<?php
session_start();
$ruta_raiz = ".";
if (!$_SESSION['dependencia']) header ("Location: $ruta_raiz/cerrar_session.php");
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
$krd                = $_SESSION["krd"];
$dependencia        = $_SESSION["dependencia"];
$usua_doc           = $_SESSION["usua_doc"];
$codusuario         = $_SESSION["codusuario"];
$tip3Nombre         = $_SESSION["tip3Nombre"];
$tip3desc           = $_SESSION["tip3desc"];
$tip3img            = $_SESSION["tip3img"];
$tpNumRad           = $_SESSION["tpNumRad"];
$tpPerRad           = $_SESSION["tpPerRad"];
$tpDescRad          = $_SESSION["tpDescRad"];
$usuaPermExpediente = $_SESSION["usuaPermExpediente"];
$nomcarpeta=$_GET["nomcarpeta"];
$verradicado = $_GET['verrad'];
// Modificado Infom�trika 22-Julio-2009
// Compatibilidad con register_globals = Off
if (!$ent) $ent = substr($verradicado, -1 );
if(!$menu_ver_tmp) $menu_ver_tmp = $menu_ver_tmpOld;
if(!$menu_ver) $menu_ver = $menu_ver_Old;
if(!$menu_ver) $menu_ver=3;
if($menu_ver_tmp)	$menu_ver=$menu_ver_tmp;
if (!defined('ADODB_ASSOC_CASE')) define('ADODB_ASSOC_CASE', 1);
include_once "./include/db/ConnectionHandler.php";
if($verradicado)	$verrad= $verradicado;
if(!$ruta_raiz)	$ruta_raiz=".";
$numrad = $verrad;
error_reporting(7);
$db = new ConnectionHandler(".");
$db->conn->SetFetchMode(3);

if($carpeta==8){	$info=8;
	$nombcarpeta = "Informados";
}
include_once "$ruta_raiz/config.php";
include_once "$ruta_raiz/class_control/Radicado.php";

$objRadicado = new Radicado($db);
$objRadicado->radicado_codigo($verradicado);
$path = $objRadicado->getRadi_path();

include_once "$ruta_raiz/tx/verLinkArchivo.php";
$verLinkArchivo = new verLinkArchivo($db);

/** verificacion si el radicado se encuentra en el usuario Actual*/

include "$ruta_raiz/tx/verifSession.php";

?>
<html><head><title>.: Modulo total :.</title>
<?php include_once "htmlheader.inc.php"; ?>
<!-- seleccionar todos los checkboxes-->
<?php include_once "$ruta_raiz/js/funtionImage.php"; ?>
<script language="javascript">
function datosbasicos(){
	window.location='radicacion/NEW.PHP?<?=session_name()."=".session_id()?>&<?="nurad=$verrad&fechah=$fechah&ent=$ent&Buscar=Buscar Radicado&carpeta=$carpeta&nomcarpeta=$nomcarpeta"; ?>';
}
function mostrar(nombreCapa)
{
	document.getElementById(nombreCapa).style.display="";
}
function ocultar(nombreCapa)
{
	if(document.getElementById(nombreCapa) != null)
	document.getElementById(nombreCapa).style.display="none";
}
var contadorVentanas=0
<?

if($dependencia==900 ) $verradPermisos = "Full";
if($carpeta==8 || $carpeta==66 )  $verradPermisos = "Full";

if($verradPermisos == "Full" or $datoVer=="985")
{	if($datoVer=="985")
	{
?>

function  window_onload(){
  <?	if($verradPermisos == "Full" or $datoVer=="985"){ ?>
  window_onload2();
  <?  } ?>
}

<?
}
}
else
{
?>
function changedepesel(xx)
{
}
<?
}
?>

function ver_tipodocuTRD(codserie,tsub)
 {
   <?php
 		//echo "ver_tipodocumental(); ";
 		$isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
 		            WHERE RADI_NUME_RADI = '$numrad'";
 		$rsDepR = $db->conn->Execute($isqlDepR);
 		$coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
 		$codusua = $rsDepR->fields['RADI_USUA_ACTU'];
 		$ind_ProcAnex="N";
   ?>
   window.open("./radicacion/tipificar_documento.php?<?=session_name()."=".session_id()?>&nurad=<?=$verrad?>&ind_ProcAnex=<?=$ind_ProcAnex?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>&codusuario=<?=$codusuario?>&dependencia=<?=$dependencia?>&tsub="+tsub+"&codserie="+codserie,"Tipificacion_Documento","height=600,width=850,scrollbars=yes");
 }


function ver_temas(){
   window.open("./tipo_documento.php?<?=session_name()."=".session_id()?>&verrad=<?=$verrad?>","Temas","height=350,width=450,scrollbars=yes");
}



</script>

<div id="spiffycalendar" class="text"></div>
<script language="JavaScript" src="js/spiffyCal/spiffyCal_v2_1.js"></script>
<link rel="stylesheet" type="text/css" href="js/spiffyCal/spiffyCal_v2_1.css">
</head>
<?php
// Modificado Supersolidaria
if( isset( $_GET['ordenarPor'] ) && $_GET['ordenarPor'] != "" ){
 $body = "document.location.href='#t1';";
}
?>
<body <?=$body?>>
<?
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$fechah=date("dmy_h_m_s") . " ". time("h_m_s");
	$check=1;
	$numeroa=0;$numero=0;$numeros=0;$numerot=0;$numerop=0;$numeroh=0;
  include "ver_datosrad.php";
    $_SESSION['dir_doc_us1'] = $cc_documento_us1;
    $_SESSION['dir_doc_us2'] = $cc_documento_us2;

	if($verradPermisos == "Full" or $datoVer=="985")
 		{

 		}else
 		{
 			$numRad = $verrad;
 			if($nivelRad==1) include "$ruta_raiz/seguridad/sinPermisoRadicado.php";
 			if($nivelRad==1) die("-");
 		}
 ?>
<table width=100%   class="table table-striped table-bordered table-hover dataTable">
 <tr>
   <td >
<?
 if($krd)
	{
	$isql = "select * From usuario where USUA_LOGIN ='$krd' and USUA_SESION='". substr(session_id(),0,29)."' ";
	$rs = $db->query($isql);
	if (($krd))
	{
  ?><small>
	DOCUMENTO N.
	<?
	if ($mostrar_opc_envio==0 and $carpeta!=8 and !$agendado)
	{
		$ent=substr($verrad, -1);
        echo "<a title='Click para modificar el Documento' href='./radicacion/NEW.php?nurad=$verrad&Buscar=BuscarDocModUS&".session_name()."=".session_id()."&Submit3=ModificarDocumentos&Buscar1=BuscarOrfeo78956jkgf' notborder >$verrad</a>";
	}else echo $verrad;

    /*
     *  Modificado: 15-Agosto-2006 Supersolidaria
     *  Muestra el numero del expediente al que pertenece el radicado.
	 */
	if( $numExpediente && $_GET['expIncluido'][0] == "" )
    {
        echo "<span class=noleidos>&nbsp;&nbsp;&nbsp;PERTENECIENTE AL EXPEDIENTE No. ". ( $_SESSION['numExpedienteSelected'] != "" ?  $_SESSION['numExpedienteSelected'] : $numExpediente )."</span>";
	}
    else if( $_GET['expIncluido'][0] != "" )
	{
        echo "<span class=noleidos>&nbsp;&nbsp;&nbsp;PERTENECIENTE AL EXPEDIENTE No. ".$_GET['expIncluido'][0]."</span>";
        $_SESSION['numExpedienteSelected'] = $_GET['expIncluido'][0];
	}

	?>
	</small></td>
	<td class="titulos5">
      <a class="vinculos" href='./solicitar/Reservas.php?radicado=<?="$verrad"?>'><small>Solicitados</small></a>
    </td>
    <td class="titulos5">
      <a class="vinculos" href='./solicitar/Reservar.php?radicado=<?="$verrad&sAction=insert"?>'><small>Solicitar Fisico</small></a>
    </td>
  </tr>
</table>
<?
$datosaenviar = "fechaf=$fechaf&mostrar_opc_envio=$mostrar_opc_envio&tipo_carp=$tipo_carp&carpeta=$carpeta&nomcarpeta=$nomcarpeta&datoVer=$datoVer&ascdesc=$ascdesc&orno=$orno";
?>
<form name="form1" id="form1" action="<?=$ruta_raiz?>/tx/formEnvio.php?<?=session_name()?>=<?=session_id()?>" method="GET" class="smart-form">
<?php
if($verradPermisos=="Full" && !($carpeta==66 || $carpeta==8 ) )
{
}
?>
<input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
<input type=hidden name=enviara value='9'>
<input type=hidden name=codTx value='9'>
<input id="chkr" type="checkbox" value="CHKANULAR" name="checkValue[<?=$verradicado?>]" checked  >
 <?
echo "<input type='hidden' name='fechah' value='$fechah'>";
// Modificado Infom�trika 22-Julio-2009
// Compatibilidad con register_globals = Off.
print "<input type='hidden' name='verrad' value='".$verrad."'>";
if($flag==2)
	{
	echo "<CENTER>NO SE HA PODIDO REALIZAR LA CONSULTA<CENTER>";
	}
else
	{
	$row = array();
	$row1 = array();
	if($info)
	{
		$row["INFO_LEIDO"]=1;
		$row1["DEPE_CODI"] = $dependencia;
		$row1["USUA_CODI"] = $codusuario;
		$row1["RADI_NUME_RADI"] = $verrad;
		$rs = $db->update("informados", $row, $row1);
	}
	elseif (($leido!="no" or !$leido) and $datoVer!=985)
	{
		$row["RADI_LEIDO"]=1;
		$row1["radi_depe_actu"] = $dependencia;
		$row1["radi_usua_actu"] = $codusuario;
		$row1["radi_nume_radi"] = $verrad;
		$rs = $db->update("radicado", $row, $row1);
	}
}
include "ver_datosrad.php";
include "ver_datosgeo.php";
$tipo_documento .= "<input type=hidden name=menu_ver value='$menu_ver'>";
$hdatos = session_name()."=".session_id()."&leido=$leido&nomcarpeta=$nomcarpeta&tipo_carp=$tipo_carp&carpeta=$carpeta&verrad=$verrad&datoVer=$datoVer&fechah=fechah&menu_ver_tmp=";

	}else {
	?>
</form>
<form name='form11' action='enviar.php' method='GET'>
<input type=hidden name=depsel>
<input type=hidden name=depsel8>
<input type=hidden name=carpper>
<CENTER>
	<span class='titulosError'>SU SESION HA TERMINADO O HA SIDO INICIADA EN OTRO EQUIPO</span><BR>
	<span class='eerrores'>
	</CENTER>
		<?
	}
}else {echo "<center><b><span class='eerrores'>NO TIENE AUTORIZACION PARA INGRESAR</span><BR><span class='eerrores'><a href='login.php' target=_parent>Por Favor intente validarse de nuevo. Presione aca!</span></a>";}

include_once("$ruta_raiz/tx/txOrfeo.php");
?>
</form>
<!-- row -->
 <input type=hidden name=reftab id=reftab >
	<div class="well well-sm well-light">
		<div id="tabs">
			<ul>
				<li>
					<div><a href="#tabs-a">Informaci&oacute;n del Radicado</a></div>
				</li>

				<li>
					<a href="#tabs-b">Traza</a>
				</li>

				<li>
					<a href="#tabs-c">Documentos Anexos</a>
				</li>

				<li>
					<a href="#tabs-d">Expediente</a>
				</li>
				<li>
					<a href="#tabs-gis">Gis</a>
				</li>

			</ul>
			<ul>

			<div id="tabs-a">
					<?php include "lista_general.php"; ?>
			</div>
			<div id="tabs-b">
				<p>
					Cargando . . .
				</p>
			</div>

			<div id="tabs-c">
				<p>
					<?php include "./lista_anexos.php"; ?>
				</p>
			</div>
			<div id="tabs-d">
			  Cargando . . .
				<?php  // include "./expediente/lista_expedientes.php"; ?>
			</div>
				<div id="tabs-gis" width="100%">
				<?php include "./gis/verGis.php"; ?>
			</div>
			</ul>
		</div>
  </div>

  <script>
function cargarPagina(pagina,nombreDiv){
$.post( pagina,{verradicado:"<?=$verradicado?>"}, function( data ) {
  $('#'+ nombreDiv).html(data);
});
}
</script>  
  
<script type="text/javascript">
$( document ).ready(function(){
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	$('#tabs').tabs();
    $( "#tabs" ).on( "tabsactivate", function( event, ui ) {
        window.location.href = ui.newTab.find('a.ui-tabs-anchor').attr('href');
        if($(ui.newTab).attr('aria-controls')=='tabs-b') cargarPagina('./ver_historico.php','tabs-b');
        if($(ui.newTab).attr('aria-controls')=='tabs-d') cargarPagina('./expediente/lista_expedientes.php','tabs-d');
        console.log(window.location.href);
    } );

	// Dynamic tabs
	var tabTitle = $("#tab_title"), tabContent = $("#tab_content"), tabTemplate = "<li style='position:relative;'> <span class='air air-top-left delete-tab' style='top:7px; left:7px;'><button class='btn btn-xs font-xs btn-default hover-transparent'><i class='fa fa-times'></i></button></span></span><a href='#{href}'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #{label}</a></li>", tabCounter = 2;

  $('#chkr, #depsel, #carpper, #Enviar').hide();

});
</script>



</body>
</html>
