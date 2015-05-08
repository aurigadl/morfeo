<?php 
$searchText = $_POST["searchText"];
$radicados = $_POST["radicados"];
if(!$searchText) $searchText = $_GET["searchText"];
if(!$radicados) $radicados = $_GET["radicados"];
function getRadsExpediente($numeroExpediente="", $searchText="",$radicados=""){
  $ruta_raiz = "..";
  include ($ruta_raiz."/config.php");
  include_once($ruta_raiz."/include/db/ConnectionHandler.php");
  
  //include_once($ruta_raiz."/include/tx/Expediente.php");
  
  $db = new ConnectionHandler($ruta_raiz);
  //$expediente = new Expediente($db);
  $searchText = trim(strtoupper($searchText));
  $pos = strpos($searchText, "-");
  if($searchText && $pos>=5 ){
    $searchText = substr($searchText, 0,$pos);
  }
  $filtroRads = "";
  if($radicados) {
    $filtroRads = " and r.radi_nume_radi not in ($radicados 0)";
  }
  #$db->conn->debug = true;
  
  //Aqui busco la informacion necesaria del usuario para la creacion de expedientes
  //$db->conn->debug = true;
  $sql= "select exp.RADI_NUME_RADI, r.ra_asun, r.RADI_FECH_RADI, sexp.sgd_sexp_parexp1
            ,sexp.sgd_sexp_parexp1
            ,sexp.sgd_sexp_parexp2
            ,sexp.sgd_sexp_parexp3
            ,sexp.sgd_sexp_parexp4
	    ,r.tdoc_codi
	    ,r.radi_path
	    ,'<a href=&#34;http://200.69.119.84/siim32/bodega/'||r.radi_path||'&#34;>Imagen</a>' radi_path2
	    ,tpr.sgd_tpr_descrip
           from sgd_dir_drecciones dir, sgd_sexp_secexpedientes sexp, sgd_exp_expediente exp , radicado r
 left outer join sgd_tpr_tpdcumento tpr on (r.tdoc_codi=tpr.sgd_tpr_codigo)
 where  
 r.radi_nume_radi = dir.radi_nume_radi and 
 sexp.sgd_exp_numero=exp.sgd_exp_numero AND exp.radi_nume_radi=r.radi_nume_radi and 
	   (upper(sexp.sgd_sexp_parexp2) = upper ('".$searchText."')
	   or
	   upper(sexp.sgd_sexp_parexp1) = upper ('".$searchText."')
	   or
	   upper(sexp.sgd_sexp_parexp3) = upper ('".$searchText."')
           or
   	   dir.sgd_dir_doc like '%".$searchText."%')
	   $filtroRads
	   ";
  
  //return $sql;
  $rs = $db->conn->query($sql);
  $docs = array();
  $i=0;
  while (!$rs->EOF){
       $docs[$i]["radicado"] = $radi_nume_radi  = $rs->fields['RADI_NUME_RADI'];
       $docs[$i]["asunto"] = $rs->fields['RA_ASUN'];
       $docs[$i]["fecha"] =  $rs->fields['RADI_FECH_RADI'];
       $docs[$i]["path"] = $rs->fields['RADI_PATH'];
       $docs[$i]["tipoDocumento"] = $rs->fields['SGD_TPR_DESCRIP'];
       $docs[$i]["codigoTipoDocumento"] = $rs->fields['TDOC_CODI'];
       $rs->MoveNext();
       $i++;
  }
  
  
  return $docs;
}

if($searchText){
  $res = getRadsExpediente("",$searchText,$radicados);
  
  //var_dump( $res);
  echo json_encode($res);
}
?>
