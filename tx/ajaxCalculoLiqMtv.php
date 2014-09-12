<?php
  include '../config.php';
  include '../include/db/ConnectionHandler.php';
  
  session_start();
  
  $ruta_raiz  = '..';
  include '../include/tx/Tx.php';
  
  $codCarpeta = $_POST["codCarpeta"];
  $dato       = substr($codCarpeta,0,2);
  $chip       = strtoupper($_POST["chip"]);
  $valA1       = $_POST["valA1"];
  $db = new ConnectionHandler($ruta_raiz);
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

  $carpetaPersonal = ($dato == 11)? 1 : 0;
  
  $carpetaDestino = substr($codCarpeta,2,5);
  
  //  changeFolder( $radicados, $usuaLogin,$carpetaDestino,$carpetaTipo,$tomarNivel,$observa)

  if(trim($chip)) {
    $isql = "SELECT * FROM predial2014_20140819 WHERE CHIP = '". trim(strtoupper($chip))."'";
    $rs = $db->conn->query($isql);
    if($rs->fields["CHIP"]){
      $chipB = $rs->fields["CHIP"];
      $valM2T = $rs->fields["VAL_M2_T"];
      $areaTerreno = $rs->fields["A_TER_CAT"];
      $nombrePropietario = $rs->fields["NOM_PRO"];
      $direccionPredio = $rs->fields["DIR_REAL"];
      $direccionCorr = $rs->fields["DIR_CORR"];
      $pFMI = $rs->fields["FMI"];
      $valorReferencia = 1394292.03;
      $valorCatastralPromedio = 1088049.31;
      $valorA2 =  ($valM2T / $valorCatastralPromedio) * $valA1;
      $valorObligacion = $valorA2 * $valorReferencia;
      //echo "--> ($valM2T / $valorReferencia) * $valA1; ";  
      
      $rtaMove = 1;
    }else{
       $rtaMove = 0;
    } 
  }else{
    $msg = "No vienen Radicados";
  }
  
  if ($rtaMove == 1) {
    $valorObligacionF = "$ " . number_format($valorObligacion,2,",",".");
    $valM2TF = number_format($valM2T,2,",",".");
    $valorReferenciaF = number_format($valorReferencia,2,",",".");
    $valorCatastralPromedioF = number_format($valorCatastralPromedio,2,",",".");
    $valorA2F = number_format($valorA2,4,",",".");
    $textoFinal = "$codBarras Nombre Propietario: $nombrePropietario <br> Direccion : $direccionPredio <BR>CHIP : $chip <BR>Valor M<sup>2</sup> :$ $valM2TF<br>Area : $areaTerreno<br>Valor de Referencia : $ $valorReferenciaF <br>Valor Estimado de la Obligación : $ $valorObligacionF <br> <br>Si esta seguro de los datos Presione Generar la Solicitud.";
    echo "
    <script>
      $('#valorO').val('$valorObligacionF');  
      $('#valM2T').val('$valM2TF');
      $('#valRef').val('$valorReferenciaF');
      $('#valorA2').val('$valorA2F');
      $('#pDir').val('$direccionPredio');
      $('#address').val('$direccionCorr');
      $('#pRep').val('$nombrePropietario');
      $('#pAreaB').val('$areaTerreno');
      $('#pFMI').val('$pFMI');
      $('#valorCatastralPromedio').val('$valorCatastralPromedioF');
      $('#chip').val('$chip');
      $('#pChip').val('$chip');
      $('#resultado').html('$textoFinal');
      $('#areaTerreno').html('(Area del terreno  $areaTerreno m<sup>2</sup>)')
    </script>
    ";
  } else {
    echo "<div class='alert alert-danger fade in'>
              <button class='close' data-dismiss='alert'> × </button>
              <i class='fa-fw fa fa-times'></i>
              <strong>CHIP $chip</strong>
               No se ha encontrado en la Base de datos.  Porfavor verifiquelo.
              </div>
              
              ";
  }
?>
