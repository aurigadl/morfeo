<?
ini_set("display_errors",1);
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
$chips = json_decode($_GET["predios_seleccionados"], true);
$i=0;
//$numeroExpediente = "2008900999900003E";
$numeroExpediente = $_GET["numeroExpediente"];
foreach($chips["chip"] as $key => $chip){
   //echo "<br>$key>>>".$chip."<br>";
   //$chip = "AAA0000PJEA";
   $url = "http://200.118.122.176:5380/py/pyforms/seleccion_predios/select_predio?expediente=$numeroExpediente&chip=$chip";
   //echo $url;
   $res = file_get_contents($url);
   echo "$res";
   $sPos = "No form was returned by the controller";
   $pos = strpos($res, $sPos, 1);
   if($pos>=1) echo $chip . " Agregado Corectamente en $numeroExpediente<br>"; else "No se ha encontrado el Chip $chip <br>";

   $i++;
}
//var_dump($chip[0]);
//curl 'http://200.118.122.176:5380/siim2/gis/seleccionarPredio.php?predios_seleccionados=%7B%22chip%22%3A%5B%22AAA0012SMJZ%22%2C%22AAA0012SKJZ%22%2C%22AAA0012SLRU%22%2Cnull%5D%7D&_dc=1397426829205&callback=stcCallback1001' -H 'Accept: */*' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: es-ar,es;q=0.8,en-us;q=0.5,en;q=0.3' -H 'Connection: keep-alive' -H 'Host: 200.118.122.176:5380' -H 'Referer: http://162.243.69.213:8081/mtvSIG/' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:28.0) Gecko/20100101 Firefox/28.0'
// <iframe src="http://162.243.69.213:8081/mtvSIG/?numeroExpediente={numeroExpediente}" width="100%"></iframe>

//$url = "http://162.243.69.213:8081/mtvSIG/";
//$res = file_get_contents($url);
//echo "$res";
   
?>
   
