 <?php
 
 /**Coloco el asunto del radicado padre*/
  $isql_ = "select * from radicado where radi_nume_radi = $numrad";
  $rs_ = $db->query($isql_);
  if (!$rs_->EOF) {
  $asunto = $rs_->fields['RA_ASUN'];
 
  } else {
  saveMessage('error',"No se ha podido obtener la informacion del radicado.");
  die(json_encode($answer));
  }
 
 
 ?>

