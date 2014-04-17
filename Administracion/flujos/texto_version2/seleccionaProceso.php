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
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
  session_start();

  $ruta_raiz = "../../..";
  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

  if($_POST["nombreProceso"]) $nombreProceso = $_POST["nombreProceso"];
  if($_POST["codserie"]) $codserie = $_POST["codserie"];
  if($_POST["tsub"]) $tsub = $_POST["tsub"];
  if($_GET["accion"]) $accion = $_GET["accion"];

  include "$ruta_raiz/config.php";
  include_once "$ruta_raiz/include/db/ConnectionHandler.php";
  $db = new ConnectionHandler( "$ruta_raiz" );
  if (!defined('ADODB_FETCH_ASSOC'))define('ADODB_FETCH_ASSOC',2);
  $ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;

  $salida    = 0;
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
  <title>Procesos</title>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body>
<form name='frmCrear' action='<?=$action?>' method="post">
    <div class="col-sm-12"> <!-- widget grid -->
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
                  <small><?=$tituloCrear ?></small>
                </h2>
              </header>
              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body">
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
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
                </div>

                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr class=timparr>
                      <td height="30" colspan="2" class="listado2"><span class="celdaGris"> <span class="e_texto1">
                        <center> <input class="botones" type="submit" Value="Continuar"> </center> </span> </span></td>
                      <td height="30" colspan="2" class="listado2"><span class="celdaGris"> <span class="e_texto1">
                        <center><a href='mnuFlujosBasico.php?<?=session_name()."=".session_id()."&$encabezado"?>'><input class="botones" type=button name=Cancelar id=Cancelar Value=Cancelar></a></center>  </span> </span>
                      </td>
                   </tr>
                  </table>
                </div>

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
