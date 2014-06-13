<?php
session_start();
ini_set("display_errors",0);
error_reporting(0);
if(!$ruta_raiz) $ruta_raiz = "..";
include "$ruta_raiz/conn.php";
$page = $_GET['page']; // get the requested page
$limit = $_GET['rows']; // get how many rows we want to have into the grid
$sidx = $_GET['sidx']; // get index row - i.e. user click to sort
$sord = $_GET['sord']; // get the direction
$dat = $_GET['dat']; // get the direction
$tableSearch = $_GET['tableSearch'];
$fieldSearch = $_GET['fieldSearch'];
$fieldsView = $_GET['fieldsView'];
$searchTerm = $_GET['searchTerm'];
//echo "<hr>". $_GET['jh'];
if(!$sidx) $sidx =1;
if ($searchTerm=="") {
	$searchTerm="%";
} else {
	$searchTerm = "%" . $searchTerm . "%";
}
if(!trim($fieldsView)) $fieldView = " * ";
// connect to the database
$result = $db->conn->query("SELECT COUNT(*) count FROM $table WHERE $fieldSearch like '$searchTerm' $paramSearch");
$count = $resutl->fields['COUNT'];

if( $count >0 ) {
	$total_pages = ceil($count/$limit);
} else {
	$total_pages = 0;
}
if ($page > $total_pages) $page=$total_pages;
$paramSearch = str_replace('undefined','',$paramSearch);
$start = $limit*$page - $limit; // do not put $limit*($page - 1)
if(trim($paramSearch) and trim($paramSearch)!="="  ) $andWhere = "AND  $paramSearch ";
if($total_pages!=0) $SQL = "SELECT $fieldsView FROM  $tableSearch WHERE $fieldSearch like '$searchTerm' $andWhere LIMIT 40 "; // ORDER BY $sidx $sord LIMIT $start , $limit";
else $SQL = "SELECT $fieldsView FROM $tableSearch WHERE $fieldSearch like '$searchTerm' $andWhere LIMIT 40"; //  ORDER BY $sidx $sord";
//$db->conn->debug = true;
$result = $db->conn->query( $SQL ) or die("Couldn t execute query.");

$response->page = $page;
$response->total = $total_pages;
$response->records = $count;
$i=0;
while(!$result->EOF) {
 $row = $result->FetchRow();
  foreach($row as $key => $value) {
    $nameField = strToUpper($key);
    $response->rows[$i][$nameField]=$value;
  }
    $i++;
    $result->MoveNext();
}        
echo json_encode($response);

?>
