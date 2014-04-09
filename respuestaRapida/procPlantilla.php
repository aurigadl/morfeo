<?php
session_start();
//error_reporting(E_ALL);
//ini_set('display_errors', '1');

$ruta_raiz = "../";
if (!$_SESSION['dependencia'])
  header ("Location: ".$ruta_raiz."cerrar_session.php");

include_once ($ruta_raiz."include/db/ConnectionHandler.php");

$db = new ConnectionHandler("$ruta_raiz");
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
//$db->conn->debug = true;

$usuario     = $_SESSION["usua_nomb"];
$dependencia = $_SESSION["depe_nomb"];
$dep_code    = $_SESSION["dependencia"];
$usu_code    = $_SESSION["codusuario"];

//Borramos la planilla
if(!empty($_POST['delPlant'])){
  $idPlanila = $_POST["planaborrar"];

  foreach ($idPlanila as $valor){
    $sql21 ="DELETE FROM
              SGD_PLAN_PLANTILLAS
            WHERE
            ID        = $valor AND
            DEPE_CODI = $dep_code AND
            USUA_CODI = $usu_code" ;

    $rsg   = $db->conn->Execute($sql21);
  }
}

//Creamos la planilla
if ($_POST['plantillas']) {

  $nombre    = $_POST["nombre"];
  $nivel     = $_POST["nivel"];
  $contenido = $_POST["contplant"];
  $fecha     = $db->conn->OffsetDate(0,$db->conn->sysTimeStamp);

  $sql21 = "
    INSERT INTO
    SGD_PLAN_PLANTILLAS(
      plan_plantilla,
      plan_nombre,
      plan_fecha,
      depe_codi,
      usua_codi,
      plan_tipo)
    VALUES (
      '$contenido',
      '$nombre',
       $fecha,
      '$dep_code',
      '$usu_code',
      '$nivel')";
  $rsg   = $db->conn->Execute($sql21);
}

header('Location: index.php');
?>
