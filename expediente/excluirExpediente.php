<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
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

if (!$ruta_raiz) $ruta_raiz = "..";
    if (!$_SESSION['dependencia']) header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

define('ADODB_ASSOC_CASE', 1);

$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];
$nurad = $_GET['nurad'];

if ( !$nurad )
{
    $nurad = $rad;
}

error_reporting( 7 );
include_once( "$ruta_raiz/include/db/ConnectionHandler.php" );
$db = new ConnectionHandler( "$ruta_raiz" );
include_once( "$ruta_raiz/include/tx/Historico.php" );

$encabezado = "$PHP_SELF?".session_name()."=".session_id()."&opcionExp=$opcionExp&numeroExpediente=$numeroExpediente&dependencia=$dependencia&krd=$krd&nurad=$nurad&coddepe=$coddepe&codusua=$codusua&depende=$depende&ent=$ent&tdoc=$tdoc&codiTRDModi=$codiTRDModi&codiTRDEli=$codiTRDEli&codserie=$codserie&tsub=$tsub&ind_ProcAnex=$ind_ProcAnex";

error_reporting( 7 );
include_once ("$ruta_raiz/include/tx/Expediente.php");
$expediente = new Expediente( $db );

if( isset( $_POST['expSeleccionados'] ) && $_POST['expSeleccionados'] != "" )
{
    $arrExpSeleccionados = explode( ",", $_POST['expSeleccionados'] );
    foreach( $arrExpSeleccionados as $clave => $numExpediente )
    {
        // Consulta si el radicado está archivado
        $arrDatosArchivado = $expediente->expedienteArchivado( $_GET['nurad'], $numExpediente );
        // Si el radicado está archivado
        if( $arrDatosArchivado['estado'] == 1 )
        {
            $mensaje  = "El documento se encuentra archivado en el expediente No. ".$numExpediente;
            $mensaje .= " Desea excluirlo del expediente y enviar una solicitud a la dependencia de archivo?";
            break;
        }
        // Si el radicado no está archivado
        else if( $arrDatosArchivado['estado'] == 0 )
        {
            $mensaje = "Va a excluir éste documento del(os) Expediente(s) seleccionado(s). <br> Está seguro?";
        }
    }
    
    // Excluye el radicado del expediente
    if( isset( $_POST['confirmaIncluirExp'] ) && $_POST['confirmaIncluirExp'] == "EXCLUIR_EXP" )
    {
        foreach( $arrExpSeleccionados as $clave => $numExpediente )
        {
            $resultadoExp = $expediente->excluirExpediente( $_GET['nurad'], $numExpediente );
            if( $resultadoExp == 1 )
            {
                $observa = "Excluir radicado de Expediente";
                include_once "$ruta_raiz/include/tx/Historico.php";
                $radicados[0] = $_GET['nurad'];
                $tipoTx = 52;
                $Historico = new Historico( $db );
                $Historico->insertarHistoricoExp( $numExpediente, $radicados, $dependencia, $codusuario, $observa, $tipoTx, 0 );
            }
            else
            {
                print '<hr><font color=red>No se excluyó este radicado del expediente No. '.$numExpediente.'. Por favor intente de nuevo.</font><hr>';
                break;
            }
        }
        ?>
        <script language="JavaScript">
          opener.cargarPagina('expediente/lista_expedientes.php','tabs-d');
          window.close();
        </script>
        <?php
    }
}
/** CONSULTA SI EL EXPEDIENTE TIENE UNA CLASIFICACION TRD */
// Consulta los expedientes a los que pertenece un radicado

$arrExpedientes = $expediente->expedientesRadicado($nurad);
foreach( $arrExpedientes as $clave => $numExpediente ){
    // Consulta el proceso y el estado del expediente
    $arrTRDExp = $expediente->getTRDExp( $numExpediente, "", "", "" );
    $arrDatosExpediente[ $numExpediente ]['proceso'] = $arrTRDExp['proceso'];
    $arrDatosExpediente[ $numExpediente ]['estado']  = $arrTRDExp['estado'];
}




?>
<html>
<head>
<title>Excluir de Expediente</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<script language="JavaScript" src="../js/funciones.js"></script>
<script language="JavaScript">
function excluirExpediente()
{
    var strExpSeleccionados = "";
    frm = document.excExp;
    if( typeof frm.check_uno.length != "undefined" ) {
        for( i = 0; i < frm.check_uno.length; i++ ) {
            if( frm.check_uno[i].checked ) {
                if( strExpSeleccionados == "" ) {
                    coma = "";
                }
                else {
                    coma = ",";
                }
                strExpSeleccionados += coma + frm.check_uno[i].value;
            }
        }
    }
    else {
        if( frm.check_uno.checked ) {
            strExpSeleccionados = frm.check_uno.value;
        }
    }

  if( strExpSeleccionados != "" ) {
		frm.expSeleccionados.value = strExpSeleccionados;
    frm.submit();
	} else {
		alert( "Debe seleccionar un expediente." );
        return false;
	}
}

function confirmaExcluir() {
    document.getElementById( 'confirmaIncluirExp' ).value = "EXCLUIR_EXP";
    document.excExp.submit();
}
</script>
</head>
<body>
<form name='excExp' action='<?php print $encabezado; ?>' method="post">
<input type="hidden" name="expSeleccionados" value="<?php print $_POST['expSeleccionados']; ?>">
<input type="hidden" name='confirmaIncluirExp' id='confirmaIncluirExp' value="" >
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
              Excluir radicado de expediente<br>
            </h2>
          </header>
          <!-- widget div-->
          <div>
            <!-- widget content -->
            <div class="widget-body no-padding">
              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                  <tr bordercolor="#FFFFFF">
                    <td colspan="2" class="titulos2">
                      <center>
                        <p><B>Radicado No. <?php print $_GET['nurad']; ?> Se excluir&aacute; del expediente No. </B> </p>
                    </center></td>
                  </tr>
                </table>
              </div>

              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                  <tr class="timparr">
                    <td width="26%" height="66" class="titulos2" align="center">
                      EXPEDIENTE
                    </td>
                    <td width="24%" class="titulos2" align="center">PROCESO</td>
                    <td width="30%" class="titulos2" align="center">ESTADO</td>
                    <td width="20%" height="66" class="titulos2">
                      <input type="checkbox" name="check_todos" value="checkbox" onClick="todos( document.forms[0] );">
                    </td>
                  </tr>
                  <?php foreach( $arrDatosExpediente as $numeroExpediente => $datosExpediente ) { ?>
                  <tr class="listado1">
                      <td align="center" class="leidos">
                          <?php print $numeroExpediente; ?>
                        </td>
                        <td align="center" class="leidos">
                          <?php print $datosExpediente['proceso']; ?>
                        </td>
                        <td align="center" class="leidos">
                          <?php print $datosExpediente['estado']; ?>
                        </td>
                        <td align="center">
                          <input type="checkbox" name="check_uno" value="<?php print $numeroExpediente; ?>" onClick="uno( document.forms[0] );">
                        </td>
                      </tr>
                  <?php
                  }
                  ?>
                  </table>
                  </div>
<?php if( !isset( $_POST['expSeleccionados'] ) ) { ?>
              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <tr class="timparr">
                    <td height="30" colspan="2" class="listado2">
                        <center>
                          <input class="botones" type="button" name="btnExcluir" id="btnExcluir" Value="EXCLUIR" onClick="excluirExpediente();">
                      </center>
                      </td>
                    <td width="50%" height="30" colspan="2" class="listado2"><center>
                      <input class="botones" type="button" name="Cancelar" id="Cancelar" value="CANCELAR" onClick="opener.cargarPagina('expediente/lista_expedientes.php','tabs-d'); window.close();"></center>  </td>
                    </tr>
                </table>
             </div>
<?php
}
// Solicita confirmación para excluir el radicado del expediente
else if( isset( $_POST['expSeleccionados'] ) && $_POST['expSeleccionados'] != "" ) { ?>
              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <tr align="center">
                      <td width="33%" height="25" class="listado2" align="center">
                        <center class="titulosError2">
                          <br>
                          <?php print $mensaje; ?>
                        </center>
                      </td>
                    </tr>
                  </table>
              </div>
              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <tr align="center">
                      <td width="33%" height="25" class="listado2" align="center">
                      <center>
                        <input name="btnConfirmar" type="button" onClick="confirmaExcluir();" class="botones_funcion" value="Confirmar">
                      </center>
                      </td>
                    <td width="33%" class="listado2" height="25">
                    <center><input name="cerrar" type="button" class="botones_funcion" id="envia22" onClick="opener.regresar(); window.close();" value=" Cerrar "></center></TD>
                    </tr>
                  </table>
            </div>
<?php	
}
?>

              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>

</form>
</body>
</html>
