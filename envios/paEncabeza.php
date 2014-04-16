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

if (isset($nomcarpeta))
    $nomcarpetaOLD = $nomcarpeta;
else{
    $nomcarpetaOLD = "";
    $nomcarpeta = "";
}

if (!isset($_GET['carpeta'])) {
    $carpeta = "0";
    $nomcarpeta = "Entrada";
}

if (!isset($pagina_actual))
    $pagina_actual = "";

if (!isset($estado_sal_max))
    $estado_sal_max = "";

if (!isset($pagina_sig))
    $pagina_sig = "";

if (!isset($dep_sel))
    $dep_sel = "";

$accion  = $pagina_actual .'?'. session_name().'='. session_id().
      '&estado_sal_max='.$estado_sal_max.'&pagina_sig='.
      $pagina_sig .'&dep_sel='. $dep_sel. '&nomcarpeta='.
      $nomcarpeta .'method=GET';


if(isset($_GET['nomcarpeta']))
    $getNombreCarpeta = $_GET['nomcarpeta'];
else
    $getNombreCarpeta = "";
?>
    <div class="col-sm-12">
      <!-- widget grid -->
      <h2></h2>
      <section>
        <!-- row -->
        <div class="row">
          <!-- NEW WIDGET START -->
          <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" data-widget-editbutton="false">

              <header>
                <h2>
                  Estadisticas Detalles <br>
                  <small><?=$tituloCrear ?></small>
                </h2>
              </header>
              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body no-padding">
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr >
                        <td class=titulos2 width='35%'>
                          Listado De:
                        </td>
                        <td class=titulos2 >
                          Usuario
                        </td>
                        <td class=titulos2 >
                          Dependencia
                        </td>
                      </tr>
                      <tr>
                        <td class="info">
                            <?= $getNombreCarpeta ?>
                        </td>
                        <td class="info">
                            <?= $_SESSION['usua_nomb']?>
                        </td>
                        <?php
                              if (!isset($swBusqDep))
                                  $swBusqDep = false;

                              if (!$swBusqDep) {
                        ?>

                      <td class="info">
                        <?= $_SESSION['depe_nomb']?>
                          </td>
                      <? } else { ?>
                        <form name=formboton action="<?=$accion ?>">
                        <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
                        <input type=hidden name=estado_sal value='<?=$estado_sal?>'>
                        <input type=hidden name=estado_sal_max value='<?=$estado_sal_max?>'>
                        <td>
                          <?php
                          include_once "$ruta_raiz/include/query/envios/queryPaencabeza.php";
                          $sqlConcat = $db->conn->Concat($conversion, "'-'", depe_nomb);
                          $sql       = "select $sqlConcat ,depe_codi from dependencia where depe_estado = 1
                                                  order by depe_codi";
                          $rsDep     = $db->conn->Execute($sql);
                          if (!$depeBuscada)
                              $depeBuscada = $dependencia;
                          print $rsDep->GetMenu2("dep_sel", "$dep_sel", false, false, 0, " onChange='submit();' class='select'");
                          ?>
                        </td>
                        </form>
                      <? } ?>
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
