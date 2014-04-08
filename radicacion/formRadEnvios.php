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
    $ruta_raiz = "..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$entidad     = $_SESSION["entidad"];
$datos_enviar = session_name()."=".session_id();

?>
<html>
<head>
  <title>Procesos</title>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body>
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
                  Envio de Correspondencia<br>
                  <small><?=$tituloCrear ?></small>
                </h2>
              </header>
              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body no-padding">

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr class='titulos2'>
                          <td colspan="5">
                              <img src='../imagenes/correo.gif'>  &nbsp;
                          </td>
                      </tr>
                      <tr align="center" class='listado2'>
                          <td class='listado2' >
                          <a href='../envios/cuerpoEnvioNormal.php?<?=$datos_enviar?>&estado_sal=3&estado_sal_max=3&krd=<?=$krd?>&nomcarpeta=Radicados Para Envio' class='vinculos'>Normal
                          </a>
                          </td>
                          <td class='listado2' ><a href='../envios/cuerpoModifEnvio.php?<?=$datos_enviar?>&estado_sal=4&estado_sal_max=4&devolucion=3&krd=<?=$krd?>' class='vinculos'>Modificacion Registro de Envio
                          </a></td>
                          <td class='listado2' ><a href='../radsalida/cuerpo_masiva.php?<?=$datos_enviar?>&krd=<?=$krd?>&estado_sal=3&estado_sal_max=3' class='vinculos'>Masiva
                          </a></td>
                          <td class='listado2'><b><a href='../radsalida/generar_envio.php?<?=$datos_enviar?>&krd=<?=$krd?>' class='vinculos'>Generacion de Planillas
                          y Guias 
                          </a></td>
                                          <td class='listado2'><b><a href='../envios/uploadPlanos.php?<?=$datos_enviar?>&krd=<?=$krd?>' class='vinculos'>Cargue Resultado Envio
                          </a></td>
                      </tr>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr class='titulos2'>
                        <td colspan="4">
                          <img src='../imagenes/devoluciones.gif'> Devoluciones
                        </td>
                      </tr>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr>
                          <td class='listado2' height="25">
                            <a href='../devolucion/dev_corresp.php?<?=$datos_enviar?>&estado_sal=4&estado_sal_max=4&krd=<?=$krd?>' class='vinculos'>
                          Por exceder  tiempo de espera
                            </a>
                          </td>
                              <td class='listado2' height="25">
                            <a href='../devolucion/cuerpoDevOtras.php?<?=$datos_enviar?>&estado_sal=4&estado_sal_max=4&devolucion=1&krd=<?=$krd?>' class='vinculos'>
                              Otras Devoluciones
                            </a>
                          </td>
                              <td class='listado2' height="25">
                            <a href='../devolucion/cuerpoDevGestion.php?<?=$datos_enviar?>&estado_sal=3&estado_sal_max=3&devolucion=1&krd=<?=$krd?>' class='vinculos'>
                              Devoluciones para gestion
                            </a>
                          </td>
                              <td class='listado2' height="25"><a href='../radsalida/dev_corresp2.php?<?=$datos_enviar?>&estado_sal=4&estado_sal_max=4'>
                              </a>
                          </td>
                      </tr>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr class='titulos2'>
                        <td colspan="4">
                          <img src='../iconos/anulacionRad.gif'> Anulaciones
                        </td>
                      </tr>
                      <tr>
                        <td class='listado2' height="25">
                          <a href='../anulacion/anularRadicados.php?<?=$datos_enviar?>&estado_sal=4&tpAnulacion=2&krd=<?=$krd?>' class="vinculos">
                            Anular Radicados
                              </a>
                        </td>
                      </tr>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr class='titulos2'>
                        <td colspan="4">
                          <img src='../imagenes/estadisticas_icono.gif'> Reportes 
                        </td>
                      </tr>
                      <tr>
                        <td class='listado2' height="25"><a href='../reportes/generar_estadisticas_envio.php?<?=$datos_enviar?>&estado_sal=4&estado_sal_max=4&krd=<?=$krd?>' class='vinculos'>
                          Envio de Correo
                              </a>
                        </td>
                        <td class='listado2' height="25">
                          <a href='../reportes/generar_estadisticas.php?<?=$datos_enviar?>&estado_sal=4&estado_sal_max=4&krd=<?=$krd?>' class='vinculos'>
                            Devoluciones
                          </a>
                        </td>
                        <td class='listado2' height="25">
                          <a href='../anulacion/cuerpo_RepAnula.php?<?=$datos_enviar?>&estado_sal=4&tpAnulacion=2&krd=<?=$krd?>' class='vinculos'>
                            Anulaciones
                          </a>
                        </td>
                        <?  if (strtoupper($entidad) == 'correlibre'){ ?>
                        <td class='listado2' height="25">
                          <a href='../reportes/generar_listado_entrega.php?<?=$datos_enviar?>&estado_sal=4&krd=<?=$krd?>' class='vinculos'>
                          Listado Entrega
                          </a>
                        </td>
                        <? } ?>
                      </tr>
                    </table>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>
</body>
</html>
