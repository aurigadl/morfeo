<html>
<heder>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</header>
<?
session_start();
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
setlocale(LC_ALL,"es_CO");
$fechaRad =  strftime("%A %d de %B del %Y");

$dias = array("Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sábado");
$meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
 
$fechaRad = $dias[date('w')]." ".date('d')." de ".$meses[date('n')-1]. " del ".date('Y') ;
?>
<body>
    <div class="row" STYLE="position:absolute; top:20px; left:70px;" >
      <table >
       <tr><td><img src="../imagenes/logoFrmWeb.png" align=left></td></tr>
      </table>
    </div>

    <div class="row" STYLE="position:absolute; top:20px; left:50px;width:90%;" >
      <table width="100%">
       <tr><td><img src="../imagenes/logoFrmWeb2.png" height=80 align="right" ></td></tr>
      </table>
    </div>  
<div  STYLE="position:absolute; top:120px; left:70px;" >
<br><br><br>
Bogot&aacute;, <?=$fechaRad?>    <br><br><br>

<bR>
<br><br>

Simulacion del Calculo de la Obigaci&oacute;n VIP/VIS.
<br><br>

<div id=pData>
 <?=$pData?>
</div>
<br><br>



* En todo caso el valor definitivo será adoptado mediante resolución motivada tras la verificación de los soportes del traslado de la obligación urbanística.
<br>
<br>
</div>

<script>
  pData = window.opener.resultado.innerHTML;
  document.getElementById("pData").innerHTML =pData;
  document.getElementById("fname").innerHTML = window.opener.fname.value + " " + window.opener.lname.value;
  document.getElementById("faddress").innerHTML = window.opener.address.value;
  window.print();
</script>
</body>
</html>