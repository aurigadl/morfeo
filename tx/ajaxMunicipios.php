<?php
/**
  * Pagina que devuelve a un select especifico los municipios seleccionados previamente.
  * @autor Jairo Losada - Correlibre 2014
  */
  include '../config.php';
  include '../include/db/ConnectionHandler.php';
  
  session_start();
  foreach ($_GET as $key => $valor)   ${$key} = $valor;
  foreach ($_POST as $key => $valor)   ${$key} = $valor;
  $ruta_raiz  = '..';
  
  $codCarpeta = $_POST["codCarpeta"];
  $dato       = substr($codCarpeta,0,2);
  $rads       = $_POST["rads"];
  
  $db = new ConnectionHandler($ruta_raiz);
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
  if($dptoCodi && $idPais && $idCont){
    $iSql = "select * from MUNICIPIO WHERE dpto_codi=$dptoCodi and id_pais=$idPais and id_cont=$idCont order by muni_nomb";
    //$db->conn->debug = true;
    $rs = $db->conn->query($iSql);
    
    $script = "<script>  $('#$selectIdMuni').empty();";
    
    while(!$rs->EOF){
     $muniNomb = $rs->fields["MUNI_NOMB"];
     $muniCodi = $rs->fields["MUNI_CODI"];
     $script .= " $('#$selectIdMuni').append('<option value=$muniCodi>$muniNomb</option>');";
     //echo "$muniNomb - $muniCodi <br>";
     $rs->MoveNext();
    }
    $script .= "</script>";
    if ($rs) {
      echo "$script";
    } else {
      echo "<div class='alert alert-danger fade in'>
                <button class='close' data-dismiss='alert'> × </button>
                <i class='fa-fw fa fa-times'></i>
                <strong>Error en el Movimiento Entre Carpetas.</strong>
                Radicados $rads $msg de carpeta ($carpetaDestino, $carpetaPersonal)</div>";
    }
    }else{
      echo "<div class='alert alert-danger fade in'>
                <button class='close' data-dismiss='alert'> × </button>
                <i class='fa-fw fa fa-times'></i>
                <strong>No se puede seleccionar Municipios</strong>
                </div>";
  }
?>
