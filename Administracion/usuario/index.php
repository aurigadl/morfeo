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

include_once("./libs/Smarty.class.php");
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
include_once("$ruta_raiz/include/tx/roles.php");

$smarty = new Smarty;

$smarty->template_dir = './templates';
$smarty->compile_dir  = './templates_c';
$smarty->config_dir   = './configs/';
$smarty->cache_dir    = './cache/';

$smarty->left_delimiter  = '<-{';
$smarty->right_delimiter = '}->';

$db    = new ConnectionHandler($ruta_raiz);
$roles = new Roles($db);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
//$db->conn->debug = true;


//Traemos los permisos
if($roles->retornarPermisos()){
    $permisos = $roles->permisos;
}

//Traemos las opciones sobre los permisos
$crud = $roles->retornarOpcionesPermisos();

//Traemos los grupos
if($roles->retornarGrupos()){
    $grupos = $roles->grupos;
}

//Traemos los Usuarios
if($roles->retornarUsuarios()){
    $grupos = $roles->usuarios;
}

//Traemos los Dependencias
if($roles->retornarDependencias()){
    $usuarios = $roles->dependencias;
}

$smarty->assign("permisos"     , $permisos);
$smarty->assign("crud"         , $crud);
$smarty->assign("grupos"       , $grupos);
$smarty->assign("dependencias" , $dependencias);
$smarty->assign("membresias"   , $membresias);
$smarty->assign("usuarios"     , $usuarios);

$smarty->display('index.tpl');
