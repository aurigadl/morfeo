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

$ruta_raiz = ".";
if (!$_SESSION['dependencia'])
header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

define('ADODB_ASSOC_CASE', 1);
$verrad         = "";
$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];
$tip3Nombre     = $_SESSION["tip3Nombre"];
$tip3desc       = $_SESSION["tip3desc"];
$tip3img        = $_SESSION["tip3img"];
$descCarpetasGen= $_SESSION["descCarpetasGen"] ;
$descCarpetasPer= $_SESSION["descCarpetasPer"];

$_SESSION['numExpedienteSelected'] = null;

  include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");
	if (!$db) $db = new ConnectionHandler($ruta_raiz);
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	//$db->conn->debug = true;
	$sqlFecha = $db->conn->SQLDate("Y-m-d H:i A","b.RADI_FECH_RADI");
	  if(strlen($orderNo)==0){
      $orderNo="2";
      $order = 3;
  }else{
      $order = $orderNo +1;
  }

		if(trim($orderTipo)=="") $orderTipo="DESC";
		if($orden_cambio==1){
				if(trim($orderTipo)!="DESC"){
						$orderTipo="DESC";
				}else{
						$orderTipo="ASC";
				}
		}

			if(!$carpeta) $carpeta=0;
			if(!$tipo_carp) $tipo_carp=0;

		/**
		* Este if verifica si se debe buscar en los radicados de todas las carpetas.
		* @$chkCarpeta char  Variable que indica si se busca en todas las carpetas.
		*
		*/
		if($chkCarpeta){
				$chkValue=" checked ";
				$whereCarpeta = " ";
		}else{
				$chkValue="";
				$whereCarpeta = " and b.carp_codi=$carpeta ";
				$whereCarpeta   = $whereCarpeta ." and b.carp_per=$tipo_carp ";
		}


		$fecha_hoy      = Date("Y-m-d");
		$sqlFechaHoy    = $db->conn->DBDate($fecha_hoy);

		//Filtra el query para documentos agendados
		if ($agendado==1){
			$sqlAgendado=" and (radi_agend=1 and radi_fech_agend > $sqlFechaHoy) "; // No vencidos
		}else  if ($agendado==2){
			$sqlAgendado=" and (radi_agend=1 and radi_fech_agend <= $sqlFechaHoy)  "; // vencidos
		}

		if ($agendado){
			$colAgendado = "," .$db->conn->SQLDate("Y-m-d H:i A","b.RADI_FECH_AGEND").' as "Fecha Agendado"';
			$whereCarpeta="";
		}

		//Filtra teniendo en cienta que se trate de la carpeta Vb.
		if($carpeta==11 && $codusuario !=1 && $_GET['tipo_carp']!=1){
				$whereUsuario = " and  b.radi_usu_ante ='$krd' ";
		}else{
			$whereUsuario = " and b.radi_usua_actu='$codusuario' ";
		}

?>
<html>
<head>
    <meta charset="utf-8">
        <title>Sistema de informaci&oacute;n integrado de Metrovivienda</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="SIIM2">
        <meta name="keywords" content="siim, metrovivienda, gestion, misional">
        <link rel="shortcut icon" href="<?=$ruta_raiz?>/img/favicon.png">
        <!-- Bootstrap core CSS -->

        <?php include_once "htmlheader.inc.php"; ?>

</head>
<body onLoad="window_onload();">
  <FORM name=form1 id=form1 action="./tx/formEnvio.php?<?=$encabezado?>" methos=post/>
  <div id="content" style="opacity: 1;">

    <div class="row">
      <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark">
          <i class="fa fa-table fa-fw "></i>
            Bandeja
          <span>>
          <?=$nomcarpeta?>
          </span>
        </h1>
      </div>
      <div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
        <ul id="sparks" class="">
          <li class="sparks-info">
            <h5> Radicados <span class="txt-color-blue"><?=$numeroRadicados?></span></h5>
            <div class="sparkline txt-color-blue hidden-mobile hidden-md hidden-sm">
              1300, 1877, 2500, 2577
            </div>
          </li>
          <li class="sparks-info">
            <h5> Vencidos <span class="txt-color-purple"><i class="fa fa-arrow-circle-up" data-rel="bootstrap-tooltip" title="Increased"></i>&nbsp;45</span></h5>
            <div class="sparkline txt-color-purple hidden-mobile hidden-md hidden-sm">
              110,150,300,130,400,240
            </div>
          </li>
          <li class="sparks-info">
            <h5> Ok <span class="txt-color-greenDark">&nbsp;2447</span></h5>
            <div class="sparkline txt-color-greenDark hidden-mobile hidden-md hidden-sm">
              110,150,300,130,400,240
            </div>
          </li>
        </ul>
      </div>
    </div>

    <!-- widget grid -->
    <section id="widget-grid" class="">

      <!-- row -->
      <div class="row" >

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
                          <option value="15" >Enviar a Visto Bueno.</option>
                          <option value="10">Mover a Carpeta...</option>
                          <option value="9">Enviar a Visto Bueno...</option>
                          <option value="8	">Informar...</option>
                          <option value="12	">Devolver...</option>
                          <option value="13">Archivar...</option>
                          <option value="14">Agendar...</option>
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
                    include "$ruta_raiz/include/query/queryCuerpo.php";
                      // $db->conn->debug = true;
                      $rs     =$db->conn->Execute($isql);

                  while(!$rs->EOF){
                    $numeroRadicado = $rs->fields["HID_RADI_NUME_RADI"];
                    $fechaRadicado = $rs->fields["HID_RADI_FECH_RADI"];
                    $asuntoRadicado = $rs->fields["ASUNTO"];
                    $remitenteRadicado = $rs->fields["REMITENTE"];
                    $tipoDocumentoRadicado = $rs->fields["TIPO DOCUMENTO"];
                    $diasRadicado = $rs->fields["DIAS RESTANTES"];
                    $enviadoPor = $rs->fields["ENVIADO POR"];
                    $radiPath = $rs->fields["HID_RADI_PATH"];

                    $linkVerRadicado = "./verradicado.php?verrad=$numeroRadicado&".session_name()."=".session_id()."&nomcarpeta=$nomcarpeta#tabs-a";
                    $linkImagen = "$ruta_raiz/bodega/$radiPath";
                  ?>
                    <tr>
                      <td><small><A onClick="window.open('<?=$linkImagen?>','imgCaliope<?=date("ymdhis")?>','width=200,height=100');" href='#'> <?=$numeroRadicado?></a></small></td>
                      <td><small><a href='<?=$linkVerRadicado?>' target="mainFrame"><?=$fechaRadicado?></a></small></td>
                      <td><small><?=$asuntoRadicado?></small></td>
                      <td><small><?=$remitenteRadicado?></small></td>
                      <td><small><?=$tipoDocumentoRadicado?></small></td>
                      <td><small><?=$diasRadicado?>35728</small></td>
                      <td><small><?=$enviadoPor?></small></td>
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
    <!-- end widget grid -->
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
