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

$ruta_raiz = ".";
if (!$_SESSION['dependencia'])
  header ("Location: $ruta_raiz/cerrar_session.php");
define('ADODB_ASSOC_CASE', 2);
$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc = $_SESSION["usua_doc"];
$codusuario = $_SESSION["codusuario"];
$tip3Nombre=$_SESSION["tip3Nombre"];
$tip3desc = $_SESSION["tip3desc"];
$tip3img =$_SESSION["tip3img"];

$nomcarpeta = (isset($_GET["carpeta"]))? $_GET["carpeta"] : '';
$tipo_carpt = $_GET["tipo_carpt"];

$adodb_next_page = (isset($_GET["adodb_next_page"]))? $_GET["adodb_next_page"] : '';

if(isset($_GET["orderNo"])) $orderNo=$_GET["orderNo"];
if(isset($_GET["orderTipo"])) $orderTipo=$_GET["orderTipo"];
if(isset($_GET["busqRadicados"])) $busqRadicados=$_GET["busqRadicados"];
if(isset($_GET["busq_radicados"])) $busq_radicados=$_GET["busq_radicados"];
if(isset($_GET["depeBuscada"])) $depeBuscada=$_GET["depeBuscada"];
if(isset($_GET["filtroSelec"])) $filtroSelec=$_GET["filtroSelec"];
if(isset($_GET["carpeta"])) $carpeta=$_GET["carpeta"];
if(isset($_GET["agendado"])) $agendado=$_GET["agendado"];

$ruta_raiz = ".";

$verrad = "";
?>
<html>
<html>

  <title>Sistema de informaci&oacute;n <?=$entidad_largo?></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap core CSS -->
  <?php include_once "htmlheader.inc.php"; ?>
  <script src="./js/popcalendar.js"></script>
  <script src="./js/mensajeria.js"></script>
<div id="spiffycalendar" class="text"></div>
<?php include_once "$ruta_raiz/js/funtionImage.php"; ?>
</head>
<?
include "./envios/paEncabeza.php";
?>
<body class="smart-form" topmargin="0" onLoad="window_onload();">

<?php
include_once "./include/db/ConnectionHandler.php";
require_once("$ruta_raiz/class_control/Mensaje.php");
if (!$db) $db = new ConnectionHandler($ruta_raiz);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
$objMensaje= new Mensaje($db);
$mesajes = $objMensaje->getMsgsUsr($_SESSION['usua_doc'],$_SESSION['dependencia']);

if ($swLog==1)
  echo ($mesajes);
if(trim($orderTipo)=="") $orderTipo="DESC";

if($orden_cambio==1) {
  $orderTipo = (trim($orderTipo)!="DESC")? 'DESC' : 'ASC';
}

if(!$carpeta) $carpeta=0;
if($busqRadicados)
{
  $busqRadicados = trim($busqRadicados);
  $textElements = split (",", $busqRadicados);
  $newText = "";
  $dep_sel = $dependencia;
  foreach ($textElements as $item)
  {
    $item = trim ( $item );
    if ( strlen ( $item ) != 0) {
      $busqRadicadosTmp .= " b.radi_nume_radi like '%$item%' or";
    }
  }
  if(substr($busqRadicadosTmp,-2)=="or")
  {
    $busqRadicadosTmp = substr($busqRadicadosTmp,0,strlen($busqRadicadosTmp)-2);
  }
  if(trim($busqRadicadosTmp))
  {
    $whereFiltro .= "and ( $busqRadicadosTmp ) ";
  }

}
$encabezado = "".session_name()."=".session_id()."&depeBuscada=$depeBuscada&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion&carpeta=8&tipo_carp=$tipo_carp&chkCarpeta=$chkCarpeta&busqRadicados=$busqRadicados&nomcarpeta=Agendados&agendado=$agendado&";
$linkPagina = "$PHP_SELF?$encabezado&orderTipo=$orderTipo&orderNo=$orderNo&carpeta=8";
$encabezado = "".session_name()."=".session_id()."&adodb_next_page=1&depeBuscada=$depeBuscada&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion&carpeta=8&tipo_carp=$tipo_carp&nomcarpeta=Agendados&agendado=$agendado&orderTipo=$orderTipo&orderNo=";
?>
<TABLE  class="table table-bordered">
<tr >
  <TD >
  <span class="etextomenu">
  <FORM name="form_busq_rad" id="form_busq_rad" action='<?=$_SERVER['PHP_SELF']?>?<?=$encabezado?>' method="GET">
      Buscar radicado(s) (Separados por coma)<span class="etextomenu">
         <input name="busqRadicados" type="text" size="40" class="tex_area" value="<?=$busqRadicados?>">
         <input type=submit value='Buscar ' name=Buscar valign='middle' class='botones'>
        </span>
<?php
/**
 * Este if verifica si se debe buscar en los radicados de todas las carpetas.
 * @$chkCarpeta char  Variable que indica si se busca en todas las carpetas.
 *
 */
if($chkCarpeta)
{
  $chkValue=" checked ";
  $whereCarpeta = " ";
}
else
{
  $chkValue="";
  if(!$tipo_carp) $tipo_carp = "0";
  $whereCarpeta = " and b.carp_codi=$carpeta  and b.carp_per=$tipo_carp";
}



$fecha_hoy = Date("Y-m-d");
$sqlFechaHoy=$db->conn->DBDate($fecha_hoy);

//Filtra el query para documentos agendados

?>
   <input type="checkbox" name="chkCarpeta" value=xxx <?=$chkValue?> > Todas las carpetas
   <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
  </form>
       </span>
      </td>
      </tr>
   </table>

<form name="form1" id="form1" action="./tx/formEnvio.php?<?=$encabezado?>" method="GET" class="smart-form">
  <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
<?php
$controlAgenda=1;
if($carpeta==11 and !$tipo_carp and $codusuario!=1)
{
}else
{
  include "./tx/txOrfeo.php";
}
/*  GENERACION LISTADO DE RADICADOS
 *  Aqui utilizamos la clase adodb para generar el listado de los radicados
 *  Esta clase cuenta con una adaptacion a las clases utiilzadas de orfeo.
 *  el archivo original es adodb-pager.inc.php la modificada es adodb-paginacion.inc.php
 *
 */

if(strlen($orderNo)==0)
{
  $orderNo="2";
  $order = 3;
}else
{
  $order = $orderNo +1;
}

$sqlFecha = $db->conn->SQLDate("Y-m-d H:i A","b.RADI_FECH_RADI");
//$sqlFecha = $db->conn->DBDate("b.RADI_FECH_RADI", "d-m-Y H:i A");
//$sqlFecha = $db->conn->DBTimeStamp("b.RADI_FECH_RADI","" ,"Y-m-d H:i:s");
//$db->SQLDate('Y-\QQ');
include "$ruta_raiz/include/query/queryCuerpoAgenda.php";
$rs=$db->conn->Execute($isql);
if ($rs->EOF and $busqRadicados)  {
  echo "<hr><center><b><span class='alarmas'>No se encuentra ningun radicado con el criterio de busqueda</span></center></b></hr>";
}
else{
  $pager = new ADODB_Pager($db,$isql,'adodb', true,$orderNo,$orderTipo);
  $pager->checkAll = false;
  $pager->checkTitulo = true;
  $pager->toRefLinks = $linkPagina;
  $pager->toRefVars = $encabezado;
  $pager->descCarpetasGen=$descCarpetasGen;
  $pager->descCarpetasPer=$descCarpetasPer;
  if($_GET["adodb_next_page"]) $pager->curr_page = $_GET["adodb_next_page"];
  $pager->Render($rows_per_page=20,$linkPagina,$checkbox=chkAnulados);


}
?>
  </form>
</tr>
</td>
</table>
</body>
</html>
