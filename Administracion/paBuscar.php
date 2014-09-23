<?php
/** * @module paBuscar
*
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
?>
  <div class="col-sm-12">
    <!-- widget grid -->
    <section id="widget-grid">
      <!-- row -->
      <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!-- Widget ID (each widget will need unique ID)-->
          <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">

            <header>
              <h2>
                Buscar<br>
                <small><?=$tituloCrear ?></small>
              </h2>
            </header>

            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">
                <table class="table table-bordered table-striped">

                  <tr class="tablas">
                  <td class="etextomenu" >
                  <span class="etextomenu">
                  <form name=form_busq_rad action='<?=$pagina_actual?>?<?=session_name()."=".session_id()."&krd=$krd" ?>&estado_sal=<?=$estado_sal?>&tpAnulacion=<?=$tpAnulacion?>&estado_sal_max=<?=$estado_sal_max?>&pagina_sig=<?=$pagina_sig?>&dep_sel=<?=$dep_sel?>&nomcarpeta=<?=$nomcarpeta?>' method=post>
                  Buscar por nombres de usuario y/o login (Separados por coma)
                  <input name="busqRadicados" type="text" size="60" class="tex_area" value="<?=$busqRadicados?>">
                  <input type=submit value='Buscar ' name=Buscar valign='middle' class='botones'>
                  <?
                  if ($busqRadicados) {
                    $busqRadicados = trim($busqRadicados);
                    $textElements =explode (",", $busqRadicados);
                    $newText = "";
                    $i = 0;
                    foreach ($textElements as $item) {
                      $item = trim ( $item );
                      if ($item) {
                      if ($i != 0) $busq_and = " or "; else $busq_and = "  ";
                        //$busq_radicados_tmp .= " $busq_and upper($varBuscada) like upper('%$item%') ";
                        $busq_radicados_tmp .= " $busq_and upper($varBuscada) like upper('%$item%') ";
                        if($varBuscada2) $busq_radicados_tmp .= " or upper($varBuscada2) like upper('%$item%') ";
                        $i++;
                      }
                    } //FIN foreach

                  $dependencia_busq2 .= " and ($busq_radicados_tmp) ";
                  } //FIN if ($busqRadicados)
                ?>
                  </form>
                  </span>
                  </td></tr>
              </table>
