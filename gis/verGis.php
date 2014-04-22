<? 
  $prediosGis = "";
  if($prediosExp) $prediosGis = "&prediosExp=$prediosExp";
  $url = "http://162.243.69.213:8081/mtvSIG/?numeroExpediente=$numExpediente".$prediosGis;
?>
<iframe src="<?=$url?>" width="100%" height="80%"></iframe>
