<?php
/** RADICADOS DE ENTRADA RECIBIDOSç
  * 
  * @autor JAIRO H LOSADA - SSPD
  * @version ORFEO 3.1
  * 
  */
$coltp3Esp = '"'.$tip3Nombre[3][2].'"'; 
if(!$orno) $orno= 1;
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
$whereTipoRadicado  = str_replace("A."," ",$whereTipoRadicado);
$whereTipoRadicado  = str_replace("a."," ",$whereTipoRadicado);
$whereTipoRadicado  = str_replace("r."," ",$whereTipoRadicado);
$whereTipoRadicado  = str_replace("R."," ",$whereTipoRadicado);
$whereTipoRadicado  = str_replace("t."," ",$whereTipoRadicado);
$whereTipoRadicado  = str_replace("b."," ",$whereTipoRadicado);
$whereTipoRadicado  = str_replace("B."," ",$whereTipoRadicado);


//*$condiRep Esta condicion permite que se genere la estadistica con solo una respuesta por radicado
//$db->conn->debug = true;
switch($db->driver)
{ 
  case 'postgres':
  case 'oracle':
  case 'oci8':
  case 'oci805':
  case 'ocipo':
    { if ( $dependencia_busq != 99999)
      { $condicionE = " AND DEPE_CODI_DEST=$dependencia_busq AND DEPE_USUA =$dependencia_busq "; }
    if ( $dependencia_busqOri != 99999)
      { $condicionEDes = " AND DEPE_ORIGEN=$dependencia_busqOri "; }     

	$queryE = "
	  SELECT MIN(USUARIO) USUARIO , count(DISTINCT RADICADO) RADICADOS , 
		COUNT (DISTINCT CASE WHEN radi_nume_salida IS NOT NULL THEN radi_nume_salida ELSE res_asociado END ) TRAMITADOS,
		MIN(USUA_CODI) HID_COD_USUARIO , MIN(depe_usua) HID_DEPE_USUA 
	  FROM tmp_tramite 
	  WHERE 
	      TO_CHAR(hist_fech,'yyyy/mm/dd') BETWEEN '$fecha_ini'  AND '$fecha_fin'  
              $condicionE
              $condicionEDes
              $whereTipoRadicado";
      
      $queryE .= " GROUP BY USUA_LOGIN  ORDER BY $orno $ascdesc ";
      
      /*
       * CONSULTA PARA VER DETALLES 
      */
     //$db->conn->debug = true;
     if ($condiRep == "SI" )
      {	
   
       $queryEDetalle = 
        "SELECT 
         radicado
          , MAX(peticionario) peticionario
	  , MAX(municipio)    municipio
          , MAX(asunto)       asunto
	  , MAX(TO_CHAR(radi_fech_radi, 'DD/MM/YYYY')) fecha_radicacion
	  , MAX(radi_depe_actu) radi_depe_actu
          , MAX(usuario)      usuario
          , MAX(depe_usua)    depe_usua
          , MAX(radi_path)       HID_RADI_PATH
          , MAX(par_serv_secue)  par_serv_secue
          , MAX(par_serv_nombre) par_serv_nombre
          , MAX(sgd_cau_codigo)  sgd_cau_codigo
          , MAX(sgd_cau_descrip) sgd_cau_descrip
          , MAX(sgd_dcau_codigo) sgd_dcau_codigo
	  , MAX(sgd_dcau_descrip) sgd_dcau_descrip
          , MAX(sgd_ddca_codigo)  sgd_ddca_codigo
          , MAX(sgd_ddca_descrip) sgd_ddca_descrip
	  , MAX(sgd_tpr_codigo)   sgd_tpr_codigo
	  , MAX(sgd_tpr_descrip)  sgd_tpr_descrip
          , MAX(sgd_tpr_termino)  sgd_tpr_termino
          , MAX(TO_CHAR(fech_vcmto, 'DD/MM/YYYY')) fecha_vencimiento
          , MAX(dias_vencimiento) dias_vencimiento
          , MAX(radi_nume_salida) radi_nume_salida
          , MAX(anex_radi_fech)   anex_radi_fech
          , MAX(anex_fech_envio)  anex_fech_envio
          , MAX(dias_proyecto)    dias_proyecto
          , MAX(dias_envio)       dias_envio
          , MAX(dias_tramite)     dias_tramite
          , MAX(res_asociado)     res_asociado
          , MAX(fecha_asociado)   fecha_asociado
          , MAX(fech_envio_as)    fech_envio_as
          , MAX(dias_proyecto_as) dias_proyecto_as
          , MAX(dias_envio_as)    dias_envio_as
          , MAX(tramite_as)       tramite_as
          , MAX(anex_fech_anex)   anex_fech_anex
        FROM  tmp_tramite
        WHERE 
          TO_CHAR(hist_fech,'yyyy/mm/dd') BETWEEN '$fecha_ini'  AND '$fecha_fin' 
        $condicionE
        $whereTipoRadicado
        $condicionEDes
        ";
        $agrupamiento = "GROUP BY radicado, peticionario , municipio , asunto ,fecha_radicacion , 
		      radi_depe_actu , usuario , depe_usua , RADI_PATH , par_serv_secue , par_serv_nombre , sgd_cau_codigo , 
		      sgd_cau_descrip , sgd_dcau_codigo , sgd_dcau_descrip , sgd_ddca_codigo , sgd_ddca_descrip , sgd_tpr_codigo , 
		      sgd_tpr_descrip , sgd_tpr_termino , fecha_vencimiento , dias_vencimiento ,  radi_nume_salida, anex_radi_fech ,
                      anex_fech_envio , 
		      dias_proyecto , dias_envio , dias_tramite , res_asociado , fecha_asociado , fech_envio_as , dias_proyecto_as , 
		      dias_envio_as , tramite_as ";

         $agrupamiento = "GROUP BY radicado ";


     }else 
     {
       $queryEDetalle = 
        "SELECT 
         radicado
          , peticionario
	  , municipio
          , asunto
	  , TO_CHAR(radi_fech_radi, 'DD/MM/YYYY') fecha_radicacion
	  , radi_depe_actu
          , usuario
          , depe_usua  
          , radi_path HID_RADI_PATH
          , par_serv_secue
          , par_serv_nombre
          , sgd_cau_codigo
          , sgd_cau_descrip
          , sgd_dcau_codigo
	  , sgd_dcau_descrip
          , sgd_ddca_codigo
          , sgd_ddca_descrip
	  , sgd_tpr_codigo 
	  , sgd_tpr_descrip  
          , sgd_tpr_termino 
          , TO_CHAR(fech_vcmto, 'DD/MM/YYYY') fecha_vencimiento
          , dias_vencimiento
          , radi_nume_salida
          , anex_radi_fech 
          , anex_fech_envio 
          , dias_proyecto  
          , dias_envio 
          , dias_tramite
          , res_asociado
          , fecha_asociado
          , fech_envio_as
          , dias_proyecto_as 
          , dias_envio_as 
          , tramite_as
        FROM  tmp_tramite
        WHERE 
          TO_CHAR(hist_fech,'yyyy/mm/dd') BETWEEN '$fecha_ini'  AND '$fecha_fin' 
        $condicionE
        $whereTipoRadicado
        $condicionEDes
        ";

      }

    if($codEsp) $queryEDetalle .= " AND EESP_CODI = $codEsp ";
    $condicionUS = " AND USUA_CODI=$codUs
                     AND depe_usua = $depeUs "; 
    $orderE = " ORDER BY $orno $ascdesc";

    /** CONSULTA PARA VER TODOS LOS DETALLES 
    */ 
    $queryETodosDetalle = $queryEDetalle . $orderE;
    $queryEDetalle .= $condicionUS . $agrupamiento. $orderE; 

    }break;
}
if(isset($_GET['genDetalle'])&& $_GET['denDetalle']=1)

$titulos=array("#","1#RADICADO","2#PETICIONARIO","3#MUNICIPIO","4#ASUNTO","5#FECHA RADICACION","6#DEPE ACTUAL",
               "7#USUARIO TRAMITE","8#DEPENDENCIA TRAMITE","9#COD SECTOR","10#SECTOR","11#COD CAUSAL","12#CAUSAL","13#COD DETALLE",
               "14#DETALLE","15#COD DES","16#DES","17#COD TIPO","18#TIPO DOCUMENTAL","19#TERMINO","20#FECHA VENCIMIENTO",
	       "21#MORA","22#RESPUESTA", "23#FECH CREAC","24#FECH ENVIO","25#DIAS CREAC","26#DIAS ENVIO","27#DIAS TRAMITE",
               "28#RESPUESTA ASOCIADA","29#FECHA ASOC","30#FECHA ENVIO ASOC",
               "31#DIAS CREAC ASOC","32#DIAS ENVIO ASOC","33#DIAS TRAMITE ASOC");


else    
  $titulos=array("#","1#Usuario","2#Radicados","3#Tramitados");

function pintarEstadistica($fila,$indice,$numColumna)
{
  global $ruta_raiz,$_POST,$_GET,$krd;
  $salida="";
  switch ($numColumna)
  {
    case  0:
      $salida=$indice;
      break;
    case 1: 
      $salida=$fila['USUARIO'];
      break;
    case 2:
      $datosEnvioDetalle="tipoEstadistica=".$_GET['tipoEstadistica']."&amp;genDetalle=1&amp;usua_doc=".urlencode($fila['HID_USUA_DOC'])."&amp;dependencia_busq=".$_GET['dependencia_busq']."&amp;dependencia_busqOri=".$_GET['dependencia_busqOri']."&amp;fecha_ini=".$_GET['fecha_ini']."&amp;fecha_fin=".$_GET['fecha_fin']."&amp;tipoRadicado=".$_GET['tipoRadicado']."&amp;tipoDocumento=".$_GET['tipoDocumento']."&amp;codUs=".$fila['HID_COD_USUARIO']."&amp;depeUs=".$fila['HID_DEPE_USUA'];
      $datosEnvioDetalle=(isset($_GET['usActivos']))?$datosEnvioDetalle."&codExp=$codExp&amp;usActivos=".$_GET['usActivos']:$datosEnvioDetalle;
      $datosEnvioDetalle=(isset($_GET['conSinRep']))?$datosEnvioDetalle."&condiRep=SI":$datosEnvioDetalle."&condiRep=NO";
      $salida="<a href=\"genEstadistica.php?{$datosEnvioDetalle}&codEsp=".$_GET["codEsp"]."&amp;krd={$krd}\"  target=\"detallesSec\" >".$fila['RADICADOS']."</a>";
      break;
    case 3:
      $salida=$fila['TRAMITADOS'];
      break;
    default: $salida=false;
  }
return $salida;
}
//$db->conn->debug = true;
function pintarEstadisticaDetalle($fila,$indice,$numColumna){
      global $ruta_raiz,$encabezado,$krd,$db,$radi_anterior;
        include_once "$ruta_raiz/js/funtionImage.php";
        include_once "$ruta_raiz/tx/verLinkArchivo.php";
        $verLinkArchivo = new verLinkArchivo($db);
	$numRadicado=$fila['RADICADO'];	
        switch ($numColumna){
          case 0:
            $salida=$indice;
            break;
          case 1:
            if($fila['HID_RADI_PATH'])
                  {
                    $radi = $fila['RADICADO'];
                    $resulVali = $verLinkArchivo->valPermisoRadi($radi);
                    $valImg = $resulVali['verImg'];
                    if($valImg == "SI")
                      $salida="<center><a class=\"vinculos\" href=\"#2\" onclick=\"funlinkArchivo('$radi','$ruta_raiz');\">".$fila['RADICADO']."</a></center>";
                    else
		       $salida="<center><a class=vinculos href=javascript:noPermiso()>".$fila['RADICADO']."</a></center>";
                    } else   
                      $salida="<center class=\"leidos\">{$numRadicado}</center>";
            break;
	  case 2:
            $salida="<center class=\"leidos\">".$fila['PETICIONARIO']."</center>";
            break;
          case 3:
            $salida="<center class=\"leidos\">".$fila['MUNICIPIO']."</center>";
            break;
          case 4:
              $salida="<center class=\"leidos\">".$fila['ASUNTO']."</center>";
              break;
          case 5:
		$radi = $fila['RADICADO'];
                $resulVali = $verLinkArchivo->valPermisoRadi($radi);
                $valImg = $resulVali['verImg'];
		if($valImg == "SI")
		   $salida="<a class=\"vinculos\" href=\"{$ruta_raiz}verradicado.php?verrad=".$fila['RADICADO']."&amp;".session_name()."=".session_id()."&amp;krd=".$_GET['krd']."&amp;carpeta=8&amp;nomcarpeta=Busquedas&amp;tipo_carp=0 \" >".$fila['FECHA_RADICACION']."</a>";
		 else 
                    $salida="<a class=vinculos href=javascript:noPermiso()>".$fila['FECHA_RADICACION']."</a>";
                 break;
          case 6:
		$salida="<center class=\"leidos\">".$fila['RADI_DEPE_ACTU']."</center>";    
		break;
          case 7:
		$salida="<center class=\"leidos\">".$fila['USUARIO']."</center>";
		break;
          case 8:
		$salida="<center class=\"leidos\">".$fila['DEPE_USUA']."</center>";    
		break;
          case 9:
		$salida="<center class=\"leidos\">".$fila['PAR_SERV_SECUE']."</center>";    
		break;
          case 10:
		$salida="<center class=\"leidos\">".$fila['PAR_SERV_NOMBRE']."</center>";    
		break;
          case 11:
		$salida="<center class=\"leidos\">".$fila['SGD_CAU_CODIGO']."</center>";    
		break;
          case 12:
		$salida="<center class=\"leidos\">".$fila['SGD_CAU_DESCRIP']."</center>";    
		break;
          case 13:
		$salida="<center class=\"leidos\">".$fila['SGD_DCAU_CODIGO']."</center>";    
		break;
          case 14:
		$salida="<center class=\"leidos\">".$fila['SGD_DCAU_DESCRIP']."</center>";    
		break;
          case 15:
		$salida="<center class=\"leidos\">".$fila['SGD_DDCA_CODIGO']."</center>";    
		break;
          case 16:
		$salida="<center class=\"leidos\">".$fila['SGD_DDCA_DESCRIP']."</center>";    
		break;
          case 17:
		$salida="<center class=\"leidos\">".$fila['SGD_TPR_CODIGO']."</center>";    
		break;
          case 18:
		$salida="<center class=\"leidos\">".$fila['SGD_TPR_DESCRIP']."</center>";    
		break;
          case 19:
		$salida="<center class=\"leidos\">".$fila['SGD_TPR_TERMINO']."</center>";    
		break;
          case 20:
		$salida="<center class=\"leidos\">".$fila['FECHA_VENCIMIENTO']."</center>";    
		break;
          case 21:
		$salida="<center class=\"leidos\">".$fila['DIAS_VENCIMIENTO']."</center>";    
		break;
          case 22:
		$salida="<center class=\"leidos\">".$fila['RADI_NUME_SALIDA']."</center>";    
		break;
          case 23:
		$salida="<center class=\"leidos\">".$fila['ANEX_RADI_FECH']."</center>";    
		break;
          case 24:
		$salida="<center class=\"leidos\">".$fila['ANEX_FECH_ENVIO']."</center>";    
		break;
          case 25:
		$salida="<center class=\"leidos\">".$fila['DIAS_PROYECTO']."</center>";    
		break;
          case 26:
		$salida="<center class=\"leidos\">".$fila['DIAS_ENVIO']."</center>";    
		break;
          case 27:
		$salida="<center class=\"leidos\">".$fila['DIAS_TRAMITE']."</center>";    
		break;
          case 28:
		$salida="<center class=\"leidos\">".$fila['RES_ASOCIADO']."</center>";    
		break;
	  case 29:
		$salida="<center class=\"leidos\">".$fila['FECHA_ASOCIADO']."</center>";    
		break;
	  case 30:
		$salida="<center class=\"leidos\">".$fila['FECHA_ENVIO_AS']."</center>";    
		break;
	  case 31:
		$salida="<center class=\"leidos\">".$fila['DIAS_PROYECTO_AS']."</center>";    
		break;
	  case 32:
		$salida="<center class=\"leidos\">".$fila['DIAS_ENVIO_AS']."</center>";    
		break;
	  case 33:
		$salida="<center class=\"leidos\">".$fila['TRAMITE_AS']."</center>";    
		break;
      }
     
      return $salida;
    }
?>                                                         