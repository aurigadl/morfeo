<?php
session_start();

$ruta_raiz = "..";
if (!$_SESSION['dependencia'])
    header ("Location: $ruta_raiz/cerrar_session.php");

$nomcarpeta=$_GET["nomcarpeta"];
define('ADODB_ASSOC_CASE', 2);
$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
	
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
?>
<html>
<head>
<title>Untitled Document - Documento sin Titulo</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body onLoad="window_onload();">
<div id="spiffycalendar" class="text"></div>
<link rel="stylesheet" type="text/css" href="js/spiffyCal/spiffyCal_v2_1.css">
    <div class="col-sm-12">
        <!-- widget grid -->
        <h2></h2>
        <section id="widget-grid">
            <!-- row -->
            <div class="row">
                <!-- NEW WIDGET START -->
                <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <!-- Widget ID (each widget will need unique ID)-->
                    <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">


                        <?
                         $ruta_raiz = "..";
                         include_once "$ruta_raiz/include/db/ConnectionHandler.php";
                         $db = new ConnectionHandler("$ruta_raiz");
                         $db->conn->debug = true;


                         if(!$estado_sal)   {$estado_sal=2;}
                         if(!$estado_sal_max) $estado_sal_max=3;
                          if($estado_sal==4)
                          {

                             if($devolucion==2)
                                {
                                  $accion_sal = "Cerrar Envio";
                                  $pagina_sig = "devolucion_otras.php";
                                  $nomcarpeta="Documentos Devueltos por Agencia de Correo";
                                  $dev_documentos = "";
                            }
                            if(!$dep_sel) $dep_sel = $dependencia;
                            $anoActual = date('Y');
                            $anoAnterior = $anoActual - 1;
                            $dependencia_busq1 .= " and c.depe_codi = $dep_sel";
                          }
                        if($busq_radicados)
                        {
                            $busq_radicados = trim($busq_radicados);
                            $textElements = split (",", $busq_radicados);
                            $newText = "";
                            $i = 0;
                            foreach ($textElements as $item)
                            {
                                 $item = trim ( $item );
                                 if ( strlen ( $item ) != 0 )
                                 {
                                   $i++;
                                   if ($i != 1) $busq_and = " and "; else $busq_and = " ";
                                   $busq_radicados_tmp .= " $busq_and cast(radi_nume_sal as varchar(20)) like '%$item%' ";

                                  }
                             }
                             //if(substr($busq_radicados_tmp,-1)==",")   $busq_radicados_tmp = substr($busq_radicados_tmp,0,strlen($busq_radicados_tmp)-1);
                             $dependencia_busq1 .= " and $busq_radicados_tmp ";
                                        if(!$dep_sel) $dep_sel = $dependencia;

                                        $dependencia_busq1 .= " and c.depe_codi = $dep_sel";

                        }else
                        {
                           $sql_masiva = " and a.sgd_renv_planilla != '00' ";
                           $sql_masiva = "";
                        }
                        $tbbordes = "#CEDFC6";
                        $tbfondo = "#FFFFCC";
                        if(!$orno){$orno=1;}
                        $imagen="flechadesc.gif";


                         $encabezado = "".session_name()."=".session_id()."&krd=$krd&filtroSelect=$filtroSelect&accion_sal=$accion_sal&dependencia=$dependencia&tpAnulacion=$tpAnulacion&orderNo=";
                         $linkPagina = "$PHP_SELF?$encabezado&accion_sal=$accion_sal&orderTipo=$orderTipo&orderNo=$orderNo";

                         $pagina_actual = "../devolucion/cuerpoDevCorreo.php";
                         $carpeta = "xx";
                         include "../envios/paEncabeza.php";
                         $varBuscada = "cast(radi_nume_sal as varchar(20))";
                         include "../envios/paBuscar.php";
                         $pagina_sig = "../devolucion/devolucion_otras.php";
                         $accion_sal = "Cerrar Envio";
                         include "../envios/paOpciones.php";

                            /*  GENERACION LISTADO DE RADICADOS
                             *  Aqui utilizamos la clase adodb para generar el listado de los radicados
                             *  Esta clase cuenta con una adaptacion a las clases utiilzadas de orfeo.
                             *  el archivo original es adodb-pager.inc.php la modificada es adodb-paginacion.inc.php
                             */

                            error_reporting(7);

                            if ($orderNo==98 or $orderNo==99) {
                               $order=1;
                               if ($orderNo==98)   $orderTipo="desc";

                               if ($orderNo==99)   $orderTipo="";

                            }

                            else  {
                               if (!$orderNo)  $orderNo=0;
                               $order = $orderNo + 1;

                               if($orden_cambio==1)
                               {
                                  if(!$orderTipo)
                                  {
                                      $orderTipo="desc";
                                  }else
                                  {
                                      $orderTipo="";
                                  }
                               }
                            }
                        $sqlChar = $db->conn->SQLDate("d-m-Y H:i A","SGD_RENV_FECH");
                        $valor    = "(cast(a.sgd_renv_cantidad as numeric) * cast(a.sgd_renv_valor as numeric))";
                        include "$ruta_raiz/include/query/devolucion/querycuerpoDevCorreo.php";
                        ?>
                         <form name=formEnviar action='../devolucion/devolucion_otras.php?<?=session_name()."=".session_id() ?>&estado_sal=<?=$estado_sal?>&estado_sal_max=<?=$estado_sal_max?>&pagina_sig=<?=$pagina_sig?>&dep_sel=<?=$dep_sel?>&nomcarpeta=<?=$nomcarpeta?>&orderNo=<?=$orderNo?>' method=post>
                        <?
                        $encabezado = "".session_name()."=".session_id()."&estado_sal=$estado_sal&estado_sal_max=$estado_sal_max&accion_sal=$accion_sal&dependencia_busq2=$dependencia_busq2&dep_sel=$dep_sel&filtroSelect=$filtroSelect&tpAnulacion=$tpAnulacion&nomcarpeta=$nomcarpeta&orderTipo=$orderTipo&orderNo=";
                        $linkPagina = "$PHP_SELF?$encabezado&orderTipo=$orderTipo";

                            $pager = new ADODB_Pager($db,$isql,'adodb', true,$orderNo,$orderTipo);
                            $pager->checkAll = false;
                            $pager->checkTitulo = true;
                            $pager->toRefLinks = $linkPagina;
                            $pager->toRefVars = $encabezado;
                            if($_GET["adodb_next_page"]) $pager->curr_page = $_GET["adodb_next_page"];
                            $pager->Render($rows_per_page=200,$linkPagina,$checkbox=chkEnviar);

                         ?>
                          </form>
                    </div>
                </article>
            </div>
        </section>
    </div>
</body>

</html>

