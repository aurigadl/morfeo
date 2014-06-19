<?php
//session_start();
//ini_set("display_errors",1);
if(!$ruta_raiz) $ruta_raiz = "..";			
if(!$db) {  include_once $ruta_raiz."/conn.php"; }
include_once $ruta_raiz."/js/inc/init.php";
include_once $ruta_raiz."/htmlheader.inc.php";
if(!$nameGrid ) $nameGrid = "grid1";
if(!$descGrid ) $descGrid = "Tablas ...";
if($fieldsView) $fieldsView = mb_strtoupper($fieldsView);
if($tableSearch ){
 if(!trim($fieldsView)) $fieldsView = " * ";
  $fieldSql = "SELECT $fieldsView FROM $tableSearch ORDER BY 1";
}
//$db->conn->debug = true;
$rs = $db->conn->query($fieldSql);
 $i=1;
 
$colsNames = ""; $colModels = ""; $dataFields="";
while(!$rs->EOF){
  $k=1;
  // var_dump($rs->fields);
  if($i!=1) $dataFields .=" ,{"; else $dataFields .=" {";
  foreach($rs->fields as $nameField => $valueField){
   if($k!=1) $dataFields .=" ,";
   if($i==1) {   
   if($k!=1 && $i==1) {$colsNames .= " ,"; $colsModels .= " ,";}
    $colsNames .= "'". $nameField. "'"; 
    $colsModels .= "{name : '$nameField', index : '$nameField',  editable : true}";
   }
   $dataFields .= "$nameField : '$valueField'  ";
   $k++;
  }
  $dataFields .= "}";
  $rs->MoveNext();
  $i++;
  
}
?>
<!-- row -->

<!-- widget grid -->
<small>
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<table id="<?=$nameGrid?>"></table>
			<div id="pjqgrid"></div>

			<br>
			<a href="javascript:void(0)" id="m1">Get Selected id's</a>
			<br>
			<a href="javascript:void(0)" id="m1s">Select(Unselect) row 13</a>

		</article>
		<!-- WIDGET END -->

	</div>

	<!-- end row -->

</section>
<!-- end widget grid -->
</small>
<?php
$scriptJS .= "
	/* DO NOT REMOVE : GLOBAL FUNCTIONS!
	 *
	 * pageSetUp(); WILL CALL THE FOLLOWING FUNCTIONS
	 *
	 * // activate tooltips
	 * $('[rel=tooltip]').tooltip();
	 *
	 * // activate popovers
	 * $('[rel=popover]').popover();
	 *
	 * // activate popovers with hover states
	 * $('[rel=popover-hover]').popover({ trigger: 'hover' });
	 *
	 * // activate inline charts
	 * runAllCharts();
	 *
	 * // setup widgets
	 * setup_widgets_desktop();
	 *
	 * // run form elements
	 * runAllForms();
	 *
	 ********************************
	 *
	 * pageSetUp() is needed whenever you load a page.
	 * It initializes and checks for all basic elements of the page
	 * and makes rendering easier.
	 *
	 */

	pageSetUp();

	/*
	 * ALL PAGE RELATED SCRIPTS CAN GO BELOW HERE
	 * eg alert('my home function');
	 *
	 * var pagefunction = function() {
	 *   ...
	 * }
	 * loadScript('js/plugin/_PLUGIN_NAME_.js', pagefunction);
	 *
	 */

	var pagefunction = function() {
		loadScript('$ruta_raiz/js/plugin/jqgrid/jquery.jqGrid.min.js', run_jqgrid_function);

		function run_jqgrid_function() {

			var jqgrid_data = [$dataFields];

			jQuery('#$nameGrid').jqGrid({
				data : jqgrid_data,
				datatype : 'local',
				height : '900',
				colNames : [$colsNames],
				colModel : [$colsModels],
				rowNum : 10,
				rowList : [10, 20, 30],
				pager : '#pjqgrid',
				sortname : 'ID',
				toolbarfilter : true,
				viewrecords : true,
				sortorder : 'asc',
				gridComplete : function() {
					var ids = jQuery('#$nameGrid').jqGrid('getDataIDs');
					for (var i = 0; i < ids.length; i++) {
						var cl = ids[i];
						be = '<button class=\'btn btn-xs btn-default\' data-original-title=\'Edit Row\' onclick=\'jQuery(\'#$nameGrid\').editRow(\' + cl + \');\'><i class=\'fa fa-pencil\'></i></button>';
						se = '<button class=\'btn btn-xs btn-default\' data-original-title=\'Save Row\' onclick=\'jQuery(\'#$nameGrid\').saveRow(\' + cl + \');\'><i class=\'fa fa-save\'></i></button>';
						ca = '<button class=\'btn btn-xs btn-default\' data-original-title=\'Cancel\' onclick=\'jQuery(\'#$nameGrid\').restoreRow(\' + cl + \');\'><i class=\'fa fa-times\'></i></button>';
						//ce = '<button class=\'btn btn-xs btn-default\' onclick=\'jQuery(\'#$nameGrid\').restoreRow(\'+cl+\');\'><i class=\'fa fa-times\'></i></button>';
						//jQuery('#$nameGrid').jqGrid('setRowData',ids[i],{act:be+se+ce});
						jQuery('#$nameGrid').jqGrid('setRowData', ids[i], {
							act : be + se + ca
						});
					}
				},
				editurl : 'dummy.html',
				caption : '$descGrid',
				multiselect : true,
				autowidth : true,

			});
			jQuery('$nameGrid').jqGrid('navGrid', '#pjqgrid', {
				edit : false,
				add : false,
				del : true
			});
			jQuery('#$nameGrid').jqGrid('inlineNav', '#pjqgrid');
			/* Add tooltips */
			$('.navtable .ui-pg-button').tooltip({
				container : 'body'
			});

			jQuery('#m1').click(function() {
				var s;
				s = jQuery('#$nameGrid').jqGrid('getGridParam', 'selarrrow');
				alert(s);
			});
			jQuery('#m1s').click(function() {
				jQuery('#$nameGrid').jqGrid('setSelection', '13');
			});

			// remove classes
			$('.ui-jqgrid').removeClass('ui-widget ui-widget-content');
			$('.ui-jqgrid-view').children().removeClass('ui-widget-header ui-state-default');
			$('.ui-jqgrid-labels, .ui-search-toolbar').children().removeClass('ui-state-default ui-th-column ui-th-ltr');
			$('.ui-jqgrid-pager').removeClass('ui-state-default');
			$('.ui-jqgrid').removeClass('ui-widget-content');

			// add classes
			$('.ui-jqgrid-htable').addClass('table table-bordered table-hover');
			$('.ui-jqgrid-btable').addClass('table table-bordered table-striped');

			$('.ui-pg-div').removeClass().addClass('btn btn-sm btn-primary');
			$('.ui-icon.ui-icon-plus').removeClass().addClass('fa fa-plus');
			$('.ui-icon.ui-icon-pencil').removeClass().addClass('fa fa-pencil');
			$('.ui-icon.ui-icon-trash').removeClass().addClass('fa fa-trash-o');
			$('.ui-icon.ui-icon-search').removeClass().addClass('fa fa-search');
			$('.ui-icon.ui-icon-refresh').removeClass().addClass('fa fa-refresh');
			$('.ui-icon.ui-icon-disk').removeClass().addClass('fa fa-save').parent('.btn-primary').removeClass('btn-primary').addClass('btn-success');
			$('.ui-icon.ui-icon-cancel').removeClass().addClass('fa fa-times').parent('.btn-primary').removeClass('btn-primary').addClass('btn-danger');
			$('.ui-icon.ui-icon-seek-prev').wrap('<div class=\'btn btn-sm btn-default\'></div>');
			$('.ui-icon.ui-icon-seek-prev').removeClass().addClass('fa fa-backward');

			$('.ui-icon.ui-icon-seek-first').wrap('<div class=\'btn btn-sm btn-default\'></div>');
			$('.ui-icon.ui-icon-seek-first').removeClass().addClass('fa fa-fast-backward');

			$('.ui-icon.ui-icon-seek-next').wrap('<div class=\'btn btn-sm btn-default\'></div>');
			$('.ui-icon.ui-icon-seek-next').removeClass().addClass('fa fa-forward');

			$('.ui-icon.ui-icon-seek-end').wrap('<div class=\'btn btn-sm btn-default\'></div>');
			$('.ui-icon.ui-icon-seek-end').removeClass().addClass('fa fa-fast-forward');

			// update buttons
			
			$(window).on('resize.jqGrid', function() {
				$('#$nameGrid').jqGrid('setGridWidth', $('#content').width());
			});

		}// end function

	}
	loadScript('$ruta_raiz/js/plugin/jqgrid/grid.locale-en.min.js', pagefunction);

";
//echo "<script>".$scriptJS."</script>";
