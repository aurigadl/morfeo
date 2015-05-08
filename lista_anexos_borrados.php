<?php
session_start();

$sqlFechaDocto = $db->conn->SQLDate("Y-m-D H:i:s A","sgd_fech_doc");
$sqlFechaAnexo = $db->conn->SQLDate("Y-m-D H:i:s A","anex_fech_anex");
//$sqlFechaAnexo = "to_char(anex_fech_anex, 'YYYY/DD/MM HH:MI:SS')";
$sqlSubstDesc =  $db->conn->substr."(anex_desc, 0, 100)";
//include_once("include/query/busqueda/busquedaPiloto1.php");
// Modificado SGD 06-Septiembre-2007
#$maxRows = $db->limit(); 
		$db->limit(24);
                $limitMsql = $db->limitMsql;
                $limitOci8 = $db->limitOci8;
                $limitPsql = $db->limitPsql;

                $db->limit(1);
                $limit2Oci8 = $db->limitOci8;
                $limit2Psql = $db->limitPsql;

$isql = "select $limitMsql a.anex_codigo AS DOCU
            ,at.anex_tipo_ext AS EXT
			,a.anex_tamano AS TAMA
			,a.anex_solo_lect AS RO
            ,usua_nomb AS CREA
			,$sqlSubstDesc AS DESCR
			,a.anex_nomb_archivo AS NOMBRE
			,a.ANEX_CREADOR
			,a.ANEX_ORIGEN
			,a.ANEX_SALIDA
			,$radi_nume_salida RADI_NUME_SALIDA
			,a.ANEX_ESTADO
			,SGD_PNUFE_CODI
			,SGD_DOC_SECUENCIA
			,SGD_DIR_TIPO
			,SGD_DOC_PADRE
			,a.SGD_TPR_CODIGO
			,a.SGD_TRAD_CODIGO
			,a.ANEX_TIPO
			,a.ANEX_FECH_ANEX AANEX_FECH_ANEX
			,a.ANEX_FECH_ANEX
			,a.ANEX_RADI_NUME
			,$sqlFechaDocto FECDOC
			,$sqlFechaAnexo FEANEX
			,a.ANEX_TIPO NUMEXTDOC
			,(SELECT d.sgd_dir_nomremdes from sgd_dir_drecciones d where (d.sgd_anex_codigo=a.anex_codigo  or d.radi_nume_radi=a.radi_nume_salida)
 AND a.sgd_dir_tipo=d.sgd_dir_tipo $limit2Oci8 $limit2Psql) destino
		from anexos a, anexos_tipo at ,usuario u
      where anex_radi_nume=$verrad and a.anex_tipo=at.anex_tipo_codi
		   and a.anex_creador=u.usua_login and a.anex_borrado='S' $limitOci8
	   order by a.ANEX_FECH_ANEX,sgd_dir_tipo,a.anex_radi_nume,a.radi_nume_salida $limitPsql";

// case eliminado. No se entiende para qu se realiza. 
?>
<table WIDTH="100%" align="center" id="tableDocument" class="table table-striped table-hover" >
    <thead>
        <tr>
            <th width='1%'></th>
            <th width='10%' colspan=2><center>Documento</center></th>
            <th width='5%'><center>Trd</center></th>
            <th width='1%'></th>
            <th width='10%'>Destino</th>
            <th width='5%'> Tama&ntilde;o (Kb)</th>
            <th width='20%'>Creador</th>
            <th width='20%'>Descripcion</th>
            <th width='12%'>Fecha</th>
        </tr>
    </thead>
<?php

include_once "$ruta_raiz/tx/verLinkArchivo.php";
$verLinkArchivo = new verLinkArchivo($db);
$rowan = array();
$rs = $db->conn->query($isql);
//$db->conn->debug = true;

if (!$ruta_raiz_archivo) $ruta_raiz_archivo = $ruta_raiz;
$directoriobase="$ruta_raiz_archivo/bodega/";
//Flag que indica si el radicado padre fue generado desde esta area de anexos
$swRadDesdeAnex=$anex->radGeneradoDesdeAnexo($verrad);

if($rs){

while(!$rs->EOF){
	$aplinteg     = $rs->fields["SGD_APLI_CODI"];
	$numextdoc    = $rs->fields["NUMEXTDOC"];
	$tpradic      = $rs->fields["SGD_TRAD_CODIGO"];
	$coddocu      = $rs->fields["DOCU"];
	$origen       = $rs->fields["ANEX_ORIGEN"];
  $para_radicar = $rs->fields["ANEX_SALIDA"];

	if ($rs->fields["ANEX_SALIDA"]==1 )	$num_archivos++;
	$linkarchivo=$directoriobase.substr(trim($coddocu),0,4)."/".intval(substr(trim($coddocu),4,$ln))."/docs/".trim($rs->fields["NOMBRE"]);
	$linkarchivo_vista="$ruta_raiz/bodega/".substr(trim($coddocu),0,4)."/".intval(substr(trim($coddocu),4,$ln))."/docs/".trim($rs->fields["NOMBRE"])."?time=".time();
	$linkarchivotmp=$directoriobase.substr(trim($coddocu),0,4)."/".intval(substr(trim($coddocu),4,$ln))."/docs/tmp".trim($rs->fields["NOMBRE"]);
	if(!trim($rs->fields["NOMBRE"])) $linkarchivo = "";

if ($db->entidad=="CRA"){if ($tpradic==''){$tip_rest = substr($verrad,-1);if ($tip_rest == 2){$tpradic = 1 ;}else{$tpradic =$tip_rest;}}}

?>
<tr id="<?=$coddocu?>">
<?php

$cod_radi = ($rs->fields["RADI_NUME_SALIDA"]!=0)? $rs->fields["RADI_NUME_SALIDA"] : $coddocu;

$anex_estado = $rs->fields["ANEX_ESTADO"];
$img_estado = "<span class='glyphicon glyphicon-remove' title='Este archivo se eliminó. . .'></span> "; 
?>
<TD height="21" > <font size=1> <?=$img_estado?> </font>
</TD>
 <TD>
<?php
if(trim($linkarchivo))
			{
				$ext = $rs->fields["EXT"];
				echo "<img src='img/icono_$ext.jpg' title='$ext'> ";
		}else{
			echo $msg;
		}
?>
 </td><td width="1" valign="middle" align=right>
<?
     $total_digitos = 11 + $ln;

	 if (strlen($cod_radi) <= $total_digitos){
		//Se trata de un Radicado
		$resulVali = $verLinkArchivo->valPermisoRadi($cod_radi);
		$valImg = $resulVali['verImg'];
	 }else{
		//Se trata de un Anexo sin Radicar
		$resulValiA = $verLinkArchivo->valPermisoAnex($coddocu);
		$valImg = $resulValiA['verImg'];
	}
	if(trim($linkarchivo)){
	 //Codigo solo para la migracion de acapella ---- Ini----
	 preg_match("/b\/20/", $linkarchivo, $matches, PREG_OFFSET_CAPTURE);
	 $acapella = substr($linkarchivo, $matches[0][1]+2);
	 if (preg_match("/b\/20/", $linkarchivo)){
	 echo "<b><a class=\"vinculos\" href=\"./bodega/b/$acapella \"> $cod_radi </a>";
	}else{
	 if($valImg == "SI" or $verradPermisos == "Full" ){
	 echo "<b><a class=\"vinculos\" href=\"#2\" onclick=\"funlinkArchivo('$coddocu','$ruta_raiz');\"> $cod_radi </a>";
	 }else{
	 echo "<a class='vinculos' href='javascript:noPermiso()' > $cod_radi </a>";
	 }
	}
 //Codigo solo para la migracion de acapella ---- Fin ----
	 //if($valImg == "SI" or $verradPermisos == "Full" ){
	 //echo "<b><a class=\"vinculos\" href=\"#2\" onclick=\"funlinkArchivo('$coddocu','$ruta_raiz');\"> $cod_radi </a>";
	 //}else{
		 //echo "<a class='vinculos' href='javascript:noPermiso()' > $cod_radi </a>";
		 //}
	}else{
	 
		echo trim(strtolower($cod_radi));
	}

?>
</small></td>
<td width="1%" valign="middle"><font face="Arial, Helvetica, sans-serif" class="etextomenu"><small>
  <?
	/*
	* Indica si el Radicado Ya tiene asociado algun TRD
	*/
		$isql_TRDA = "SELECT *
				FROM SGD_RDF_RETDOCF
				WHERE RADI_NUME_RADI = '$cod_radi'
				";
	$rs_TRA = $db->conn->Execute($isql_TRDA);
	$radiNumero = $rs_TRA->fields["RADI_NUME_RADI"];

  $msg_TRD = ($radiNumero !='')? 'S' : '';
  echo "\n";
	echo $msg_TRD;
?>
</small></td>

	<td width="1%" valign="middle"><font face="Arial, Helvetica, sans-serif">
<?php
  
  $no_es_impreso = $rs->fields["ANEX_ESTADO"] <= 3;
  $es_extension = ($rs->fields["EXT"]=="rtf" or
                    $rs->fields["EXT"]=="doc" or
                    $rs->fields["EXT"]=="docx" or
                    $rs->fields["EXT"]=="odt" or
                    $rs->fields["EXT"]=="xml") and $no_es_impreso;
  
  if($es_extension) {
    if($valImg == "SI"){
		  echo"<a class=\"vinculos\" style='cursor:pointer;cursor:hand;' onclick=\"vistaPreliminar('$coddocu','$linkarchivo','$linkarchivotmp');\">";
		}else{
		  echo "<a class='vinculos' style='cursor:pointer;cursor:hand;' href='javascript:noPermiso()' >";
		}

    echo "<span class='glyphicon glyphicon-search'></span>\n";
    echo "<font face='Arial, Helvetica, sans-serif' class='etextomenu'>\n";
    echo "</a>\n";
    $radicado = "false";
    $anexo = $cod_radi;
	}
?>
	</font>
</TD>
 <td><font size=1> <?=substr($rs->fields["DESTINO"],0,18)?> </font></small></td>
 <td><font size=1> <?=$rs->fields["TAMA"]?> </font></small></td>
 <td><font size=1> <?=$rs->fields["CREA"]?> </font></small></td>
 <td><font size=1> <?=$rs->fields["DESCR"]?> </font></small></td>
 <td><font size=1> <?=$rs->fields["FEANEX"]?> </font></small></td>

</tr>
<?php
	$rs->MoveNext();
}
}

?>

</table>


