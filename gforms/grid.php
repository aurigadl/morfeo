<?php
//session_start();
//ini_set("display_errors",1);
if (!$ruta_raiz)
    $ruta_raiz = "..";
if (!$db) {
    include_once("$ruta_raiz/conn.php");
}

include_once("$ruta_raiz/js/inc/init.php");

if ($fieldsView) {
    $fieldsView = mb_strtoupper($fieldsView);
}

if (isset($tableSearch)) {

    if (!trim($fieldParams)) {
        $fieldsView = " * ";
    }

    $fieldSql = "SELECT
                    $fieldsView
                 FROM
                    $tableSearch
                 ORDER BY 1";
}

$rs = $db->conn->query($fieldSql);

unset($colsNames_1);
$arraydata = array();
$dataarray = array();

$k = 1;
while (!$rs->EOF) {
    unset($dataFields);
    foreach ($rs->fields as $nameField => $valueField) {
        if ($k == 1) {
            if(!is_numeric($nameField)){
                if (empty($colsNames_1)) {
                    $colsNames_1 = "<th> $nameField </th>";
                } else {
                    $colsNames_1 .= "<th> $nameField </th>";
                }
            }
        }

        if(!is_numeric($nameField)){
            $nameField_l = strtolower($nameField);
            if (empty($dataFields)) {
                $dataFields    = "<td><a data-idvalue='$valueField' class='buttonid'>$valueField</a></td>";
                $idRegistro    = $valueField;
            } else {
                $dataFields .= "<td>$valueField</td>";
            }
            $arraydata[$nameField_l] = $valueField;
            $arraykeys[]           = $nameField_l;
        }
    }

    $dataarray[$idRegistro] = $arraydata;
    $totaldata .= "<tr>$dataFields</tr>";

    $k++;
    $rs->MoveNext();
}

$dataarray = empty($dataarray)? '{}' : json_encode($dataarray);
$arraykeys = empty($arraykeys)? '[]' : json_encode(array_unique($arraykeys));
?>

    <table id="idtableformview" class="table table-striped table-bordered table-hover dataTable no-footer smart-form">
        <thead>
            <tr>
                <?= $colsNames_1 ?>
            </tr>
        </thead>
        <tbody>
            <?= $totaldata ?>
        </tbody>
    </table>

<?php


//Script que permite formatear la tabla construida desde php
$scriptJS .= " $('#idtableformview').dataTable({
    'language': {
        'lengthMenu'   :'_MENU_',
        'zeroRecords'  :'No existe registro',
        'info'         :'Mostrando pagina _PAGE_ de _PAGES_',
        'infoEmpty'    :'Numero de registros permitidos',
        'search'       :'',
        'infoFiltered' :'(filtrado para _MAX_ total de registros)',
        'paginate'     :{
                            'next': 'Siguiente',
                            'previous': 'Anterior'
                        }
    }
});";

$scriptJS .= "
    //objeto para transferir datos al evento del click
    var objtrans = {};

    //Todos los datos de la tabla
    objtrans.tabdata = $dataarray

    //Las llaves del arreglo que representan cada uno de los campos
    objtrans.keydata = $arraykeys;

    //La tabla tiene un enalace en el id que hace activar el
    //siguiente evento
    $('.buttonid').on('click', objtrans,function(){
        var tabdata  = objtrans.tabdata;
        var keydata  = objtrans.keydata;
        var idsearch = $(this).data('idvalue');
        var objShow  = tabdata[idsearch];

        for (index = 0; index < keydata.length; ++index) {

            //Nombre de la columna de la tabla que es a su vez un campo
            //del formulario
            var localkey = keydata[index];

            //Si el campo es el id remplazamos el identificador en un campo hidden
            //para poder actulizar el registro una vez se envien los datos
            if(localkey == 'id'){
                $('#paramAjax' ).val(objShow[localkey]);
            }

            //Validamos si existe el elemento por medio de su id
            //con esta información se busca el elemento y se modifica
            //su valor en los elementos existentes del formulario
            if( $('#'+localkey).length !== 0){
                //Si el campo es un Input
                if($('#'+ localkey).is('input')){
                    $('#'+ localkey).val(objShow[localkey]);
                }
            }
        }
    });
";

//echo "<script>".$scriptJS."</script>";
