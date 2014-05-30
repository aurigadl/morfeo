<?php
session_start();
if (!$ruta_raiz) $ruta_raiz= "..";
$sqlFechaDocto =  $db->conn->SQLDate("Y-m-D H:i:s A","mf.sgd_rdf_fech");
$sqlSubstDescS =  $db->conn->substr."(s.sgd_srd_descrip, 0, 30)";
$sqlSubstDescSu = $db->conn->substr."(su.sgd_sbrd_descrip, 0, 30)";
$sqlSubstDescT =  $db->conn->substr."(t.sgd_tpr_descrip, 0, 30)";
$sqlSubstDescD =  $db->conn->substr."(d.depe_nomb, 0, 30)";

include "$ruta_raiz/include/query/trd/querylista_tiposAsignados.php"; 
$isqlC = 'select 
			  '. $sqlConcat .  '      AS "CODIGO" 
			, '. $sqlSubstDescS .  '  AS "SERIE" 
			, '. $sqlSubstDescSu .  ' AS "SUBSERIE" 
			, '. $sqlSubstDescT .  '  AS "TIPO_DOCUMENTO" 
			, '. $sqlSubstDescD .  '  AS "DEPENDENCIA"
			, m.sgd_mrd_codigo        AS "CODIGO_TRD"
			, mf.usua_codi             AS "USUARIO"
			, mf.depe_codi             AS "DEPE"
			from 
				SGD_RDF_RETDOCF mf,
	   			SGD_MRD_MATRIRD m, 
	   			DEPENDENCIA d,
	   			SGD_SRD_SERIESRD s,
	   			SGD_SBRD_SUBSERIERD su, 
	   			SGD_TPR_TPDCUMENTO t
	   		where d.depe_codi     = mf.depe_codi 
	   			and s.sgd_srd_codigo  = m.sgd_srd_codigo 
	   			and su.sgd_sbrd_codigo = m.sgd_sbrd_codigo 
				and su.sgd_srd_codigo = m.sgd_srd_codigo
	  			and t.sgd_tpr_codigo  = m.sgd_tpr_codigo
	   			and mf.sgd_mrd_codigo = m.sgd_mrd_codigo
			    and mf.radi_nume_radi = '. $nurad;
     error_reporting(7);
?>
	<TABLE class="table table-bordered"><tr><td>
   <small>CLASIFICACION DEL RADICADO No. <?=$nurad ?></small></td></tr></table>
	<br>
	<table class="table table-bordered" width="100%" cellpadding="0" cellspacing="5">
  	<tr  align="center">
    	<th width="10%"><small>CODIGO</small></th>
		<th width="20%"><small>SERIE</small></th>
		<th width="20%"><small>SUBSERIE</small></th>
 		<th width="20%"><small>TIPO DE 
				DOCUMENTO</small></td>
    	<th width="20%"><small>DEPENDENCIA</small></th>
   	   	<th width="20%"><small>ACCION</small></th>
  		</tr>
  	<?php
	 	$rsC=$db->query($isqlC);
   		while(!$rsC->EOF)
			{
      			$coddocu  =$rsC->fields["CODIGO"];
	  			$dserie   =$rsC->fields["SERIE"]; 
				$dsubser  =$rsC->fields["SUBSERIE"];
				$dtipodo  =$rsC->fields["TIPO_DOCUMENTO"];
                                $ddepend  =$rsC->fields["DEPENDENCIA"];
				$codiTRDEli  =$rsC->fields["CODIGO_TRD"];
				$codiTRDModi =$codiTRDEli;
				
		?> 
				<td class="listado5"> <small><?=$coddocu?></small> </td>
				<td class="listado5"> <small><?=$dserie?></small> </td>
				<td class="listado5"> <small><?=$dsubser?></small> </td>
				<td class="listado5"> <small><?=$dtipodo?></small> </td>
				<td class="listado5"> <small><?=$ddepend?></small> </td>
	 			<td  <? if (!$rsC->fields["CODIGO"]) echo " class='celdaGris ' "; else echo " class='e_tablas ' "; ?>  > <font size=2>
		<?php 
	      		echo "<a href=javascript:borrarArchivo('$codiTRDEli','si')><span class='botones_largo'>Borrar</a> ";
			/*if($coddocu && $rsC->fields["USUARIO"]==$codusua && $rsC->fields["DEPE"] == $coddepe)
				{
					echo "<a href=javascript:borrarArchivo('$codiTRDEli','si')><span class='botones_largo'>Borrar</a> ";
		  		} */
		  ?> 
		 
	</td>
	</tr>
	<?
				$rsC->MoveNext();
  		}
		//<font face="Arial, Helvetica, sans-serif" class="etextomenu">
		 ?>
   </table>