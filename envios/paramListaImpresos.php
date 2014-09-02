<?php
session_start();
extract($_REQUEST);
$krd           = $_SESSION["krd"];
$dependencia   = $_SESSION["dependencia"];
$usua_doc      = $_SESSION["usua_doc"];
$codusuario    = $_SESSION["codusuario"];
$ruta_raiz     = "..";

if (!$fecha_busqH)
    $fecha_busqH = date("Y-m-d");
if (!$fecha_busq)
    $fecha_busq = date("Y-m-d");

include_once "../include/db/ConnectionHandler.php";
$db = new ConnectionHandler("..");
define('ADODB_FETCH_ASSOC', 2);
$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
if (!$dep_sel){
    $dep_sel = $_SESSION['dependencia'];
}
?>
<head>
    <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body>

<br>

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
                            DOCUMENTOS LISTOS PARA SER ENTREGADOS EN CORRESPONDENCIA
                        </h2>
                    </header>

                    <!-- widget div-->
                    <div>
                        <!-- widget content -->
                        <div class="widget-body no-padding">

                            <form name="gen_listado"
                                  action='cuerpoListaImpresos.php?<?= session_name() . "=" . session_id() . "&krd=$krd&fecha_ini=$fecha_ini&indi_generar=SI&dep_sel=$dep_sel&tip_radi=$tip_radi&fecha_h=$fechah&fecha_busq=$fecha_busq&fecha_busq2=$fecha_busq2" ?>'
                                  method=post class="smart-form">
                                <table class="table table-bordered table-striped">
                                    <TR>
                                        <TD height="21" class='titulos2'> Fecha Desde <br>
                                            <?
                                            echo "(" . date("Y-m-d") . ")";
                                            ?>
                                        </TD>
                                        <TD align="right" valign="top" class='listado2'>
                                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                <input type="text" id="fecha_busq"  name="fecha_busq"
                                                       placeholder="Fecha desde" value="<?=$fecha_busq?>">
                                            </label>
                                        </TD>
                                    </TR>
                                    <TR>
                                        <td height="21" class='titulos2'> Fecha Hasta <br>
                                        </td>
                                        <TD align="right" valign="top" class='listado2'>
                                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                <input type="text" id="fecha_busqH"  name="fecha_busqH"
                                                       placeholder="Fecha hasta"  value="<?=$fecha_busq?>">
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="21" class='titulos2'> Desde la Hora</td>
                                        <td  valign="top" class='listado2'>
                                            <?
                                            if (!$hora_ini)
                                                $hora_ini = 01;
                                            if (!$hora_fin)
                                                $hora_fin = date("H");
                                            if (!$minutos_ini)
                                                $minutos_ini = 01;
                                            if (!$minutos_fin)
                                                $minutos_fin = date("i");
                                            if (!$segundos_ini)
                                                $segundos_ini = 01;
                                            if (!$segundos_fin)
                                                $segundos_fin = date("s");
                                            ?>
                                            <ul class="list-inline">
                                                <li>
                                                    <select name=hora_ini class=select>
                                                    <?
                                                        for ($i = 0; $i <= 23; $i++) {
                                                            if ($hora_ini == $i) {
                                                                $datoss = " selected ";
                                                            } else {
                                                                $datoss = " ";
                                                            }?>
                                                            <option value='<?= $i ?>' '<?=$datoss?>'>
                                                              <?=$i?>
                                                            </option>
                                                    <? } ?>
                                                    </select>
                                                </li>
                                                <li>
                                                    :
                                                </li>
                                                <li>
                                                    <select name=minutos_ini class=select>
                                                        <? for ($i = 0; $i <= 59; $i++) {
                                                            if ($minutos_ini == $i) {
                                                                $datoss = " selected ";
                                                            } else {
                                                                $datoss = " ";
                                                            }?>
                                                            <option value='<?= $i ?>' '<?=$datoss?>'>
                                                                <?=$i?>
                                                            </option>
                                                        <? } ?>
                                                    </select>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <TD height="26" class='titulos2'> Hasta</td>
                                        <TD valign="top" class='listado2'>
                                            <ul class="list-inline">
                                                <li>
                                                    <select name=hora_fin class=select>
                                                        <? for ($i = 0; $i <= 23; $i++) {
                                                            if ($hora_fin == $i) {
                                                                $datoss = " selected ";
                                                            } else {
                                                                $datoss = " ";
                                                            }?>
                                                            <option value='<?= $i ?>' '<?=$datoss?>'>
                                                                <?=$i?>
                                                            </option >
                                                        <? } ?>
                                                    </select>
                                                </li>
                                                <li>
                                                    :
                                                </li>
                                                <li>
                                                    <select name=minutos_fin class=select>
                                                        <? for ($i = 0; $i <= 59; $i++) {
                                                            if ($minutos_fin == $i) {
                                                                $datoss = " selected ";
                                                            } else {
                                                                $datoss = " ";
                                                            }?>
                                                            <option value='<?= $i ?>' '<?=$datoss?>'>
                                                                <?=$i?>
                                                            </option >
                                                        <? } ?>
                                                    </select>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <TD height="26" class='titulos2'>Tipo de Radicacion</td>
                                        <td class="listado5">
                                            <?
                                            $ss_RADI_DEPE_ACTUDisplayValue = "--- Todos los Tipos ---";
                                            $valor = 0;
                                            $sqlD = "select SGD_TRAD_DESCR,sgd_trad_codigo from SGD_TRAD_TIPORAD where SGD_TRAD_CODIGO != '2' order by 1";
                                            $rsDep = $db->conn->Execute($sqlD);
                                            print $rsDep->GetMenu2("tip_radi", "$tip_radi", $blank1stItem = "$valor:$ss_RADI_DEPE_ACTUDisplayValue", false, 0, " class='select'");
                                            ?>
                                        </td>
                                    </tr>
                                    </td>
                                    <tr>
                                        <td height="26" colspan="2" valign="top" class='titulos2'>
                                            <INPUT TYPE=SUBMIT name=generar_listado Value=' Generar '
                                                   class=botones_funcion>
                                            <INPUT TYPE=submit name=cancelarAnular value=Cancelar class=botones_funcion>
                                        </td>
                                    </tr>
                                </table>
                                <?php

                                if (!$fecha_busq)
                                    $fecha_busq = date("Y-m-d");
                                if (!$fecha_busqH)
                                    $fecha_busqH = date("Y-m-d");

                                ?>
                            </form>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
        </section>
    </div>
</body>

<script language="javascript">
    //Datepicker muestra fecha
    $('#fecha_busq').datepicker({
        dateFormat : 'yy-mm-dd',
        onSelect : function(selectedDate) {
            $('#date').datepicker('option', 'maxDate', selectedDate);
        }
    });

    $('#fecha_busqH').datepicker({
        dateFormat : 'yy-mm-dd',
        onSelect : function(selectedDate) {
            $('#date').datepicker('option', 'maxDate', selectedDate);
        }
    });

</script>
