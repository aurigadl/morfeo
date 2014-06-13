<HTML>
<HEAD>
<title>Sistema de informaci&oacute;n <?=$entidad_largo?></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<?php
  session_start();
  $ruta_raiz = "..";
  ini_set("display_errors",1);
  include_once "../htmlheader.inc.php";
  
?>
  <link rel="stylesheet" type="text/css" media="screen" href="../js/jqgrid/resources/css/smoothness/jquery.ui.combogrid.css"/>
  <script type="text/javascript" src="../js/jqgrid/resources/plugin/jquery.ui.combogrid-1.6.3.js"></script>
</HEAD>
<BODY>


<?php
  if($_POST["codeForm"]) $codeForm = $_POST["codeForm"];
  if($_GET["codeForm"]) $codeForm = $_GET["codeForm"];
  /** Primer intento de tener un Generador de Formularios para Caliope
    */
  include "$ruta_raiz/conn.php";
  include "$ruta_raiz/gforms/genForm.class.php";
  //$db->conn->debug = true;
  $form = new genForm($db);
  $form->getForm($codeForm);
  $fields = $form->getFormFields();

  $nameForm = $form->nameForm;
  $descForm = $form->descriptionForm;
  // include "frmUpdate.php";z1aSAW3swq33|1w<e	fX
  // include "frmController";
  $scriptJs = "";
?>
<div id="resultadoFrm">
	
</div>

<article class="col-sm-12 col-md-12 col-lg-12">
	
	<!-- Widget ID (each widget will need unique ID)-->
<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false"	data-widget-editbutton="false">
<!-- widget options:
	usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">
	
	data-widget-colorbutton="false"	
	data-widget-editbutton="false"
	data-widget-togglebutton="false"
	data-widget-deletebutton="false"
	data-widget-fullscreenbutton="false"
	data-widget-custombutton="false"
	data-widget-collapsed="true" 
	data-widget-sortable="false"
	
-->
<header>
	<span class="widget-icon"> <i class="fa fa-check txt-color-green"></i> </span>
	<h2><?=$nameForm?> </h2>				
	
</header>
	<!-- widget edit box -->
	<div class="jarviswidget-editbox">
		<!-- This area used as dropdown edit box -->
		
	</div>
	<!-- end widget edit box -->


					<!-- widget content -->
	<div class="">
		
		<!-- Success states for elements -->
		<form class="smart-form">
			<header><?=$descForm?></header>
			<input type=hidden id=paramAjax>
			<fieldset>	
			<table class="table table-bordered">
			<?php
			$arrFieldsSave = array();
			$i =1;
			foreach($fields as $fieldCode => $field){
				$fieldName =     $field["FIELD_NAME"];
				$fieldPk =       $field["FIELD_PK"];
				$fieldDesc =     $field["FIELD_DESC"];
				$fieldType =     $field["FIELD_TYPE"];
				$fieldTypeCode = $field["FIELD_TYPE_CODE"];
				$fieldNull =     $field["FIELD_NULL"];
				$fieldHtml =     $field["FIELD_HTML"];
				$fieldHelp =     $field["FIELD_HELP"];
				$fieldCol =      $field["FIELD_COL"];
				$fieldOrder =    $field["FIELD_ORDER"];
				$fieldColspan =  $field["FIELD_COLSPAN"];
				$fieldLabel =    $field["FIELD_LABEL"];
				$fieldJS =       $field["FIELD_JS"];
				$fieldSql =      $field["FIELD_SQL"];
				$fieldClass =    $field["FIELD_CLASS"];
				$fieldMask =     $field["FIELD_MASK"];
				$fieldSave =     $field["FIELD_SAVE"];
				$tableSave =     $field["TABLE_SAVE"];
				$tablePkSearch = $field["TABLE_PKSEARCH"];
				$fieldPkSearch = $field["FIELD_PKSEARCH"];
				$fieldPkSearch1 = $field["FIELD_PKSEARCH1"];
				$fieldPkSave =   $field["FIELD_PKSAVE"];
				if($orderOld!=$fieldOrder){ 
				  if($orderOld){ echo "</tr>";   }
				  echo "<tr>";   
				}
				
				$arrPkSearch = preg_split("/[\s||]+/", $fieldPkSearch);
				foreach($arrPkSearch as $value){
				  list($val1,$val2,$val3) = preg_split("/[\s->]+/", $value);
				  
				}
				$orderOld=$fieldOrder;
				if(!trim($fieldLabel)) $fieldLabel=$fieldName;
				if($i=1)
				IF($fieldColspan) $addColspan = " colspan=$fieldColspan "; else $addColspan ="";
				if($fieldMask) $tFieldMask = ' data-mask="'.$fieldMask.'" data-mask-placeholder= "-" ';
				$addAttr = " fieldSave='$fieldSave'  tableSave='$tableSave' fieldPk='$fieldPk' ";
				if(trim($fieldClass=="datefield")){
				$scriptJS .= '
					$(\'#'.$fieldName.'\').datepicker({
							dateFormat: \'yy/mm/dd\',
							prevText: \'<i class="fa fa-chevron-left"></i>\',
							nextText: \'<i class="fa fa-chevron-right"></i>\',
							onSelect: function (selectedDate) {
												}
					});';
				   
				   $i++;
				}
			?>
			
			<td  <?=$addColspan?> >
				<section>
				<label class="label"><?=$fieldLabel?></label>
				<label class="<?=$fieldClass?>">
				 <div class="input-group col-lg-12">
				 
					<i class="<?php if(trim($fieldHelp) && trim($fieldClass!="datefield") && trim($fieldTypeCode!=9)){ echo 'icon-append fa fa-question-circle'; } 
					?>" ></i>
					
					<?php if($fieldTypeCode==1 || $fieldTypeCode==2) {?><input <?=$addAttr?> type="<?=$feildType?>" placeholder="<?=$fieldDesc?>" name="<?=$fieldName?>"  id="<?=$fieldName?>"  <?=$tFieldMask?> > <?php } ?>
					<?php if($fieldClass=="textarea") {?><textarea <?=$addAttr?> fieldSave="<?=$fieldSave?>" placeholder="<?=$fieldDesc?>" rows="3"  name="<?=$fieldName?>"  id="<?=$fieldName?>"  ></textarea><?php } ?>
					<?php if($fieldTypeCode==4) {?><input <?=$addAttr?> fieldSave="<?=$fieldSave?>" id="<?=$fieldLabel?>" class="datepicker" type="text" data-dateformat="yyyy-mm-dd" placeholder="Select a date" name="<?=$fieldLabel?>"><?php } ?>
					<?php if($fieldTypeCode==7) {
					  if($fieldSql){
					   $datosSelect = explode ('||',$fieldSql);				   
					  }
					?>
					<select <?=$addAttr?> fieldSave="<?=$fieldSave?>" id="<?=$fieldLabel?>" name="<?=$fieldLabel?>">
					  <?php 
					    foreach($datosSelect as $key => $value){
					    list($val, $cod,$sel) = preg_split("/[\s->]+/", $value);
					    if(!$cod and trim($cod) =="") $cod=$val;
					    if(trim($sel)=="*") $datoss = " selected"; else $datoss = ""
					  ?>
					   <option value=<?=$cod?> <?=$datoss?> ><?=$val?></option>
					  <?php }  ?>
					</select> 
					 <?php 
					} ?>

					<?php if($fieldTypeCode==8) {
					  if($fieldSql){
					   //$db->conn->debug = true;
					   $ADODB_FETCH_MODE = ADODB_FETCH_NUM;
					   $db->conn->SetFetchMode(ADODB_FETCH_NUM);
					   $rsSel = $db->conn->query ($fieldSql);				   
					  }
					?>
					<select <?=$addAttr?> fieldSave="<?=$fieldSave?>" id="<?=$fieldLabel?>" name="<?=$fieldLabel?>">
					  <?php 
					    while(!$rsSel->EOF and $rsSel){
								if(trim($sel)=="*") $datoss = " selected"; else $datoss = "";
								$val = $rsSel->fields[0];
								$cod = $rsSel->fields[1];
								if(!$cod and trim($cod) =="") $cod=$val;

					  ?>
					   <option value=<?=$cod?> <?=$datoss?> ><?=$val?></option>
					  <?php 
					   $rsSel->MoveNext();
					  }  ?>
					</select> 
					 <?php 
					} ?>					
					
					<?php if($fieldTypeCode==9) {
					?>
								<div>
							<div style="float:left"><input size="30" id="<?=$fieldName?>" <?=$addAttr?>  /></div><br/>&nbsp;<br/>
							<div id="switcher" style="float:right"></div>
						</div>
				 <?php 
				if($fieldSql){
					$datosSelect = explode ('||',$fieldSql);				   
				}
				$i=1;
				$fieldsView = "";
				$fieldsViewObject = "";
				$fieldsInsertValueId = "";
				foreach($datosSelect as $key => $value){
				  if($i>=2) {
				    $fieldsViewObject .=",";
				    $fieldsView .=",";  
				    $fieldsInsertValueId .= "";
				  }
					list($field, $fieldId,$sel) = preg_split("/[\s->]+/", $value);
					if(!$cod and trim($cod) =="") $cod=$val;
					if(trim($sel)=="*") { $datoss = " selected"; }else{ $datoss = "";}
					$fieldsView .= "$field";
					$fieldsViewObject .= '{"columnName":"'.$field.'","width":"30","label":"'.$field.'"}';
					$fieldsInsertValueId .= '$( "#'.$fieldId.'" ).val( ui.item.'.$field.' );';
					$i++;
				}
				   
				   
					 $scriptJS .= '
					 jQuery(document).ready(function(){
					      
								$( "#'.$fieldName.'" ).combogrid({
								url: "server.php?tableSearch='.$tablePkSearch.'&fieldSearch='.$fieldPkSearch1.'&fieldsView='.$fieldsView.'",
								debug:true,
								//replaceNull: true,
								colModel: ['.$fieldsViewObject.'],
								select: function( event, ui ) {
								  cargarParametros(),
									'.$fieldsInsertValueId .'
									return false;
								}
							});
						});
					 function cargarParametros(){
					  val = $( "#'.$val2.'" ).val();
					  param = "'.$val1.'="+val;
					  $( "#paramAjax" ).val(param);
					 }
						';
					}else{ ?>					
					<?php 
					if(trim($fieldClass=="datefield")){ ?>
						<span class="input-group-addon">
						<i class="fa fa-calendar"></i>
						</span> 
					<?php
					}elseif (trim($fieldHelp)) {
					?>
						<b class="tooltip tooltip-top-right bg-color-orange">
						<i class="fa fa-question-circle "></i>
						<?=$fieldHelp ?>
						</b>
					<?php }
					}
					?>
					</div>
						<div>

				</label>

				<?php if($fieldNull==1) {?><div class="note note-success">Este campo es Requerido.</div> <?php } ?>
				</section>								
				</td>

			<?php
				}
			?>				</table>	
			</fieldset>
			<footer>
			<button class="btn btn-primary" type="button" onCLick="saveForm();" id=grabar> Grabar </button>
			<button class="btn btn-default" onclick="" type="button"> Cancelar </button>
			</footer>
		</form>	
		</div>
	</div> 
</article>

</BODY>
<script  type="text/javascript">
 function saveForm(){
  // $($('[tablesave]')[1]).attr('id')
  var arrF = new Array();
  var arrJ = new Array();
  var arrJson = "";
  
  $($('[tablesave]')).each(function( index ) {
    fieldId = $($('[tablesave]')[index]).attr('id');
    arrF[index] = new Array(5);
    arrF[index]['tableSave'] =  $($('[tablesave]')[index]).attr('tablesave');
    arrF[index]['fieldSave'] =  $($('[fieldsave]')[index]).attr('fieldsave');
    arrF[index]['fieldPk'] =    $($('[fieldpk]')[index]).attr('fieldpk');
    arrF[index]['fieldValue'] = $($('[tablesave]')[index]).val();
    
    var item = {
        "tableSave":arrF[index]['tableSave'],
        "fieldSave":arrF[index]['fieldSave'],
        "fieldValue":arrF[index]['fieldValue'],
        "fieldPk":arrF[index]['fieldPk'],
    };
      arrJ.push(item);
		});
		pagina = "formUpdate.php";
		$.post( pagina,{data:arrJ}, function( data ) {
    $('#resultadoFrm').html(data);
  });
		// alert(JSON.stringify(arrJ));
 }

 
 function cargarPagina(pagina,nombreDiv){
  $.post( pagina,{verradicado:"<?=$verradicado?>",verradPermisos:"<?=$verradPermisos?>",permRespuesta:"<?=$permRespuesta?>"}, function( data ) {
  $('#'+ nombreDiv).html(data);
  });
}
 <?=$scriptJS?>

</script>
</HTML>