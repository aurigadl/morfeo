<?php
session_start();

foreach ($_GET as $key => $valor)
    ${$key} = $valor;
foreach ($_POST as $key => $valor)
    ${$key} = $valor;

$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc = $_SESSION["usua_doc"];
$codusuario = $_SESSION["codusuario"];
$ruta_raiz = "..";
header('Content-Type: text/html; charset=ISO-8859-1');
if (!$fecha_busq)
    $fecha_busq = date("Y-m-d");
if (!$fecha_busq2)
    $fecha_busq2 = date("Y-m-d");

include('../config.php');
include_once "$ruta_raiz/include/tx/Anulacion.php";
include_once "$ruta_raiz/include/tx/Historico.php";
include_once "$ruta_raiz/include/db/ConnectionHandler.php";

$db = new ConnectionHandler("$ruta_raiz");

if ($cancelarAnular) {
    $aceptarAnular = "";
    $actaNo = "";
}

$depe_codi_territorial = $_SESSION['depe_codi_territorial'];

if ($generar_informe or $aceptarAnular) {
    if ($depeBuscada and $depeBuscada != 0) {
        $whereDependencia = " b.DEPE_CODI=$depeBuscada AND";
    }
    include_once("../include/query/busqueda/busquedaPiloto1.php");
    include "$ruta_raiz/include/query/anulacion/queryanularRadicados.php";

    $fecha_ini = $fecha_busq;
    $fecha_fin = $fecha_busq2;
    $fecha_ini = mktime(00, 00, 00, substr($fecha_ini, 5, 2), substr($fecha_ini, 8, 2), substr($fecha_ini, 0, 4));
    $fecha_fin = mktime(23, 59, 59, substr($fecha_fin, 5, 2), substr($fecha_fin, 8, 2), substr($fecha_fin, 0, 4));

    $query = "select $radi_nume_radi as radi_nume_radi, r.radi_fech_radi, r.ra_asun, r.radi_usua_actu,
        r.radi_depe_actu, r.radi_usu_ante, c.depe_nomb, b.sgd_anu_sol_fech, b.sgd_anu_desc as sgd_anu_desc
        from radicado r, sgd_anu_anulados b, dependencia c";
    $fecha_mes = substr($fecha_ini, 0, 7);

    // Si la variable $generar_listado_existente viene entonces este if genera la planilla existente
    $where_isql = " WHERE $whereDependencia	b.sgd_anu_sol_fecH BETWEEN " .
        $db->conn->DBTimeStamp($fecha_ini) . " and " . $db->conn->DBTimeStamp($fecha_fin) .
        " and SGD_EANU_CODI = 1 $whereTipoRadi and r.radi_nume_radi=b.radi_nume_radi and b.depe_codi = c.depe_codi";
    $order_isql = " ORDER BY  b.depe_codi, b.SGD_ANU_SOL_FECH";
    $query_t = $query . $where_isql . $order_isql;
    // Verifica el ultimo numero de acta del tipo de radicado
    $queryk = "Select max (usua_anu_acta)
        from sgd_anu_anulados
        where sgd_eanu_codi=2 and sgd_trad_codigo = $tipoRadicado	";

    $c = $db->conn->Execute($queryk);
    $rsk = $db->query($queryk);

    $actaNo = (int)$rsk->fields["0"];
    $actaNo++;
}

?>
<HTML>
<HEAD>
    <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</HEAD>
<BODY>
<P>

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
        Anular Radicados<br>
    </h2>
</header>
<!-- widget div-->
<div>
<!-- widget content -->
<div class="widget-body no-padding">
<div class="table-responsive">
<TABLE width="100%" class='borde_tab' cellspacing="5">
    <TR>
        <TD height="30" valign="middle" class='titulos5' align="center">Anulacion de Radicados por Dependencia
        </td>
    </tr>
</table>
<form name="new_product" class="smart-form" action='anularRadicados.php?<?= session_name() . "=" . session_id() .  "&krd=$krd&fecha_h=$fechah" ?>' method=post>
<center>

    <table class="table table-bordered table-striped">
        <!--DWLayoutTable-->
        <TR>
            <TD width="125" height="21" class='titulos2'> Fecha desde<br>
                <?
                echo "($fecha_busq)";
                ?>
            </TD>
            <TD width="500" align="right" valign="top" class='listado2'>
                <label class="input"> <i class="icon-append fa fa-calendar"></i>
                    <input type="text" id="fecha_busq" name="fecha_busq" placeholder="Fecha de inicial" value="<?=$fecha_busq?>">
                </label>
            </TD>
        </TR>
        <TR>
            <TD width="125" height="21" class='titulos2'> Fecha Hasta<br>
                <?
                echo "($fecha_busq2)";
                ?>
            </TD>
            <TD width="500" align="right" valign="top" class='listado2'>
                <label class="input"> <i class="icon-append fa fa-calendar"></i>
                    <input type="text" id="fecha_busq2" name="fecha_busq2" placeholder="Fecha de inicial" value="<?=$fecha_busq2?>">
                </label>
            </TD>
        </TR>
        <tr>
            <TD height="26" class='titulos2'>Tipo Radicacion</TD>
            <TD valign="top" align="left" class='listado2'>
                <label class="select">
                    <?
                    $sqlTR = "select upper(sgd_trad_descr),sgd_trad_codigo from sgd_trad_tiporad
                                     where sgd_trad_codigo != 2
                    order by sgd_trad_codigo";
                    $rsTR = $db->conn->Execute($sqlTR);
                    print $rsTR->GetMenu2("tipoRadicado", "$tipoRadicado", false, false, 0, " class='select'>");
                    ?>
                </label>
            </TD>
        </tr>
        <tr>
            <TD height="26" class='titulos2'>Dependencia</TD>
            <TD valign="top" align="left" class='listado2'>
                <label class="select">
                    <?
                    $sqlD = "select depe_nomb,depe_codi from dependencia
                       where depe_codi_territorial = $depe_codi_territorial
                                order by depe_codi";
                    $rsD = $db->conn->Execute($sqlD);
                    print $rsD->GetMenu2("depeBuscada", "$depeBuscada", false, false, 0, " class='select'> <option value=0>--- TODAS LAS DEPENDENCIAS --- </OPTION ");
                    //if(!$depeBuscada) $depeBuscada=$dependencia;
                    ?>
                </label>
            </td>
        </tr>
        <tr>
            <td height="26" colspan="2" valign="top" class='titulos2'>
                <center>
                    <INPUT TYPE=submit name=generar_informe Value='Ver Documentos En Solicitud' class='btn btn-sm  btn-success '>
                </center>
            </td>
        </tr>
    </TABLE>

    <HR>
    <?php
    if (!$fecha_busq)
        $fecha_busq = date("Y-m-d");
    if ($aceptar and !$actaNo and !$cancelarAnular)
        die ("<font color=red><span class=etextomenu>Debe colocal el Numero de acta para poder anular los radicados</span></font>");
    if (($generar_informe or $aceptarAnular) and !$cancelarAnular) {

    require "../anulacion/class_control_anu.php";
    $db->conn->SetFetchMode(ADODB_FETCH_NUM);
    $btt = new CONTROL_ORFEO($db);
    $campos_align = array("C", "L", "L", "L", "L", "L", "L", "L", "L", "L", "L", "L");
    $campos_tabla = array("depe_nomb", "radi_nume_radi", "sgd_anu_sol_fech", "sgd_anu_desc");
    $campos_vista = array("Dependencia", "Radicado", "Fecha de Solicitud", "Observacion Solicitante");
    $campos_width = array(200, 100, 280, 300);
    $btt->campos_align = $campos_align;
    $btt->campos_tabla = $campos_tabla;
    $btt->campos_vista = $campos_vista;
    $btt->campos_width = $campos_width;
    ?></center>

<table width="100%" cellspacing="3" class="table table-bordered table-striped">
    <TR>
        <TD height="30" valign="middle" class='titulos5' align="center" colspan="2">Documentos con solicitud de
            Anulacion
        </td>
    </tr>
    <tr>
        <td width="16%" class='titulos5'>Fecha Inicial</td>
        <td width="84%" class='listado5'><?= $fecha_busq ?> </td>
    </tr>
    <tr>
        <td class='titulos5'>Fecha Final</td>
        <td class='listado5'><?= $fecha_busq2 ?>
    </tr>
    <tr>
        <td class='titulos5'>Fecha Generado</td>
        <td class='listado5'><? echo date("Ymd - H:i:s"); ?></td>
    </tr>
</table>
<?
$btt->tabla_sql($query_t);
$html = $btt->tabla_html;

$radAnular = $btt->radicadosEnv;
$radObserva = $btt->radicadosObserva;

//Se asigna el No. de la ultima acta + 1

}
if ($generar_informe) {
    ?>
    <span class="listado2">
    <br>Si esta seguro de Anular estos documentos por favor presione aceptar.<br>

    <table class="table table-bordered table-striped" align="center">
      <tr>
          <td>
              <input type="submit" name="aceptarAnular" value="Aceptar" class="btn btn-sm btn-default">
          </td>
          <td>
              <input type="submit" name="cancelarAnular" value="Cancelar" class="btn btn-sm btn-default">
          </td>
      </tr>
    </table>
    </span>
<?
}

//Se le asigna a actaNo el No. de acta que debe seguir
if ($aceptarAnular and $actaNo) {

    include_once "$ruta_raiz/include/db/ConnectionHandler.php";
    $db = new ConnectionHandler("$ruta_raiz");
    //*Inclusion territorial

    if ($depeBuscada == 0) {

        $sqlD = "select depe_nomb,depe_codi from dependencia
                  where depe_codi_territorial = $depe_codi_territorial
                  order by depe_codi";

        $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

        $rsD = $db->conn->Execute($sqlD);
        while (!$rsD->EOF) {
            $depcod = $rsD->fields["DEPE_CODI"];
            $lista_depcod .= " $depcod,";
            $rsD->MoveNext();
        }
        $lista_depcod .= "0";
    } else {
        $lista_depcod = $depeBuscada;
    }

    $where_depe = " and (depe_codi) in ($lista_depcod )";
    //*fin inclusion
    /*
     * Variables que manejan el tipo de Radicacion
     */
    $isqlTR = 'select sgd_trad_descr,sgd_trad_codigo from sgd_trad_tiporad
              where sgd_trad_codigo = ' . $tipoRadicado . '
              ';
    $rsTR = $db->conn->Execute($isqlTR);
    if ($rsTR) {
        $TituloActam = $rsTR->fields["SGD_TRAD_DESCR"];
    } else {
        $TituloActam = "sin titulo ";
    }

    $dbSel = new ConnectionHandler("$ruta_raiz");
    $dbSel->conn->SetFetchMode(ADODB_FETCH_ASSOC);
    $rsSel = $dbSel->conn->Execute($query_t);
    $i = 0;
    while (!$rsSel->EOF) {
        $radAnularE[$i] = $rsSel->fields['RADI_NUME_RADI'];
        $radObservaE[$i] = $rsSel->fields['SGD_ANU_DESC'];
        $i++;
        $rsSel->MoveNext();
    }

    if (!$radAnularE)
        die("<P><span class=etextomenu><CENTER><FONT COLOR=RED>NO HAY RADICADOS PARA ANULAR</FONT></CENTER><span>");
    else {
        $where_TipoRadicado = " and sgd_trad_codigo = " . $tipoRadicado;
        $Anulacion = new Anulacion($db);
        $observa = "Radicado Anulado. (Acta No $actaNo)";
        $var = md5(date("YMDHis"));
        $noArchivo = "/pdfs/planillas/ActaAnul_$dependencia" . "_" . "$tipoRadicado" . "_" . "$actaNo" . "_" . $var . "_.pdf";
        $radicados = $Anulacion->genAnulacion($radAnularE,
            $dependencia,
            $usua_doc,
            "'" . $observaE . "'",
            $codusuario,
            $actaNo,
            $noArchivo,
            $where_depe,
            $where_TipoRadicado,
            $tipoRadicado,
            $rsk->fields["0"]);

        $Historico = new Historico($db);
        $radicados = $Historico->insertarHistorico($radAnularE, $dependencia, $codusuario, $depe_codi_territorial, 1, $observa, 26);

        define(FPDF_FONTPATH, '../fpdf/font/');
        $radAnulados = join(",", $radAnularE);

        foreach ($radAnularE as $id => $noRadicado) {
            $norad = $radAnularE[$id];
            $txrad = $radObservaE[$id];
            $radicadosPdf .= "<br><tr><td width='700' bgcolor='#D0D0FF'><b>Radicado No.  $norad</b></td></tr><span bgcolor='#D0D0'>$txrad</span>";
        }

        $anoActual = date("Y");
        $ruta_raiz = "..";
        include("$ruta_raiz/fpdf/fpdf.php");
        require("$ruta_raiz/fpdf/html_table.php");

        $fecha = date("d-m-Y");
        $fecha_hoy_corto = date("d-m-Y");
        include "$ruta_raiz/class_control/class_gen.php";
        $date = date("m/d/Y");
        $b    = new CLASS_GEN();
        $fecha_hoy = $b->traducefecha($date);
        $html = <<<EOD
              <br>
              <br>
              <br>
              <br><b>ACTA DE ANULACIÓN  No. $actaNo</b>
              <br>
              <br>
              <br><b>NUMEROS DE RADICACIÓN DE CORRESPONDENCIA ENVIADA AÑO $anoActual</b>
              <br>
              <br><b>CENTRO DE DOCUMENTACIÓN</b>
              <br>
              <br><span >En cumplimiento a lo establecido en el Acuerdo No.060 del 30 de  octubre de 2001 expedido por el Archivo General de la Nación, en el cual se establecen pautas para la   administración de las comunicaciones oficiales en las entidades públicas y privadas que cumplen  funciones públicas, y con base especialmente en el parpágrafo del Articulo Quinto,  el cual establece que: Cuando existan errores en la radicación y se anulen los números,  se  debe dejar  constancia por escrito, con la respectiva justificación y firma del  Jefe de la unidad  de  correspondencia. </span>  <br><p>El    Coordinador   de    Gestión   Documental   y    Correspondencia de $entidad_largo procede a anular los siguientes números de  radicación de  $TituloActam que no fueron tramitados por las dependencias radicadoras:</span>
              <br>
              <br> 1.- Números de radicación de $TituloActam a anular:
              <br> $radicadosPdf
              <br>
              <br> 2.- Se deja copia de la presente acta en el archivo central de la Entidad para el trámite
                  respectivo de la organización física de los archivos.
              <br>
              <br>Se firma la presente el $fecha_hoy.
              <br>
              <br>
              <br> ____________________________________________________ <br>
              Director administrativo
EOD;
        $html = '<img src="../img/banerPDF.jpg" width="220">' . $html;
        $ruta_raiz = "..";


        $pdf = new PDF();
        $pdf->SetTitle("Acta de Anulacion de Radicados");
        $pdf->SetSubject("Anulacion radicados");
        $pdf->SetFont('Arial', '', 11);
        $pdf->SetMargins(15,15,15,15);
        $pdf->AddPage();
        if (ini_get('magic_quotes_gpc') == '1')
            $html = stripslashes($html);
        $pdf->WriteHTML(iconv('UTF-8', 'ISO-8859-1', $html));
        $noArchivo = "../bodega" . $noArchivo;
        $pdf->Output($noArchivo);
        ?>
        Ver Acta <a class="titulo2" href='<?= $noArchivo ?>'>Acta No <?= $actaNo ?> </a><?
        exit;
    }
}
?>

</form>
</div>
</div>
</div>
</div>
</article>
</div>
</section>
</div>

</BODY>
<script>
    //Datepicker muestra fecha
    $('#fecha_busq').datepicker({
        dateFormat : 'dd-mm-yy',
        onSelect : function(selectedDate) {
            $('#date').datepicker('option', 'maxDate', selectedDate);
        }
    });

    //Datepicker muestra fecha
    $('#fecha_busq2').datepicker({
        dateFormat : 'dd-mm-yy',
        onSelect : function(selectedDate) {
            $('#date').datepicker('option', 'maxDate', selectedDate);
        }
    });
</script>

</HTML>