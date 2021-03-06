<?php    
//echo "@@@@@"; exit;
/** CONSUTLA 001 
  * Estadiscas por usuario
  * @autor JAIRO H LOSADA Correlibre.org
  * @version ORFEO 3.1
  * 
  * Arreglo por LIliana Gomez 2012
  */
$coltp3Esp = '"'.$tip3Nombre[3][2].'"';
if(!$orno) $orno=2;
$tmp_substr = $db->conn->substr;
 /**
   * $db-driver Variable que trae el driver seleccionado en la conexion
   * @var string
   * @access public
   */
 /**
   * $fecha_ini Variable que trae la fecha de Inicio Seleccionada  viene en formato Y-m-d
   * @var string
   * @access public
   */
/**
   * $fecha_fin Variable que trae la fecha de Fin Seleccionada
   * @var string
   * @access public
   */
/**
   * $mrecCodi Variable que trae el medio de recepcion por el cual va a sacar el detalle de la Consulta.
   * @var string
   * @access public
   */

$ln=$_SESSION["digitosDependencia"];

if($_GET["tipoDocumentos"]) $tipoDocumentos=$_GET["tipoDocumentos"];

$whereTipoDocumento = "";
if(!empty($tipoDocumentos) and $tipoDocumentos!='9999' and $tipoDocumentos!='9998' and $tipoDocumentos!='9997')
	{
		$whereTipoDocumento.=" AND t.SGD_TPR_CODIGO in ( ". $tipoDocumentos . ")";
	}elseif ($tipoDocumentos=="9997")	
	{
		$whereTipoDocumento.=" AND t.SGD_TPR_CODIGO = 0 ";
	}
if(!empty($depeUs)){
    $condicionDep = "AND b.depe_codi = $depeUs";
    $condicionE   = "AND b.USUA_CODI = $codUs $condicionDep ";
}

if ($_GET['codserie']>0){
	$condicion_serie = " AND f.serie =".$_GET['codserie'];
}
if ($_GET['tsub']>0){
	$condicion_subserie = " AND f.subserie =".$_GET['tsub'];
}


$ascdesc = " DESC ";
switch($db->driver)
{
	case 'mssql':
	case 'postgresql':	
	case 'postgres':	
	{	$queryE = "
		SELECT f.codigo_trd as CODIGO_TRD, f.nume_exp as EXPEDIENTE, t.SGD_TPR_DESCRIP as TIPO_DOCUMENTO
		FROM SGD_EXP_FUID f 
		INNER JOIN SGD_SEXP_SECEXPEDIENTES s ON f.nume_exp = s.sgd_exp_numero   
		LEFT OUTER JOIN SGD_TPR_TPDCUMENTO t ON f.TDOC_CODI = t.SGD_TPR_CODIGO
		WHERE 
		((
			".$db->conn->SQLDate('Y/m/d', 'f.fecha_ini')." BETWEEN '$fecha_ini' AND '$fecha_fin' 
		) 
		AND (
			".$db->conn->SQLDate('Y/m/d', 'f.fecha_fin')." < '$fecha_fin' 
		))
		$condicion_serie  
		$condicion_subserie  
		GROUP BY f.nume_exp,t.SGD_TPR_DESCRIP ORDER BY $orno $ascdesc 
		";
                
 		/** CONSULTA PARA VER DETALLES 
         * Se incluye una nueva restriccion para que en el detalle unicamente 
         * muestre la direccion remitente/destinatario
         * Junio 14 2012
		 */
	$concatb = $db->conn->Concat('SRD.SGD_SRD_DESCRIP',"' / '",'SBRD.SGD_SBRD_DESCRIP');

	$queryETodosDetalle = "
		SELECT 
		ROW_NUMBER() OVER(ORDER BY $orno $ascdesc ) AS Orden, 
		f.codigo_trd as CODIGO_TRD,
	        $concatb as TIPO_DOCUMENTO,	
		f.nume_exp as EXPEDIENTE, 
		s.SGD_SEXP_PAREXP1 as nombre_exp,
		s.SGD_SEXP_PAREXP2 as cc_o_nit,
		s.SGD_SEXP_PAREXP3 as id_expediente,
		s.SGD_SEXP_PAREXP4 as objeto_cto,
		s.SGD_SEXP_PAREXP5 as descriptor5,
		TO_CHAR(f.fecha_ini,'YYYY/MM/DD') as fecha_inicial, 
		TO_CHAR(f.fecha_fin,'YYYY/MM/DD') as fecha_final,
		c.UCONS_NOMB as TIPO_CONSERVACION, 
		f.folio_ini as FOLIO_INICIAL,
		f.folio_fin as FOLIO_FINAL, 
		'Por Definir' as SOPORTE,
		f.observaciones as OBSERVACIONES,
		f.num_caja as NUMERO_CAJA,
		f.num_carpeta as NUMERO_CARPETA, 
		f.num_estante as No_Estante, 
		f.num_fila as No_Fila,
		f.num_columna as No_Columna,
		f.num_bandeja as No_Bandeja
		FROM SGD_EXP_FUID f
		INNER JOIN SGD_SEXP_SECEXPEDIENTES s ON f.nume_exp = s.sgd_exp_numero  
		LEFT OUTER JOIN SGD_UNIDAD_CONSERVACION c ON f.cons_id = c.ucons_id  
		LEFT OUTER JOIN SGD_TPR_TPDCUMENTO t ON f.TDOC_CODI = t.SGD_TPR_CODIGO,
	       	SGD_SRD_SERIESRD SRD, SGD_SBRD_SUBSERIERD SBRD
		WHERE 
		s.SGD_SRD_CODIGO = SRD.SGD_SRD_CODIGO 
		AND s.SGD_SBRD_CODIGO = SBRD.SGD_SBRD_CODIGO 
		AND SRD.SGD_SRD_CODIGO = SBRD.SGD_SRD_CODIGO 
		AND	
		((
			".$db->conn->SQLDate('Y/m/d', 'f.fecha_ini')." BETWEEN '$fecha_ini' AND '$fecha_fin' 
		) 
		AND (
			".$db->conn->SQLDate('Y/m/d', 'f.fecha_fin')." < '$fecha_fin' 
		))
		$condicion_serie  
		$condicion_subserie  
		GROUP BY f.nume_exp,c.UCONS_NOMB,t.SGD_TPR_DESCRIP,s.SGD_SEXP_PAREXP1, s.SGD_SEXP_PAREXP2, s.SGD_SEXP_PAREXP3, s.SGD_SEXP_PAREXP4, s.SGD_SEXP_PAREXP5,$concatb 
		ORDER BY $orno $ascdesc  
		";

	//echo $queryEDetalle; exit;
		
//        echo "<pre>$queryETodosDetalle</pre>"; exit;         
	}break;
	case 'oracle':
	case 'oci8':
	case 'oci805':
	case 'ocipo':
	{           
	}break;
}
if(isset($_GET['genDetalle'])&& $_GET['denDetalle']=1){
$titulos= array("1#ORDEN","2#CODIGO TRD","3#NOMBRE DE LA SERIE, SUBSERIE O ASUNTO","4#NUMERO EXPEDIENTE","5#NOMBRE EXPEDIENTE","6#CC O NIT","7#ID EXPEDIENTE","8#OBJETO CTO","9#DESCRIPTOR5","10#FECHA INICIAL","11#FECHA FINAL","12#UNIDAD DE CONSERVACION","13#FOLIO INICIAL","14#FOLIO FINAL","15#SOPORTE","16#OBSERVACIONES","17#NUMERO CAJA","18#NUMERO CARPETA","19#NUMERO ESTANTE","20#NUMERO FILA","21#NUMERO COLUMNA","22#NUMERO BANDEJA");
}
else 		
	$titulos=array("#","1#Expediente","2#Proceso");
		
function pintarEstadistica($fila,$indice,$numColumna)
{
	global $ruta_raiz,$_POST,$_GET,$krd,$usua_doc,$tipoDocumentos;
	$salida="";
	switch ($numColumna)
	{
	case  0:
		$salida=$indice;
		break;
	case 1:	
		$salida=$fila['EXPEDIENTE'];
		break;
	case 2:
		$salida = $fila['TIPO_DOCUMENTO'];
	break;
	default: $salida=false;
	break;
}
	return $salida;
}

function pintarEstadisticaDetalle($fila,$indice,$numColumna)
{
	global $ruta_raiz,$encabezado,$krd, $db;
        include_once "$ruta_raiz/js/funtionImage.php";
        include_once "$ruta_raiz/tx/verLinkArchivo.php";
        $verLinkArchivo = new verLinkArchivo($db);
        $numRadicado=$fila['RADICADO'];	
	switch ($numColumna)
	{
	case 0:
		$salida="<center class=\"leidos\">".$fila['ORDEN']."</center>";		
		break;
	case 1:
		$salida="<center class=\"leidos\">".$fila['CODIGO_TRD']."</center>";		
	         break;
	case 2:
		$salida="<center class=\"leidos\">".$fila['TIPO_DOCUMENTO']."</center>";		
	        break;
	case 3:
		$salida="<center class=\"leidos\">".$fila['EXPEDIENTE']."</center>";		
		break;
	case 4:
		$salida="<center class=\"leidos\">".$fila['NOMBRE_EXP']."</center>";		
		break;
	case 5:
		$salida="<center class=\"leidos\">".$fila['CC_O_NIT']."</center>";		
		break;
	case 6:
		$salida="<center class=\"leidos\">".$fila['ID_EXPEDIENTE']."</center>";		
		break;
	case 7:
		$salida="<center class=\"leidos\">".$fila['OBJETO_CTO']."</center>";		
		break;
	case 8:
		$salida="<center class=\"leidos\">".$fila['DESCRIPTOR5']."</center>";		
		break;
	case 9:
		$salida="<center class=\"leidos\">".$fila['FECHA_INICIAL']."</center>";
		break;
	case 10:
		$salida="<center class=\"leidos\">".$fila['FECHA_FINAL']."</center>";			
		break;	
	case 11:
		$salida="<center class=\"leidos\">".$fila['TIPO_CONSERVACION']."</center>";			
		break;	
	case 12:
		$salida="<center class=\"leidos\">".$fila['FOLIO_INICIAL']."</center>";			
		break;
	case 13:
		$salida="<center class=\"leidos\">".$fila['FOLIO_FINAL']."</center>";			
		break;		
	case 14:
		$salida="<center class=\"leidos\">".$fila['SOPORTE']."</center>";			
		break;
	case 15:
		$salida="<center class=\"leidos\">".$fila['OBSERVACIONES']."</center>";			
		break;
	case 16:
		$salida="<center class=\"leidos\">".$fila['NUMERO_CAJA']."</center>";			
		break;
	case 17:
		$salida="<center class=\"leidos\">".$fila['NUMERO_CARPETA']."</center>";			
		break;
	case 18:
		$salida="<center class=\"leidos\">".$fila['NO_ESTANTE']."</center>";			
		break;
	case 19:
		$salida="<center class=\"leidos\">".$fila['NO_FILA']."</center>";			
		break;
	case 20:
		$salida="<center class=\"leidos\">".$fila['NO_COLUMNA']."</center>";			
		break;
	case 21:
		$salida="<center class=\"leidos\">".$fila['NO_BANDEJA']."</center>";			
		break;
	}
	return $salida;
}
?>
