<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

Orfeo Models are the data definition of Orfeo Information System
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

/**
  * Pagina que crea las aristas de un proceso
  * @autor Jairo Losada 2009-08
  *        Correlibre.org 2013
  * @licencia GNU/GPL V 3
  */
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

if($_GET["crear"]) $crear = $_GET["crear"];
if($_GET["proceso"]) $proceso = $_GET["proceso"];
if($_GET["etapaCreaArista"]) $etapaCreaArista = $_GET["etapaCreaArista"];

if($_POST["nombreEtapa"]) $nombreEtapa = $_POST["nombreEtapa"];
if($_POST["etapaInicial"]) $etapaInicial = $_POST["etapaInicial"];
if($_POST["etapaFinal"]) $etapaFinal = $_POST["etapaFinal"];
if($_POST["terminoEtapa"]) $terminoEtapa = $_POST["terminoEtapa"];
if($_POST["nombreProceso"]) $nombreProceso = $_POST["nombreProceso"];
if($_POST["codserie"]) $codserie = $_POST["codserie"];
if($_POST["tsub"]) $tsub = $_POST["tsub"];
if($_POST["tipo"]) $tipo = $_POST["tipo"];
if($_POST["proceso"]) $proceso = $_POST["proceso"];
if($_POST["etapaAEliminar"]) $etapaAEliminar = $_POST["etapaAEliminar"];
if($_POST["clickboton"]) $clickboton = $_POST["clickboton"];
if($_POST["etapaInicial"]) $cetapaInicial = $_POST["etapaInicial"];
if($_POST["etapaFinal"]) $etapaFinal = $_POST["etapaFinal"];
if($_POST["descripcionArista"]) $descripcionArista = $_POST["descripcionArista"];
if($_POST["diasMinimo"]) $diasMinimo = $_POST["diasMinimo"];
if($_POST["diasMaximo"]) $diasMaximo = $_POST["diasMaximo"];
if($_POST["trad"]) $trad = $_POST["trad"];
if($_POST["tipificacion"]) $tipificacion = $_POST["tipificacion"];
if($_POST["automatico"]) $automatico = $_POST["automatico"];
if($_POST["ClickCrea"]) $ClickCrea = $_POST["ClickCrea"];
if($_POST["clickboton"]) $clickboton = $_POST["clickboton"];
if($_POST["Button_x"]) $Button_x = $_POST["Button_x"];
if($_POST["Button_y"]) $Button_y = $_POST["Button_y"];
if($_POST["Button"]) $Button = $_POST["Button"];


$ruta_raiz = "../../..";
$entrada = 0;
$modificaciones = 0;
$salida = 0;
$trdDisabled = false;
if ( $tipificacion ) $deshabilitado =  ""; else $deshabilitado =  "disabled=true";

 include "$ruta_raiz/config.php";
	include_once "$ruta_raiz/include/db/ConnectionHandler.php";
    $db = new ConnectionHandler( "$ruta_raiz" );
    if (!defined('ADODB_FETCH_ASSOC'))define('ADODB_FETCH_ASSOC',2);
    $ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
	if( $_GET['proceso'] != '' ){
		$procesoSelected = $_GET['proceso'];
	}elseif ( $_POST['proceso'] != ''){
		$procesoSelected = $_POST['proceso'];
	}
	include_once "$ruta_raiz/include/query/flujos/queryAristas.php";
	$rsDepMax = $db->conn->Execute( $sqlMax );
	$idEtapas = $rsDepMax->fields['MAXETAPAS'];
?>
<html>
<html>

<head>
  <title>Sistema de informaci&oacute;n integrado</title>
  <meta charset="utf-8">
  <!-- Bootstrap core CSS -->
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<title>Creaci&oacute;n de Proceso </title>
<script language="JavaScript">
<!--

var nodo  =0;
	function nuevoAjax(){
        var xmlhttp=false;
        if(typeof XMLHttpRequest!='undefined'){
                xmlhttp = new XMLHttpRequest();
        }else{
                try {
                        this.xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e) {
                        try {
                                        this.xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (E) {
                                xmlhttp = false;
                        }
                }
        }
        return xmlhttp;
	}
	function $(elemento){
		return document.getElementById(elemento);

	}


function consulta(componente){
		var compon;
		var param="";
		var nodo="";
		var nomcompo=componente.id.substr( 0, 4 );
		if( nomcompo == "tsub" ){

			nodo=componente.id.substr( 4 );
			compon="tipo";
			param="&tsub="+componente.value;
		}else{
			nodo=componente.id.substr(8);
			compon="tsub";
			param="&subserie=1";
		}
		pagina="trd.php?codserie="+$("codserie").value+param;
		ajax=nuevoAjax();
		ajax.open("GET",pagina ,true);
        ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
                     $(compon).innerHTML = ajax.responseText;
                }
        }
        ajax.send(null)
	}


	function validarDatos()
	{
		if(document.frmCrearArista.descripcionArista.value == "")
        {       alert("Debe ingresar la descripcion de la Conexion." );
                document.frmCrearArista.descripcionArista.focus();
                return false;
        }

		var minimo = document.frmCrearArista.diasMinimo.value;
		var maximo = document.frmCrearArista.diasMaximo.value;
		var enteroMin = parseInt(minimo);
		var enteroMax = parseInt(maximo);

        if( enteroMin < 0 || enteroMin > 999 )
        {       alert("El valor para Dias Minimo debe estar entre 0 y 999" );
                document.frmCrearArista.diasMinimo.focus();
                return false;
        }
        if( enteroMax < 0 || enteroMax > 999 )
        {       alert("El valor para Dias Maximo debe estar entre 0 y 999" );
                document.frmCrearArista.diasMaximo.focus();
                return false;
        }

        if( minimo != '' && isNaN(enteroMin) )
        {
               alert( "Solo debe ingresar numeros en dias minimo" );
                document.frmCrearArista.diasMinimo.focus();
                return false;
        }

        if( maximo != '' && isNaN(enteroMax) )
        {
               alert( "Solo debe ingresar numeros en dias maximo" );
                document.frmCrearArista.diasMaxnimo.focus();
                return false;
        }

        var tipifica = document.frmCrearArista.tipificacion.checked;
        var serieDoc = document.frmCrearArista.codserie.value;
        var subserieDoc = document.frmCrearArista.tsub.value;
        var tipoDoc = document.frmCrearArista.tipo.value;

        if( tipifica  && ( serieDoc == 0 || subserieDoc == 0 || tipoDoc == 0 ))
        {       alert("Si selecciona tipificacion, debe seleccionar la serie, subserie y tipo documental." );

                return false;
        }

	 	document.frmCrearArista.submit();
	}

function Start(URL, WIDTH, HEIGHT)
{
 windowprops = "top=0,left=0,location=no,status=no, menubar=no,scrollbars=yes, resizable=yes,width=700,height=500";
 window.open(URL , "preview", windowprops);
}

function cerrar(){
	window.opener.regresar();
	window.close();
}


function regresar(){
	window.location.reload();
	window.close();
}

	function verificaEliminacion( aristaParaEliminacion, form ){

				var confirmaEliminacion = confirm("Seguro que desea eliminar la conexion: " + aristaParaEliminacion);
				if( confirmaEliminacion ){
					form.submit();
					return true;
				}else{

						if (form.aristaAEliminar.length)
						{

							for (var b = 0; b < form.aristaAEliminar.length; b++)
								if (form.aristaAEliminar[b].checked)
								{
									form.aristaAEliminar[b].checked = false; break;
								}
						} else
							form.aristaAEliminar.checked = false;

					return false;
				}
	}

	function verificaEtapas(){
		//Verificar primero si hay etapas para el flujo, si no hay no se pueden crear aristas
		<?

			if( $idEtapas < 1 ){
		?>
		alert("El flujo para el Proceso seleccionado no tiene Etapas,\npor lo tanto no puede crear Conexiones. \nSera redireccionado a la pagina de creacion de etapas.");
			window.location = 'creaEtapa.php?proceso=<?=$procesoSelected?>';
		<?
			}else {

		?>

			return true;
		<?
			}
		?>
	}

//-->
</script>

</head>
<body onload="verificaEtapas()">
<?
	if( $aristaAEliminar ){
		$queryELimina = "DELETE FROM SGD_FARS_FARISTAS WHERE SGD_FARS_CODIGO = " .$aristaAEliminar;
		 $rs = $db->conn->query( $queryELimina );
		 if($rs){
		 	$resultadoInsercion = "Se elimin&oacute; la conexi&oacute;n de forma satisfactoria";
		 }else {
		 	$resultadoInsercion = "Error eliminando la conexi&oacute;n";
		 }

	}
	if ($_GET['etapaCreaArista']) {
		$etapaInicial = $_GET['etapaCreaArista'];
	}elseif ($_POST['etapaCreaArista']) {
		$etapaInicial = $_POST['etapaCreaArista'];
	}

	if( ( $_POST['descripcionArista'] != '' &&  $_POST['codserie'] != null &&  $_POST['tsub'] != null &&  $_POST['tipo'] != null  &&  $_POST['codserie'] != 0 &&  $_POST['tsub'] != 0 &&  $_POST['tipo'] != 0 &&  $_POST['tipificacion'] != null &&  $_POST['tipificacion'] != '' && !$aristaAEliminar  && $ClickCrea == 'Crear')
	||  ( $_POST['descripcionArista'] != '' &&  $_POST['codserie'] == 0 &&  $_POST['tsub'] == 0 &&  $_POST['tipo'] == 0 &&  $_POST['tipificacion'] == null && !$aristaAEliminar   && $ClickCrea == 'Crear')
			 ){
			include "$ruta_raiz/include/tx/Proceso.php";
	 		$flujo = new AristaFlujo( $db );
			if( $_POST['tipificacion'] != ''){
		 		$serieArista = $codserie;
		 		$subserieArista = $tsub;
			}else {
		 		$serieArista = 0;
		 		$subserieArista = 0;
			}

	 		$flujo->initArista( $etapaInicial, $etapaFinal, $descripcionArista, $diasMinimo, $diasMaximo, $trad,$serieArista,$subserieArista, $tipo, $procesoSelected, $_POST['automatico'], $tipificacion );

			$resultadoInsercion = $flujo-> insertaArista(  );
	}
?>
<form name='frmCrearArista' action='creaArista.php?proceso=<?=$procesoSelected?>' method="post" class="smart-form">
<table width="93%"  class="table table-bordered" align="center">
  	<tr >
    <td colspan="2" >
	<center>
	ADMINISTRACI&Oacute;N DE FLUJOS</span></BR>
	Crear conexi&oacute;n</center>
	</td>
	</tr>
</table>

<table  width=93% class="table table-bordered" align="center">
	<tr >
			<td  ><small>Etapa Inicial</small></td>
			<td  colspan=3><label class="select state-success">
				<?
				$rsDep = $db->conn->query( $sql );
				print $rsDep->GetMenu2( "etapaInicial", $etapaInicial, false, false, 0," class='select'" );

				?>
			</select>
		</td>
	</tr>
	<tr >
			<td  ><small>Etapa Final</small></td>
			<td  colspan=3><label class="select state-success">
				<?
				$rsDep = $db->conn->query( $sql );
				print $rsDep->GetMenu2( "etapaFinal", $etapaFinal, false, false, 0," class='select'" );
				?>
				</label>
		</td>
	</tr>
                <tr>
                <td  >
                <small>Descripci&oacute;n:</small>
                        </td>
                        <td    colspan=3>
                        <label class="input state-success">
                        <input type="text" name="descripcionArista"  id="descripcionArista" value="<?=$descripcionArista?>"  size=60 lenght=100 >
                        </label>
                </td>
                </tr>
        </td>
  </tr>
	   <tr>
	        <td    width="25%">
	        	<small>D&iacute;as M&iacute;nimo:</small>
	        </td>
	        <td   width="25%">
	        	<small><label class="input state-success"><input type="text" name="diasMinimo" value="<?=$diasMinimo?>" size="15" lenght="3" ></label>
	        	</small>
	        </td>
	        <td    width="25%">
	        	<small>D&iacute;as M&aacute;ximo</small>
	        </td>
	        <td    width="25%">
	        	<label class="input state-success"><input type="text" name="diasMaximo" value="<?=$diasMaximo?>" size="15" lenght="3">
	        	</label>
	        </td>
        </tr>
        <tr>
            <td   width="25%">
            	<small>Tipo de Radicado:</small>
            </td>
            <td    width="25%"><label class="select state-success">
            	<?

			 	include_once "$ruta_raiz/include/query/flujos/queryTiposDoc.php";
				$rsDep = $db->conn->Execute( $sql );

				print $rsDep->GetMenu2( "trad", $trad, "0:-- Ninguno --", false, ""," class='select'" );

				?></label>
            </td>
            <td   width="25%">
            	<small>Autom&aacute;tico:</small>
            </td>
            <td    width="25%">
             	   <input type="checkbox" name="automatico" <? if ($automatico) echo "checked"; else echo "";?> >
            </td>
        </tr>
        <tr>
        	<td  colspan=2>
            	<small>Incluye Accion al Clasificar (Tipificaci&oacute;n:)
            </td>
            <td >
                <input type="checkbox" name="tipificacion" <? if ($tipificacion) echo "checked"; else echo "";?> onchange="submit();">
            </td>
            <td    width="25%">

            </td>
        </tr>
</table>
<?php
 if($tipificacion){
 ?>
 <table width="93%" align="center" class="table table-bordered" id=tablaTRD >
	<tr align="center">
		<td height="35" colspan="2" ><small>Aplicaci&Oacute;n de la TRD para la Conexi&oacute;n</small></td>
	</tr>
	<tr align="center">
		<td width="36%" ><small>SERIE</small></td>
		<td width="64%" height="35" ><label class="select state-success">
		<?php
    include "$ruta_raiz/trd/actu_matritrd.php";
    if(!$codserie) $codserie = 0;
	$fechah=date("dmy") . " ". time("h_m_s");
	$fecha_hoy = Date("Y-m-d");
	$sqlFechaHoy=$db->conn->DBDate($fecha_hoy);
	$check=1;
	$fechaf=date("dmy") . "_" . time("hms");
	$num_car = 4;
	$nomb_varc = "sgd_srd_codigo";
	$nomb_varde = "sgd_srd_descrip";
   	include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";

//   	$sqlConcat = $db->conn->Concat("$nomb_varde","' -- '","$nomb_varc");
	$querySerie = "select distinct ($sqlConcat) as detalle, sgd_srd_codigo
	         from sgd_srd_seriesrd
			 order by detalle
			  ";
	$rsD=$db->conn->query($querySerie);
	$comentarioDev = "Muestra las Series Docuementales";
	include "$ruta_raiz/include/tx/ComentarioTx.php";
	//$codserie = $_SESSION["serieProc"];
	print $rsD->GetMenu2("codserie", $codserie, "0:-- Seleccione --", false,"","onChange='consulta(this);' class='select' " . $deshabilitado." id='codserie'"  );
		?>
				</label></td>
	</tr>
		 	<tr align="center">
									<td width="36%" ><small>SUBSERIE</small></td>
									<td width="64%" height="35" ><label class="select state-success">
									<select name="tsub" id="tsub"  onChange="consulta(this);" class="select">
									<option value="0" selected >-- Seleccione --</option>
									</select>
									</label>
									</td>
								</tr>
							  	<tr align="center">
									<td width="36%" ><small>TIPO DE DOCUMENTO</small></td>
									<td width="64%" height="35" ><label class="select state-success">
								<select name="tipo" id="tipo" class="select">
									<option value="0" selected >-- Seleccione --</option>
									</select></label></td>
						</tr>
</table>
<?php
 }
?>
<input name='proceso' type='hidden' value='<?=$procesoSelected?>'>

<table border=1 width=93% class="table table-bordered" align="center">
	<tr >
	<td height="30" colspan="2" >
	<center> <input class="btn btn-primary btn-xs" type="submit" Value="Crear"  onClick=" return validarDatos();"  name="ClickCrea"> </center>
	</td>
	<td height="30" colspan="2" ><span class="celdaGris">
	<center><input class="btn btn-primary btn-xs" type=button name=Cerrar id=Cerrar Value=Cerrar onclick='cerrar();'></a></center>  </span>
	</td>
	</tr>
</table>
<?
if ($_POST['descripcionArista'] != ''  ||  $aristaAEliminar != null ) {
  ?>
		<center>
			<table class="table table-bordered">
				<tr>
					<td class=titulosError>
					   <?=$resultadoInsercion?>
					</td>
				</tr>
			</table>
		</center>
<?
	}

?>
<?
	include("./listadoAristas.php");
?>
</form>
</body>
</html>
