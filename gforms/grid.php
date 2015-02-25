<?php
//session_start();
//ini_set("display_errors",1);

    $ruta_raiz = "..";
if (!$db) {
    include_once("$ruta_raiz/conn.php");
}

include_once("$ruta_raiz/js/inc/init.php");

if ($fieldsView) {
    $fieldsView = mb_strtoupper($fieldsView);
}



if (isset($tablePkSearch)) {

    if (!trim($fieldParams)) {
        $fieldsView = " * ";
    }

    //Filtro generado si existe de variables get post session
    if(!empty($fieldPkSearch) && !empty($valueVar)){
        $filtertable = " where $fieldPkSearch = '$valueVar' ";
    }

    $fieldSql = "SELECT
                    $fieldsView
                 FROM
                    $tablePkSearch
                    $filtertable
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
$scriptJS .= "
//vefificamos si el objeto de la tabla creada desde php tiene elementos
//de lo contrario debemos inactivar el javascript de manejo de tablas

if( $('#idtableformview').find('td,th').length > 0){
     $('#idtableformview').dataTable({
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
     });

     $('#idtableformview_filter')
     .prepend('<a  id=\"csvdown\" class=\"btn btn-default btn-xs\"><i class=\"fa fa-download\"></i> csv </a>')

     // This must be a hyperlink
     $('body').on('click','#csvdown', function (event) {
        var tableCon   = $('#idtableformview');
        var rowCons    = tableCon.find('tr');
        var d          = new Date(); // for now

        // Temporary delimiter characters unlikely to be typed by keyboard
        // This is to avoid accidentally splitting the actual contents
        var tmpColDelim = String.fromCharCode(11); // vertical tab character
        var tmpRowDelim = String.fromCharCode(0); // null character

        // actual delimiter characters for CSV format
        var colDelim = ',';
        var rowDelim = '\\n';


        // Grab text from table into CSV formatted string
        csv = rowCons.map(function (i, row) {
              var rowCon = $(row),
              colsCon = rowCon.find('td,th');
              return colsCon.map(function (j, col) {
                      var colCon = $(col),
                      text = colCon.text();
                      return text.replace('\"', '\"\"'); // escape double quotes
                      }).get().join(tmpColDelim);
              }).get().join(tmpRowDelim)
              .split(tmpRowDelim).join(rowDelim)
              .split(tmpColDelim).join(colDelim),
             // Data URI

            csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

        datetext = d.toTimeString().split(' ')[0].replace(/:/g, '');

        $(this).attr({
          'download': datetext + 'tempFile.csv',
              'href': csvData,
            'target': '_blank'
        });
     });
}

 ";

$scriptJS .= "

    if( $('#idtableformview').find('td,th').length > 0){
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
            var valida   = false;

            if(idsearch !== undefined){
                for (index = 0; index < keydata.length; ++index) {

                    //Nombre de la columna de la tabla que es a su vez un campo
                    //del formulario
                    var localkey = keydata[index];

                    //Si el campo es el id remplazamos el identificador en un campo hidden
                    //para poder actulizar el registro una vez se envien los datos
                    if(localkey == 'id'){
                        $('#paramAjax' ).val(objShow[localkey]);
                        $('#paramAjax' ).attr({'tablesave':'$tablePkSearch',
                                               'fieldpk'  : 1,
                                               'fieldsave': 'id'});
                        valida = true;
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
            }

        });
    }
";
