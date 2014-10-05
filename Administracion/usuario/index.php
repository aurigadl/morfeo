<?php
session_start();

/*error_reporting(E_ALL);
ini_set("display_errors", 1);*/

$ruta_raiz = "../..";

if (!$_SESSION['dependencia'])
  header ("Location: ".$ruta_raiz."/cerrar_session.php");

$krd          = (isset($_SESSION["krd"]))? $_SESSION["krd"] : '';
$verrad       = '';
$krd          = $_SESSION["krd"];
$dependencia  = $_SESSION["dependencia"];
$usua_doc     = $_SESSION["usua_doc"];
$codusuario   = $_SESSION["codusuario"];

include_once ('./libs/Smarty.class.php');
include_once ($ruta_raiz."/include/db/ConnectionHandler.php");

$smarty = new Smarty;

$smarty->template_dir = './templates';
$smarty->compile_dir  = './templates_c';
$smarty->config_dir   = './configs/';
$smarty->cache_dir    = './cache/';

$smarty->left_delimiter  = '<-{';
$smarty->right_delimiter = '}->';

$db = new ConnectionHandler($ruta_raiz);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
//$db->conn->debug = true;

//Permisos
$sql_perm = "     SELECT
                      id,
                      autg_id,
                      nombre,
                      dependencia,
                      crud,
                      descripcion
                  FROM
                      autp_permisos";

$perm     = $db->conn->query($sql_perm);

while (!$perm->EOF) {
    $permisos[] = $perm->fields;
    $perm->MoveNext();
}


//Grupos
$sql_grup = "     SELECT
                      id,
                      nombre,
                      descripcion
                  FROM
                      autg_grupos";

$grup     = $db->conn->query($sql_grup);

while (!$grup->EOF) {
    $grupos[] = $grup->fields;
    $grup->MoveNext();
}

//Usuarios
$sql_usua = "     SELECT
                      id,
                      primer_nombre,
                      segundo_nombre,
                      user_email,
                      user_password
                  FROM
                      autu_usuarios";

$usua     = $db->conn->query($sql_usua);

while (!$usua->EOF) {
    $usuarios[] = $usua->fields;
    $usua->MoveNext();
}


//Membresias
$sql_memb = "
              SELECT
                am.id,
                ag.nombre,
                au.primer_nombre

              FROM 	autm_membresias am,
                autg_grupos ag,
                autu_usuarios au

              WHERE
                am.autg_id = ag.id and
                am.autu_id = au.id";

$memb     = $db->conn->query($sql_memb);

while (!$memb->EOF) {
    $membresias[] = $memb->fields;
    $memb->MoveNext();
}

$smarty->assign("permisos"   , $permisos);
$smarty->assign("grupos"     , $grupos);
$smarty->assign("membresias" , $membresias);
$smarty->assign("usuarios"   , $usuarios);

$smarty->display('index.tpl');
