<?
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
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

session_start();

if($_POST["nombreEtapa"]) $nombreEtapa = $_POST["nombreEtapa"];
if($_POST["terminoEtapa"]) $terminoEtapa = $_POST["terminoEtapa"];
if($_POST["proceso"]) $proceso = $_POST["proceso"];
if($_POST["etapaAEliminar"]) $etapaAEliminar = $_POST["etapaAEliminar"];
if($_POST["clickboton"]) $clickboton = $_POST["clickboton"];
if($_GET["crear"]) $crear = $_GET["crear"];

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$ruta_raiz = "../../..";

include "$ruta_raiz/config.php";
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler( "$ruta_raiz" );
if (!defined('ADODB_FETCH_ASSOC'))define('ADODB_FETCH_ASSOC',2);
$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
$entrada = 0;
$modificaciones = 0;
$salida = 0;

	$subtitulo = "CREAR O MODIFICAR ETAPAS";
	$nombreBoton = "Crear";

	if( $_GET['proceso'] != '' ){
		$procesoSelected = $_GET['proceso'];
	}elseif ( $_POST['proceso'] != ''){
		$procesoSelected = $_POST['proceso'];
	}
	include_once "$ruta_raiz/include/query/flujos/queryProcesos.php";

	$rsTRDProc=$db->query( $sqlSerie );

	if( $rsTRDProc ){

			$_SESSION["serieProc"] = $rsTRDProc->fields['SGD_SRD_CODIGO'];
			$_SESSION["subserieProc"] = $rsTRDProc->fields['SGD_SBRD_CODIGO'];

	}
?>
<html>
<head>
<title>Creacion de Proceso</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<script language="JavaScript">
<!--

	function validarDatos()
	{
		if(document.frmCrearEtapa.nombreEtapa.value == "")
        {       alert("Debe ingresar nombre de la Etapa." );
                document.frmCrearEtapa.nombreEtapa.focus();
                return false;
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
	 	document.frmCrearEtapa.submit();
	}

	function verificaEliminacion( etapaParaEliminacion, puedeEliminar, form ){
		if ( puedeEliminar ) {

			alert("La etapa: " + etapaParaEliminacion + ", no se puede eliminar porque hay conexiones que dependen de ella.");
			if (form.etapaAEliminar.length)
						{

							for (var b = 0; b < form.etapaAEliminar.length; b++)
								if (form.etapaAEliminar[b].checked)
								{
									form.etapaAEliminar[b].checked = false; break;
								}

						} else
							form.etapaAEliminar.checked = false;
			return false;
		}else{
				var confirmaEliminacion = confirm("Seguro que desea eliminar la etapa: " + etapaParaEliminacion + "?");
				if( confirmaEliminacion ){
					form.submit();
					return true;
				}else{
					//Al no confirmar la eliminación se debe desmarcar la etapa que se habia marcado para eliminación
					if (form.etapaAEliminar.length)
						{

							for (var b = 0; b < form.etapaAEliminar.length; b++)
								if (form.etapaAEliminar[b].checked)
								{
									form.etapaAEliminar[b].checked = false; break;
								}

						} else
							form.etapaAEliminar.checked = false;
					return false;
				}
		}

	}

function Start(URL, WIDTH, HEIGHT){
 windowprops = "top=0,left=0,location=no,status=no, menubar=no,scrollbars=yes, resizable=yes,width=";
 windowprops += WIDTH + ",height=" + HEIGHT;
 window.open(URL , "preview", windowprops);
}

function regresar(){
	window.location.reload();
	window.close();
}

function carga(){
		document.frmCrearEtapa.nombreEtapa.value = '';
		document.frmCrearEtapa.terminoEtapa.value = '';
	    document.frmCrearEtapa.nombreEtapa.focus();
}
//-->
</script>

</head>
<body onload="carga();">
<?
	$resultadoInsercion = 1;

	if( $_GET['proceso'] != '' ){
		$procesoSelected = $_GET['proceso'];
	}elseif ( $_POST['proceso'] != ''){
		$procesoSelected = $_POST['proceso'];
	}

	if( $etapaAEliminar ){
		$queryELimina = "DELETE FROM SGD_FEXP_FLUJOEXPEDIENTES WHERE SGD_FEXP_CODIGO = " .$etapaAEliminar;
		 $rs = $db->conn->query( $queryELimina );
		 if($rs){
		 	$resultadoInsercion = "Se elimin&oacute; la etapa de forma satisfactoria";
		 }else {
		 	$resultadoInsercion = "Error eliminando la etapa";
		 }

	}

	if ( $_POST['nombreEtapa'] != '' && $clickBoton && !$etapaAEliminar ){
			include "$ruta_raiz/include/tx/Proceso.php";
	 		$flujo = new EtapaFlujo( $db );

	 		$flujo->initEtapa( $nombreEtapa, $ordenEtapa, $terminoEtapa, $procesoSelected );

			$resultadoInsercion = $flujo-> insertaEtapa(  );

			$clickBoton = false;
	}
?>
<form name='frmCrearEtapa' action='creaEtapa.php?&crear=<?=$crear?>' method="post">
  <div class="col-sm-12">
    <!-- widget grid -->
    <h2></h2>
    <section id="widget-grid">
      <!-- row -->
      <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!-- Widget ID (each widget will need unique ID)-->
          <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">

            <header>
              <h2>
                Administraci&oacute;n de flujos<br>
                <small><?=$subtitulo?></small>
              </h2>
            </header>
            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">
                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr class=timparr>
                        <td class="titulos2" height="26">Nombre Etapa:</td>
                        <td class="listado2" height="1">
                          <input type=text name=nombreEtapa value='<?=$nombreEtapa?>'>
                      </td>

                        <td class="titulos2" height="26" width="100%" colspan="2"> Convenciones para listado de conexiones</td>

                    </tr>
                    <tr class=timparr>
                        <td class="titulos2" height="26" width="25%">Duraci&oacute;n (d&iacute;as)</td>
                        <td class="listado2" height="1" width="25%">
                          <input type=text name=terminoEtapa value='<?=$terminoEtapa?>'>
                        </td>
                      </td>

                        <td class="titulos2" height="26" width="25%"><img src="../../../imagenes/FlechasEntrada2b.gif">  </td>
                        <td class="listado2" height="1" width="75%">Indica que la conexi&oacute;n es de entrada a dicha etapa </td>
                    </tr>
                    <tr class=timparr>
                        <td class="titulos2" height="26" width="25%">Serie del Proceso: &nbsp;&nbsp;<font color="Green" size="3"><?=$_SESSION["serieProc"]?></font></td>
                        <td class="listado2" height="1" width="25%">SubSerie del Proceso: &nbsp;&nbsp;<font color="Green" size="3"><?=$_SESSION["subserieProc"]?>
                        </font></td>
                        <td class="titulos2" height="26" width="25%"><img src="../../../imagenes/FlechasSalida.gif"> </td>
                        <td class="listado2" height="1" width="75%">Indica que la conexi&oacute;n es de salida a dicha etapa </td>
                    </tr>
                  </table>
                </div>

                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr class=timparr>
                          <td height="30" colspan="6" class="listado2"><span class="celdaGris"> <span class="e_texto1">
                        <center> <input class="botones" type="button" Value=<?=$nombreBoton?> onClick=" return validarDatos();"> </center> </span></td>
                    </tr>
                  </table>
                </div>

                <input name='proceso' type='hidden' value='<?=$procesoSelected?>'>
                <input name='clickboton' type='hidden' value='<?=$clickBoton?>'>

<?  if ( ( $_POST['nombreEtapa'] != '' ||  $etapaAEliminar != null )) { ?>
               <center>
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr>
                        <td class=titulos2>
                          <?=$resultadoInsercion?>
                        </td>
                      </tr>
                    </table>
                </div>
               </center>
              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>
<?  } ?>
<?  include("./listadoEtapas.php"); ?>

</form>
</body>
</html>
