<?php
  session_start();

  $ruta_raiz = ".";
  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

  $krd            = $_SESSION["krd"];
  $dependencia    = $_SESSION["dependencia"];
  $usua_doc       = $_SESSION["usua_doc"];
  $codusuario     = $_SESSION["codusuario"];
  $tip3Nombre     = $_SESSION["tip3Nombre"];
  $tip3desc       = $_SESSION["tip3desc"];
  $tip3img        = $_SESSION["tip3img"];
  $ESTILOS_PATH   = $_SESSION["ESTILOS_PATH"];
  $nombUser       = $_SESSION["usua_nomb"];
  $fechah         = date("Ymdhms");
  $ruta_raiz      = ".";

  include_once "$ruta_raiz/include/db/ConnectionHandler.php";
  $db = new ConnectionHandler("$ruta_raiz");

  // BUSCA LAS CARPETAS PERSONALES DE CADA USUARIO Y LAS COLOCA contando el numero de documentos en cada carpeta.
  $isql ="SELECT DISTINCT CODI_CARP,DESC_CARP,NOMB_CARP
          FROM CARPETA_PER
          WHERE USUA_CODI=$codusuario AND DEPE_CODI=$dependencia ORDER BY CODI_CARP";

  $rs=$db->query($isql);

  while(!$rs->EOF){
    if($data=="")   $data = "NULL";
    $data    = trim($rs->fields["NOMB_CARP"]);
    $numdata = trim($rs->fields["CODI_CARP"]);
    $detalle = trim($rs->fields["DESC_CARP"]);
    $data    = trim($rs->fields["NOMB_CARP"]) ;

    $isql    = "SELECT COUNT(1) AS CONTADOR
                FROM RADICADO
                WHERE CARP_PER=1 AND CARP_CODI=$numdata
                AND RADI_DEPE_ACTU=$dependencia AND RADI_USUA_ACTU=$codusuario";

    $rs1     = $db->query($isql);
    $numerot = $rs1->fields["CONTADOR"];

    $links.="<a href=\"cuerpo.php?".$phpsession."&.\"fechah=".$fechah."&tipo_carp=1&carpeta=".$numdata."&nomcarpeta=".$data."(Personal) alt=\"".$detalle." title=\"".$detalle." class=\"menu_princ\" target=\"mainFram\">".$data." ". $numerot;
   echo $links;
    $rs->MoveNext();
  }

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
        <!-- inicio script que crea la sesion y la cierra para el carro de compras-->

        <script language="javascript">
            function returnKrdF_top(){
                return '<?=$krd?>';
            };

            function nueva(){
                open('plantillas.php?<?=session_name()."=".session_id()?>', 'Sizewindow', 'width=800,height=600,scrollbars=yes,toolbar=no')
            }

            function cerrar_session() {
              if (confirm('Seguro de cerrar sesion ?')){
                <?$fechah = date("Ymdhms"); ?>
                url="login.php?adios=chao";document.form_cerrar.submit();
                url = 'login.php?<?= session_name()."=".session_id()."&fechah=$fechah"?>';
                window.location.href=url;
              }
            }

            function MM_swapImgRestore(){
                var i,x,a=document.MM_sr; for(i=0;a&&i
                <a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
            }

            function MM_preloadImages(){
                var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
                var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i
                <a.length; i++)
                if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
            }

            function MM_findObj(n, d){
                var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
                if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i
                <d.forms.length;i++) x=d.forms[i][n];
                for(i=0;!x&&d.layers&&i
                <d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
                if(!x && d.getElementById) x=d.getElementById(n); return x;
            }

            function MM_swapImage(){
                var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i
                <(a.length-2);i+=3)
                if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
            }

        </script>
        <!-- FIN    Script que crea la sesion y la cierra para el carro de compras-->
        <script type="text/javascript" src="<?=$ruta_raiz?>/js/ajaxSessionRads.js"></script>
    </head>

    <body topmargin="0" leftmargin="0" onLoad="MM_preloadImages('');MM_preloadImages('');MM_preloadImages('');MM_preloadImages('')">
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
                      <li><a href="#">Action</a></li>
                      <li><a href="#">Another action</a></li>
                      <li><a href="#">Something else here</a></li>
                      <li class="divider"></li>
                      <li><a href="#">Separated link</a></li>
                      <li class="divider"></li>
                      <li><a href="#">One more separated link</a></li>
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
