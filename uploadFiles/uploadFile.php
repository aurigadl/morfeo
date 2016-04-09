<?
$krdOld = $krd;
session_start();
if(!$krd) $krd=$krdOsld;
$ruta_raiz = "..";
if(!$dependencia) include "$ruta_raiz/rec_session.php";
error_reporting(7);
$verrad = "";
//PROGRAMA DE CARGA DE IMAGENES DE RADICADOS
?>
<HTML>
<head>
<link rel="stylesheet" href="<?=$ruta_raiz?>/estilos/orfeo.css">
</head>
<BODY>
</BODY>
