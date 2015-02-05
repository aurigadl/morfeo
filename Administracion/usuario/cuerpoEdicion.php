<?php
/**
* @module crearUsuario
*
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
$ruta_raiz = "../..";
  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$tip3Nombre  = $_SESSION["tip3Nombre"];
$tip3desc    = $_SESSION["tip3desc"];
$tip3img     = $_SESSION["tip3img"];

$nomcarpeta=$_GET["carpeta"];
$tipo_carpt=$_GET["tipo_carpt"];
$adodb_next_page=$_GET["adodb_next_page"];
if($_GET["dep_sel"]) $dep_sel=$_GET["dep_sel"];
if($_GET["orderTipo"]) $orderTipo=$_GET["orderTipo"];
if($_GET["busqRadicados"]) $busqRadicados=$_GET["busqRadicados"];
if($_GET["busq_radicados"]) $busq_radicados=$_GET["busq_radicados"];
if($_GET["depeBuscada"]) $depeBuscada=$_GET["depeBuscada"];

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$ano_ini = date("Y");
$mes_ini = substr("00".(date("m")-1),-2);
if ($mes_ini==0) {$ano_ini=$ano_ini-1; $mes_ini="12";}
$dia_ini = date("d");
$ano_ini = date("Y");
if(!$fecha_ini) $fecha_ini = "$ano_ini/$mes_ini/$dia_ini";
$fecha_fin = date("Y/m/d") ;
$where_fecha="";
$radSelec = "";
?>
<html>
<head>
<title>Administracion...</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body>
<div id="spiffycalendar" class="text"></div>
<?php
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
 $db = new ConnectionHandler("$ruta_raiz");
 if (!$dep_sel) $dep_sel = $_SESSION['dependencia'];
 $nomcarpeta = "Modificacion Usuarios";

 if ($busq_radicados){
	 $busq_radicados = trim($busq_radicados);
	 $textElements = split (",", $busq_radicados);
	 $newText = "";
	 $i = 0;
	 foreach ($textElements as $item)  {
		 $item = trim ( $item );
		 if ( strlen ( $item ) != 0 ) {
			 $i++;
			 if ($i > 1) $busq_and = " and "; else $busq_and = " ";
			 $busq_radicados_tmp .= " $busq_and radi_nume_sal like '%$item%' ";
		 }
	 }
	 $dependencia_busq1 .= " and $busq_radicados_tmp ";

 }else  {
    $sql_masiva = "";
 }

 if ($orden_cambio==1)  {
 	if (!$orderTipo)  {
	   $orderTipo="desc";
	}else  {
	   $orderTipo="";
	}
 }
 $encabezado = session_name()."=".session_id()."&pagina_sig=$pagina_sig&accion_sal=$accion_sal&radSelec=$radSelec&dependencia=$dependencia&dep_sel=$dep_sel&selecdoc=$selecdoc&nomcarpeta=$nomcarpeta&orderTipo=$orderTipo&orderNo=";
 $linkPagina = "$PHP_SELF?$encabezado&radSelec=$radSelec&accion_sal=$accion_sal&nomcarpeta=$nomcarpeta&orderTipo=$orderTipo&orderNo=$orderNo";
 $carpeta = "nada";
 $swBusqDep = "si";
 $reasigna = 0 ;
 $pagina_actual = "../usuario/cuerpoEdicion.php";
 include "../paEncabeza.php";

 $tituloBuscar = "Buscar Usuario(s) (Separados por coma)";
 $varBuscada = "usua_nomb";
 $varBuscada2 = "usua_login";
 include "../paBuscar.php";
 $pagina_sig = "../usuario/crear.php";
 $accion_sal = "Editar";
 include "../paOpciones.php";

 if($busq_radicados_tmp)  {
   $where_fecha=" ";
 }
 else  {
    $fecha_ini = mktime(00,00,00,substr($fecha_ini,5,2),substr($fecha_ini,8,2),substr($fecha_ini,0,4));
	$fecha_fin = mktime(23,59,59,substr($fecha_fin,5,2),substr($fecha_fin,8,2),substr($fecha_fin,0,4));
    $where_fecha = " (a.SGD_RENV_FECH >= ". $db->conn->DBTimeStamp($fecha_ini) ." and a.SGD_RENV_FECH <= ". $db->conn->DBTimeStamp($fecha_fin).") " ;
    $dependencia_busq1 .= " $where_fecha and ";
 }

	/*  GENERACION LISTADO DE RADICADOS
	 *  Aqui utilizamos la clase adodb para generar el listado de los radicados
	 *  Esta clase cuenta con una adaptacion a las clases utiilzadas de orfeo.
	 *  el archivo original es adodb-pager.inc.php la modificada es adodb-paginacion.inc.php
	 */

?>
  <form name="formEnviar" action='crear.php?<?=$encabezado?>' method=GET>
  <input type="hidden" name="usModo" value="2">
  <input type="hidden" name="dep_sel" value="<?=$dep_sel?>">
  <input type="hidden" name="<?=session_name()?>" value="<?=session_id()?>"> 
 <?php
    if ($orderNo==98 or $orderNo==99) {
       $order=1;
	   if ($orderNo==98)   $orderTipo="desc";

       if ($orderNo==99)   $orderTipo="";
	}
    else  {
	   if (!$orderNo)  {
  		  $orderNo=0;
	   }
	   $order = $orderNo + 1;
    }
	$sqlChar = $db->conn->SQLDate("d-m-Y H:i A","SGD_RENV_FECH");
	$sqlConcat = $db->conn->Concat("a.radi_nume_sal","'-'","a.sgd_renv_codigo","'-'","a.sgd_fenv_codigo","'-'","a.sgd_renv_peso");
	include "$ruta_raiz/include/query/administracion/queryCuerpoEdicion.php";
  
  $rs=$db->conn->Execute($isql);
	$nregis = $rs->fields["USUA_NOMB"];
	if ($nregis)  {
		echo "<hr><center><b>NO se encontro nada con el criterio de busqueda</center></b></hr>";}
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
