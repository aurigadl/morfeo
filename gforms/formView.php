<?php
//Importamos las variables que generan el formulario y los
//datos con los cuales se llenaran algunos de los campos.
session_start();
$ruta_raiz = "..";

if ($_POST["codeForm"])
    $codeForm = $_POST["codeForm"];

if ($_GET["codeForm"])
    $codeForm = $_GET["codeForm"];

define('ADODB_ASSOC_CASE', 1);
include "$ruta_raiz/conn.php";
include "$ruta_raiz/gforms/genForm.class.php";

$form = new genForm($db);
$form->getForm($codeForm);
$fields  = $form->getFormFields();

$nameForm   = $form->nameForm;
$descForm   = $form->descriptionForm;
$fromAccion = $form->fromAccion;
$namevar    = $form->varsparam;
//Variables para javascript se incorporan al codigo
//para manipular los campos del formulario
$js_var     = 'var js_var = '.$form->js_data_array.';';
$scriptJs   = "";

//Si llegan variables iguales a las que el formulario
//necesita para precargar inforción estas son procesadas
//y se genera un arreglo con los nombres de los campos y
//los valores respectivos.
//Cargamos datos del formulario si este los tiene configurados
//para esto preguntamos por la tabla, variables a cargar
//a cada uno de los campos posteriormente.
if($namevar){

  if ($_SESSION[$namevar]){
    $vaVar = $_SESSION[$namevar];
  }

  if ($_GET[$namevar]){
    $vaVar = $_GET[$namevar];
  }

  if ($_POST[$namevar]){
    $vaVar = $_POST[$namevar];
  }

  //Datos del formulario resultado de la consulta precargada
  //para el formulario en la tabla frm_form
  $arrDataForm = $form->loadDataForm($vaVar);
}


//Acciones a mostrar al inicio o final del formulario
foreach ($fromAccion as $showaction) {

  if($showaction == "limpiar") {
    $accionbutton .= "<button class=\"btn btn-default\" onclick=\"cleanForm()\" type=\"button\">Limpiar</button>";
  }

  if($showaction == "borrar"){
    $accionbutton .= "<button class=\"btn btn-danger\" type=\"button\" onCLick=\"deleteForm();\" id=\"deletefor\"> Borrar</button>";
  }

  if($showaction == "grabar"){
    $accionbutton .="<button class=\"btn btn-primary\" type=\"button\" onCLick=\"saveForm();\" id=\"grabar\"> Grabar</button>";
  }

}

if (!empty($accionbutton)) {
  $accionbutton = "<footer>".$accionbutton."</footer>";
}

?>

<HTML>
<HEAD>
    <title>Sistema de informaci&oacute;n <?= $entidad_largo ?></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php include_once "../htmlheader.inc.php"; ?>
    <script type="text/javascript" src="<?= $ruta_raiz ?>/js/plugin/datatables/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="<?= $ruta_raiz ?>/estilos/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" media="screen" href="<?= $ruta_raiz ?>/estilos/jquery-ui.css">
    <link rel="stylesheet" type="text/css" media="screen" href="<?= $ruta_raiz ?>/estilos/jquery.ui.combogrid.css">
</HEAD>
<BODY>


<br>

<div id="resultadoFrm">
</div>

<article class="col-sm-6 col-md-6 col-lg-12">

<!-- Widget ID (each widget will need unique ID)-->
<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">
<header>
    <h2><?= $nameForm ?> </h2>
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
<header><?= $descForm ?></header>

  <!--Mostramos los botones -->
  <?=$accionbutton ?>

<input type=hidden id=paramAjax>
<fieldset>
<table class="table table-bordered">
<?php
$arrFieldsSave = array();
$i = 1;

//Cargamos datos por cada uno de las entradas del formulario
//desde los variables enviadas hasta el contenido dinamico
//generado por consultas directas y por interaccion con otros
//campos
foreach ($fields as $fieldCode => $field){
$fieldName      = strtolower($field["FIELD_NAME"]);
$fieldLabel     = $field["FIELD_LABEL"];
$fieldPk        = $field["FIELD_PK"];
$fieldDesc      = $field["FIELD_DESC"];
$fieldType      = $field["FIELD_TYPE"];
$fieldTypeCode  = $field["FIELD_TYPE_CODE"];
$fieldNull      = $field["FIELD_NULL"];
$fieldHtml      = $field["FIELD_HTML"];
$fieldHelp      = $field["FIELD_HELP"];
$fieldCol       = $field["FIELD_COL"];
$fieldOrder     = $field["FIELD_ORDER"];
$fieldColspan   = $field["FIELD_COLSPAN"];
$fieldJS        = $field["FIELD_JS"];
$fieldSql       = $field["FIELD_SQL"];
$fieldClass     = $field["FIELD_CLASS"];
$fieldMask      = $field["FIELD_MASK"];
$fieldSave      = $field["FIELD_SAVE"];
$tableSave      = $field["TABLE_SAVE"];
$tablePkSearch  = $field["TABLE_PKSEARCH"];
$fieldPkSearch  = $field["FIELD_PKSEARCH"];
$fieldPkSearch1 = $field["FIELD_PKSEARCH1"];
$fieldPkSave    = $field["FIELD_PKSAVE"];
$fieldDefault   = $field["FIELD_DEFAULT"];
$fieldRowspan   = $field["FIELD_ROWSPAN"];
$fieldParams    = $field["FIELD_PARAMS"];
$valfromsearch  = $arrDataForm[strtoupper($fieldSave)];

//Datos a pasar al formulario pasados por
//variables de envio $_get $_post $_session
$fieldVarsparam = $field["FIELD_VARSPARAM"];
$fieldVars      = $field["FIELD_VARS"];

if ($orderOld != $fieldOrder) {
    if ($orderOld) {
        echo "</tr>";
    }
    echo "<tr>";
}

/*
 * Busca las variables configuradas desde datos externos
 * GET, POST, SESION
 *
 *   Si el valor configurado es 0: explora los metodos  $POST_,$_GET $_SESSION
 *   dejando con prioridad el orden anterior.
 *
 *   Si el valor configurado es 1: trae los datos de $_GET
 *   Si el valor configurado es 2: trae los datos de $_POST
 *   Si el valor configurado es 3: trae los datos de $_SESSION
*/

unset($valueVar,$addValue);
if ($fieldVars == 0 && trim($fieldVarsparam)) {
    if ($_SESSION[$fieldVarsparam])
        $valueVar = $_SESSION[$fieldVarsparam];
    if ($_GET[$fieldVarsparam])
        $valueVar = $_GET[$fieldVarsparam];
    if ($_POST[$fieldVarsparam])
        $valueVar = $_POST[$fieldVarsparam];
} elseif ($fieldVars == 1 && trim($fieldVarsparam)) {
    if ($_GET[$fieldVarsparam])
        $valueVar = $_GET[$fieldVarsparam];
} elseif ($fieldVars == 2 && trim($fieldVarsparam)) {
    if ($_POST[$fieldVarsparam])
        $valueVar = $_POST[$fieldVarsparam];
} elseif ($fieldVars == 3 && trim($fieldVarsparam)) {
    if ($_SESSION[$fieldVarsparam])
        $valueVar = $_SESSION[$fieldVarsparam];
}

if ($valueVar){
    $addValue = " readonly='readonly' value='$valueVar' ";
}
if($valfromsearch){
  $valueVar = $valfromsearch;
  $addValue = " value='$valfromsearch' ";
}


$arrPkSearch = preg_split("/[\s||]+/", $fieldPkSearch);

foreach ($arrPkSearch as $value) {
    //Se utilizan la estructura BARMANPRE->BarManPre y
    //en ocasiones  BARMANPRE->BarManPre->345
    //El primer parametro es el campo de la base de datos el segundo
    //el el campo del formulario y el tercero puede ser el valor por
    //defecto
    list($val1, $val2, $val3) = preg_split("/[\s->]+/", $value);
}

$orderOld = $fieldOrder;

if (!trim($fieldLabel))
    $fieldLabel = $fieldName;
if ($i = 1)
    IF ($fieldColspan)
        $addColspan = " colspan=$fieldColspan "; else $addColspan = "";
if ($fieldRowspan)
    $addRowspan = " rowspan=$fieldRowspan "; else $addRowspan = "";
$addAttr = " fieldSave='$fieldSave'  tableSave='$tableSave' fieldPk='$fieldPk' ";

if (trim($fieldClass == "datefield")) {
    $scriptJS .= '
					$(\'#' . $fieldName . '\').datepicker({
							dateFormat: \'yy/mm/dd\',
							prevText: \'<i class="fa fa-chevron-left"></i>\',
							nextText: \'<i class="fa fa-chevron-right"></i>\',
							onSelect: function (selectedDate) {
												}
					});';
    $i++;
}
?>

<td  <?= $addColspan ?> >
<label> <?= ucwords($fieldLabel) ?></label>
<? if ($fieldTypeCode != 12) { ?><label class="<?= $fieldClass ?>"> <? } ?>
<div class="input-group col-lg-12">

<i class="<?php if (trim($fieldHelp) && trim($fieldTypeCode == 3) && trim($fieldTypeCode != 9) && trim($fieldTypeCode != 12)) {
    echo 'icon-append fa fa-question-circle';
}
?>"></i>

<?php
/************************************************************
 ************************************************************
 *********************** TIPO 1 - TIPO 2 ********************
 ************************************************************
 ***********************************************************/
  if ($fieldTypeCode == 1 || $fieldTypeCode == 2){
    echo "<input $addAttr type=\"$feildType\"
      placeholder=\"$fieldDesc\" name=\"$fieldName\"
      id=\"$fieldName\" $tFieldMask $addValue>";
  }

/************************************************************
 ************************************************************
 ***************************  TIPO 3  ***********************
 ************************************************************
 ***********************************************************/
  if ($fieldTypeCode == 3){
    echo "<textarea $addAttr fieldSave=\"$fieldSave\"
      placeholder=\"$fieldDesc\" rows=\"3\"
      name=\"$fieldName\"
      id=\"$fieldName\">$valueVar</textarea>";
  }

/************************************************************
 ************************************************************
 ***************************  TIPO 4  ***********************
 ************************************************************
 ***********************************************************/
  if ($fieldTypeCode == 4) {
    echo "<input $addAttr fieldSave=\"$fieldSave\" id=\"$fieldName\"
      class=\"datepicker\" type=\"text\" data-dateformat=\"yy-mm-dd\"
      placeholder=\"Select a date\"
      name=\"$fieldName\">";
  }

/************************************************************
 ************************************************************
 ***************************  TIPO 5  ***********************
 ************************************************************
 ***********************************************************/
  if ($fieldTypeCode == 5){
    echo "<label id=\"$fieldLabel\" class=\"label\">$fieldDesc</label>";
  }

/************************************************************
 ************************************************************
 ***************************  TIPO 7  ***********************
 ************************************************************
 ***********************************************************/
  if ($fieldTypeCode == 7) {
     if ($fieldParams) {
         $datosSelect = explode('||', $fieldParams);
     }
    ?>
    <select <?= $addAttr ?> fieldSave="<?= $fieldSave ?>" id="<?= $fieldName ?>" name="<?= $fieldName ?>">
        <?php
        foreach ($datosSelect as $key => $value) {
            $datoss = "";
            list($val, $cod, $sel) = preg_split("/[\s->]+/", $value);
            if (!$cod and trim($cod) == "")
                $cod = $val;
            if (trim($sel) == "*" && !$valueVar)
                $datoss = " selected "; else $datoss = "";
            if (trim($valueVar) == trim($cod))
                $datoss = " selected ";
            ?>
            <option value=<?= $cod ?> <?= $datoss ?>><?= $val ?></option>
        <?php } ?>
    </select>
<?php
}

/************************************************************
 ************************************************************
 ***************************  TIPO 8  ***********************
 ************************************************************
 ***********************************************************/

  if ($fieldTypeCode == 8) {
    if ($fieldSql){
        $ADODB_FETCH_MODE = ADODB_FETCH_NUM;
        $db->conn->SetFetchMode(ADODB_FETCH_NUM);
        $rsSel = $db->conn->query($fieldSql);
    }
    ?>
    <select <?= $addAttr ?> fieldSave="<?= $fieldSave ?>" id="<?= $fieldName ?>" name="<?= $fieldName ?>">
        <?php
        while (!$rsSel->EOF and $rsSel) {
            if (trim($sel) == "*" && !$valueVar)
                $datoss = " selected"; else $datoss = "";
            if (trim($valueVar))
                $datoss = " selected ";
            $val = $rsSel->fields[0];
            $cod = $rsSel->fields[1];
            if (!$cod and trim($cod) == "")
                $cod = $val;

            ?>
            <option value=<?= $cod ?> <?= $datoss ?>><?= $val ?></option>
            <?php
            $rsSel->MoveNext();
        }  ?>
    </select>
<?php
}

/************************************************************
 ************************************************************
 ***************************  TIPO 9  ***********************
 ************************************************************
 ***********************************************************/
if ($fieldTypeCode == 9) { ?>
    <div>
        <div style="float:left"><input size="30" id="<?= $fieldName ?>" <?= $addAttr ?> <?= $addValue ?>
                /></div>
        <br/>&nbsp;<br/>

        <div id="switcher" style="float:right"></div>
    </div>
    <?php
    if ($fieldParams) {
        $datosSelect = explode('||', $fieldParams);
    }
    $i = 1;
    $fieldsView = "";
    $fieldsViewObject = "";
    $fieldsInsertValueId = "";
    foreach ($datosSelect as $key => $value) {
        if ($i >= 2) {
            $fieldsViewObject .= ",";
            $fieldsView .= ",";
            $fieldsInsertValueId .= "";
        }
        list($field, $fieldId, $sel) = preg_split("/[\s->]+/", $value);
        if (!$cod and trim($cod) == "")
            $cod = $val;
        if (trim($sel) == "*") {
            $datoss = " selected";
        } else {
            $datoss = "";
        }
        $fieldsView .= "$field";
        $fieldsViewObject .= '{"columnName":"' . $field . '","width":"30","label":"' . $field . '"}';
        $fieldsInsertValueId .= '$( "#' . strtolower($fieldId) . '" ).val( ui.item.' . $field . ' );';
        $i++;
    }

    $scriptJS .= ' jQuery(document).ready(function(){
								$( "#' . $fieldName . '" ).combogrid({
								url: "server.php?tx=1&tableSearch=' . $tablePkSearch . '&fieldSearch=' .  $fieldPkSearch1 . '&fieldsView=' . $fieldsView . '",
								minLength : 4,
								colModel: [' . $fieldsViewObject . '],
								select: function( event, ui ) {
								  cargarParametros(),
									' . $fieldsInsertValueId . '
									return false;
								}
							});
						});

					 function cargarParametros(){
                         val = $( "#' . $val2 . '" ).val();
                         param = "' . $val1 . '="+val;
					 } ';
} else { ?>
    <?php
    if ($fieldTypeCode == 4) {
        ?>
        <span class="input-group-addon">
						<i class="fa fa-calendar"></i>
						</span>
    <?php
    } elseif (trim($fieldHelp) and $fieldTypeCode != 4) {
        ?>
        <b class="tooltip tooltip-top-right bg-color-orange">
            <i class="fa fa-question-circle "></i>
            <?= $fieldHelp ?>
        </b>
    <?php
    }
}

$ADODB_FETCH_MODE = ADODB_FETCH_ASOC;
$db->conn->SetFetchMode(ADODB_FETCH_ASOC);

/************************************************************
 ************************************************************
 ***************************  TIPO 10 ***********************
 ************************************************************
 ***********************************************************/
if ($fieldTypeCode == 10) {
    $year = Date('Y');
    $pathfile = "../bodega/$year/formFiles/";
    $norandom = fileuploader . rand();
    echo("<div $addAttr id='$norandom'>Subir archivo</div>
                              <input  type='hidden' value='' id='inp_$norandom' $addAttr />");

    if ($fieldParams) {
        $datosSelect = explode('||', $fieldParams);
        foreach ($datosSelect as $key => $value) {
            list($val, $cod) = preg_split("/[\s->]+/", $value);
            if ($val == 'link') {
                $urlattach = " var idurlattach ='" . $cod . "'; ";
            }

            if ($val == 'image') {
                $imageattach = " var idimageattach ='" . $cod . "'; ";
            }

        }
    }

    $scriptJS .= " $urlattach
                   $imageattach

                   var uploaderId = '$norandom';
                   $('#$norandom').uploadFile({
                       url:'./server.php?tx=2',
                       fileName:'fileFormDinamic',
                       onSuccess:function(files,data,xhr){
                           var datareturn = JSON.parse(data);

                           $('#inp_$norandom').val(datareturn[0]);

                           if(idurlattach !== undefined){
                               $('#' + idurlattach).html('<a href=\"$pathfile'+ JSON.parse(data)[0] +'\">Descarga ' + JSON.parse(data)[0] + '</a>')
                           }

                           if(idimageattach !== undefined){
                               enviar = /.(gif|jpg|png|jpeg)$/i.test(JSON.parse(data)[0]);
                               if(enviar){
                                   $('#' + idimageattach).html('<img src=\"$pathfile'+ JSON.parse(data)[0] +'\" width=\"100%\">');
                               }
                           }

                       }
                   });
                  ";
}

/************************************************************
 ************************************************************
 ***************************  TIPO 11 ***********************
 ************************************************************
 ***********************************************************/
if ($fieldTypeCode == 11) {
    $norandom = fileuploader . rand();
    echo("<div $addAttr id='$norandom'>Subir archivo</div>
          <input  type='hidden' value='' id='inp_$norandom' $addAttr />");

    $scriptJS .= "  $js_var
                    var uploaderId = '$norandom';
                    $('#$norandom').uploadFile({
                        url:'./server.php?tx=2',
                        fileName:'fileFormDinamic',
                        multiple:true,
                        onSuccess:function(files,data,xhr){
                           var datareturn = JSON.parse(data);

                           //Acciones de precarga de datos con archivos csv en el formulario
                           //El servidor retorna arreglo con los datos de los campos a llenar
                           //con la llave correspondiente al nonmbre del campo en el formulario

                            if (typeof datareturn['loadcsv'] != undefined) {
                              var v = datareturn['loadcsv'];
                              var arraykeys = Object.keys(v);
                              for(p in arraykeys){
                                if (typeof js_var[arraykeys[p]] != \"undefined\"){
                                  $(\"input[name=\" + js_var[arraykeys[p]]+\"]\")
                                    .val(v[arraykeys[p]])
                                }
                              }
                            }else{
                              $('#inp_$norandom').val(datareturn);
                            }
                        }
                    });
                  ";
}

/************************************************************
 ************************************************************
 ***************************  TIPO 12  **********************
 ************************************************************
 ***********************************************************/
/*
 * Generacion de tabla.
 * Esta tabla se genera desde php y se le da el formato con javascript el cual
 * genera los eventos de ordenamiento y filtro.
 * La tabla se genera mediante los campos tablapksearch, muestra los campos numerados
 * en params y se permite hacer el filtro por datos enviados desde get post o sesion.
 * */
if ($fieldTypeCode == 12) {
    define('ADODB_ASSOC_CASE', 1);
    $db->conn->SetFetchMode(ADODB_FETCH_ASOC);
    $datosSelect = "";
    if ($fieldParams) {
        $datosSelect = explode('||', $fieldParams);
    }
    $i = 1;
    $fieldsView = "";
    $fieldsViewObject = "";
    $fieldsInsertValueId = "";
    if ($datosSelect) {
        foreach ($datosSelect as $key => $value) {
            if ($i >= 2) {
                $fieldsViewObject .= ",";
                $fieldsView .= ",";
                $fieldsInsertValueId .= "";
            }
            list($field, $fieldId, $sel) = preg_split("/[\s->]+/", $value);
            $fieldsView .= "$field";
            $fieldsViewObject .= '{"columnName":"' . $field . '","width":"30","label":"' . $field . '"}';
            $fieldsInsertValueId .= '$( "#' . $fieldId . '" ).val( ui.item.' . $field . ' );';
            $i++;
        }
    }

    if (trim($tablePkSearch)){
        include "$ruta_raiz/gforms/grid.php";
    } else {
        echo "No hay tabla para realizar busqueda";
    }
}

/************************************************************
 ************************************************************
 ***************************  TIPO 15  **********************
 ************************************************************
 ***********************************************************/
if ($fieldTypeCode == 15) {
    define('ADODB_ASSOC_CASE', 1);
    $db->conn->SetFetchMode(ADODB_FETCH_ASOC);
    ?>
    <?php
    $scriptJS .= " function cargarLink$fieldName (pagina,target,vars){";
    $datosSelect = "";
    if ($fieldParams) {
        $datosSelect = explode('||', $fieldParams);
    }
    $i = 1;
    $fieldsView = "";
    $fieldsViewObject = "";
    $fieldsInsertValueId = "";
    if ($datosSelect) {
        foreach ($datosSelect as $key => $value) {
            if ($i >= 3) {
                $fieldsViewObject .= ",";
                $fieldsView .= ",";
                $fieldsInsertValueId .= "";
            } elseif ($i == 1) {
                $fieldLink = $value;
            }
            if ($i >= 2) {
                list($field, $fieldId, $sel) = preg_split("/[\s->]+/", $value);
                if (!$cod and trim($cod) == "")
                    $cod = $val;
                $fieldsView .= "$field";
                $variables = "";
                if ($i == 1)
                    $fieldsInsertValueId .= "'";
                $fieldsInsertValueId .= "'$field='+$('#$fieldId').val()+'&'+";
            }

            $i++;
        }
        $fieldsInsertValueId = "vars=$fieldsInsertValueId'';";
    }
    $scriptJS .= "$fieldsInsertValueId";
    ?>
    <div><a heref='#' onClick="cargarLink<?= $fieldName ?>('<?= $fieldLink ?>','');"> <?= $fieldDesc ?></a></div>
    <?
    $scriptJS .= "
          window.open(pagina+vars,target,vars);  }";
}

?>
<? $fieldTypeCode != 12 ?>    </div> <? } ?>
<?php if ($fieldNull == 1) { ?>
    <div class="note note-success">Este campo es Requerido.</div> <?php } ?>
</section>
</td>
</table>
</fieldset>

<!--Mostramos los botones -->
<?=$accionbutton ?>

</form>
</div>
</div>
</article>

</BODY>
<script type="text/javascript">

 function saveForm(){
  var arrF = new Array();
  var arrJ = new Array();
  var arrJson = "";

  $($('[tablesave]')).each(function( index ) {
    fieldId = $($('[tablesave]')[index]).attr('id');
    arrF[index] = new Array(5);
    arrF[index]['tableSave']  =  $($('[tablesave]')[index]).attr('tablesave');
    arrF[index]['fieldSave']  =  $($('[fieldsave]')[index]).attr('fieldsave');
    arrF[index]['fieldPk']    =  $($('[fieldpk]')[index]).attr('fieldpk');
    arrF[index]['fieldValue'] =  $($('[tablesave]')[index]).val();

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
            if($('#resultadoFrm').hasClass('alert-success')){
              setInterval(function (){
                  window.location = location.href;
              },5000);
            }
        });
		// alert(JSON.stringify(arrJ));
 }

 function deleteForm(){
  var arrF = new Array();
  var arrJ = new Array();
  var arrJson = "";

  $($('[tablesave]')).each(function( index ) {
    fieldId = $($('[tablesave]')[index]).attr('id');
    arrF[index] = new Array(5);
    arrF[index]['tableSave']  =  $($('[tablesave]')[index]).attr('tablesave');
    arrF[index]['fieldSave']  =  $($('[fieldsave]')[index]).attr('fieldsave');
    arrF[index]['fieldPk']    =  $($('[fieldpk]')[index]).attr('fieldpk');
    arrF[index]['fieldValue'] =  $($('[tablesave]')[index]).val();

    var item = {
        "tableSave":arrF[index]['tableSave'],
        "fieldSave":arrF[index]['fieldSave'],
        "fieldValue":arrF[index]['fieldValue'],
        "fieldPk":arrF[index]['fieldPk'],
    };
      arrJ.push(item);
		});
		pagina = "formDelete.php";
    $.post( pagina,{data:arrJ, codeForm:<?=$codeForm?>}, function( data ) {
            $('#resultadoFrm').html(data);
            if($('#resultadoFrm').hasClass('alert-success')){
              setInterval(function (){
                  window.location = location.href;
              },5000);
            }
        });
 }

function cleanForm(){
    $( '#paramAjax' ).removeAttr('value');
    $( '#paramAjax' ).removeAttr('tablesave');
    $( '#paramAjax' ).removeAttr('fieldpk'  );
    $( '#paramAjax' ).removeAttr('fieldsave');

  $($('[tablesave]')).each(function( index ) {
    var elemtovali = $($('[tablesave]')[index]);
    var attr = elemtovali.attr('readonly');

    // For some browsers, `attr` is undefined; for others,
    // attr is false Check for both.
    if (typeof attr === typeof undefined || attr === false) {
        $($('[tablesave]')[index]).val('');
    }
  });
}


function cargarPagina(pagina,nombreDiv){
  $.post( pagina,{verradicado:"<?= $verradicado ?>",verradPermisos:"<?= $verradPermisos ?>
    ",permRespuesta:"<?= $permRespuesta ?>"}, function( data ) {
  $('#'+ nombreDiv).html(data);
  });
}

function cargarLink(pagina,target,vars){
    window.open(pagina,target,vars);
}

<?= $scriptJS ?>

</script>
</HTML>
