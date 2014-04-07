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

if($carpeta==8)
{	$info=8;
	$nombcarpeta = "Informados";
}

include_once "$ruta_raiz/class_control/Radicado.php";
$objRadicado = new Radicado($db);
$objRadicado->radicado_codigo($verradicado);
$path = $objRadicado->getRadi_path();
/*
  * @author Modificacion Liliana Gomez Velasquez
  * @since 10 noviembre 2009
  * @category imagenes
 */
include_once "$ruta_raiz/tx/verLinkArchivo.php";
$verLinkArchivo = new verLinkArchivo($db);

/** verificacion si el radicado se encuentra en el usuario Actual
*
*/

include "$ruta_raiz/tx/verifSession.php";

?>
<html><head><title>.: Modulo total :.</title>
<?php include_once "htmlheader.inc.php"; ?>
<!-- seleccionar todos los checkboxes-->
<?php include_once "$ruta_raiz/js/funtionImage.php"; ?>
<SCRIPT LANGUAGE="JavaScript">
function datosBasicos()
{
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
function  window_onload()
{	<?	if($verradPermisos == "Full" or $datoVer=="985")
{
?>
window_onload2();
<?
}
?>
}
<?
}
?>
</script>
<?
include "pestanas.js";
?>
<script >
<?
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

function window_onload2()
{
<?
if ($menu_ver==3)
{
	echo "ocultar_mod(); ";
	if ($ver_causal) {echo "ver_causales();"; }
	if ($ver_sectores) {echo "ver_sector();"; }
	if ($ver_flujo) {echo "ver_flujo();"; }
	if ($ver_VinAnexo) {echo "verVinculoDocto();"; }
}
 ?>
}
function verNotificacion() {
   mostrar("mod_notificacion");
   ocultar("tb_general");
   ocultar("mod_causales");
   ocultar("mod_sector");
   ocultar("mod_flujo");
}
function ver_datos()
{
   mostrar("tb_general");
   ocultar("mod_causales");
   ocultar("mod_sector");
   ocultar("mod_flujo");
}
function ocultar_mod()
{
   ocultar("mod_causales");
   ocultar("mod_sector");
   ocultar("mod_flujo");
}

function ver_tipodocumental()
{
<?
	if($menu_ver_tmp!=2)
	{
?>
	   ocultar("tb_general");
	   ocultar("mod_causales");
	   ocultar("mod_flujo");
<?	} ?>
}
function ver_tipodocumento()
{
   ocultar("tb_general");
   ocultar("mod_causales");
   ocultar("mod_flujo");
}
function verDecision()
{
   ocultar("tb_general");
   ocultar("mod_causales");
   ocultar("mod_flujo");
}
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
   window.open("./radicacion/tipificar_documento.php?<?=session_name()."=".session_id()?>&nurad=<?=$verrad?>&ind_ProcAnex=<?=$ind_ProcAnex?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>&codusuario=<?=$codusuario?>&dependencia=<?=$dependencia?>&tsub="+tsub+"&codserie="+codserie,"Tipificacion_Documento","height=500,width=750,scrollbars=yes");
 }

function verVinculoDocto()
{
<?php
		echo "ver_tipodocumental(); ";
  ?>
  window.open("./vinculacion/mod_vinculacion.php?verrad=<?=$verrad?>&codusuario=<?=$codusuario?>&dependencia=<?=$dependencia?>","Vinculacion_Documento","height=500,width=750,scrollbars=yes");
}


function verResolucion()
{
   ocultar("tb_general");
   ocultar("mod_causales");
   ocultar("mod_flujo");
   ocultar("mod_tipodocumento");
   mostrar("mod_resolucion");
   ocultar("mod_notificacion");
}

function ver_temas(){
   window.open("./tipo_documento.php?<?=session_name()."=".session_id()?>&verrad=<?=$verrad?>","Temas","height=200,width=400,scrollbars=yes");
}

function ver_flujo()
{
   ocultar("tb_general");
   ocultar("mod_tipodocumento");
   ocultar("mod_causales");
   ocultar("mod_sector");
   ocultar("mod_resolucion");
   ocultar("mod_notificacion");
}
function hidden_tipodocumento()
{
  <?
  if(!$ver_tipodoc)
  {
  ?>
      //ocultar_mod();
  <?
  }
  ?>
}
/** FUNCION DE JAVA SCRIPT DE LAS PESTA�S
  * Esta funcion es la que produce el efecto de pertanas de mover a,
  * Reasignar, Informar, Devolver, Vobo y Archivar
  */
</script>
<div id="spiffycalendar" class="text"></div>
<script language="JavaScript" src="js/spiffyCal/spiffyCal_v2_1.js"></script>
<link rel="stylesheet" type="text/css" href="js/spiffyCal/spiffyCal_v2_1.css">
</head>
<?php
// Modificado Supersolidaria
if( isset( $_GET['ordenarPor'] ) && $_GET['ordenarPor'] != "" )
{
 $body = "document.location.href='#t1';";
}
?>
<body bgcolor="#FFFFFF" topmargin="0" onLoad="window_onload();<? print $body; ?>">
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
	// Validacion de Usuario y COntrase� MD5
	//echo "** $krd *** $drde";
	//Modificado por idrd
	if (($krd))
	{
	//  $iusuario = " and us_usuario='$krd'";
	//  $isql = "select a.* from radicado a where radi_depe_actu=$dependencia  and radi_nume_radi=$verrad";
  ?>
	DATOS DEL RADICADO No
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
	</td>
	<td class="titulos5">
      <a class="vinculos" href='./solicitar/Reservas.php?radicado=<?="$verrad"?>'>Solicitados</a>
    </td>
    <td class="titulos5">
      <a class="vinculos" href='./solicitar/Reservar.php?radicado=<?="$verrad&sAction=insert"?>'>Solicitar Fisico</a>
    </td>
  </tr>
</table>
<?
$datosaenviar = "fechaf=$fechaf&mostrar_opc_envio=$mostrar_opc_envio&tipo_carp=$tipo_carp&carpeta=$carpeta&nomcarpeta=$nomcarpeta&datoVer=$datoVer&ascdesc=$ascdesc&orno=$orno";
?>
<form name="form1" id="form1" action="<?=$ruta_raiz?>/tx/formEnvio.php?<?=session_name()?>=<?=session_id()?>" method="GET">
<?php
if($verradPermisos=="Full" && !($carpeta==66 || $carpeta==8 ) )
{
 include "$ruta_raiz/tx/txOrfeo.php";
}
?>
<input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'> 
<input type=hidden name='checkValue[<?=$verrad?>]' value='CHKANULAR'>
<input type=hidden name=enviara value='9'>
</form>
<form action='verradicado.php?<?=session_name()?>=<?=trim(session_id())?>&verrad=<?=$verrad?>&datoVer=<?=$datoVer?>&chk1=<?=$verrad."&carpeta=$carpeta&nomcarpeta=$nomcarpeta"?>' method='GET' name='form2'>
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
<form name='form1' action='enviar.php' method='GET'>
<input type=hidden name=depsel>
<input type=hidden name=depsel8>
<input type=hidden name=carpper>
<CENTER>
	<span class='titulosError'>SU SESION HA TERMINADO O HA SIDO INICIADA EN OTRO EQUIPO</span><BR>
	<span class='eerrores'>
	</CENTER></form>
		<?
	}
}else {echo "<center><b><span class='eerrores'>NO TIENE AUTORIZACION PARA INGRESAR</span><BR><span class='eerrores'><a href='login.php' target=_parent>Por Favor intente validarse de nuevo. Presione aca!</span></a>";}

?>
<!-- row -->
<div >
	<div class="well well-sm well-light">
			<div id="tabs">
				<ul>
					<li>
						<div><a href="#tabs-a">Informacion del Radicado</a></div>
					</li>
					<li>
						<a href="#tabs-b">Traza</a>
					</li>
					<li>
						<a href="#tabs-c">Documeto Anexos</a>
					</li>
					<li>
						<a href="#tabs-d">Expediente</a>
					</li>					
					<li>
						<a href="#tabs-f">WorkFlow</a>
					</li>									
				</ul>
				<div id="tabs-a">
			      <?php include "lista_general.php"; ?>
				</div>
				<div id="tabs-b">
					<p>
						<?php include "ver_historico.php"; ?>
					</p>
				</div>
				<div id="tabs-c">
					<p>
						<?php include "./lista_anexos.php"; ?>
					</p>
				</div>
				<div id="tabs-f" width=80%>
					<p>
						<IFRAME SRC="proceso/workFlow.php?verrad=<?=$verrad?>&numeroExpediente=<?=$numExpediente?>&<?=session_name()."=".session_id()?>" width="100%" height="2000" frameborder="0">  </IFRAME>
					</p>
				</div>				
				<div id="tabs-d">
					<p>
						<?php include "./expediente/lista_expediente.php"; ?>
					</p>
				</div>
			</div>
</div>
<script type="text/javascript">
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();

	// PAGE RELATED SCRIPTS

	// menu
	$("#menu").menu();

	/*
	 * AUTO COMPLETE AJAX
	 */

	function log(message) {
		$("<div>").text(message).prependTo("#log");
		$("#log").scrollTop(0);
	}

	$("#city").autocomplete({
		source : function(request, response) {
			$.ajax({
				url : "http://ws.geonames.org/searchJSON",
				dataType : "jsonp",
				data : {
					featureClass : "P",
					style : "full",
					maxRows : 12,
					name_startsWith : request.term
				},
				success : function(data) {
					response($.map(data.geonames, function(item) {
						return {
							label : item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
							value : item.name
						}
					}));
				}
			});
		},
		minLength : 2,
		select : function(event, ui) {
			log(ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
		}
	});

	/*
	 * Spinners
	 */
	$("#spinner").spinner();
	$("#spinner-decimal").spinner({
		step : 0.01,
		numberFormat : "n"
	});

	$("#spinner-currency").spinner({
		min : 5,
		max : 2500,
		step : 25,
		start : 1000,
		numberFormat : "C"
	});

	/*
	 * CONVERT DIALOG TITLE TO HTML
	 * REF: http://stackoverflow.com/questions/14488774/using-html-in-a-dialogs-title-in-jquery-ui-1-10
	 */
	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
		_title : function(title) {
			if (!this.options.title) {
				title.html("&#160;");
			} else {
				title.html(this.options.title);
			}
		}
	}));


	/*
	* DIALOG SIMPLE
	*/

	// Dialog click
	$('#dialog_link').click(function() {
		$('#dialog_simple').dialog('open');
		return false;

	});

	$('#dialog_simple').dialog({
		autoOpen : false,
		width : 600,
		resizable : false,
		modal : true,
		title : "<div class='widget-header'><h4><i class='fa fa-warning'></i> Empty the recycle bin?</h4></div>",
		buttons : [{
			html : "<i class='fa fa-trash-o'></i>&nbsp; Delete all items",
			"class" : "btn btn-danger",
			click : function() {
				$(this).dialog("close");
			}
		}, {
			html : "<i class='fa fa-times'></i>&nbsp; Cancel",
			"class" : "btn btn-default",
			click : function() {
				$(this).dialog("close");
			}
		}]
	});

	/*
	* DIALOG HEADER ICON
	*/

	// Modal Link
	$('#modal_link').click(function() {
		$('#dialog-message').dialog('open');
		return false;
	});

	$("#dialog-message").dialog({
		autoOpen : false,
		modal : true,
		title : "<div class='widget-header'><h4><i class='icon-ok'></i> jQuery UI Dialog</h4></div>",
		buttons : [{
			html : "Cancel",
			"class" : "btn btn-default",
			click : function() {
				$(this).dialog("close");
			}
		}, {
			html : "<i class='fa fa-check'></i>&nbsp; OK",
			"class" : "btn btn-primary",
			click : function() {
				$(this).dialog("close");
			}
		}]

	});

	/*
	 * Remove focus from buttons
	 */
	$('.ui-dialog :button').blur();

	/*
	 * Just Tabs
	 */

	$('#tabs').tabs();

	/*
	 *  Simple tabs adding and removing
	 */

	$('#tabs2').tabs();

	// Dynamic tabs
	var tabTitle = $("#tab_title"), tabContent = $("#tab_content"), tabTemplate = "<li style='position:relative;'> <span class='air air-top-left delete-tab' style='top:7px; left:7px;'><button class='btn btn-xs font-xs btn-default hover-transparent'><i class='fa fa-times'></i></button></span></span><a href='#{href}'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #{label}</a></li>", tabCounter = 2;

	var tabs = $("#tabs2").tabs();

	// modal dialog init: custom buttons and a "close" callback reseting the form inside
	var dialog = $("#addtab").dialog({
		autoOpen : false,
		width : 600,
		resizable : false,
		modal : true,
		buttons : [{
			html : "<i class='fa fa-times'></i>&nbsp; Cancel",
			"class" : "btn btn-default",
			click : function() {
				$(this).dialog("close");

			}
		}, {

			html : "<i class='fa fa-plus'></i>&nbsp; Add",
			"class" : "btn btn-danger",
			click : function() {
				addTab();
				$(this).dialog("close");
			}
		}]
	});

	// addTab form: calls addTab function on submit and closes the dialog
	var form = dialog.find("form").submit(function(event) {
		addTab();
		dialog.dialog("close");
		event.preventDefault();
	});

	// actual addTab function: adds new tab using the input from the form above
	function addTab() {
		var label = tabTitle.val() || "Tab " + tabCounter, id = "tabs-" + tabCounter, li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)), tabContentHtml = tabContent.val() || "Tab " + tabCounter + " content.";

		tabs.find(".ui-tabs-nav").append(li);
		tabs.append("<div id='" + id + "'><p>" + tabContentHtml + "</p></div>");
		tabs.tabs("refresh");
		tabCounter++;

		// clear fields
		$("#tab_title").val("");
		$("#tab_content").val("");
	}

	// addTab button: just opens the dialog
	$("#add_tab").button().click(function() {
		dialog.dialog("open");
	});

	// close icon: removing the tab on click
	$("#tabs2").on("click", 'span.delete-tab', function() {

		var panelId = $(this).closest("li").remove().attr("aria-controls");
		$("#" + panelId).remove();
		tabs.tabs("refresh");
	});

	/*
	* ACCORDION
	*/
	//jquery accordion
	
     var accordionIcons = {
         header: "fa fa-plus",    // custom icon class
         activeHeader: "fa fa-minus" // custom icon class
     };
     
	$("#accordion").accordion({
		autoHeight : false,
		heightStyle : "content",
		collapsible : true,
		animate : 300,
		icons: accordionIcons,
		header : "h4",
	})

	/*
	 * PROGRESS BAR
	 */
	$("#progressbar").progressbar({
     	value: 25,
     	create: function( event, ui ) {
     		$(this).removeClass("ui-corner-all").addClass('progress').find(">:first-child").removeClass("ui-corner-left").addClass('progress-bar progress-bar-success');
		}
	});

</script>
</body>
</html>
