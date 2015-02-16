<?php
//session_start();
//ini_set("display_errors",1);
if (!$ruta_raiz)
    $ruta_raiz = "..";
if (!$db) {
    include_once $ruta_raiz . "/conn.php";
}
include_once $ruta_raiz . "/js/inc/init.php";
if ($fieldsView) {
    $fieldsView = mb_strtoupper($fieldsView);
}
if ($tableSearch) {

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
            if (empty($dataFields)) {
                $dataFields = "<td>$valueField</td>";
            } else {
                $dataFields .= "<td> $valueField </td>";
            }
        }
    }
    $totaldata .= "<tr>$dataFields<tr>";
    $k++;
    $rs->MoveNext();
}
?>

    <table id="example" class="table table-striped table-bordered table-hover dataTable no-footer smart-form">
        <thead>
        <tr>
            <?= $colsNames_1 ?>
        </tr>
        </thead>
        <tbody>
            <?= $totaldata ?>
    </table>

<?php

$scriptJS .= " $('#example').dataTable({
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
                        },
    }
});";


//echo "<script>".$scriptJS."</script>";
