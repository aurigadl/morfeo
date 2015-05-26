<?php
session_start();
if (!$ruta_raiz)
    $ruta_raiz = "..";
if (!$db)
    include_once "../conn.php";

//Codigo ajax respuesta para la modificacion de etiquetas
//Se utiliza desde el archivo include lista_expedientes.php
//se coloca en esta seccion para no crear un nuevo archivo para
//tan poco codigo y por que esta relacionada con la consulta
//original.

if($_POST['saveEtiq']){

    $allPostKeys = implode(',',array_keys($_POST));
    if (preg_match_all('/etique_[0-9]*E/',$allPostKeys,$matches)){
        list($nda, $noExp) = explode("_", $matches[0][0]);
    }

    include_once ("$ruta_raiz/include/tx/Expediente.php");
    #echo "<script> alert('Intento imprimir el mensaje  de actualización de datos');</script>";
    $expediente = new Expediente($db);
    return $expediente->editDatosParamExp($noExp, $_POST[$matches[0][0]]);
    die;
    #Despues de editado un expediente.

}

?>
<script>
    function verTipoExpediente(numeroExpediente, codserie, tsub, tdoc, opcionExp) {
        <?php
              $isqlDepR = "SELECT RADI_DEPE_ACTU,
                      RADI_USUA_ACTU
                      FROM radicado
                      WHERE RADI_NUME_RADI = '$numrad'";
                      // $db->conn->debug = true;
              $rsDepR = $db->conn->Execute($isqlDepR);
              $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
              $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
              $ind_ProcAnex = "N";
                $fechaH = Date("Ymdhis");
        ?>
        window.open("./expediente/tipificarExpediente.php?opcionExp=" + opcionExp + "&numeroExpediente=" + numeroExpediente + "&nurad=<?=$verrad?>&codserie=" + codserie + "&tsub=" + tsub + "&tdoc=" + tdoc + "&krd=<?=$krd?>&dependencia=<?=$dependencia?>&fechaExp=<?=$radi_fech_radi?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>", "MflujoExp<?=$fechaH?>", "height=850,width=970,scrollbars=yes");
    }
    function verHistExpediente(numeroExpediente, codserie, tsub, tdoc, opcionExp) {
        <?php
              $isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
                          WHERE RADI_NUME_RADI = '$numrad'";
              $rsDepR = $db->conn->Execute($isqlDepR);
              $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
              $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
              $ind_ProcAnex = "N";
      ?>
        window.open("./expediente/verHistoricoExp.php?sessid=<?=session_id()?>&opcionExp=" + opcionExp + "&numeroExpediente=" + numeroExpediente + "&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>", "HistExp<?=$fechaH?>", "height=800,width=1060,scrollbars=yes");
    }
    function crearProc(numeroExpediente) {
        window.open("./expediente/crearProceso.php?sessid=<?=session_id()?>&numeroExpediente=" + numeroExpediente + "&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>", "HistExp<?=$fechaH?>", "height=450,width=680,scrollbars=yes");
    }
    function seguridadExp(numeroExpediente, nivelExp) {
        nivelExp = nivelExp || 0;
        window.open("./seguridad/expediente.php?<?=session_name()?>=<?=session_id()?>&num_expediente=" + numeroExpediente + "&nurad=<?=$verrad?>&nivelExp=" + nivelExp + "&ind_ProcAnex=<?=$ind_ProcAnex?>", "HistExp<?=$fechaH?>", "height=350,width=700,scrollbars=yes");
    }
    function reportePredios(numeroExpediente, predios, vars, tipoReporte) {
        predios = predios || '';
        // tipoReporte = tipoReporte || 'modeloPredial';
        window.open("<?=$servidorBirt?>" + tipoReporte + ".rptdesign&chip=" + predios + "&num_expediente=" + numeroExpediente + "&nurad=<?=$verrad?>" + vars, "HistExp<?=$fechaH?>" + predios, "fullscreen=yes,scrollbars=yes");
    }
    function verTipoExpedienteOld(numeroExpediente) {
        <?php
          $isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
                  WHERE RADI_NUME_RADI = '$numrad'";
          $rsDepR = $db->conn->Execute($isqlDepR);
          $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
          $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
          $ind_ProcAnex="N";
          ?>
        window.open("./expediente/tipificarExpedienteOld.php?numeroExpediente=" + numeroExpediente + "&nurad=<?=$verrad?>&krd=<?=$krd?>&dependencia=<?=$dependencia?>&fechaExp=<?=$radi_fech_radi?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>", "Tipificacion_Documento", "height=450,width=750,scrollbars=yes");
    }
    function modFlujo(numeroExpediente, texp, codigoFldExp, ventana) {

        ventana = ventana || 'default';
        <?php
            $isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
                                    WHERE RADI_NUME_RADI = '$numrad'";
            $rsDepR = $db->conn->Execute($isqlDepR);
            $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
            $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
            $ind_ProcAnex="N";


        ?>
        if (ventana == "Max") {
            opcVentana = "fullscreen=yes, scrollbars=auto";
        } else {
            opcVentana = "height=350,width=850,scrollbars=yes";
        }

        window.open("./flujo/modFlujoExp.php?codigoFldExp=" + codigoFldExp + "&krd=<?=$krd?>&numeroExpediente=" + numeroExpediente + "&numRad=<?=$verrad?>&texp=" + texp + "&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>", "TexpE<?=$fechaH?>", opcVentana);
    }
    <?php /* */ ?>
    function Responsable(numeroExpediente) {
         frm = document.form2;
        <?php
            $isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU
                    FROM radicado
                    WHERE RADI_NUME_RADI = '$numrad'";
            $rsDepR = $db->conn->Execute($isqlDepR);
            $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
            $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
            $isql = "SELECT USUA_DOC_RESPONSABLE, SGD_EXP_PRIVADO
                    FROM SGD_SEXP_SECEXPEDIENTES
                    WHERE SGD_EXP_NUMERO = '$numeroExpediente'";
            $rs = $db->conn->Execute($isql);
            $responsable= $rs->fields['USUA_DOC_RESPONSABLE'];
            $nivelExp= $rs->fields['SGD_EXP_PRIVADO'];
        ?>
        window.open("./expediente/responsable.php?&numeroExpediente=" + numeroExpediente +
            "&numRad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>&responsable=<?=$responsable?>&coddepe=<?=$coddepe?>&codusua=<?=$codusua?>", "Responsable", "height=400,width=550,scrollbars=yes");
    }
    <?php  ?>
    function CambiarE(est, numeroExpediente) {
        window.open("./archivo/cambiar.php?krd=<?=$krd?>&numRad=<?=$verrad?>&expediente=" + numeroExpediente + "&est=" + est + "&dependencia=<?=$dependencia?>", "Cambio Estado Expediente", "height=200,width=200,scrollbars=yes");
    }
    function insertarExpediente() {
        window.open("./expediente/insertarExpediente.php?sessid=<?=session_id()?>&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>", "HistExp<?=$fechaH?>", "height=900,width=1100,scrollbars=yes");
    }
    function verWorkFlow(numeroExpediente, codigoProceso) {
        var numeroExpediente = numeroExpediente || '';
        var codigoProceso = codigoProceso || 0;
        <?php
            //  include "./proceso/workFlow.php"; //?verrad=$verrad&numeroExpediente=$numExpediente&".session_name()."=".session_id()."";
            $pWorkFlow = "./proceso/workFlow.php?verrad=$verrad&".session_name()."=".session_id()."";
        ?>
        window.open("<?=$pWorkFlow?>&HistExp<?=$fechaH?>&numeroExpediente=" + numeroExpediente + "&codigoProceso=" + codigoProceso, "HistExp<?=$fechaH?>" + numeroExpediente, "height=750,width=850,scrollbars=yes");
    }
    function crearExpediente() {
        numExpediente = document.getElementById('num_expediente').value;
        numExpedienteDep = document.getElementById('num_expediente').value.substr(4, 3);
        if (numExpedienteDep ==<?=$dependencia?>) {
            if (numExpediente.length == 13) {
                insertarExpedienteVal = true;
            } else {
                alert("Error. El numero de digitos debe ser de 13.");
                insertarExpedienteVal = false;
            }
        }
        else {
            alert("Error. Para crear un expediente solo lo podra realizar con el codigo de su dependencia. ");
            insertarExpedienteVal = false;
        }
        if (insertarExpedienteVal == true) {
            respuesta = confirm("Esta apunto de crear el EXPEDIENTE No. " + numExpediente + " Esta Seguro ? ");
            insertarExpedienteVal = respuesta;
            if (insertarExpedienteVal == true) {
                dv = digitoControl(numExpediente);
                document.getElementById('num_expediente').value = document.getElementById('num_expediente').value + "E" + dv;
                document.getElementById('funExpediente').value = "CREAR_EXP"
                document.form2.submit();
            }
        }
    }
</script>
<script language="javascript">
    var varOrden = 'ASC';
    function ordenarPor(campo) {
        if (document.getElementById('orden').value == 'ASC') {
            varOrden = 'DESC';
        }
        else {
            varOrden = 'ASC';
        }
        document.getElementById('orden').value = varOrden;
        document.getElementById('ordenarPor').value = campo + ' ' + varOrden;
        document.form2.submit();
    }

    var i = 1;
    var numRadicado;
    function cambiarImagen(imagen) {
        numRadicado = imagen.substr(13);
        if (i == 1) {
            document.getElementById('anexosRadicado').value = numRadicado;
            i = 2;
        } else {
            document.getElementById('anexosRadicado').value = "";
            i = 1;
        }

        document.form2.submit();
    }

    function excluirExpediente() {
        window.open("./expediente/excluirExpediente.php?sessid=<?=session_id()?>&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>", "HistExp<?=$fechaH?>", "height=400,width=730,scrollbars=yes");
    }


    function solicitarExpediente(){
        window.open("./solicitar/reservarExpediente.php?sessid=<?=session_id()?>>", "HistExp<?=$fechaH?>", "height=400,width=730,scrollbars=yes");
    }

    // Incluir Anexos y Asociados a un Expediente.
    function incluirDocumentosExp() {
        var strRadSeleccionados = "";
        frm = document.form2;
        if (typeof frm.check_uno.length != "undefined") {
            for (i = 0; i < frm.check_uno.length; i++) {
                if (frm.check_uno[i].checked) {
                    if (strRadSeleccionados == "") {
                        coma = "";
                    }
                    else {
                        coma = ",";
                    }
                    strRadSeleccionados += coma + frm.check_uno[i].value;
                }
            }
        } else {
            if (frm.check_uno.checked) {
                strRadSeleccionados = frm.check_uno.value;
            }
        }

        if (strRadSeleccionados != "") {
            window.open("./expediente/incluirDocumentosExp.php?sessid=<?=session_id()?>&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>&strRadSeleccionados=" + strRadSeleccionados, "HistExp<?=$fechaH?>", "height=300,width=600,scrollbars=yes");
        } else {
            alert("Error. Debe seleccionar por lo menos un \n\r documento a incluir en el expediente.");
            return false;
        }
    }

    // Crear Subexpediente
    function incluirSubexpediente(numeroExpediente, numeroRadicado) {
        window.open("./expediente/datosSubexpediente.php?sessid=<?=session_id()?>&nurad=" + numeroRadicado + "&krd=<?=$krd?>&num_expediente=" + numeroExpediente, "HistExp<?=$fechaH?>", "height=350,width=700,scrollbars=yes");
    }
</script>
<script language="JavaScript" src="./js/funciones.js"></script>
<input type="hidden" name="ordenarPor" id="ordenarPor" value="">
<input type="hidden" name="orden" id="orden" value="<?php print $orden; ?>">
<input type="hidden" name="verAnexos" id="verAnexos" value="">
<input type="hidden" name="anexosRadicado" id="anexosRadicado" value="">
<?php
function microtime_float() {
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

$time_start = microtime_float();
if (!isset($verBorrados)) {
    print '<input type="hidden" name="verBorrados" id="verBorrados" value="' . $anexosRadicado . '">';
}

include("$ruta_raiz/include/js/digitoControl.js");
$verradicado = $verrad;
if ($menu_ver_tmp) {
    $menu_ver = $menu_ver_tmp;
}
if ($verradicado) {
    $verrad = $verradicado;
}
$numrad = $verrad;
if (!$menu_ver) {
    $menu_ver = 4;
}
$fechah = date("dmy_h_m_s") . " " . time("h_m_s");
$check = 1;
$numeroa = 0;
$numero  = 0;
$numeros = 0;
$numerot = 0;
$numerop = 0;
$numeroh = 0;
$rs = $db->conn->Execute($isql);

include_once "$ruta_raiz/tx/verLinkArchivo.php";
$verLinkArch = new verLinkArchivo($db);


include_once("$ruta_raiz/include/tx/Expediente.php");
$expediente = new Expediente($db);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
if ($verrad){
    $exp = $expediente->consultaExp($verrad);
}
$arrExpedientes = $expediente->expedientes;
?>

<!-- widget content -->
<div class="widget-body" height="100%">

    <div class="tabs-left" height="100%">
        <ul class="nav nav-tabs tabs-left" id="demo-pill-nav" height="100%">
            <?php
            $iExp = 1;
            foreach ($arrExpedientes as $numExpediente => $datosExp){
                if ($iExp == 1)
                    $datoss = " active "; else  $datoss = " ";
                ?>
                <li class="<?= $datoss ?>">
                    <a href="#tab-<?= $numExpediente ?>" data-toggle="tab"><span
                            class="badge bg-color-blue txt-color-white">*</span><?= $numExpediente ?></a>
                </li>
                <?php
                $iExp++;
            }
            ?>
        </ul>

        <div class="tab-content" align=left>
            <?
            $iExp = 1;
            if ($arrExpedientes) {
                foreach ($arrExpedientes as $numExpediente => $datosExp) {
                    if ($iExp == 1)
                        $datoss = " active "; else  $datoss = " ";
                    ?>
                    <div class="tab-pane <?= $datoss ?>" id="tab-<?= $numExpediente ?>">
                        <?
                        $numeroExpediente = $num_expediente = $numExpedente;
                        $texp = 0;
                        include "lista_expediente.php";
                        ?>
                    </div>
                    <?php
                    $iExp++;
                }
            } else {
                if (!empty($usuaPermExpediente)) {
                    if (!$tsub)
                        $tsub = "0";
                    if (!$tdoc)
                        $tdoc = "0";
                    if (!$codserie)
                        $codserie = "0";?> <span class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
                                    <small>Expediente</small>
                                    <b class="caret"></b> </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="#" onClick="insertarExpediente();">Incluir en...</a>
                                    </li>

                                    <? if ($usuaPermExpediente > 1) { ?>
                                        <li>
                                            <a href="#"
                                               onClick="verTipoExpediente('<?= $num_expediente ?>',<?= $codserie ?>,<?= $tsub ?>,<?= $tdoc ?>,'MODIFICAR');">Crear
                                                Nuevo Expediente</a>
                                        </li>
                                    <? } ?>

                                </ul>
                                </span>
                <? } ?>
            <?php } ?>
        </div>
    </div>
    <!-- end widget content -->
</div>


<table class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox">
    <tr>
        <td>
            <small>Y ESTA RELACIONADO CON EL(LOS) SIGUIENTE(S) DOCUMENTOS:
                <small>
        </td>
        <td align="center">
            <? if ($usuaPermExpediente and $verradPermisos == "Full" or $dependencia == '999') {
                ?>
                <a href="#tblAnexoAsociado" onClick="incluirDocumentosExp();">
                    <b>
                        <small>Incluir Documentos en Expediente
                    </b></small>
                </a>
            <?
            }
            ?>
        </td>
    </tr>
</table>

<table border=0 width="100%">
    <tr>
        <td>
            <input type="checkbox" name="check_uno" value="<?php print $radicadoAnexo; ?>"
                   onClick="uno( document.forms[1] );">
        </td>
        <td>
            <?php
            print $rutaRadicado;
            ?>
        </td>
        <td>
            <?
            if ($radicadoAnexo){
            $resulVal = $verLinkArch->valPermisoRadi($radicadoAnexo);
            $verImg = $resulVal['verImg'];
            if ($verImg == "NO") {
                echo "<a href='#2' onclick=\"alert('El documento posee seguridad y no posee los suficientes permisos'); return false;\"><span class=leidos>";

            } else {
            ?>
            <a href='./verradicado.php?verrad=<?= $radicadoAnexo ?>&<?= session_name() ?>=<?= session_id() ?>&krd=<?= $krd ?>'
               target="VERRAD<?= $radicadoAnexo ?>">

                <?
                }
                print $arrDatosRad['fechaRadicacion'];
                }

                ?>
            </a>
        </td>
        <td>
            <?php
            print $arrDatosRad['tipoDocumento'];
            ?>
        </td>
        <td>
            <?php
            print $arrDatosRad['asunto'];
            ?>
        </td>
        <td>
            <?php
            print $tipoRelacion;
            ?>
        </td>
    </tr>
</table>

<script type="text/javascript">
// DO NOT REMOVE : GOBAL FUNCTIONS!
pageSetUp()

// PAGE RELATED SCRIPTS

/*
 * Autostart Carousel
 */
$('.carousel.slide').carousel({
    interval: 3000,
    cycle: true
});
$('.carousel.fade').carousel({
    interval: 3000,
    cycle: true
});

// load bootstrap-progress bar script
loadScript("js/plugin/bootstrap-progressbar/bootstrap-progressbar.js", progressBarAnimate);

// Fill all progress bars with animation
function progressBarAnimate() {
    $('.progress-bar').progressbar({
        display_text: 'fill'
    });
}

/*
 * Smart Notifications
 */
$('#eg1').click(function (e) {

    $.bigBox({
        title: "Big Information box",
        content: "This message will dissapear in 6 seconds!",
        color: "#C46A69",
        //timeout: 6000,
        icon: "fa fa-warning shake animated",
        number: "1",
        timeout: 6000
    });

    e.preventDefault();

})

$('#eg2').click(function (e) {

    $.bigBox({
        title: "Big Information box",
        content: "Lorem ipsum dolor sit amet, test consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
        color: "#3276B1",
        //timeout: 8000,
        icon: "fa fa-bell swing animated",
        number: "2"
    });

    e.preventDefault();
})

$('#eg3').click(function (e) {

    $.bigBox({
        title: "Shield is up and running!",
        content: "Lorem ipsum dolor sit amet, test consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
        color: "#C79121",
        //timeout: 8000,
        icon: "fa fa-shield fadeInLeft animated",
        number: "3"
    });

    e.preventDefault();

})

$('#eg4').click(function (e) {

    $.bigBox({
        title: "Success Message Example",
        content: "Lorem ipsum dolor sit amet, test consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
        color: "#739E73",
        //timeout: 8000,
        icon: "fa fa-check",
        number: "4"
    }, function () {
        closedthis();
    });

    e.preventDefault();

})

$('#eg5').click(function () {

    $.smallBox({
        title: "Ding Dong!",
        content: "Someone's at the door...shall one get it sir? <p class='text-align-right'><a href='javascript:void(0);' class='btn btn-primary btn-sm'>Yes</a> <a href='javascript:void(0);'  onclick='noAnswer();' class='btn btn-danger btn-sm'>No</a></p>",
        color: "#296191",
        //timeout: 8000,
        icon: "fa fa-bell swing animated"
    });

})

function noAnswer() {

    $.smallBox({
        title: "Sure, as you wish sir...",
        content: "",
        color: "#A65858",
        iconSmall: "fa fa-times",
        timeout: 5000
    });
}


$('#eg6').click(function () {
    $.smallBox({
        title: "Big Information box",
        content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
        color: "#5384AF",
        //timeout: 8000,
        icon: "fa fa-bell"
    });
})

$('#eg7').click(function () {
    $.smallBox({
        title: "James Simmons liked your comment",
        content: "<i class='fa fa-clock-o'></i> <i>2 seconds ago...</i>",
        color: "#296191",
        iconSmall: "fa fa-thumbs-up bounce animated",
        timeout: 4000
    });
})

function closedthis() {
    $.smallBox({
        title: "Great! You just closed that last alert!",
        content: "This message will be gone in 5 seconds!",
        color: "#739E73",
        iconSmall: "fa fa-cloud",
        timeout: 5000
    });
}

/*
 * SmartAlerts
 */
// With Callback
$("#smart-mod-eg1").click(function (e) {
    $.SmartMessageBox({
        title: "Smart Alert!",
        content: "This is a confirmation box. Can be programmed for button callback",
        buttons: '[No][Yes]'
    }, function (ButtonPressed) {
        if (ButtonPressed === "Yes") {

            $.smallBox({
                title: "Callback function",
                content: "<i class='fa fa-clock-o'></i> <i>You pressed Yes...</i>",
                color: "#65365",
                iconSmall: "fa fa-check fa-2x fadeInRight animated",
                timeout: 4000
            });
        }

        if (ButtonPressed === "No") {
            $.smallBox({
                title: "Callback function",
                content: "<i class='fa fa-clock-o'></i> <i>You pressed No...</i>",
                color: "#C46A69",
                iconSmall: "fa fa-times fa-2x fadeInRight animated",
                timeout: 4000
            });
        }

    });
    e.preventDefault();
})
// With Input
$("#smart-mod-eg2").click(function (e) {

    $.SmartMessageBox({
        title: "Smart Alert: Input",
        content: "Please enter your user name",
        buttons: "[Accept]",
        input: "text",
        placeholder: "Enter your user name"
    }, function (ButtonPress, Value) {
        alert(ButtonPress + " " + Value);
    });

    e.preventDefault();
})
// With Buttons
$("#smart-mod-eg3").click(function (e) {

    $.SmartMessageBox({
        title: "Smart Notification: Buttons",
        content: "Lots of buttons to go...",
        buttons: '[Need?][You][Do][Buttons][Many][How]'
    });

    e.preventDefault();
})
// With Select
$("#smart-mod-eg4").click(function (e) {

    $.SmartMessageBox({
        title: "Smart Alert: Select",
        content: "You can even create a group of options.",
        buttons: "[Done]",
        input: "select",
        options: "[Costa Rica][United States][Autralia][Spain]"
    }, function (ButtonPress, Value) {
        alert(ButtonPress + " " + Value);
    });

    e.preventDefault();
});

// With Login
$("#smart-mod-eg5").click(function (e) {

    $.SmartMessageBox({
        title: "Login form",
        content: "Please enter your user name",
        buttons: "[Cancel][Accept]",
        input: "text",
        placeholder: "Enter your user name"
    }, function (ButtonPress, Value) {
        if (ButtonPress == "Cancel") {
            alert("Why did you cancel that? :(");
            return 0;
        }

        Value1 = Value.toUpperCase();
        ValueOriginal = Value;
        $.SmartMessageBox({
            title: "Hey! <strong>" + Value1 + ",</strong>",
            content: "And now please provide your password:",
            buttons: "[Login]",
            input: "password",
            placeholder: "Password"
        }, function (ButtonPress, Value) {
            alert("Username: " + ValueOriginal + " and your password is: " + Value);
        });
    });

    e.preventDefault();
});

</script>


<script type="text/javascript">
    // DO NOT REMOVE : GLOBAL FUNCTIONS!
    pageSetUp();

    // PAGE RELATED SCRIPTS

    $('.tree > ul').attr('role', 'tree').find('ul').attr('role', 'group');
    $('.tree').find('li:has(ul)').addClass('parent_li').attr('role', 'treeitem').find(' > span').attr('title', 'Collapse this branch').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(':visible')) {
            children.hide('fast');
            $(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
        }
        e.stopPropagation();
    });

</script>

