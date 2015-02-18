<?php
  session_start();
  include '../config.php';
  include '../include/db/ConnectionHandler.php';
  
  
  
  $ruta_raiz  = '..';
  include '../include/tx/Tx.php';
  
  $codCarpeta = $_POST["codCarpeta"];
  $dato       = substr($codCarpeta,0,2);
  $chip       = strtoupper($_POST["chip"]);
  $valA1       = $_POST["valA1"];
  $nombreProyecto =$_POST["nombreProyecto"];
  $urbanizadorP = $_POST["urbanizadorP"];
  $pRep=$_POST["pRep"];
  $repLegal=$_POST["repLegal"];

  $db = new ConnectionHandler($ruta_raiz);
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
  if(trim($chip)) $_SESSION["chips"] .= "'". trim($chip). "'," ;
  $carpetaPersonal = ($dato == 11)? 1 : 0;
  
  $carpetaDestino = substr($codCarpeta,1,5);
  
  //  changeFolder( $radicados, $usuaLogin,$carpetaDestino,$carpetaTipo,$tomarNivel,$observa)

  if(trim( $_SESSION["chips"])) {
	//  $db->conn->debug = true;
    //$isql = "SELECT * FROM predial2014_20140819 WHERE CHIP in (". $_SESSION["chips"]."'0') order by CAST(VAL_M2_T AS NUMERIC) DESC";
    $isql = "SELECT * FROM (SELECT DISTINCT CHIP, VAL_M2_T, A_TER_CAT, DIR_REAL, DIR_CORR, FMI FROM habitat_predios WHERE CHIP in (". $_SESSION["chips"]."'0')) a order by CAST(VAL_M2_T AS NUMERIC) DESC";
    $rs = $db->conn->query($isql);
    if($rs->fields["CHIP"]){
      $chipB = $rs->fields["CHIP"];
      $chipMax = $chipB;
      $valM2T = $rs->fields["VAL_M2_T"];
      $valM2TMax = number_format($valM2T,2,",",".");
      $areaTerreno = $rs->fields["A_TER_CAT"];
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
  $chipss=explode(',',$_SESSION['chips']);
  $ultimoChip=$chipss[count($chipss)-2];
  $isql="select * From habitat_predios WHERE CHIP=$ultimoChip";
  $lala=$db->conn->query($isql);
  if ($rtaMove == 1 && $lala->fields["CHIP"]) {
    $_SESSION['chipsListado'].=$lala->fields["CHIP"].',';
    $chipsListado=explode(',',$_SESSION['chipsListado']);
    $chipsListado=array_unique($chipsListado);
    $chipsListado=implode('<hr style="border-top:1px solid black">',$chipsListado);
    $chipsListado=substr($chipsListado,0,-39);
    $valorObligacionF = "$ " . number_format($valorObligacion,2,",",".");
    $valM2TF = number_format($valM2T,2,",",".");
    $valorReferenciaF = number_format($valorReferencia,2,",",".");
    $valorCatastralPromedioF = number_format($valorCatastralPromedio,2,",",".");
    $valorA2F = number_format($valorA2,2,",",".");
    $textoFinal = " <table width=\"70%\" border=1><tr id=nombreProyecto><td>Nombre del proyecto</td><td> $nombreProyecto </td></tr>";
    $textoFinal .= " <tr><td>Direci&oacute;n</td><td>$direccionPredio  </td></tr>";
    $textoFinal .= " <tr><td>CHIP</td><td>$chipsListado  </td></tr>";
    $textoFinal .= " <tr id=urbanizadorP><td>Urbanizador / Constructor / Patrimonio Aut&oacute;nomo</td><td>$urbanizadorP  </td></tr>";
    $textoFinal .= "<tr id=repLegalP><td>Representante Legal</td><td> $repLegal</td></tr>";
    $textoFinal .= "<tr><td>Area obligaci&oacute;n VIP (A1) </td><td> $valA1 m<sup>2</sup> </Td></tr>";
    $textoFinal .= "<tr><td>Area a trasladar</td><td>$valorA2F m<sup>2</sup></Td></tr>";
    $textoFinal .= "<tr><td>Valor estimado de la Obligaci&oacute;n por traslado VIP/VIS </td><td>$valorObligacionF </Td></tr>";
    $textoFinal .= "<tr><td></td></tr></table>";
    
    $tablaChips = "<TABLE class=\"table table-bordered\">";
    //$tablaChips .= "<TR><Th>Chip</Th><Th>Direcci&oacute;n</Th><Th>Area Bruta</Th><Th>Representante Legal</Th><Th>Valor Catastral M<sup>2</sup></Th><Th></Th></TR>";
    $tablaChips .= "<TR><Th>Chip</Th><Th>Direcci&oacute;n</Th><Th>Area Bruta</Th></TR>";
    while(!$rs->EOF){
      $chipB = $rs->fields["CHIP"];
      $valM2T = $rs->fields["VAL_M2_T"];
      $valM2TF = number_format($valM2T,2,",",".");
      $pAreaB+=$areaTerreno = $rs->fields["A_TER_CAT"];
      $direccionPredio = $rs->fields["DIR_REAL"];
      $direccionCorr = $rs->fields["DIR_CORR"];
      $pFMI = $rs->fields["FMI"];
      //$tablaChips .= "<TR><TD>$chipB</TD><TD>$direccionPredio</TD><TD>$areaTerreno</TD><TD>$nombrePropietario</TD><TD align=right>$valM2TF</TD><TD></TD>";
      $tablaChips .= "<TR><TD>$chipB</TD><TD>$direccionPredio</TD><TD>$areaTerreno</TD>";
      $tablaChips .= "</TR>";
      $rs->MoveNext();
    }
    $tablaChips .= "</TABLE>";
    echo "<script>
      pNombreI = $('#pNombre').val();
      pConstructoraI = $('#pConstructora').val();
      pRepI = $('#pRep').val();
      $('#valorO').val('$valorObligacionF');  
      $('#valM2T').val('$valM2TMax');
      $('#valRef').val('$valorReferenciaF');
      $('#valorA2').val('$valorA2F');
      $('#pDir').val('$direccionPredio');
      //$('#pRep').val('$nombrePropietario');
      $('#pAreaB').val('$pAreaB');
      $('#chips').html('$tablaChips');
      $('#pFMI').val('$pFMI');
      $('#valorCatastralPromedio').val('$valorCatastralPromedioF');
      $('#chip').val('');
      $('#chip').attr('placeholder', '$chipMax');
      $('#pChip').val('$chipMax');
      $('#resultado').html('$textoFinal');
      $('#areaTerreno').html('(Area del terreno  $areaTerreno m<sup>2</sup>)')
      $('#pNombreI').text(pNombreI);
      $('#pRepI').text(pRepI);
    </script>
    ";
  } else {
	  if ($chip=='0'){
		    echo "<div class='alert alert-danger fade in'>
	              <button class='close' data-dismiss='alert'> × </button>
	              <i class='fa-fw fa fa-times'></i>
	              Por favor ingrese un Chip. 
		      </div>";
   
	  }else{
		    echo "<div class='alert alert-danger fade in'>
		              <button class='close' data-dismiss='alert'> × </button>
		              <i class='fa-fw fa fa-times'></i>
		              <strong>CHIP $chip</strong>
		               No se ha encontrado en la Base de datos.  Por favor verifiquelo.
		              </div>";
	  }
  }
?>
