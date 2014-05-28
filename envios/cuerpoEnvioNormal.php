<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
Copyright (C) 2013 Infometrika Ltda.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

session_start();

    $ruta_raiz = "..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
    
    
$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$tip3Nombre  = $_SESSION["tip3Nombre"];
$tip3desc    = $_SESSION["tip3desc"];
$tip3img     = $_SESSION["tip3img"];

/*
 * Lista Subseries documentales
 * @autor Jairo Losada
 * @fecha 2009/06 Modificacion Variables Globales. Arreglo cambio de los request Gracias a recomendacion de Hollman Ladino
 */

foreach ($_POST as $key => $valor)   ${$key} = $valor;
foreach ($_GET as $key => $valor)   ${$key} = $valor;


if (!$dep_sel) $dep_sel = $dependencia;
?>
<html>
<head>
  <title>Sistema de informaci&oacute;n <?=$entidad_largo?></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap core CSS -->
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body >

<?php
 include_once "$ruta_raiz/js/funtionImage.php";
 include_once "$ruta_raiz/include/db/ConnectionHandler.php";
 $db = new ConnectionHandler("$ruta_raiz");	 
 if(!$carpeta) $carpeta=0;
 if(!$estado_sal)   {$estado_sal=2;}
 if(!$estado_sal_max) $estado_sal_max=3;

 if($estado_sal==3 && (!$bTodasDep && !$busqradicados  )  ) {
    $accion_sal = "Envio de Documentos";
	$pagina_sig = "cuerpoEnvioNormal.php";
	$nomcarpeta = "Radicados Para Envio";
	if(!$dep_sel) $dep_sel = $dependencia;
	$dependencia_busq1 = " and c.radi_depe_radi = $dep_sel ";
	$dependencia_busq2 = " and c.radi_depe_radi = $dep_sel";
 }
$accion_sal = "Envio de Documentos";
 
  if ($orden_cambio==1)  {
 	if (!$orderTipo)  {
	   $orderTipo="desc";
	}else  {
	   $orderTipo="";
	}
 }

 $encabezado = "".session_name()."=".session_id()."&estado_sal_max=$estado_sal_max&accion_sal=$accion_sal&dependencia_busq2=$dependencia_busq2&dep_sel=$dep_sel&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion&nomcarpeta=$nomcarpeta&orderTipo=$orderTipo&orderNo=";
 $linkPagina = "$PHP_SELF?$encabezado&orderNo = $orderNo";
 $swBusqDep  = "si";
 $carpeta    = "nada";
 $swListar   = "Si";
 include "$ruta_raiz/envios/paEncabeza.php";
 include "$ruta_raiz/envios/paBuscar.php";   
 include "$ruta_raiz/envios/paOpciones.php";   
 $pagina_actual = "$ruta_raiz/envios/cuerpoEnvioNormal.php";
 $varBuscada    = "radi_nume_salida";
 $pagina_sig    = "$ruta_raiz/envios/envia.php";

 /*  GENERACION LISTADO DE RADICADOS
 *  Aqui utilizamos la clase adodb para generar el listado de los radicados
 *  Esta clase cuenta con una adaptacion a las clases utiilzadas de orfeo.
 *  el archivo original es adodb-pager.inc.php la modificada es adodb-paginacion.inc.php
 */
 
?>

 <form name=formEnviar action='../envios/envia.php?<?=$encabezado?>' method=GET class="smart_form">
	<input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'> 
	<input type='hidden' name='estado_sal' value='<?= $estado_sal ?>'>
	<input type='hidden' name='estado_sal_max' value='<?= $estado_sal_max ?>'>
  <?php 
    if ($orderNo==98 or $orderNo==99) {
       $order=1; 
	   if ($orderNo==98)   $orderTipo="desc";
       if ($orderNo==99)   $orderTipo="";
	}  
    else  {
	   if (!$orderNo)  {
	   		$orderNo=3;
			$orderTipo="desc";
		}
	   $order = $orderNo + 1;
    }

 	$radiPath = $db->conn->Concat($db->conn->substr."(a.anex_codigo,1,4) ", "'/'",$db->conn->substr."(a.anex_codigo,5,3) ","'/docs/'","a.anex_nomb_archivo");
 	include "$ruta_raiz/include/query/envios/queryCuerpoEnvioNormal.php";
//    echo $isql;
	echo "<hr>";
    $rs=$db->conn->Execute($isql);
	if ($rs->EOF){
        echo "<table class='table table-bordered' ><tr><td class=titulosError><center>NO se encontro nada con el criterio de busqueda</center></td></tr></table>";
    }
	else  {
		$pager = new ADODB_Pager($db,$isql,'adodb', true,$orderNo,$orderTipo);
		$pager->toRefLinks = $linkPagina;
		$pager->toRefVars = $encabezado;
		$pager->Render($rows_per_page=120,$linkPagina,$checkbox=chkEnviar);
	}
 ?>
  </form>
</body>
</html>
