<?php
session_start();

    $ruta_raiz = ".."; 
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
    
foreach ($_GET  as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

//print_r($_POST);
if($_POST["usCodSelect"]) $usCodSelect = $_POST["usCodSelect"];	

$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$depe_nomb   = $_SESSION["depe_nomb"];
$usua_nomb   = $_SESSION["usua_nomb"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$fechaAgenda = $_POST["fechaAgenda"];


/*  REALIZAR TRANSACCIONES
 *  Este archivo realiza las transacciones de radicados en Orfeo.
 */
?>
<html>
<head>
<title>Realizar Transaccion - Orfeo </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<?php
 include_once $ruta_raiz."/htmlheader.inc.php";
?>
</head>
<?php
/**
  * Inclusion de archivos para utiizar la libreria ADODB
  *
  */
   include_once "$ruta_raiz/include/db/ConnectionHandler.php";
   $db = new ConnectionHandler("$ruta_raiz");
 /*
	* Genreamos el encabezado que envia las variable a la paginas siguientes.
	* Por problemas en las sesiones enviamos el usuario.
	* @$encabezado  Incluye las variables que deben enviarse a la singuiente pagina.
	* @$linkPagina  Link en caso de recarga de esta pagina.
	*/
	$encabezado = "".session_name()."=".session_id()."&depeBuscada=$depeBuscada&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion";

   if($checkValue){
       $num = count($checkValue);
       $i = 0;
       while ($i < $num)
       {
           $record_id = key($checkValue);
           $setFiltroSelect .= $record_id ;
           $radicadosSel[] = $record_id;
           if($i<=($num-2))
           {
               $setFiltroSelect .= ",";
           }
           next($checkValue);
           $i++;
       }
       if ($radicadosSel)
       {
           $whereFiltro = " and b.radi_nume_radi in($setFiltroSelect)";
       }
   }
   
   if($setFiltroSelect){
       $filtroSelect = $setFiltroSelect;
   }
?>
<body>
<?php
$txSql = "";
if($chkNivel and $codusuario==1)
{
	$tomarNivel = "si";
}
else
{
	$tomarNivel = "no";
}
include "$ruta_raiz/include/tx/Tx.php";

$rs = new Tx($db);

foreach($radicadosSel as $rad){				
	$radicadosSelText  .= $rad. ", ";
	$rutaImagen          = substr($rad,0,4)."/".substr($rad,4,3)."/".$rad.".tif";
	$linkImagenes      .= "<a href='*SERVIDOR_IMAGEN*".$rutaImagen."'>$rad</a> - ";
}

    include_once("$ruta_raiz/class_control/Param_admin.php");
	$param = Param_admin::getObject($db,'%','ALERT_FUNCTION');

switch ($codTx){
	case 7:
		$nombTx = "Borrar Informados";
		$observa = "($krd) $observa";
		$radicadosSel = $rs->borrarInformado( $radicadosSel, $krd,$depsel8,$_SESSION['dependencia'],$_SESSION['codusuario'], $codusuario,$observa);
		break;
	case 8:
		{
		  echo "> $chkConjunto";
              if(is_array($_POST['usCodSelect']))
                while (list(,$var)=each($_POST['usCodSelect']))
                {	$depsel8 = split('-',$var);
				$usCodSelect = $depsel8[1];
				$depsel8 = $depsel8[0];
				$nombTx = "Informar Documentos";
				if($_POST["chkConjunto"]=="Si") $infConjunto="1"; else $infConjunto="0";
				echo ">> $infConjunto ";
				$usCodDestino .= $rs->informar( $radicadosSel, $krd,$depsel8,$dependencia,$usCodSelect, $codusuario,$observa,$_SESSION['usua_doc'],'',$infConjunto).", ";
			}
			$usCodDestino = substr($usCodDestino,0,strlen(trim($usCodDestino))-1);
		}
		break;
	case 9:
		$depsel = split('-',$usCodSelect);
		$usCodSelect = $depsel[1];
		$depsel = $depsel[0];
		if($EnviaraV=="VoBo"){
			$codTx=16;
			$carp_codi=11;

		if($param->PARAM_VALOR=="1"){ // COMPRUEBO SI LA FUNCION DE ALERTAS ESTA ACTIVA
                 foreach($radicadosSel as $rad){			
		   $rs->registrarNovedad('NOV_VOBO', $usCodSelect,$rad, $ruta_raiz);
		    }
		  }
		}else{
			$codTx=9;
			$carp_codi=0;

		}
		if($fechaAgenda){
       		 $nombTx = "Agendar Documentos, ";
		 $txSql = $rs->agendar( $radicadosSel, $krd,$dependencia,$codusuario,$observa, $fechaAgenda);
		}
		$nombTx .= "Reasignar Documentos ";
		$usCodDestino = $rs->reasignar( $radicadosSel, $krd,$depsel,$dependencia,$usCodSelect, $codusuario,$tomarNivel, $observa,$codTx,$carp_codi);
		break;

	case 10:
		$nombTx = "Movimiento a Carpeta $carpetaNombre";
		$okTx = $rs->cambioCarpeta( $radicadosSel, $krd,$carpetaCodigo,$carpetaTipo,$tomarNivel, $observa);
		$depSel = $dependencia;
		$usCodSelect = $codusuario;
		$usCodDestino = $usua_nomb;
		break;

	case 12:
		$nombTx = "Devolucion de Documentos";
		$usCodDestino = $rs->devolver( $radicadosSel, $krd,$dependencia, $codusuario,$tomarNivel, $observa);
		break;

	case 13:
		$nombTx = "Archivo de Documentos";
		$txSql = $rs->archivar( $radicadosSel, $krd,$dependencia,$codusuario,$observa);
		break;

	case 14:
		$nombTx = "Agendar Documentos";
		$txSql = $rs->agendar( $radicadosSel, $krd,$dependencia,$codusuario,$observa, $fechaAgenda);
		break;
	case 15:
		$nombTx = "Sacar de 'Agendar Documentos'";
		$txSql = $rs->noAgendar( $radicadosSel, $krd,$dependencia,$codusuario,$observa);
		break;
	case 16:
		$nombTx = "Radicados NRR";
		$txSql = $rs->nrr( $radicadosSel, $krd,$dependencia,$codusuario,$observa);
		break;
}
if($okTx== -1)  $okTxDesc = " No ";

?>
<div id="content" style="opacity: 1; width=80%;">
<div class="well well-sm well-light" style="opacity: 1; width=80%;">
<div class="widget-body" style="opacity: 1; width=80%;">
<div id="wid-id-0" class="jarviswidget jarviswidget-color-orange jarviswidget-sortable" data-widget-editbutton="false" role="widget" style="opacity: 1; width=80%;">
<header role="heading" style="opacity: 1; width=80%;">

<span class="widget-icon">
<h2>Transacciones</h2>
<span class="jarviswidget-loader">
</header>

<form action='enviardatos.php' method=post name=formulario>
<input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'> 
<br>
<table WIDTH=50%  class="table table-striped table-bordered table-hover dataTable" id=tb_general align="center">
	<tr>
	<td colspan="2" >ACCION REQUERIDA <?=$accionCompletada?>  <?=$okTxDesc?> COMPLETADA <?=$causaAccion ?> </td>
	</tr>
	<tr>
	<td align="right"  height="25" >ACCION REQUERIDA :
	</td>
	<td  width="65%" height="25" >
	<?=$nombTx?>
	</td>
	</tr>
	<tr>
	<td align="right" height="25" class="titulos2">RADICADOS INVOLUCRADOS :
	</td>
	<td  width="65%" height="25" class="listado2_no_identa"><?=join("<BR> ",$radicadosSel)?>
	</td>
	</tr>
	<tr>
	<td align="right"height="25" >USUARIO DESTINO :
	</td>
	<td  width="65%" height="25" >
	<?=$usCodDestino?>
	</td>
	</tr>
	<tr>
	<td align="right"  height="25" >FECHA Y HORA :
	</td>
	<td  width="65%" height="25" >
	<?=date("m-d-Y  H:i:s")?>
	</td>
	</tr>
	<tr>
	<td align="right" height="25" class="titulos2">USUARIO ORIGEN:
	</td>
	<td  width="65%" height="25" class="listado2_no_identa">
	<?=$usua_nomb?>
	</td>
	</tr>
	<tr>
	<td align="right"  height="25" class="titulos2">DEPENDENCIA ORIGEN:
	</td>
	<td  width="65%" height="25" class="listado2_no_identa">
	<?=$depe_nomb?>
	</td>
	</tr>
	<tr>
	<td class="listado2_no_identa" colspan=2>
<?php
echo $_SESSION["enviarMailMovimientos"]; 
if($_SESSION["enviarMailMovimientos"]==1){
    if($codTx==9 || $codTx==8){
        if (is_array($_POST['usCodSelect']))
        { 
            foreach($_POST['usCodSelect'] as $value)
            {
                $depsel8 = split('-',$value);
                $usuaCodiMail = $depsel8[1];
                $depeCodiMail = $depsel8[0];
                include "$ruta_raiz/include/mail/mailInformar.php";
            }
        }else{
            $depsel8 = split('-',$_POST['usCodSelect']);
            $usuaCodiMail = $depsel8[1];
            $depeCodiMail = $depsel8[0];
            include "$ruta_raiz/include/mail/mailInformar.php";
        }
    }
}
?>
</td>
</tr>
	
</table>
</div>
</div>
</div>
</div>
</form>
</body>
</html>
