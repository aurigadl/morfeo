<? 
  $prediosGis = "";
  if($prediosExp) $prediosGis = "&prediosExp=$prediosExp";
  $url = $servidorGis . "?numeroExpediente=$numExpediente".$prediosGis;
?>
<iframe src="<?=$url?>" width="100%" height="80%"></iframe>
