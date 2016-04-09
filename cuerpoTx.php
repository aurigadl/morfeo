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
any later version.

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

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

define('ADODB_ASSOC_CASE', 2);
$verrad         = "";
$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];
$verrad         = "";
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
  <script src="./js/popcalendar.js"></script>
  <script src="./js/mensajeria.js"></script>
  <div id="spiffycalendar" class="text"></div>
</head>
<?
$nomcarpeta = "Ultimas Transacciones Realizadas";
include "./envios/paEncabeza.php";
?>
<body onLoad="window_onload();">

<?
   include_once "./include/db/ConnectionHandler.php";
   require_once("$ruta_raiz/class_control/Mensaje.php");
   if (!$db) $db = new ConnectionHandler($ruta_raiz);
   $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
   $objMensaje= new Mensaje($db);
   $mesajes = $objMensaje->getMsgsUsr($_SESSION['usua_doc'],$_SESSION['dependencia']);

if ($swLog==1)
	echo ($mesajes);
	  if(trim($orderTipo)=="") $orderTipo="DESC";
  if($orden_cambio==1){
	  if(trim($orderTipo)!="DESC"){
		   $orderTipo="DESC";
		}else{
			$orderTipo="ASC";
		}
	}

	if(!$carpeta) $carpeta=0;

	if($busqRadicados){
    $busqRadicados = trim($busqRadicados);
    $textElements  = split (",", $busqRadicados);
    $newText       = "";
    $dep_sel       = $dependencia;
    foreach ($textElements as $item){
      $item = trim ( $item );
      if ( strlen ( $item ) != 0) {
          $busqRadicadosTmp .= " r.radi_nume_radi like '%$item%' or";
      }
    }

    if(substr($busqRadicadosTmp,-2)=="or"){
      $busqRadicadosTmp = substr($busqRadicadosTmp,0,strlen($busqRadicadosTmp)-2);
    }

    if(trim($busqRadicadosTmp)){
      $whereFiltro .= "and ( $busqRadicadosTmp ) ";
    }
	}
   $encabezado = "".session_name()."=".session_id()."&krd=$krd&depeBuscada=$depeBuscada&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion&carpeta=8&tipo_carp=$tipo_carp&chkCarpeta=$chkCarpeta&nomcarpeta=$nomcarpeta&&busqRadicados=$busqRadicados&";
   $linkPagina = "$PHP_SELF?$encabezado&orderTipo=$orderTipo&orderNo=$orderNo&carpeta=8";
   $encabezado = "".session_name()."=".session_id()."&adodb_next_page=1&krd=$krd&depeBuscada=$depeBuscada&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion&carpeta=8&tipo_carp=$tipo_carp&nomcarpeta=$nomcarpeta&orderTipo=$orderTipo&orderNo=";
?>
<div class="col-sm-12"> <!-- widget grid -->
  <section>
    <!-- row -->
    <div class="row">
      <!-- NEW WIDGET START -->
      <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="well" data-widget-editbutton="false">
                <!-- widget content -->
                <div class="widget-body" class="smart-form">
                    <form name="form_busq_rad" id="form_busq_rad" class="form-inline" action='<?=$_SERVER['PHP_SELF']?>?<?=$encabezado?>' method="post">
                      Buscar radicado(s) (Separados por coma)
                      <input name="busqRadicados" class="input" type="text" value="<?=$busqRadicados?>">
                      <?
                      if($chkCarpeta){
                        $chkValue=" checked ";
                        $whereCarpeta = " ";
                      } else {
                        $chkValue="";
                        if(!$tipo_carp) $tipo_carp = "0";
                        $whereCarpeta = " and b.carp_codi=$carpeta  and b.carp_per=$tipo_carp";
                      }

                      $fecha_hoy = Date("Y-m-d");
                      $sqlFechaHoy=$db->conn->DBDate($fecha_hoy);

                      //Filtra el query para documentos agendados

                    ?>
                     <div class="checkbox">
                      <label>
                        <i></i>
                        <input type="checkbox" name="chkCarpeta" value=xxx <?=$chkValue?> > Todas las carpetas
                      </label>
                    </div>
                    <input type=submit value='Buscar ' name=Buscar valign='middle' class='btn btn-primary btn-sm'>
                  </form>
                </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>

<form name="form1" id="form1" action="./tx/formEnvio.php?<?=$encabezado?>" method="POST">
<div class="col-sm-12"> <!-- widget grid -->
  <section>
    <!-- row -->
    <div class="row">
      <!-- NEW WIDGET START -->
      <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget jarviswidget-color-darken" data-widget-editbutton="false">
          <!-- widget div-->
          <div>
            <!-- widget content -->
            <div class="widget-body">
              <div class="table-responsive">

  <?
  $controlAgenda=1;
	if($carpeta==11 and !$tipo_carp and $codusuario!=1){
	}else
	{
  //include "./tx/txOrfeo.php";
	}
	/*  GENERACION LISTADO DE RADICADOS
	 *  Aqui utilizamos la clase adodb para generar el listado de los radicados
	 *  Esta clase cuenta con una adaptacion a las clases utiilzadas de orfeo.
	 *  el archivo original es adodb-pager.inc.php la modificada es adodb-paginacion.inc.php
	 *
	 */

	if(strlen($orderNo)==0){
		$orderNo="2";
		$order = 3;
	}else{
		$order = $orderNo +1;
	}

	$sqlFecha = $db->conn->SQLDate("Y-m-d H:i A","h.HIST_FECH");
	include "$ruta_raiz/include/query/queryCuerpoTx.php";
	$rs=$db->conn->Execute($isql);
	if ($rs->EOF and $busqRadicados)  {
		echo "<hr><center><b><span class='alarmas'>No se encuentra ningun radicado con el criterio de busqueda</span></center></b></hr>";
	}
	else{
		$pager = new ADODB_Pager($db,$isql,'adodb', true,$orderNo,$orderTipo);
		$pager->checkAll = false;
		$pager->checkTitulo = true; $pager->toRefLinks = $linkPagina;
		$pager->toRefVars = $encabezado;
		$pager->descCarpetasGen=$descCarpetasGen;
		if($_GET["adodb_next_page"]) $pager->curr_page = $_GET["adodb_next_page"];
		$pager->descCarpetasPer=$descCarpetasPer;
		$pager->Render($rows_per_page=2000,$linkPagina,$checkbox=chkAnulados);
	}
	?>
                </div>

              </div>
            </div>
          </div>

        </article>
      </div>
    </section>
  </div>

	</form>
</body>
</html>
