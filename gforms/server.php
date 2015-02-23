<?php
session_start();

if (!$ruta_raiz){
    $ruta_raiz = "..";
}

include "$ruta_raiz/conn.php";

$page = $_GET['page']; // get the requested page
$limit = $_GET['rows']; // get how many rows we want to have into the grid
$sidx = $_GET['sidx']; // get index row - i.e. user click to sort
$sord = $_GET['sord']; // get the direction
$dat = $_GET['dat']; // get the direction
$tx = $_GET['tx'];
$tableSearch = $_GET['tableSearch'];
$fieldSearch = $_GET['fieldSearch'];
$fieldsView = $_GET['fieldsView'];
$searchTerm = $_GET['searchTerm'];

switch ($tx) {

    case 1:

        if (!$sidx) {
            $sidx = 1;
        }

        if ($searchTerm == "") {
            $searchTerm = "%";
        } else {
            $searchTerm = "%" . $searchTerm . "%";
        }

        if (!trim($fieldsView))
            $fieldView = " * ";

        // connect to the database
        $db->conn->debug = false;

        $result = $db->conn->query("SELECT COUNT(1) count
                                    FROM $tableSearch
                                    WHERE $fieldSearch like '$searchTerm' $paramSearch");

        $count = $resutl->fields['COUNT'];

        if ($count > 0) {
            $total_pages = ceil($count / $limit);
        } else {
            $total_pages = 0;
        }

        if ($page > $total_pages) {
            $page = $total_pages;
        }

        $paramSearch = str_replace('undefined', '', $paramSearch);

        // do not put $limit*($page - 1)
        $start = $limit * $page - $limit;

        if (trim($paramSearch) and trim($paramSearch) != "=") {
            $andWhere = "AND  $paramSearch ";
        }

        if ($total_pages != 0) {
            // ORDER BY $sidx $sord LIMIT $start , $limit";
            $SQL = "SELECT $fieldsView FROM  $tableSearch WHERE $fieldSearch like '$searchTerm' $andWhere LIMIT 40 ";
        } else {
            // ORDER BY $sidx $sord";
            $SQL = "SELECT $fieldsView FROM $tableSearch WHERE $fieldSearch like '$searchTerm' $andWhere LIMIT 40";
        }
        $result = $db->conn->query($SQL) or die("Couldn t execute query.");

        $response->page = $page;
        $response->total = $total_pages;
        $response->records = $count;

        $i = 0;

        while (!$result->EOF) {
            $row = $result->FetchRow();
            foreach ($row as $key => $value) {
                $nameField = strToUpper($key);
                $response->rows[$i][$nameField] = $value;
            }
            $i++;
            $result->MoveNext();
        }
        break;

    case 2:

        $year = date("Y");
        $output_dir = "../bodega/$year/formFiles/";

        if (isset($_FILES["fileFormDinamic"])) {
            $ret = array();
            $error = $_FILES["fileFormDinamic"]["error"];
            //You need to handle  both cases
            //If Any browser does not support serializing of multiple files using FormData()
            if (!is_array($_FILES["fileFormDinamic"]["name"])) //single file
            {
                $namefile = rand(9999, 99999);
                $fileName = $namefile . '_' . $_FILES["fileFormDinamic"]["name"];
                move_uploaded_file($_FILES["fileFormDinamic"]["tmp_name"], $output_dir . $fileName);
                $ret[] = $fileName;

            } else //Multiple files, file[]
            {
                $fileCount = count($_FILES["fileFormDinamic"]["name"]);
                for ($i = 0; $i < $fileCount; $i++) {
                    $namefile = rand(9999, 99999);
                    $fileName = $namefile . '_' . $_FILES["fileFormDinamic"]["name"][$i];
                    move_uploaded_file($_FILES["fileFormDinamic"]["tmp_name"][$i], $output_dir . $fileName);
                    $ret[] = $fileName;
                }
            }
            echo json_encode($ret);
            die();
        }

        break;

}

echo json_encode($response);
