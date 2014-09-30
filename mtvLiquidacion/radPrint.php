<?php
session_start();
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
setlocale(LC_ALL,"es_CO");
$fechaRad =  strftime("%A %d de %B del %Y");

$dias = array("Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sábado");
$meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
 
   if(trim($chip)) $_SESSION["chips"] .= "'". trim($chip). "'," ;
  
  if(trim( $_SESSION["chips"])) {
    $isql = "SELECT * FROM predial2014_20140819 WHERE CHIP in (". $_SESSION["chips"]."'0') order by CAST(VAL_M2_T AS NUMERIC) DESC";
    $rs = $db->conn->query($isql);
    $tablaChips = "<TABLE width=100%>";
    $tablaChips .= "<TR><Th><p style='font-size:10px'>Chip</Th><Th><p style='font-size:10px'>Direcci&oacute;n</Th><Th><p style='font-size:10px'>Area Bruta</Th><Th><p style='font-size:10px'>Representante Legal</Th><Th><p style='font-size:10px'>Valor Catastral M<sup>2</sup></Th><Th></Th></TR>";
    while(!$rs->EOF){
      $chipB = $rs->fields["CHIP"];
      $valM2T = $rs->fields["VAL_M2_T"];
      $valM2TF = number_format($valM2T,2,",",".");
      $areaTerreno = $rs->fields["A_TER_CAT"];
      $nombrePropietario = $rs->fields["NOM_PRO"];
      $direccionPredio = $rs->fields["DIR_REAL"];
      $direccionCorr = $rs->fields["DIR_CORR"];
      $pFMI = $rs->fields["FMI"];
      $tablaChips .= "<TR><TD><p style='font-size:10px' align=center>$chipB</p></TD><TD><p style='font-size:10px'>$direccionPredio</p></TD><TD align=center><p style='font-size:10px'>$areaTerreno</p></TD><TD><p style='font-size:10px'>$nombrePropietario</p></TD><TD align=right><p style='font-size:10px'>$valM2TF</p></TD><TD></TD>";
      $tablaChips .= "</TR>";
      $rs->MoveNext();
    } 
    }
$fechaRad = $dias[date('w')]." ".date('d')." de ".$meses[date('n')-1]. " del ".date('Y') ;
$fechaRadC = date("Y/m/d h:i");
$paginaHtml = "
<html>
<heder>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
</header>
<body>
    <div class='row' STYLE='position:absolute; top:20px; left:70px;' >
      <table >
       <tr><td><img src='../../imagenes/logoFrmWeb.png' align=left width=150></td></tr>
      </table>
    </div>

    <div class='row' STYLE='position:absolute; top:20px; left:50px;width:90%;' >
      <table width='100%'>
       <tr><td><img src='../../imagenes/logoFrmWeb2.png' width=150 align='right' ></td></tr>
      </table>
    </div>  
<div  STYLE='position:absolute; top:120px; left:70px;' >
<br>
<p style='font-size: 12;'>
Bogot&aacute;, $fechaRad    <br><br><br>

    <div class='row' STYLE='position:absolute; top:20px; left:750px;width:90%;' >
      <img src='./$pathFileBarras' width=250>
      <br><p style='font-size: 12;'>No Radicaci&oacute;n  2014XXXXXX -  $numeroRadicado <br> $fechaRadC<BR>
       Liquidacion de Prueba - No Valido</p>
    </div>  
</p>
<bR>
<p style='font-size: 12;'>
Se&ntilde;or(a)<br>";
if($sFname) $paginaHtml .= $sFname . "</br>";
if($sAddress) $paginaHtml .= $sAddress . "</br>";
if($sPhone1) $paginaHtml .= $sPhone1 . "</br>";
if($sEmail) $paginaHtml .= $sEmail . "</br>";

$paginaHtml .="

<br><br>

Los siguientes datos han sido extraídos de la simulación del calculo de la obligación VIS/VIP,
en todo caso el valor definitivo será adoptado mediante resolución motivada tras la verificación de los soportes 
del traslado de la obligación urbanística.
<br><br>

 <table border='0' width='70%'><tbody><tr><td><p style='font-size:10px'>Nombre del proyecto</p></td>
 <td><p style='font-size:10px'>$pNombre </p> </td><td></td></tr> 
 <tr><td><p style='font-size:10px'>Direción</p></td><td><p style='font-size:10px'>$sAddress  </p></td></tr>
 <tr><td><p style='font-size:10px'>Urbanizador / Constructor / Patrimonio Autónomo</p></td><td><label id='pConstructoraI'><p style='font-size:10px'>$pConstructora  </p></label></td></tr> 
 <tr><td><p style='font-size:10px'>Representante Legal</p></td><td> <label id='pRepI'><p style='font-size:10px'>$pRep</p></label></td></tr>
 <tr><td><p style='font-size:10px'>Area obligación VIP (A1) </p></td><td><p style='font-size:10px'> $valA1 <sup>2</sup> </p></td></tr>
 <tr><td><p style='font-size:10px'>Area a trasladar</p></td><td><p style='font-size:10px'>$valA2 m<sup>2</sup></p></td></tr>
 <tr><td><p style='font-size:10px'>Valor estimado de la Obligación por traslado VIP/VIS </p></td><td> <p style='font-size:10px'>$valorO </p></td></tr>
 <tr><td colspan='2'><center><img src='$pathImgQr' width='180'></center></td></tr>
 <tr><td colspan=3>$tablaChips</tr></tr>
 
  </tbody></table>
<br><br>
<small>
<p style='font-size: 10;'>
<b>Documentos Ajuntos a esta solicitud.</b><br>
 $files

</small>
</p>
<p style='font-size: 12;'>
<br>
<br>
Recuerde:
<br><br>
Metrovivienda organiza, garantiza y articula una oferta y una demanda de vivienda de interés social para las poblaciones más vulnerables de Bogotá D.C.
<br>El estado de su tramite lo podra consultar en: http://www.metrovivienda.gov.co
</div>
</p>
</body>
</html>";

?>