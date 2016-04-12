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

if($_POST["nombreProceso"]) $nombreProceso = $_POST["nombreProceso"];
if($_POST["codserie"]) $codserie = $_POST["codserie"];
if($_POST["tsub"]) $tsub = $_POST["tsub"];

$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];
$tip3Nombre     = $_SESSION["tip3Nombre"];
$tip3desc       = $_SESSION["tip3desc"];
$tip3img        = $_SESSION["tip3img"];
$entrada        = 0;
$modificaciones = 0;
$salida         = 0;
$ruta_raiz      = "../../..";

include "$ruta_raiz/config.php";
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler( "$ruta_raiz" );

if (!defined('ADODB_FETCH_ASSOC'))define('ADODB_FETCH_ASSOC',2);
$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
$resultadoInsercion = 1;

if( ( $_POST['nombreProceso'] != '' &&  $_POST['codserie'] != 0 &&  $_POST['tsub'] != 0  ) ||  ( $_POST['nombreProceso'] != '' &&  $_POST['codserie'] == 0 &&  $_POST['tsub'] == 0 )){
  include "$ruta_raiz/include/tx/Proceso.php";
  $flujo = new Proceso( $db,  $nombreProceso,$codserie, $tsub, $flujoAutomatico,  $terminosProceso );
  $resultadoInsercion = $flujo-> insertaProceso();
}

?>
<html>
<head>
<title>Creacion de Proceso</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<script language="JavaScript">
<!--
  function validarDatos(){

    if(document.frmCrearProceso.nombreProceso.value == ""){
      alert("Debe ingresar nombre del Proceso." );
      document.frmCrearProceso.nombreProceso.focus();
      return false;
    }
    if(document.frmCrearProceso.codigoProceso.value == ""){
      alert("Debe ingresar el codigo del Proceso." );
      document.frmCrearProceso.codigoProceso.focus();
      return false;
    }
    if(document.frmCrearProceso.codigoProceso.value == ""){
      alert("Debe ingresar el codigo del Proceso." );
      document.frmCrearProceso.codigoProceso.focus();
      return false;
    }
    document.form1.submit();
  }
//-->
</script>

</head>
<body>
<form name='frmCrearProceso' action='creaProceso.php' method="post">
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
                <small>Creaci&oacute;n de Proceso</small>
              </h2>
            </header>
            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">
                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr class=timparr>
                        <td class="titulos2" height="26" width="25%" colspan="-1">Nombre Proceso</td>
                        <td class="listado2" height="1" width="75%" colspan="3">
                          <input type=text name=nombreProceso value='<?=$nombreProceso?>' maxlength="100" size="90">
                        </td>
                    </tr>

                    <tr align="center">
                      <td width="25%" class="titulos2">SERIE</td>
                      <td width="25%" height="35" class="listado2">
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
                          $querySerie = "select distinct ($sqlConcat) as detalle, sgd_srd_codigo
                                  from sgd_srd_seriesrd
                              order by detalle
                                ";
                          $rsD=$db->conn->query($querySerie);
                          $comentarioDev = "Muestra las Series Docuementales";
                          include "$ruta_raiz/include/tx/ComentarioTx.php";
                          print $rsD->GetMenu2("codserie", $codserie, "0:-- Seleccione --", false,"","onChange='submit()' class='select'" );
                        ?>
                          </td>

                          <td width="25%" class="titulos2">SUBSERIE</td>
                          <td width="25%" height="35" class="listado2">
                          <?
                            $nomb_varc = "sgd_sbrd_codigo";
                            $nomb_varde = "sgd_sbrd_descrip";
                            include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";
                              $querySub = "select distinct ($sqlConcat) as detalle, sgd_sbrd_codigo
                                    from sgd_sbrd_subserierd
                                where sgd_srd_codigo = '$codserie'
                                      and ".$sqlFechaHoy." between sgd_sbrd_fechini and sgd_sbrd_fechfin
                                order by detalle
                                  ";
                            $rsSub=$db->conn->query($querySub);
                            include "$ruta_raiz/include/tx/ComentarioTx.php";
                            print $rsSub->GetMenu2("tsub", $tsub, "0:-- Seleccione --", false,""," class='select'" );

                          ?>
                          </td>
                        </tr>
                  </table>
              </div>

              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                  <tr class=timparr>
                        <td height="30" colspan="4" class="listado2"><span class="celdaGris"> <span class="e_texto1">
                      <center> <input class="botones" type="submit" Value="Crear" onClick=" return validarDatos();"> </center> </span> </span></td>
                  </tr>
                </table>
              </div>

<?  if (( $_POST['nombreProceso'] != '' &&  $_POST['codserie'] != 0 &&  $_POST['tsub'] != 0  ) ||  ( $_POST['nombreProceso'] != '' &&  $_POST['codserie'] == 0 &&  $_POST['tsub'] == 0 )) { ?>
              <div class="table-responsive">
                <table class="table table-bordered table-striped">
                  <tr>
                    <td class=titulos2>
                      <?=$resultadoInsercion?>
                    </td>
                  </tr>
                </table>
              </div>
<?}?>
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
