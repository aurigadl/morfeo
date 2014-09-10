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
$verrad = "";
$ruta_raiz = "..";
if (!$dep_sel) $dep_sel = $_SESSION['dependencia'];
$depeBuscada =$dep_sel;
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc = $_SESSION["usua_doc"];
$codusuario = $_SESSION["codusuario"];
$adodb_next_page=$_GET["adodb_next_page"];
?>
<html>
<head>
<title>Anulacion de Radicados</title>
<link rel="stylesheet" href="../estilos/orfeo.css">
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<?php include_once "$ruta_raiz/js/funtionImage.php"; ?>
</head>
<body bgcolor="#FFFFFF" onLoad="window_onload();">
<div id="spiffycalendar" class="text"></div>
<link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
<?php
$ruta_raiz = "..";
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler("$ruta_raiz");
/**
 * Generamos el encabezado que envia las variable a la paginas siguientes.
 * Por problemas en las sesiones enviamos el usuario.
 * @$encabezado  Incluye las variables que deben enviarse a la singuiente pagina.
 * @$linkPagina  Link en caso de recarga de esta pagina.
*/
switch ($tpAnulacion){
    case 1:
        $whereTpAnulacion = " and (
			b.SGD_EANU_CODIGO = 9
			or b.SGD_EANU_CODIGO = 2
			or b.SGD_EANU_CODIGO IS NULL
			)";
	$nomcarpeta    = "Solicitud de Anulacion de Radicados";
	$nombreCarpeta = "Solicitud de Anulacion de Radicados";
	$accion_sal    = "Solicitar Anulacion";
	$textSubmit = "Solicitar Anulacion";
	break;
    case 2:
	$whereTpAnulacion = " AND b.SGD_EANU_CODIGO = 2 ";
	$nomcarpeta    =  "Radicados para Anular";
	$nombreCarpeta = "Radicados para Anular";
	$accion_sal    = "";
	$textSubmit = "";
	break;
    case 3:
        $whereTpAnulacion = " and b.SGD_EANU_CODIGO = 9 ";
	$nomcarpeta    = "Radicados Anulados";
	$nombreCarpeta = "Radicados Anulados";
	$accion_sal    = "Ver Reporte";
	$textSubmit = "Ver Reporte";
	break;
}

$encabezado = "".session_name()."=".session_id()."&krd=$krd&filtroSelect=$filtroSelect&accion_sal=$accion_sal&dep_sel=$dep_sel&tpAnulacion=$tpAnulacion&orderNo=";
$linkPagina = "$PHP_SELF?$encabezado&accion_sal=$accion_sal&orderTipo=$orderTipo&orderNo=$orderNo";
$carpeta    = "xx";

//include "../envios/paEncabeza.php";

$pagina_actual = "../anulacion/cuerpo_anulacion.php";
$varBuscada = "radi_nume_radi";
//include "../envios/paBuscar.php";
$pagina_sig = "../anulacion/solAnulacion.php";
//$swListar = "no";
$accion_sal="Solicitar Anulacion";
include "../envios/paOpciones.php";

$whereFiltro=$dependencia_busq2;
/**  GENERACION LISTADO DE RADICADOS
 *  Aqui utilizamos la clase adodb para generar el listado de los radicados
 *  Esta clase cuenta con una adaptacion a las clases utiilzadas de orfeo.
 *  el archivo original es adodb-pager.inc.php la modificada es adodb-paginacion.inc.php
 */

if ($orderNo==98 or $orderNo==99) {
    $order=1;
    if ($orderNo==98)   $orderTipo="desc";
    if ($orderNo==99)   $orderTipo="";
}
else {
    if (!$orderNo)  $orderNo=3;
    $order = $orderNo + 1;

    if($orden_cambio==1){
        (!$orderTipo) ? $orderTipo="desc" : $orderTipo="";
    }
}
$sqlFecha = $db->conn->SQLDate("d-m-Y H:i A","b.RADI_FECH_RADI");
?>
<form name=formEnviar action='../anulacion/solAnulacion.php?<?=session_name()."=".session_id()."&krd=$krd" ?>&tpAnulacion=<?=$tpAnulacion?>&depeBuscada=<?=$depeBuscada?>&estado_sal_max=<?=$estado_sal_max?>&pagina_sig=<?=$pagina_sig?>&dep_sel=<?=$dep_sel?>&nomcarpeta=<?=$nomcarpeta?>&orderTipo=<?=$orderTipo?>&orderNo=<?=$orderNo?>' method=post>
<?php
$encabezado = "".session_name()."=".session_id()."&krd=$krd&depeBuscada=$depeBuscada&accion_sal=$accion_sal&filtroSelect=$filtroSelect&dep_sel=$dep_sel&tpAnulacion=$tpAnulacion&nomcarpeta=$nomcarpeta&orderTipo=$orderTipo&orderNo=";
$linkPagina = $_SERVER['PHP_SELF']."?$encabezado&orderTipo=$orderTipo&orderNo=$orderNo";
?>
<div class="col-sm-12">
<section id="widget-grid" class="">
	<!-- row -->
	<div >
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2><?=$carpeta?> </h2>
				</header>

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">
						<div class="widget-body-toolbar">
							<div style="position:absolute; left: 195; top:5;">
								<span class="smart-form">
										<label class="select" style="width:230px">
										<select id="AccionCaliope" name="AccionCaliope" size="1" aria-controls="dt_basic" onChange="changedepesel1();">
										  <option value="9" selected="selected">Escoja una accion...</option>
											<option value="9" >Enviar a...</option>
											<option value="8">Mover a Carpeta...</option>
											<option value="9">Enviar a Visto Bueno...</option>
											<option value="12">Informar...</option>
											<option value="13">Archivar...</option>
											<option value="14">Agendar...</option>
											<option value="14"></option>
										</select>
								</span>
							</div>
							<?php
								$controlAgenda=1;
								if($carpeta==11 and !$tipo_carp and $codusuario!=1){
								}else{
								  ?>
								  	<div style="position:absolute; left: 430; top:5;">
										<span class="smart-form">
										<label class="select" style="width:230px">
										<?
											include "./tx/txOrfeo.php";
										}
										?>
									  </label>
										</span>
									</span>
							</div>
						</div>
						<table id="dt_basic" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>Radicado</th>
									<th>Fecha Radicado</th>
									<th>Asunto</th>
									<th>Remitente</th>
									<th>Tipo Documento</th>
									<th>Dias Restantes</th>
									<th>Enviado Por</th>
									<th><input type="checkbox" onclick="markAll();" value="checkAll" name="checkAll" id="checkAll"> </th>
								</tr>
							</thead>
							<tbody>
							<?php
                include "$ruta_raiz/include/query/anulacion/querycuerpo_anulacion.php";
								// $db->conn->debug = true;
								$rs = $db->conn->Execute($isql);

							 while(!$rs->EOF){

							  $numeroRadicado        = $rs->fields["IMG_NUMERO RADICADO"];
							  $fechaRadicado         = $rs->fields["FECHA RADICADO"];
							  $asuntoRadicado        = $rs->fields["DESCRIPCION"];
							  $remitenteRadicado     = $rs->fields["REMITENTE"];
							  $tipoDocumentoRadicado = $rs->fields["TIPO DOCUMENTO"];
							  $diasRadicado          = $rs->fields["DIAS RESTANTES"];
							  $enviadoPor            = $rs->fields["ENVIADO POR"];
							  $radiPath              = $rs->fields["HID_RADI_PATH"];

							  $linkVerRadicado = "./verradicado.php?verrad=$numeroRadicado&".session_name()."=".session_id()."&nomcarpeta=$nomcarpeta#tabs-a";
							  $linkImagen      = "$ruta_raiz/bodega/$radiPath";

							?>
								<tr>
									<td><A onClick="window.open('<?=$linkImagen?>','imgCaliope<?=date("ymdhis")?>','width=200,height=100');" href='#'> <?=$numeroRadicado?></a></td>
									<td><a href='<?=$linkVerRadicado?>'><?=$fechaRadicado?></a></td>
									<td><?=$asuntoRadicado?></td>
									<td><?=$remitenteRadicado?></td>
									<td><?=$tipoDocumentoRadicado?></td>
									<td><?=$diasRadicado?>35728</td>
									<td><?=$enviadoPor?></td>
									<td><input id="<?=$numeroRadicado?>" type="checkbox" value="CHKANULAR" name="checkValue[<?=$numeroRadicado?>]"></td>
								</tr>
							<?php
							 $rs->MoveNext();
							} ?>
							</tbody>
						</table>
					</div>
					<!-- end widget content -->
				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->
    </article>
	</div>
	<!-- end row -->
</section>
	</div>
</form>
<script type="text/javascript">

	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();

	// PAGE RELATED SCRIPTS

	loadDataTableScripts();
	function loadDataTableScripts() {

		loadScript("js/plugin/datatables/jquery.dataTables-cust.min.js", dt_2);

		function dt_2() {
			loadScript("js/plugin/datatables/ColReorder.min.js", dt_3);
		}

		function dt_3() {
			loadScript("js/plugin/datatables/FixedColumns.min.js", dt_4);
		}

		function dt_4() {
			loadScript("js/plugin/datatables/ColVis.min.js", dt_5);
		}

		function dt_5() {
			loadScript("js/plugin/datatables/ZeroClipboard.js", dt_6);
		}

		function dt_6() {
			loadScript("js/plugin/datatables/media/js/TableTools.min.js", dt_7);
		}

		function dt_7() {
			loadScript("js/plugin/datatables/DT_bootstrap.js", runDataTables);
		}

	}

	function runDataTables() {

		/*
		 * BASIC
		 */
		$('#dt_basic').dataTable({
			"sPaginationType" : "bootstrap_full"
		});

		/* END BASIC */

		/* Add the events etc before DataTables hides a column */
		$("#datatable_fixed_column thead input").keyup(function() {
			oTable.fnFilter(this.value, oTable.oApi._fnVisibleToColumnIndex(oTable.fnSettings(), $("thead input").index(this)));
		});

		$("#datatable_fixed_column thead input").each(function(i) {
			this.initVal = this.value;
		});
		$("#datatable_fixed_column thead input").focus(function() {
			if (this.className == "search_init") {
				this.className = "";
				this.value = "";
			}
		});
		$("#datatable_fixed_column thead input").blur(function(i) {
			if (this.value == "") {
				this.className = "search_init";
				this.value = this.initVal;
			}
		});


		var oTable = $('#datatable_fixed_column').dataTable({
			"sDom" : "<'dt-top-row'><'dt-wrapper't><'dt-row dt-bottom-row'<'row'<'col-sm-6'i><'col-sm-6 text-right'p>>",
			//"sDom" : "t<'row dt-wrapper'<'col-sm-6'i><'dt-row dt-bottom-row'<'row'<'col-sm-6'i><'col-sm-6 text-right'>>",
			"oLanguage" : {
				"sSearch" : "Search all columns:"
			},
			"bSortCellsTop" : true
		});



		/*
		 * COL ORDER
		 */
		$('#datatable_col_reorder').dataTable({
			"sPaginationType" : "bootstrap",
			"sDom" : "R<'dt-top-row'Clf>r<'dt-wrapper't><'dt-row dt-bottom-row'<'row'<'col-sm-6'i><'col-sm-6 text-right'p>>",
			"fnInitComplete" : function(oSettings, json) {
				$('.ColVis_Button').addClass('btn btn-default btn-sm').html('Columns <i class="icon-arrow-down"></i>');
			}
		});

		/* END COL ORDER */

		/* TABLE TOOLS */
		$('#datatable_tabletools').dataTable({
			"sDom" : "<'dt-top-row'Tlf>r<'dt-wrapper't><'dt-row dt-bottom-row'<'row'<'col-sm-6'i><'col-sm-6 text-right'p>>",
			"oTableTools" : {
				"aButtons" : ["copy", "print", {
					"sExtends" : "collection",
					"sButtonText" : 'Save <span class="caret" />',
					"aButtons" : ["csv", "xls", "pdf"]
				}],
				"sSwfPath" : "js/plugin/datatables/media/swf/copy_csv_xls_pdf.swf"
			},
			"fnInitComplete" : function(oSettings, json) {
				$(this).closest('#dt_table_tools_wrapper').find('.DTTT.btn-group').addClass('table_tools_group').children('a.btn').each(function() {
					$(this).addClass('btn-sm btn-default');
				});
			}
		});

		/* END TABLE TOOLS */

	}

</script>
</body>
</html>
