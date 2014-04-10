<?php
/**
* @module login 
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

  $ruta_raiz = ".";
  if (!$_SESSION['dependencia'] || $_GET['close']){
    header ("Location: $ruta_raiz/login.php");
  }

  include_once "$ruta_raiz/include/db/ConnectionHandler.php";
  $db = new ConnectionHandler("$ruta_raiz");

  $krd            = $_SESSION["krd"];
  $dependencia    = $_SESSION["dependencia"];
  $usua_doc       = $_SESSION["usua_doc"];
  $codusuario     = $_SESSION["codusuario"];
  $tip3Nombre     = $_SESSION["tip3Nombre"];
  $tip3desc       = $_SESSION["tip3desc"];
  $tpDescRad      = $_SESSION["tpDescRad"];
  $tip3img        = $_SESSION["tip3img"];
  $ESTILOS_PATH   = $_SESSION["ESTILOS_PATH"];
  $nombUser       = $_SESSION["usua_nomb"];
  $tpNumRad       = $_SESSION["tpNumRad"];
  $tpPerRad       = $_SESSION["tpPerRad"];


  $phpsession     = session_name()."=".session_id();
  $fechah         = date("Ymdhms");
  $ruta_raiz      = ".";
  $enlace         = "href=\"cuerpo.php?$phpsession&adodb_next_page=1&fechah=";
  $enlace1        = "href=\"cuerpoAgenda.php?$phpsession&agendado=1&fechah=";
  $enlace2        = "href=\"cuerpoAgenda.php?$phpsession&agendado=2&fechah=";
  $enlace3        = "href=\"cuerpoinf.php?$phpsession&<?=mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&
                     carpeta=8&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1\"";
  $enlace4        = "href=\"tx/cuerpoInfConjunto.php?$phpsession&mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&
                     carpeta=66&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1\"";
  $enlace5        = "href=\"cuerpoTx.php?$phpsession&";
  $enlace6        = "href=\"cuerpoPrioritario.php?$phpsession&";
  $enlace7        = "href=\"crear_carpeta.php?$phpsession&krd=$krd&";
  $enlace8        = "href=\"cuerpo.php?$phpsession&";
  $enlace21       = "href=\"busqueda/busquedaPiloto.php?$phpsession&";

  $sqlFechaHoy    = $db->conn->DBTimeStamp(time());

  // Radicacion
  foreach ($tpNumRad as $key => $valueTp){
			$valueDesc = $tpDescRad[$key];
      $enlace9   = "href=\"radicacion/chequear.php?$phpsession&krd=$krd&fechah=$fechah&primera=1&ent=$valueTp&depende=$dependencia\"";
    	if($tpPerRad[$valueTp]==1 or $tpPerRad[$valueTp]==3){
        $linkrad .= "<li><a $enlace9 target='mainFrame'> $valueDesc </a></li>";
		  }
  }

	if ($_SESSION["usua_masiva"]==1) {
      $enlace10 = "href=\"radsalida/masiva/menu_masiva.php?$phpsessio&krd=$krd&fechah=$fechah \"";
      $linkrad .= "<li><a $enlace10 target=\"mainFrame\">Masiva</a></li>";
	}

  if ($_SESSION["perm_radi"]>=1){
      $enlace11 = "href=\"uploadFiles/uploadFileRadicado.php?$phpsession&krd=$krd&fechah=$fechah&primera=1&ent=2&depende=$dependencia\"";
      $linkrad .= "<li><a $enlace11 target=\"mainFrame\">Asociar Imagenes</a></li>";
  }

  if ($_SESSION["usuaPermRadEmail"]==1) {
    $enlace12 = "href='email/index.php?$phpsession&krd=$krd&fechah=$fechah&primera=1&ent=2&depende=$dependencia\"";
    $linkrad .= "<li><a $enlace12 target=\"mainFrame\">e-Mail</a></li>";
  }

	// Esta consulta selecciona las carpetas como Devueltos,  Entrada ,salida
  $isql = "SELECT CARP_CODI,CARP_DESC FROM CARPETA ORDER BY CARP_CODI";
	$rs   = $db->query($isql);

  while(!$rs->EOF){
    $numdata    = trim($rs->fields["CARP_CODI"]);
    $sqlCarpDep = "SELECT
                    SGD_CARP_DESCR
                  FROM
                    SGD_CARP_DESCRIPCION
                  WHERE
                    SGD_CARP_DEPECODI    = $dependencia
                    AND SGD_CARP_TIPORAD = $numdata";

    $rsCarpDesc         = $db->query($sqlCarpDep);
    $descripcionCarpeta = $rsCarpDesc->fields["SGD_CARP_DESCR"];
    $desccarpt          = $rs->fields["CARP_DESC"];

    $data       = (empty($descripcionCarpeta))? trim($desccarpt) : $descripcionCarpeta;
    $link1      = $enlace."$fechah&nomcarpeta=$data&carpeta=$numdata&tipo_carpt=0&adodb_next_page=1\"";
    $link1show .= "<li><a $link1 target=\"mainFrame\" >$desccarpt</a></li>";

    $rs->MoveNext();
  }

  //Agendado
  $isql        =" SELECT COUNT(1) AS CONTADOR
                  FROM SGD_AGEN_AGENDADOS agen
                  WHERE usua_doc='$usua_doc'
                  and agen.SGD_AGEN_ACTIVO=1
                  and (agen.SGD_AGEN_FECHPLAZO >= $sqlFechaHoy )";

  $rs       = $db->query($isql);
  $num_exp  = $rs->fields["CONTADOR"];
  $data     = "Agendados no vencidos";
  $link2    = $enlace1."$fechah&nomcarpeta=$data&tipo_carpt=0\"";
  $link2show= "<li><a $link2 target=\"mainFrame\" >Agendado($num_exp)</a></li>";



  //Agendado  Vencido
  $isql="SELECT COUNT(1) AS CONTADOR
          FROM SGD_AGEN_AGENDADOS AGEN
          WHERE  USUA_DOC='$usua_doc'
          and agen.SGD_AGEN_ACTIVO=1
          and (agen.SGD_AGEN_FECHPLAZO <= $sqlFechaHoy)";
  $rs=$db->query($isql);
  $num_exp  = $rs->fields["CONTADOR"];
	$data     ="Agendados vencidos";
  $link3    = $enlace2."$fechah&nomcarpeta=$data&&tipo_carpt=0&adodb_next_page=1\"";
  $link3show= "<li><a $link3 target=\"mainFrame\" >Agendado Vencido (<font color='#990000'>$num_exp</font>)</a></li>";


  //Informados
  $isql   =" SELECT COUNT(1) AS CONTADOR
               FROM INFORMADOS
             WHERE DEPE_CODI=$dependencia
              and usua_codi=$codusuario
              and info_conjunto=0";

  $rs1     = $db->query($isql);
  $numerot = ($rs1)? $rs1->fields["CONTADOR"] : 0;
  $link4show= "<li><a $enlace3 target=\"mainFrame\" >Informados ($numerot)</a></li>";

  //Tramite conjunto
  $isql="SELECT COUNT(1) AS CONTADOR
         FROM INFORMADOS
         WHERE DEPE_CODI=$dependencia
          and usua_codi=$codusuario
          and info_conjunto>=1 ";
  $rs1=$db->query($isql);

  $numerot = ($rs1)? $rs1->fields["CONTADOR"] : 0;
  if($numerot>=1){
    $link5show= "<li><a $enlace4 target=\"mainFrame\"> Tramite Conjunto ($numerot)</a></li>";
  }

  //Ultimas transacciones del usuario
  $data     ="Ultimas Transacciones del Usuario";
  $link6    = $enlace5."$fechah&nomcarpeta=$data&tipo_carpt=0\"";
  $link6show= "<li><a $link6 target=\"mainFrame\">Transacciones</a></li>";

  //Prioritarios
  $numeroP = 0;
  include ("include/query/queryCuerpoPrioritario.php");
  $rsP               = $db->conn->query($isqlPrioritario);
  $numeroP           = $rsP->fields["NUMEROP"];
  $clasePrioritarios = ($numeroP >= 1)? "titulosError" : "menu_princ";
  $link7             = $enlace6."$fechah&nomcarpeta=$data&tipo_carpt=0\"";
  $link7show         = "<li><a $link6 target=\"mainFrame\">Prioritarios ($numeroP)</a></li>";

  //Enlace carpetas Personales
  $link8             = $enlace7."fechah=$fechah&adodb_next_page=1\"";
  $link8show         = "<a tabindex=\"-1\"  target=\"mainFrame\" > Personales </a>";
  $link9show        .= "<li><a tabindex=\"-1\" $link8 target=\"mainFrame\"> Nueva Carpeta <i class=\" fa fa-plus-circle\"></i></a></li>";

  //Carpetas Personales
  $isql ="SELECT
            DISTINCT CODI_CARP,
            DESC_CARP,
            NOMB_CARP
          FROM
            CARPETA_PER
          WHERE
            USUA_CODI=$codusuario AND
            DEPE_CODI=$dependencia ORDER BY CODI_CARP  ";

  $rs = $db->query($isql);
  while(!$rs->EOF){
	    $data    = trim($rs->fields["NOMB_CARP"]);
	    $numdata = trim($rs->fields["CODI_CARP"]);
	    $detalle = trim($rs->fields["DESC_CARP"]);
	    $data    = trim($rs->fields["NOMB_CARP"]) ;
      $isql    = "SELECT
                    COUNT(1) AS CONTADOR
                  FROM
                    RADICADO
                  WHERE
                    CARP_PER=1 AND
                    CARP_CODI = $numdata AND
                    RADI_DEPE_ACTU = $dependencia AND
                    RADI_USUA_ACTU=$codusuario ";

	    $rs1     = $db->query($isql);
	    $numerot = $rs1->fields["CONTADOR"];
	    $datap   = "$data(Personal)";

      $link9       = $enlace8."fechah=$fechah&tipo_carp=1&carpeta=$numdata&nomcarpeta=$data\"";
      $link10show .= "<li><a tabindex=\"-1\" $link9 target=\"mainFrame\" > $data($numerot) </a></li>";
	    $rs->MoveNext();
    }

  //Administracion
  $link20show  = "<a  href=\"#\" onclick=\"return false;\"> Administraci&oacute;n </a>";

  //Consultas
  $link21      = $enlace21."&etapa=1&s_Listado=VerListado&fechah=$fechah\"";
  $link21show  = "<li><a tabindex=\"-1\" $link21 target=\"mainFrame\"> Consultas </a></li>";

    $drd = false;
    $krd = false;
    if (isset($_POST["krd"])){
        $krd = $_POST["krd"];
    }
    if (isset($_POST["drd"])){
        $drd = $_POST["drd"];
    }

    if (isset($_POST["autenticaPorLDAP"]))
        $autenticaPorLDAP = $_POST["autenticaPorLDAP"];

    $fechah        = date("dmy")."_".time("hms");
    $ruta_raiz     = ".";
    $usua_nuevo    = 3;
   	$ValidacionKrd  = "";

    include("config.php");
    $serv = str_replace(".", ".", $_SERVER['REMOTE_ADDR']);

    if ($krd) {
        //session_orfeo retorna mensaje de error
        include "$ruta_raiz/session_orfeo.php";
        require_once ("$ruta_raiz/class_control/Mensaje.php");

        if ($usua_nuevo == 0 &&  !$autenticaPorLDAP) {
            include ($ruta_raiz."/contraxx.php");
            $ValidacionKrd = "NOOOO";
            if ($j = 1)
                die("<center> -- </center>");
        }
    }

    $krd = strtoupper($krd);
    $datosEnvio = session_name()."=".trim(session_id())."&fechah=$fechah&krd=$krd&swLog=1&orno=1";

    if ($ValidacionKrd == "Si") {
        header ("Location: $ruta_raiz/index_frames.php?$datosEnvio");
        exit();
    }

?>

<!DOCTYPE html>
<!--[if IE 8]> <html class="no-js lt-ie9" lang="en" > <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en"><!--<![endif]--><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="SIIM2">
  <meta name="keywords" content="">
    <link rel="shortcut icon" href="./img/favicon.png">

  <title>SIIM2</title>
    <!-- Bootstrap core CSS -->
    <link href="./estilos/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./estilos/login.css" rel="stylesheet">

  </head>
    <body>
      <!-- start Login box -->
      <div class="container" id="login-block">
        <div class="row">
          <div class="col-sm-6 col-md-4 col-sm-offset-3 col-md-offset-4 col-lg-12">
             <div class="login-box clearfix animated flipInY">
                <h3 class="animated bounceInDown"><?=$entidad_largo?></h3>
                <hr>
                <div class="login-form">

                  <div class="alert alert-error hide">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Error!</h4>
                    Los datos suministrados no son correctos.
                  </div>

                  <form action="./login.php??fecha=250314_1395788602&amp;PHPSESSID=&amp;krd=&amp;swLog=1" method="post">
                    <input name="krd" placeholder="Usuario" required="" type="text">
                    <input name="drd" placeholder="Password" required="" type="password">
                    <button type="submit" class="btn btn-login">Entrar</button>
                  </form>
                  <?if(!empty($mensajeError)){ ?>
                  <div class="login-links text-error">
                    <?=$mensajeError?>
                  </div>
                  <?}?>
                </div>
             </div>
          </div>
        </div>
      </div>
      <!-- End Login box -->

      <footer class="container">
        <p id="footer-text"><small>Copyleft 2014, basado en Caliope 0.9 de la fundaci&oacute;n <a href="http://www.correlibre.org/">Correlibre</a></small></p>
      </footer>

      <script src="./js/jquery.min.js"></script>
      <script src="./js/bootstrap.js"></script>


      <script>
        /* Custom JavaScript */
        $(document).ready(function($) {
          $('input, textarea').placeholder();
        });
      </script>
    <script src="js/placeholder-shim.min.js"></script>
</body>
</html>
