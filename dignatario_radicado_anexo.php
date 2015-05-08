<?php
 require("$ruta_raiz/include/tx/usuario.php");
 $classusua = new Usuario($db);

//Busco los valores del destinatario en el radicado padre

/**Coloco el asunto del radicado padre*/
 $isql_ = "select * from sgd_dir_drecciones where radi_nume_radi = $numrad";
 $rs_ = $db->query($isql_);
 if (!$rs_->EOF) {

 $record = array();
 $nextval = $db->nextId("sec_dir_drecciones");
 
 $rs_sgd_oem_codigo = intval ($rs_->fields['SGD_OEM_CODIGO']);

 $record['SGD_OEM_CODIGO'] = $rs_sgd_oem_codigo;
 $record['SGD_CIU_CODIGO'] = $rs_->fields['SGD_CIU_CODIGO'];
 $record['MUNI_CODI'] = $rs_->fields['MUNI_CODI'];
 $record['DPTO_CODI'] = $rs_->fields['DPTO_CODI'];
 $record['SGD_DIR_DIRECCION'] = $rs_->fields['SGD_DIR_DIRECCION'];
 $record['SGD_DIR_TELEFONO'] = $rs_->fields['SGD_DIR_TELEFONO'];
 $record['SGD_DIR_MAIL'] = $rs_->fields['SGD_DIR_MAIL'];
 $record['SGD_DIR_NOMBRE'] = $rs_->fields['SGD_DIR_NOMBRE'];
 $record['SGD_DOC_FUN'] = $rs_->fields['SGD_DOC_FUN'];
 $record['SGD_DIR_NOMREMDES'] = $rs_->fields['SGD_DIR_NOMREMDES'];
 $record['SGD_TRD_CODIGO'] = $rs_->fields['SGD_TRD_CODIGO'];
 $record['SGD_DIR_DOC'] = $rs_->fields['SGD_DIR_DOC'];
 $record['ID_PAIS'] = $rs_->fields['ID_PAIS'];
 $record['ID_CONT'] = $rs_->fields['ID_CONT'];
 $record['SGD_DIR_TIPO'] = $rs_->fields['SGD_DIR_TIPO'];
 $record['SGD_DIR_CODIGO']    = $nextval;
 $record['RADI_NUME_RADI']    = $noRad;

     $insertSQL = $db->conn->Replace("SGD_DIR_DRECCIONES",
     $record,
     'SGD_DIR_CODIGO, RADI_NUME_RADI',
     $autoquote = true);
 
     if(!empty($insertSQL)){
	    // $this->result =  array( "state"  => true, "value" => $nextval);
     //return true;
     }else{
	 echo "no se pudo insertar el destinatario"; 
	 exit;
	     //$this->db->log_error ("666-- $nurad ","No se pudo agrear usuario al radicado", $record,1);
	     //$this->result = array( "error"  => 'No se puedo agregar usuario al radicado');
	     //return false;
   }

 } else {
 //saveMessage('error',"No se ha podido obtener la informacion del radicado.");
 //die(json_encode($answer));
echo "No se pudo obtener información del destinatario"; exit;
 }

?>
