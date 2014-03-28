<?php
  session_start();

  $ruta_raiz = ".";
  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

  include_once "$ruta_raiz/include/db/ConnectionHandler.php";
  $db = new ConnectionHandler("$ruta_raiz");

  $krd            = $_SESSION["krd"];
  $dependencia    = $_SESSION["dependencia"];
  $usua_doc       = $_SESSION["usua_doc"];
  $codusuario     = $_SESSION["codusuario"];
  $tip3Nombre     = $_SESSION["tip3Nombre"];
  $tip3desc       = $_SESSION["tip3desc"];
  $tip3img        = $_SESSION["tip3img"];
  $ESTILOS_PATH   = $_SESSION["ESTILOS_PATH"];
  $nombUser       = $_SESSION["usua_nomb"];
  $phpsession     = session_name()."=".session_id();
  $fechah         = date("Ymdhms");
  $ruta_raiz      = ".";
  $enlace         = "href=\"cuerpo.php?<?=$phpsession?>&adodb_next_page=1&fechah=";
  $enlace1        = "href=\"cuerpoAgenda.php?<?=$phpsession?>&agendado=1&fechah=";
  $enlace2        = "href=\"cuerpoAgenda.php?<?=$phpsession?>&agendado=2&fechah=";
  $enlace3        = "href=\"cuerpoinf.php?<?=$phpsession?>&<?=mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&
                     carpeta=8&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1\"";
  $enlace4        = "href=\"tx/cuerpoInfConjunto.php?$phpsession&mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&
                     carpeta=66&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1\"";
  $enlace5        = "href=\"cuerpoTx.php?<?=$phpsession?>&fechah=";

  $sqlFechaHoy    = $db->conn->DBTimeStamp(time());

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
?>

<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Sistema de informaci&oacute;n integrado de Metrovivienda</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="SIIM2">
        <meta name="keywords" content="siim, metrovivienda, gestion, misional">
        <link rel="shortcut icon" href="./img/favicon.png">
        <!-- Bootstrap core CSS -->
        <link href="./estilos/bootstrap.min.css" rel="stylesheet">
        <!-- font-awesome CSS -->
        <link href="./estilos/font-awesome.css" rel="stylesheet">
        <!-- Bootstrap core CSS -->
        <link href="./estilos/siim_temp.css" rel="stylesheet">
        <script type="text/javascript" src="<?=$ruta_raiz?>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<?=$ruta_raiz?>/js/bootstrap.js"></script>
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
              <a class="navbar-brand" href="#">siim</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse">

                <ul class="nav navbar-nav">
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Bandejas <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <?=$link1show?>
                      <?=$link4show?>
                      <?=$link5show?>
                      <li class="divider"></li>
                      <?=$link6show?>
                      <li class="divider"></li>
                      <?=$link2show?>
                      <?=$link3show?>
                    </ul>
                  </li>
                </ul>

                <ul class="nav navbar-nav navbar-right navbar-user">
                  <li class="dropdown user-dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <?=$nombUser?> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="mod_datos.php?<?=session_name()."=".session_id()."&fechah=$fechah&krd=$krd&info=false"?>" target="mainFrame"><i class="fa fa-user"></i> Perfil </a></li>
                      <li class="divider"></li>
                      <li><a href="cerrar_session.php?<?= session_name()."=".session_id()?>"><i class="fa fa-power-off"></i> Salir </a></li>
                    </ul>
                  </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
          </nav>

          <iframe name='mainFrame' width="100%" height="100%" src='cuerpo.php?<?=session_name()."=".session_id()?>&swLog=<?=$swLog?>&fechah=<?=$fechah?>&tipo_alerta=1' scrolling='no'/></iframe>

      </div>
    </body>
</html>
