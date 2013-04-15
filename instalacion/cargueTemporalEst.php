<html>
<head>
    <link rel="stylesheet" href="../estilos/orfeo38/orfeo.css">
</head>
<body>
<?
ini_set("display_errors",1);
define('ADODB_ASSOC_CASE', 1);
$ruta_raiz= "..";
$usuario = "postgres";
$contrasena= "0rfe0gplMSalud";
$contrasena= "G3Ssoporte2o12pg";
$servidor = "orfeo.minsalud.gov.co:5432";
//This would by the Database Name
//$base = "bd_lgv0109";
$servicio = "orfeo382_produccion";
//include($ruta_raiz.'/include/class/adodb/adodb.inc.php'); //
include('/var/www/orfeo-3.8.2des/include/class/adodb/adodb.inc.php');
$db = & ADONewConnection("postgres");
$db->SetFetchMode(ADODB_FETCH_ASSOC);
if($db->Connect($servidor, $usuario, $contrasena, $base)==false){echo "<br>No se conecto a Orfeo";} else echo("<br>  Si se conecto a Orfeo");
$varFinalizo = "INICIA EL CARGUE";
?>
<table class=borde_tab>
<tr class=tilutos5>
<td class=listado2> <?=$varFinalizo?></td>
</tr>
<?
$isqlDelete = "delete from tmp_tramite";
$rs = $db->Execute($isqlDelete);

//$db->debug = true;
$iSqlRadicados = "insert into tmp_tramite
(
SELECT distinct r.radi_nume_radi radicado , 
	d1.sgd_dir_nomremdes peticionario , 
	m1.muni_nomb municipio , 
	r.ra_asun asunto ,
	r.radi_fech_radi , 
	r.radi_depe_radi , 
	r.radi_usua_radi , 
	r.radi_usua_actu ,
	r.radi_depe_actu ,
	r.depe_codi , 
	r.sgd_trad_codigo , 
	r.radi_nume_guia , 
	r.radi_cuentai ,
	t.sgd_tpr_codigo , 
	t.sgd_tpr_descrip , 
	t.sgd_tpr_termino , 
	ser.par_serv_secue, 
	ser.par_serv_nombre,
	rca.sgd_ddca_codigo, 
	des.sgd_ddca_descrip,
	cau.sgd_cau_codigo, 
	cau.sgd_cau_descrip,
	dcau.sgd_dcau_codigo, 
	sgd_dcau_descrip,
	r.fech_vcmto , 
	(CASE WHEN an.anex_fech_envio is NULL THEN CASE WHEN r.fech_vcmto > now() THEN '00' ELSE (now() -r.fech_vcmto) END ELSE CASE WHEN r.fech_vcmto < an.anex_fech_envio THEN (an.anex_fech_envio -r.fech_vcmto) ELSE '00' END end) dias_vencimiento ,
	b.usua_nomb usuario , 
        h.depe_codi_dest,
        b.depe_codi depe_usua ,
        b.usua_codi,
        b.usua_login,
	r.radi_path,
	r.sgd_spub_codigo,
	b.codi_nivel as usua_nivel , 
	an.radi_nume_salida , 
	an.anex_radi_fech , 
	an.anex_fech_envio ,
	an.anex_fech_anex ,
	an.anex_radi_fech-r.RADI_FECH_RADI dias_proyecto , 
	an.anex_fech_envio-r.RADI_FECH_RADI dias_envio , 
	CASE WHEN an.anex_fech_envio IS NULL THEN (an.anex_fech_envio -r.RADI_FECH_RADI) ELSE (an.anex_fech_envio - r.RADI_FECH_RADI) END dias_tramite,
	rd.radi_nume_radi  as res_asociado, 
        rd.sgd_trad_codigo as sgd_trad_codigo_as, 
	rd.radi_fech_radi  fecha_asociado, 
	ad.ANEX_FECH_ENVIO fech_envio_as, 
	ad.anex_radi_fech-r.RADI_FECH_RADI dias_proyecto_as , 
	ad.anex_fech_envio-r.RADI_FECH_RADI dias_envio_as , 
	CASE WHEN ad.anex_fech_envio IS NULL THEN (ad.anex_fech_envio -r.RADI_FECH_RADI) ELSE (ad.anex_fech_envio- ad.anex_fech_envio) END tramite_as,
	h.depe_codi as depe_origen,
	h.hist_fech
FROM sgd_dir_drecciones d1, 
     MUNICIPIO m1, 
     USUARIO b, 
     HIST_EVENTOS h, 
     SGD_TPR_TPDCUMENTO t, 
     RADICADO r left outer join anexos an ON (R.RADI_NUME_RADI=an.ANEX_RADI_NUME AND an.anex_estado>=2 and an.sgd_dir_tipo = 1)
	left outer join sgd_caux_causales rca on (r.radi_nume_radi = rca.radi_nume_radi)
	left outer join sgd_ddca_ddsgrgdo des on (des.sgd_ddca_codigo = rca.sgd_ddca_ddsgrgdo)
	left outer join par_serv_servicios ser on (ser.par_serv_secue = des.par_serv_secue and des.sgd_ddca_codigo = rca.sgd_ddca_ddsgrgdo)
	left outer join sgd_dcau_causal dcau on (dcau.sgd_dcau_codigo = des.sgd_dcau_codigo)
	left outer join sgd_cau_causal cau on (dcau.sgd_cau_codigo = cau.sgd_cau_codigo and dcau.sgd_dcau_codigo = des.sgd_dcau_codigo)
	left outer join RADICADO rd ON (r.radi_nume_radi = rd.radi_nume_deri and rd.radi_tipo_deri =2 
		   and rd.sgd_trad_codigo <> '2')
	left outer join anexos ad ON (rd.RADI_NUME_RADI=ad.ANEX_RADI_NUME and ad.sgd_dir_tipo = 1
		    and r.radi_nume_radi = rd.radi_nume_deri 
		    and rd.radi_tipo_deri in (0,2) and rd.sgd_trad_codigo <> 2)
WHERE r.tdoc_codi=t.sgd_tpr_codigo AND d1.radi_nume_radi=r.radi_nume_radi
      AND d1.sgd_dir_tipo=1 AND d1.muni_codi=m1.muni_codi AND d1.dpto_codi=m1.dpto_codi 
      --AND h.HIST_DOC_DEST  = b.usua_doc
      AND h.usua_codi_dest = b.usua_codi
      AND h.depe_codi_dest = b.depe_codi
      AND h.RADI_NUME_RADI=r.RADI_NUME_RADI 
      AND h.SGD_TTR_CODIGO in(2,9,12,16) 
      ---AND TO_CHAR(h.hist_fech,'yyyy/mm/dd') BETWEEN '2011/01/01' AND '2013/02/22' 
      ---AND r.sgd_trad_codigo = 2
      --- and r.radi_nume_radi = '201342400183742'
ORDER BY 1
)
";
      $rs = $db->Execute($iSqlRadicados);

?>
<table class=borde_tab>
<tr class=tilutos5>
<td class=listado2> <?=$varFinalizo?></td>
</tr>
<?
 $iSqlCount = "select count(*) as TOTAL from tmp_tramite";
 $rs = $db->Execute($iSqlCount);
 $numTotal = $rs->fields["TOTAL"];
 echo " $numTotal > GENERADOS EL  ". date("H:i:s")."<br>";
?>
</table>
</body>
</html>