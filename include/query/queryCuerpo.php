<?php
$coltp3Esp = '"'.$tip3Nombre[3][2].'"';
        #LLAMO UNA FUNCIÓN CONNECCIÓN HANDLER LLAMADA LIMIT LA CUAL ME DEVUELVE LA ESTRUCTURA CORRECTA
$db->limit(50);
$limitMsql = $db->limitMsql;
$limitOci8 = $db->limitOci8;
$limitPsql = $db->limitPsql;
switch($db->driver)
	{
	case 'mssql':
	$isql = 'select '. $limitMsql .'
			convert(char(20), b.RADI_NUME_RADI) "IDT_Numero Radicado"
			,b.RADI_PATH as "HID_RADI_PATH"
			,'.$sqlFecha.' as "DAT_Fecha Radicado"
			,convert(char(20), b.RADI_NUME_RADI) as "HID_RADI_NUME_RADI"
			,UPPER(b.RA_ASUN)  as "Asunto"'.
			$colAgendado.
			',d.NOMBRE_DE_LA_EMPRESA "'.$tip3Nombre[3][2].'"
			,c.SGD_TPR_DESCRIP as "Tipo Documento"
			,b.RADI_USU_ANTE "Enviado Por"
			,CAST (((radi_fech_radi+(c.sgd_tpr_termino * 7/5))-GETDATE()) AS NUMERIC) as "Dias RestanteS"
			,convert(char(20),b.RADI_NUME_RADI) "CHK_CHKANULAR"
			,b.RADI_LEIDO "HID_RADI_LEIDO"
			,b.RADI_NUME_HOJA "HID_RADI_NUME_HOJA"
			,b.CARP_PER "HID_CARP_PER"
			,b.CARP_CODI "HID_CARP_CODI"
			,b.SGD_EANU_CODIGO "HID_EANU_CODIGO"
			,b.RADI_NUME_DERI "HID_RADI_NUME_DERI"
			,b.RADI_TIPO_DERI "HID_RADI_TIPO_DERI"
		 from
		 radicado b
	left outer join SGD_TPR_TPDCUMENTO c
	on b.tdoc_codi=c.sgd_tpr_codigo
	left outer join BODEGA_EMPRESAS d
	on b.eesp_codi=d.identificador_empresa
    where
		b.radi_nume_radi is not null
		and b.radi_depe_actu='.$dependencia.
		$whereUsuario.$whereFiltro.'
		'.$whereCarpeta.'
		'.$sqlAgendado.'
	  order by '.$order .' ' .$orderTipo;
	break;
	case 'postgres':
	case 'oci8':
	   $whereFiltro = str_replace("b.radi_nume_radi","cast(b.radi_nume_radi as varchar(20))",$whereFiltro);

//	$redondeo="date_part('days', radi_fech_radi-".$db->conn->sysTimeStamp.")+floor(c.sgd_tpr_termino * 7/5)+(select count(1) from sgd_noh_nohabiles where NOH_FECHA between radi_fech_radi and ".$db->conn->sysTimeStamp.")";
        if($db->driver=="oci8") {
          $fechaT = "((radi_fech_radi-".$db->conn->sysTimeStamp.")+(c.sgd_tpr_termino))";
	  $diasHabiles = " fech_vcmto -5 "; // ".$db->conn->sysdate ." ";
	}else{
	  $fechaT = "(date_part('days', radi_fech_radi-".$db->conn->sysTimeStamp."))+floor(c.sgd_tpr_termino * 7/5)";
	  $diasHabiles = '- extract(days from date_trunc('."'".'days'."'".', NOW()) - date_trunc('."'".'days'."'".',fech_vcmto))';
	}
	$redondeo="$fechaT+(select count(1) from sgd_noh_nohabiles where NOH_FECHA between radi_fech_radi and ".$db->conn->sysTimeStamp.")";
	//$redondeo="date_part('days', radi_fech_radi-".$db->conn->sysTimeStamp.")+floor(c.sgd_tpr_termino * 7/5)+(select count(1) from sgd_noh_nohabiles where NOH_FECHA between radi_fech_radi and ".$db->conn->sysTimeStamp.")";

	$isql = 'select
			b.RADI_NUME_RADI "IDT_Numero RADICADO"
			,b.RADI_PATH "HID_RADI_PATH"
			,'.$sqlFecha.' "DAT_FECHA RADICADO"
			,'.$sqlFecha.' "HID_RADI_FECH_RADI"
			, b.RADI_NUME_RADI "HID_RADI_NUME_RADI"
			,b.RA_ASUN  "ASUNTO"
			, b.RADI_CUENTAI "REFERENCIA"'.
			$colAgendado.
			',d.SGD_DIR_NOMREMDES "REMITENTE"
			,c.SGD_TPR_DESCRIP "TIPO DOCUMENTO"
                	,'.$diasHabiles.' " DIAS RESTANTES"
			,b.RADI_USU_ANTE "ENVIADO POR"
			,b.RADI_NUME_RADI "CHK_CHKANULAR"
			,b.RADI_LEIDO "HID_RADI_LEIDO"
			,b.RADI_NUME_HOJA "HID_RADI_NUME_HOJA"
			,b.CARP_PER "HID_CARP_PER"
			,b.CARP_CODI "HID_CARP_CODI"
			,b.SGD_EANU_CODIGO "HID_EANU_CODIGO"
			,b.RADI_NUME_DERI "HID_RADI_NUME_DERI"
			,b.RADI_TIPO_DERI "HID_RADI_TIPO_DERI"
		 from
	 radicado b
	left outer join SGD_TPR_TPDCUMENTO c
	on b.tdoc_codi=c.sgd_tpr_codigo
	left outer join SGD_DIR_DRECCIONES d
	on (b.radi_nume_radi=d.radi_nume_radi and d.sgd_dir_tipo=1)
    where
		b.radi_nume_radi is not null
		and b.radi_depe_actu='.$dependencia.
		$whereUsuario.$whereFiltro.'
		'.$whereCarpeta.'
		'.$sqlAgendado.'
		'.$limitOci8 .'
	  order by '.$order .' ' .$orderTipo
	  . ' ' . $limitPsql . ' ' ;
	//$db->conn->debug = true;
	break;
	
	}
?>
