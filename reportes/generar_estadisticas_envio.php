<?php
session_start();

$ruta_raiz    = "..";
$krd          = $_SESSION["krd"];
$dependencia  = $_SESSION["dependencia"];
$usua_doc     = $_SESSION["usua_doc"];
$codusuario   = $_SESSION["codusuario"];
$depe_codi_territorial = $_SESSION["depe_codi_territorial"];

include_once "../include/db/ConnectionHandler.php";
$db = new ConnectionHandler("..");
$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;

foreach ($_GET as $key => $valor)
    ${$key} = $valor;
foreach ($_POST as $key => $valor)
    ${$key} = $valor;

$anoActual = date("Y");
if (!$fecha_busq)
    $fecha_busq = date("Y-m-d");
if (!$fecha_busq2)
    $fecha_busq2 = date("Y-m-d");

$ruta_raiz = "..";
$db = new ConnectionHandler("$ruta_raiz");
?>

<head>
    <title>LISTADO DE DOCUMENTOS ENVIADOS POR AGENCIA DE CORREO</title>
    <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>

<BODY>

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
    <h2> LISTADO DE DOCUMENTOS ENVIADOS POR AGENCIA DE CORREO </h2>
</header>
<!-- widget div-->
<div>
    <!-- widget content -->
    <div class="widget-body no-padding">
        <div class="table-responsive">
            <form name="new_product"
                  action='../reportes/generar_estadisticas_envio.php?<?= session_name() . "=" . session_id() . "&krd=$krd&fecha_h=$fechah&fecha_busq=$fecha_busq&fecha_busq2=$fecha_busq2" ?>'
                  method=post class="smart-form">

                <table class="table table-bordered table-striped">
                    <!--DWLayoutTable-->
                    <TR>
                        <TD width="415" height="21" class='titulos5'> Fecha desde<br>
                            <?
                            echo "($fecha_busq)";
                            ?>
                        </TD>
                        <TD width="415" align="right" valign="top">
                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                <input type="text" id="fecha_busq"  name="fecha_busq" placeholder="Fecha desde"
                                       value="<?=$fecha_busq?>">
                             </label>
                        </TD>
                    </TR>
                    <TR>
                        <TD width="125" height="21" class='titulos5'> Fecha Hasta<br>
                            <?
                            echo "($fecha_busq2)";
                            ?>
                        </TD>
                        <TD width="415" align="right" valign="top">
                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                <input type="text" id="fecha_busq2"  name="fecha_busq2" placeholder="Fecha hasta" value="<?=$fecha_busq2?>">
                            </label>
                        </TD>
                    </TR>
                    <tr>
                        <TD height="26" class='titulos5'>Tipo de Salida</TD>
                        <TD valign="top" align="left">

                            <label class="select">
                            <?php
                            $ss_RADI_DEPE_ACTUDisplayValue = "--- TODOS LOS TIPOS ---";
                            $valor = 0;
                            include "../include/query/reportes/querytipo_envio.php";
                            $sqlTS = "select $sqlConcat ,SGD_FENV_CODIGO from SGD_FENV_FRMENVIO
					order by SGD_FENV_CODIGO";
                            $rsTs = $db->conn->Execute($sqlTS);
                            print $rsTs->GetMenu2("tipo_envio", "$tipo_envio", $blank1stItem = "$valor:$ss_RADI_DEPE_ACTUDisplayValue", false, 0, " onChange='submit();' class='select'");
                            ?>
                            </label>
                    </tr>
                    <TR>
                        <TD height="26" class='titulos5'>Dependencia</TD>
                        <TD valign="top">
                            <label class="select">
                                <?
                                $ss_RADI_DEPE_ACTUDisplayValue = "--- TODAS LAS DEPENDENCIAS ---";
                                $valor = 0;
                                include "$ruta_raiz/include/query/devolucion/querydependencia.php";
                                $sqlD = "select $sqlConcat ,depe_codi from dependencia
                where depe_codi_territorial = $depe_codi_territorial
                                order by depe_codi";
                                $rsDep = $db->conn->Execute($sqlD);
                                print $rsDep->GetMenu2("dep_sel", "$dep_sel", $blank1stItem = "$valor:$ss_RADI_DEPE_ACTUDisplayValue", false, 0, " onChange='submit();' class='select'");
                                ?>
                            </label>
                        </TD>
                    </TR>
                    <tr>
                        <td height="26" colspan="2" valign="top" class='titulos5'>
                            <center>
                                <INPUT TYPE=SUBMIT name=generar_informe Value=' Generar Informe ' class=botones_mediano>
                            </center>
                        </td>
                    </tr>
                </TABLE>

                <?php
                if (!$fecha_busq)
                    $fecha_busq = date("Y-m-d");
                if ($generar_informe)
                {
                if ($tipo_envio == 0) {
                    $where_tipo = "";
                } else {
                    $where_tipo = " and a.SGD_FENV_CODIGO = $tipo_envio ";
                }
                if ($dep_sel == 0) {
                    /*
                    *Seleccionar todas las dependencias de una territorial
                    */
                    include "$ruta_raiz/include/query/devolucion/querydependencia.php";
                    $sqlD = "select $sqlConcat ,depe_codi from dependencia
	        where depe_codi_territorial = '$depe_codi_territorial'
			order by depe_codi";
                    $rsDep = $db->conn->Execute($sqlD);
                    while (!$rsDep->EOF) {
                        $depcod = $rsDep->fields["DEPE_CODI"];
                        $lista_depcod .= " $depcod,";
                        $rsDep->MoveNext();
                    }
                    $lista_depcod .= "0";
                } else {
                    $lista_depcod = $dep_sel;
                }
                //Se limita la consulta al substring del numero de radicado de salida 27092005
                include "../include/query/reportes/querydepe_selecc.php";

                $generar_informe = 'generar_informe';
                $fecha_ini = $fecha_busq;
                $fecha_fin = $fecha_busq2;
                $fecha_ini = mktime(00, 00, 00, substr($fecha_ini, 5, 2), substr($fecha_ini, 8, 2), substr($fecha_ini, 0, 4));
                $fecha_fin = mktime(23, 59, 59, substr($fecha_fin, 5, 2), substr($fecha_fin, 8, 2), substr($fecha_fin, 0, 4));
                $guion = "' '";
                include "$ruta_raiz/include/query/reportes/querygenerar_estadisticas_envio.php";
                if ($tipo_envio == "101" or $tipo_envio == "108" or $tipo_envio == "109") {
                    $where_isql .= " AND a.SGD_RENV_PLANILLA IS NOT NULL AND
			a.SGD_RENV_PLANILLA != '00'
		";
                }
                if ($tipo_envio == 0) {
                    $where_isql .= " and ((a.sgd_fenv_codigo != '101' and a.sgd_fenv_codigo != '108' and a.sgd_fenv_codigo != '109')
	 				  or (a.sgd_renv_planilla is not null and a.sgd_renv_planilla != '00'))
		";
                }
                $query_t = $query . $where_isql . $where_tipo . $where_depe . $order_isql;
                $ruta_raiz = "..";
                error_reporting(7);
                define('ADODB_FETCH_NUM', 1);
                $ADODB_FETCH_MODE = ADODB_FETCH_NUM;
                require "../anulacion/class_control_anu.php";
                $db->conn->SetFetchMode(ADODB_FETCH_NUM);
                $btt = new CONTROL_ORFEO($db);
                $campos_align = array("C", "L", "L", "L", "L", "L", "L", "L", "L", "L", "L", "L", "L");
                $campos_tabla = array("depe_nomb", "radi_nume_sal", "sgd_renv_nombre", "sgd_renv_dir", "sgd_renv_mpio", "sgd_renv_depto", "sgd_renv_fech", "sgd_fenv_descrip");
                $campos_vista = array("Dependencia", "Radicado", "Destinatario", "Direccion", "Municipio", "Departamento", "Fecha de envio", "Forma de envio");
                $campos_width = array(200, 100, 250, 250, 80, 80, 80, 80);
                $btt->campos_align = $campos_align;
                $btt->campos_tabla = $campos_tabla;
                $btt->campos_vista = $campos_vista;
                $btt->campos_width = $campos_width;

                ?>
                </center>
	<span class="etextomenu">
	<b>Listado de documentos Enviados</b><br>
	Fecha Inicial <?= $fecha_busq . "  00:00:00" ?> <br>
	Fecha Final   <?= $fecha_busq2 . "  23:59:59" ?> <br>
	Fecha Generado <? echo date("Ymd - H:i:s"); ?>
        <?
        $btt->tabla_sql($query_t);
        error_reporting(7);

        $html = $btt->tabla_html;
        error_reporting(7);
        define(FPDF_FONTPATH, '../fpdf/font/');
        require("../fpdf/html_table.php");
        error_reporting(7);
        $pdf = new PDF("L", "mm", "A4");
        $pdf->AddPage();
        $pdf->SetFont('Arial', '', 7);
        $entidad = $db->entidad;
        $encabezado = "<table class='table table-bordered table-striped'>
			<tr>
			<td width=1120 height=30>$entidad</td>
			</tr>
			<tr>
			<td width=1120 height=30>REPORTE DE DOCUMENTOS ENVIADOS ENTRE $fecha_busq   00:00:00  y $fecha_busq2   23:59:59 </td>
			</tr>
			</table>";
        $fin = "<table class='table table-bordered table-striped'>
			<tr>
			<td width=1120 height=60 bgcolor='#CCCCCC'>FUNCIONARIO CORRESPONDENCIA</td>
			</tr>
			<tr>
			<td width=1120 height=60></td>
			</tr>
		</table>";

        $pdf->WriteHTML($encabezado . $html . $fin);
        $arpdf_tmp = "../bodega/pdfs/planillas/envios/$dependencia_$krd" . date("Ymd_hms") . "_envio.pdf";
        $pdf->Output($arpdf_tmp);
        echo "<B><a class=\"vinculos\" href=\"#\" onclick=\"abrirArchivo('" . $arpdf_tmp . "?time=" . time() . "');\"> Abrir Archivo Pdf</a><br>";
        }
        ?>
        </span>
            </form>
        </div>
    </div>
</div>
</div>
</article>
</div>
</section>
</div>
<script>

    function abrirArchivo(url) {
        nombreventana = 'Documento';
        window.open(url, nombreventana, 'status, width=900,height=500,screenX=100,screenY=75,left=50,top=75');
        return;
    }

    $('#fecha_busq').datepicker({
        dateFormat : 'yy-mm-dd',
        onSelect : function(selectedDate) {
            $('#date').datepicker('option', 'maxDate', selectedDate);
        }
    });

    $('#fecha_busq2').datepicker({
        dateFormat : 'yy-mm-dd',
        onSelect : function(selectedDate) {
            $('#date').datepicker('option', 'maxDate', selectedDate);
        }
    });

</script>
</BODY>
