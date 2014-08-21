<?php
/**
* @module index_frame
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
  // Esto es para darle al usuario acceso al menu Opciones
  $usuarios_admin = array ('EALARCON');

  session_start();

  $ruta_raiz = ".";
  if (!$_SESSION['dependencia'] || $_GET['close']){
    header ("Location: $ruta_raiz/login.php");
    echo "<script>parent.frames.location.reload();top.location.reload();</script>";
  }

  include_once "$ruta_raiz/include/db/ConnectionHandler.php";
  include_once "$ruta_raiz/config.php";

  $db = new ConnectionHandler($ruta_raiz);

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
  $enlace3        = "href=\"bandejaInformados.php?$phpsession&<?=mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&
                     carpeta=8&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1\"";
  $enlace4        = "href=\"tx/cuerpoInfConjunto.php?$phpsession&mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&
                     carpeta=66&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1\"";
  $enlace5        = "href=\"cuerpoTx.php?$phpsession&";
  $enlace6        = "href=\"cuerpoPrioritario.php?$phpsession&";
  $enlace7        = "href=\"crear_carpeta.php?$phpsession&krd=$krd&";
  $enlace8        = "href=\"cuerpo.php?$phpsession&";
  $enlace21       = "href=\"busqueda/busquedaPiloto.php?$phpsession&";
  $enlace22       = "href=\"./estadisticas/vistaFormConsulta.php?$phpsession&";

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
      $enlace10 = "href=\"#\" onclick=\"return false;\"";
      $enlacea1 = "href=\"./radsalida/masiva/upload2PorExcel.php?$phpsession&krd=$krd&fechah=$fechah\"";
      $enlacea2 = "href=\"./radsalida/cuerpo_masiva_recuperar_listado.php?$phpsession&krd=$krd&fechah=$fechah\"";
      $linkint  = "<li><a tabindex=\"-1\" $enlacea1 target=\"mainFrame\">Masiva externa</a></li>";
      $linkint .= "<li><a tabindex=\"-1\" $enlacea2 target=\"mainFrame\">Recuperar Listado</a></li>";
      $linkrad .= "<li class=\"dropdown-submenu\">
                    <a $enlace10 target=\"mainFrame\">Masiva</a>
                    <ul class=\"dropdown-menu\">
                      $linkint
                    </ul>
                   </li>";
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
	$link1      = $enlace."$fechah&nomcarpeta=General&carpeta=9999&tipo_carpt=0\"";
	$link1show .= "<li><a $link1 target=\"mainFrame\" >General (Todos)</a></li>";
  $isql = "SELECT c.CARP_CODI,MIN(c.CARP_DESC ) CARP_DESC, COUNT(*) NRADS
            FROM CARPETA c left outer join radicado r
             on (r.carp_codi=c.carp_codi and r.carp_per=0)
            where radi_usua_actu=$codusuario
              and radi_depe_actu=$dependencia
            group by c.CARP_CODI
						ORDER BY c.CARP_CODI";
	$rs   = $db->query($isql);

  while(!$rs->EOF){
    $numdata    = trim($rs->fields["CARP_CODI"]);
    $rsCarpDesc         = $db->query($sqlCarpDep);
    $desccarpt          = $rs->fields["CARP_DESC"];
    $nRads          = $rs->fields["NRADS"];
    if($numdata==0) $numdata = 9998;
    $data       = (empty($descripcionCarpeta))? trim($desccarpt) : $descripcionCarpeta;
    $link1      = $enlace."$fechah&nomcarpeta=$data&carpeta=$numdata&tipo_carpt=0\"";
    $link1show .= "<li><a $link1 target=\"mainFrame\" >$desccarpt ($nRads)</a></li>";

    $rs->MoveNext();
  }

  // Se realiza la cuenta de radicados en Visto Bueno VoBo
  if ($numdata == 11) {                                                                                                                                 
    if ($codusuario == 1) {
      $isql = "select count(*) as CONTADOR
                    from radicado
                    where carp_per = 0 and
                    carp_codi = $numdata and
                    radi_depe_actu = $dependencia and
                    radi_usua_actu = $codusuario";
    } else {
      $isql = "select count(*) as CONTADOR
                    from radicado
                    where carp_per = 0 and
                    carp_codi = $numdata and
                    radi_depe_actu = $dependencia and
                    (radi_usu_ante = '$krd' or
                    (radi_usua_actu = $codusuario and radi_depe_actu=$dependencia))";
    }
  } else {
    $isql   = "select count(*) as CONTADOR                                                                                                              
                  from radicado
                  where carp_per = 0 and
                  carp_codi = 11 and
                  radi_depe_actu = $dependencia and
                  radi_usua_actu = $codusuario";
    $addadm = "&adm=0";
  }
  
  // Cuenta los numero de radicados por visto bueno
  var_dump($isql);
  $data       = "Documenos para Visto Bueno";
  $rs         = $db->conn->query($isql);
  $numero_radicados = (!$rs->EOF)? $rs->fields['CONTADOR'] : 0;
  $link11      = $enlace."$fechah&nomcarpeta=$data&carpeta=11&tipo_carpt=0\"";
  $link11show .= "<li><a $link11 target=\"mainFrame\" >Visto Bueno ($numero_radicados)</a></li>";

  //Agendado
  $isql        =" SELECT COUNT(1) AS CONTADOR
                  FROM SGD_AGEN_AGENDADOS agen
                  WHERE usua_doc='$usua_doc'
                  and agen.SGD_AGEN_ACTIVO=1
                  and (agen.SGD_AGEN_FECHPLAZO >= $sqlFechaHoy )";

  $rs       = $db->conn->query($isql);
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

  $rs       = $db->conn->query($isql);

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

  $rs1     = $db->conn->query($isql);
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
    // $link5show= "<li><a $enlace4 target=\"mainFrame\"> Tramite Conjunto ($numerot)</a></li>";
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
	    $data    = trim($rs->fields["NOMB_CARP"]);

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

  //Consultas
  $link21      = $enlace21."&etapa=1&s_Listado=VerListado&fechah=$fechah\"";
  $link21show  = "<li><a tabindex=\"-1\" $link21 target=\"mainFrame\"> Consultas </a></li>";

  //Estadisticas
  $link22      = $enlace22."&fechah=$fechah\"";
  $link22show  = "<li><a tabindex=\"-1\" $link22 target=\"mainFrame\"> Estadisticas </a></li>";
  
  $tiene_acceso_admin = in_array($krd, $usuarios_admin);
?>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title> ..:: <?=$entidad?> ::.</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="SIIM2">
        <link rel="shortcut icon" href="./img/favicon.png" onClick="this.reload();">
        <!-- Bootstrap core CSS -->
        <link href="./estilos/bootstrap.min.css" rel="stylesheet">
        <!-- font-awesome CSS -->
        <link href="./estilos/font-awesome.css" rel="stylesheet">
        <!-- Bootstrap core CSS -->
        <link href="./estilos/siim_temp.css" rel="stylesheet">
        <script type="text/javascript" src="<?=$ruta_raiz?>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<?=$ruta_raiz?>/js/bootstrap.js"></script>
        <script>
            function recapagi() {
                location.reload();
            }
        </script>
    </head>

    <body>
      <div id="wrapper">
        <!-- Sidebar -->
          <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">

            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand"  onclick="recapagi()" href="#">siim</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse">

                <ul class="nav navbar-nav">

                  <?php if(   $_SESSION["usua_perm_envios"]    >=1 || $_SESSION["usua_perm_adminflujos"]== 1
                           || $_SESSION["usua_perm_modifica"]  >=1 || $_SESSION["usua_perm_intergapps"] == 1
                           || $_SESSION["usua_perm_impresion"] >=1 || ($_SESSION["usua_perm_anu"]==3 or $_SESSION["usua_perm_anu"]==1)
                           || $_SESSION["usua_perm_trd"]       ==1 || $_SESSION["usua_admin_archivo"]   >= 1
                           || $_SESSION["usua_perm_prestamo"]  ==1 || $_SESSION["usua_perm_dev"]        == 1
                  ) {?>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Acciones <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      
                      <li>
                        <a href='ReportesR/indexReportes.php' alt='Generar planilla de distribucion y entrega'  target='mainFrame' class="menu_princ">Planilla Reasignados</a></li>

                      <?php if($_SESSION["usua_perm_adminflujos"]==1){ ?>
                      <li class="dropdown-submenu">
                        <a href="#" onclick="return false;">Editor Flujos</a>
                        <ul class="dropdown-menu">
                          <li><a href='./Administracion/flujos/texto_version2/creaProceso.php?<?=$phpsession ?>&accion=1' class="vinculos" target='mainFrame'>Crear Proceso</a></li>
                          <li><a href='./Administracion/flujos/texto_version2/seleccionaProceso.php?<?=$phpsession ?>&accion=2' class="vinculos" target='mainFrame'>Editar Flujo</a></li>
                        </ul>
                      </li>
                      <?php }
                     
                     if($_SESSION["usua_perm_envios"]>=1) { ?>
                      <li><a href="radicacion/formRadEnvios.php?<?=$phpsession ?>&<? echo "fechah=$fechah&usr=".md5($dep)."&primera=1&ent=1"; ?>" target='mainFrame' class="menu_princ">Envios</a></li>
                      <?php }
                      
                      if($_SESSION["usua_perm_modifica"] >=1) { ?>
                      <li><a href="radicacion/edtradicado.php?<?=$phpsession ?>&fechah=<?=$fechah?>&primera=1&ent=2" target='mainFrame' class="menu_princ">Modificaci&oacute;n</a></li>
                      <?php }

                      if($_SESSION["usua_perm_intergapps"]==1 ) { ?>
                      <li><a href="aplintegra/cuerpoApLIntegradas.php?<?=$phpsession?>&<?php echo "fechaf=$fechah&carpeta=8&nomcarpeta=Aplicaciones integradas&orderTipo=desc&orderNo=3"; ?>" target='mainFrame' class="menu_princ">Aplicaciones integradas</a></li>
                      <?php }

                      if($_SESSION["usua_perm_impresion"] >= 1) {
                        if(!isset($usua_perm_impresion)){
                          $usua_perm_impresion = "";
                        } ?>
                        <li><a href="envios/cuerpoMarcaEnviar.php?<?=$phpsession?>&<?php echo "fechaf=$fechah&usua_perm_impresion=$usua_perm_impresion&carpeta=8&nomcarpeta=Documentos Para Impresion&orderTipo=desc&orderNo=3"; ?>" target='mainFrame' class="menu_princ">Por Enviar</a></li>
                      <?php }

                      if ($_SESSION["usua_perm_anu"]==3 or $_SESSION["usua_perm_anu"]==1){?>
                        <li><a href="anulacion/cuerpo_anulacion.php?<?=$phpsession?>&tpAnulacion=1&<? echo "fechah=$fechah"; ?>" target='mainFrame' class="menu_princ">Anulaci&oacute;n</a></li>
                      <?php }

                      if ($_SESSION["usua_perm_trd"]==1) { ?>
                      <li class="dropdown-submenu">
                        <a href="#" onclick="return false;">Clasificaci&oacute;n Documental</a>
                        <ul class="dropdown-menu">
                          <li><a href='./trd/admin_series.php?<?=$phpsession ?>&krd=<?=$krd?>&krd=<?=$krd?>&<? echo "fechah=$fechah"; ?>' class="vinculos" target='mainFrame'>Series </a></li>
                          <li><a href='./trd/admin_subseries.php?<?=$phpsession ?>&krd=<?=$krd?>&krd=<?=$krd?>&<? echo "fechah=$fechah"; ?>' class="vinculos" target='mainFrame'>Subseries </a></li>
                          <li><a href='./trd/cuerpoMatriTRD.php?<?=$phpsession ?>&krd=<?=$krd?>&krd=<?=$krd?>&<? echo "fechah=$fechah"; ?>' class="vinculos" target='mainFrame'>Matriz Relaci&oacute;n </a></li>
                          <li><a href='./trd/admin_tipodoc.php?<?=$phpsession ?>&krd=<?=$krd?>&krd=<?=$krd?>&<? echo "fechah=$fechah"; ?>' class="vinculos" target='mainFrame'>Tipos Documentales </a></li>
                          <li><a href='./trd/procModTrdArea.php?<?=$phpsession ?>&krd=<?=$krd?>&krd=<?=$krd?>&<? echo "fechah=$fechah"; ?>' class="vinculos" target='mainFrame'>Modificacion TRD Area </a></li>
                          <li><a href='./trd/informe_trd.php?<?=$phpsession ?>&krd=<?=$krd?>&krd=<?=$krd?>&<? echo "fechah=$fechah"; ?>' class="vinculos" target='mainFrame'>Listado Tablas de Retencion Documental </a></li>
                        </ul>
                      </li>
                      <?php }

                        if($_SESSION["usua_admin_archivo"]>=1) {
                          $isql = "select count(1) as CONTADOR
                                from SGD_EXP_EXPEDIENTE
                                where
                                sgd_exp_estado=0 ";
                            $rs=$db->conn->Execute($isql);
                            $num_exp = $rs->fields["CONTADOR"];
                        ?>
                        <li><a href='./expediente/cuerpo_exp.php?<?=$phpsession?>&fechaf=<?=$fechah?>&carpeta=8&nomcarpeta=Expedientes&orno=1&adodb_next_page=1' target='mainFrame'>Archivo (<?=$num_exp?>)</a></li>
                      <?php }
                        if($_SESSION["usua_admin_archivo"]>=2) {
                        ?>
                        <li><a href='archivo/archivo.php?<?=$phpsession?>&fechaf=<?=$fechah?>&carpeta=8&nomcarpeta=Expedientes&orno=1&adodb_next_page=1' target='mainFrame'>Administracion Archivo</a></li>
                      <?php }
                      if ($_SESSION["usua_perm_prestamo"]==1) { ?>
                      <li class="dropdown-submenu">
                        <a href="#" onclick="return false;">Prestamo</a>
                        <ul class="dropdown-menu">
                          <li><a href="./prestamo/prestamo.php?opcionMenu=1" target='mainFrame'>Prestamo de documentos</a></li>
                          <li><a href="./prestamo/prestamo.php?opcionMenu=2" target='mainFrame'>Devolucion de documentos</a></li>
                          <li><a href="./prestamo/prestamo.php?opcionMenu=0" target='mainFrame'>Generacion de reportes</a></li>
                          <li><a href="./prestamo/prestamo.php?opcionMenu=3" target='mainFrame'>Cancelar solicitudes</a></li>
                        </ul>
                      </li>
                      <?php }
                      if($_SESSION["usua_perm_dev"]==1) { ?>
                      <li> <a href='devolucion/cuerpoDevCorreo.php?<?=$phpsession?>&krd=<?=$krd?>&<?php echo "fechaf=$fechah&carpeta=8&devolucion=2&estado_sal=4&nomcarpeta=Documentos Para Impresion&orno=1&adodb_next_page=1"; ?>' target='mainFrame' class="menu_princ" >Dev Correo</span></a></li>
                      <?php }?>


                    </ul>
                  </li>
                  <?php } ?>



                  <?php if($_SESSION["usua_admin_sistema"]==1 || $tiene_acceso_admin) {?>
                      <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Administraci&oacute;n <b class="caret"></b></a>
                          <ul class="dropdown-menu">
                              <li class="dropdown-submenu">
                                  <a href="#" onclick="return false;">Usuarios y Perfiles</a>
                                  <ul class="dropdown-menu">
                                      <li>
                                          <a href='./Administracion/usuario/crear.php?<?=$sendSession?>&usModo=1' class="vinculos" target='mainFrame'>
                                              Crear Usuario
                                          </a>
                                      </li>
                                      <li>
                                          <a href='./Administracion/usuario/cuerpoEdicion.php?<?=$sendSession?>&usModo=2' class="vinculos" target='mainFrame'>
                                              Editar Usuario
                                          </a>
                                      </li>
                                      <li>
                                          <a href='./Administracion/usuario/cuerpoConsulta.php?<?=$sendSession?>' class="vinculos" target='mainFrame'>
                                              Consultar Usuario
                                          </a>
                                      </li>
                                  </ul>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_dependencias.php?<?=$sendSession?>" class="vinculos" target="mainFrame">
                                      Dependencias
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_nohabiles.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Dias no habiles
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_fenvios.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Env&iacute;o de correspondencia
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_mensajeRapido.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Mensajes Rapidos
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_tsencillas.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Tablas sencillas
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_trad.php?<?=$sendSession?>&krd=<?=$krd?>" class="vinculos" target='mainFrame'>
                                      Tipos de radicaci&oacute;n
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_paises.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Pa&iacute;ses
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_dptos.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Departamentos
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_mcpios.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Municipios
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_tarifas.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Tarifas
                                  </a>
                              </li>

                              <li>
                                  <a href="./Administracion/tbasicas/adm_plantillas.php?<?=$sendSession?>" class="vinculos" target='mainFrame'>
                                      Plantillas
                                  </a>
                              </li>

                          </ul>
                      </li>
                  <?php } ?>


                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Bandejas <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <?=$link21show?>
                      <?=$link22show?>
                      <?=$link1show?>
                      <?=$link11show?>
                      <?=$link4show?>
                      <?=$link5show?>
                      <?=$link6show?>
                      <?=$link7show?>
                      <?=$link2show?>
                      <?=$link3show?>
                      <li class="divider"></li>
                      <li class="dropdown-submenu">
                        <?=$link8show?>
                        <ul class="dropdown-menu">
                          <?=$link9show?>
                          <?=$link10show?>
                        </ul>
                      </li>
                    </ul>
                  </li>

                  <? if(!empty($linkrad)){?>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Radicaci&oacute;n<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <?=$linkrad?>
                    </ul>
                  </li>
                  <?}?>

                </ul>

                <ul class="nav navbar-nav navbar-right navbar-user">

                  <li class="dropdown">
                    <a href="#" onclick="return false;" data-toggle="dropdown" class="dropdown-toggle"> Opciones <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="plantillas.php?<?=session_name()."=".session_id()?>&fechah=$fechah&krd=$krd&info=false" target="mainFrame"> Plantillas </a></li>
                      <li><a href="<?php echo $url_ayuda ?>" target="mainFrame"> Ayuda </a></li>
                    </ul>
                  </li>

                  <li class="dropdown user-dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <?=$nombUser?> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="mod_datos.php?<?=session_name()."=".session_id()."&fechah=$fechah&krd=$krd&info=false"?>" target="mainFrame"><i class="fa fa-user"></i> Perfil </a></li>
                      <? if ($_SESSION["autentica_por_LDAP"] != 1){?>
                      <li> <a href='contraxx.php?<?=session_name()."=".session_id()."&fechah=$fechah"?>' target=mainFrame> Cambio de clave </a></li>
                      <? } ?>
                      <li class="divider"></li>
                      <li><a href="cerrar_session.php?<?= session_name()."=".session_id()?>"><i class="fa fa-power-off"></i> Salir </a></li>
                    </ul>
                  </li>

                </ul>

            </div>
            <!-- /.navbar-collapse -->
          </nav>

          <iframe name='mainFrame' frameBorder="0" width="100%" height="100%" src='cuerpo.php?<?=session_name()."=".session_id()?>&swLog=<?=$swLog?>&fechah=<?=$fechah?>&tipo_alerta=1' scrolling='auto'/></iframe>

      </div>
    </body>
</html>
