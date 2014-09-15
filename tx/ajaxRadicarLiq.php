<?php
session_start();
 $_SESSION["dependencia"]=900;
 $_SESSION["codusuario"]=1;
  include '../config.php';
  include '../include/db/ConnectionHandler.php';
  
  session_start();
  
  $ruta_raiz  = '..';
  include '../include/tx/Radicacion.php';
  
  $codCarpeta = $_POST["codCarpeta"];
  $dato       = substr($codCarpeta,0,2);
  $rads       = $_POST["rads"];
  
  $db = new ConnectionHandler($ruta_raiz);
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

  $carpetaPersonal = ($dato == 11)? 1 : 0;
  
  $carpetaDestino = substr($codCarpeta,2,5);
  
  //  changeFolder( $radicados, $usuaLogin,$carpetaDestino,$carpetaTipo,$tomarNivel,$observa)
  $dependencia =900;
  $codusuario =1;
  $rad = new Radicacion($db);
      $rad->radiTipoDeri = 0;
    $rad->radiCuentai  = "''";
    $rad->eespCodi     = 0;
    $rad->mrecCodi     = 1; // "dd/mm/aaaa"
    if(!$radicadopadre)  $radicadopadre = null;

    $rad->radiNumeDeri = trim($radicadopadre);
    $rad->radiPais     = 179;
    $rad->descAnex     = "Prueba web";
    $rad->radiDepeActu = "'900'";
    $rad->radiDepeRadi = "'900'";
    $rad->usuaCodi     = 1;
    $rad->radiUsuaActu = 1;
    $rad->radiUsuaRadi = 1;
    $rad->trteCodi     = 0;
    $rad->tdocCodi     = 0;
    $rad->nofolios     = 1;
    $rad->noanexos     = 5;
    $rad->guia         = "22";
    $rad->tdidCodi     = 0;
    $rad->carpCodi     = 9;
    $rad->carPer       = 0;
    $rad->trteCodi     = 0;
    $rad->raAsun       = "Liquidacion VIP/VIS";
  $numeroRadicado =  $rad->newRadicado("9","900");
  $msg = '';
  
  $codBarras = "<table align=right><tr><td></td><td><img src=codBarras.png width=300><br> Radicado $numeroRadicado<br>Fecha ".date("Y/m/d H:i:s")."<br></td></tr></table>";
  
  if ($numeroRadicado) {
    $fechaHoy = date("ymdhmsi");
    echo "<script>
      $('#resultadoRad').html('$codBarras'); 
    </script>";  
    echo "<br><br><div class='alert alert-success fade in'>
            <button class='close' data-dismiss='alert'> × </button>
            <i class='fa-fw fa fa-check'></i>
            <strong>Solicitud Genrada con Numero de Radicado No. $numeroRadicado </strong>
            <a href='#' onClick='window.open(\"radPrint.php?radNumero=$numeroRadicado&\",\"mtvImprimir$fechaHoy\");'> - Imprimir Solicitud -</a>
            <span id=refresh class='btn btn-ribbon' data-reset-msg='Recargar Pagina' data-html='true' rel='tooltip' data-title='refresh' data-action='resetWidgets'></div>";
  } else {
    echo "<div class='alert alert-danger fade in'>
              <button class='close' data-dismiss='alert'> × </button>
              <i class='fa-fw fa fa-times'></i>
              <strong>Error la Generacion de la solicitud.</strong>
              Intente mas tarde</div>";
  }
?>
