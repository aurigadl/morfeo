<?php
session_start();
$ruta_raiz = "..";
if(!$db) include "$ruta_raiz/conn.php";
include "$ruta_raiz/include/tx/Tx.php";
$codCarpeta = $_POST["codCarpeta"];
$rads = $_POST["rads"];
$dato = substr($codCarpeta,0,2);
if($dato=="11") $carpetaPersonal = "1"; else $carpetaPersonal = "0";
$carpetaDestino = substr($codCarpeta,2,4);
//  changeFolder( $radicados, $usuaLogin,$carpetaDestino,$carpetaTipo,$tomarNivel,$observa)
if(trim($rads)){
 $tx = new Tx($db);
 $rtaMove =  $tx->changeFolder($rads.'0', $krd, $carpetaDestino, $carpetaPersonal,0,''  );
 $msg = "";
 }else{
 $msg = "No vienen Radicados";
}
 if($rtaMove==1){
  echo "<div class='alert alert-success fade in'>
<button class='close' data-dismiss='alert'> × </button>
<i class='fa-fw fa fa-check'></i>
<strong>Movimiento Entre Carpetas Ok</strong>
Se movieron los radicados $rads de carpeta ($carpetaDestino, $carpetaPersonal)
<span id=refresh class='btn btn-ribbon' data-reset-msg='Recargar Pagina' data-html='true' rel='tooltip' data-title='refresh' data-action='resetWidgets'>
</div>";
}else{
  echo "<div class='alert alert-danger fade in'>
<button class='close' data-dismiss='alert'> × </button>
<i class='fa-fw fa fa-times'></i>
<strong>Error en el Movimiento Entre Carpetas.</strong>
Radicados $rads $msg de carpeta ($carpetaDestino, $carpetaPersonal)</div>";

}


?>