<form name = formaTRD action="upload2PorExcel.php?<?=$paramsTRD?>" method="post">
  <div class="col-sm-12"> <!-- widget grid -->
    <h2></h2>
    <section id="widget-grid">
      <!-- row -->
      <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!-- Widget ID (each widget will need unique ID)-->
          <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">

            <header>
              <h2>
                Aplicaci&oacute;n de la trd
              </h2>
            </header>

            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body">
                <div class="table-responsive">
                  <table class="table table-bordered table-striped smart-form">
                  <?
                  $paramsTRD=$phpsession."&krd=$krd&codiTRD=$codiTRD&tsub=$tsub&codserie=$codserie&tipo=$tipo&dependencia=$dependencia&depe_codi_territorial=$depe_codi_territorial&usua_nomb=$usua_nomb&"
                          ."depe_nomb=$depe_nomb&usua_doc=$usua_doc&codusuario=$codusuario";
                  ?>
                    <tr align="center">
                      <td width="36%" class="titulos2">SERIE</td>
                      <td width="64%" height="35" class="listado2">
                        <label class="select">
                  <?

                  $coddepe=$_SESSION['dependencia'];

                  if($codserie!=0 and $tipo !=0 and $tsub !=0) {
                    $queryTRD = "select SGD_MRD_CODIGO AS CLASETRD from sgd_mrd_matrird m
                          where m.depe_codi = '$coddepe'
                            and m.sgd_srd_codigo = '$codserie' and m.sgd_sbrd_codigo = '$tsub' and m.sgd_tpr_codigo = '$tipo'";
                    $rsTRD=$db->conn->query($queryTRD);
                    if($rsTRD){
                        $codiTRD = $rsTRD->fields['CLASETRD'];
                    }
                  }

                  //$coddepe=$dependencia;
                  if ($coddepe != 0 && $tipo != 0 && $tsub != 0)
                  if(!$tipo) $tipo = 0;
                  if(!$codserie) $codserie = 0;
                  if(!$tsub) $tsub = 0;
                  $fechah=date("dmy") . " ". time("h_m_s");
                  $fecha_hoy = Date("Y-m-d");
                  $sqlFechaHoy=$db->conn->DBDate($fecha_hoy);
                  $num_car = 4;
                  $nomb_varc = "s.sgd_srd_codigo";
                  $nomb_varde = "s.sgd_srd_descrip";
                  include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";

                  $querySerie = "select
                                    distinct ($sqlConcat) as detalle
                                    , s.sgd_srd_codigo
                                from
                                    sgd_mrd_matrird m
                                    , sgd_srd_seriesrd s
                                where
                                    m.depe_codi = '$coddepe'
                                    and s.sgd_srd_codigo = m.sgd_srd_codigo
                                    and ".$sqlFechaHoy." between s.sgd_srd_fechini and s.sgd_srd_fechfin
                                order by detalle";

                  $rsD           = $db->conn->query($querySerie);
                  $comentarioDev = "Muestra las Series Docuementales";

                  include "$ruta_raiz/include/tx/ComentarioTx.php";
                  print $rsD->GetMenu2("codserie", $codserie, "0:-- Seleccione --", false,"","onChange='submit()' class='select'" );

                  ?>
                        </label>
                      </td>
                    <tr align="center">
                      <td width="36%" class="titulos2">SUBSERIE</td>
                      <td width="64%" height="35" class="listado2">
                        <label class="select">
                  <?
                  $nomb_varc  = "su.sgd_sbrd_codigo";
                  $nomb_varde = "su.sgd_sbrd_descrip";
                  include("$ruta_raiz/include/query/trd/queryCodiDetalle.php");
                  $querySub = "select distinct ($sqlConcat) as detalle, su.sgd_sbrd_codigo
                        from sgd_mrd_matrird m, sgd_sbrd_subserierd su
                        where m.depe_codi = '$coddepe'
                              and m.sgd_srd_codigo = '$codserie'
                            and su.sgd_srd_codigo = '$codserie'
                              and su.sgd_sbrd_codigo = m.sgd_sbrd_codigo
                              and ".$sqlFechaHoy." between su.sgd_sbrd_fechini and su.sgd_sbrd_fechfin
                        order by detalle";

                  $rsSub=$db->conn->query($querySub);

                  while(!$rsSub->EOF){
                      $nombre = utf8_decode($rsSub->fields['DETALLE']);
                      $codigo = $rsSub->fields['SGD_SBRD_CODIGO'];
                      if($codigo  == $tsub){
                          $options .= "<option value='$codigo' selected >$nombre</option>";
                      }else{
                          $options .= "<option value='$codigo'>$nombre</option>";
                      }
                      $rsSub->MoveNext();
                  }

                  echo "<select name='tsub' onChange='submit()' class='select'>
                          <option value='0'>-- Selecccione --</option>
                          ". $options ."
                        </select>";

                  ?>
                        </label>
                      </td>
                    </tr>
                      <tr align="center">
                      <td width="36%" class="titulos2">TIPO DE DOCUMENTO</td>
                      <td width="64%" height="35" class="listado2">
                        <label class="select">
                  <?
                  $ent = 1;
                  $nomb_varc = "t.sgd_tpr_codigo";
                  $nomb_varde = "t.sgd_tpr_descrip";
                  include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";
                  $queryTip = "select distinct ($sqlConcat) as detalle, t.sgd_tpr_codigo
                            from sgd_mrd_matrird m, sgd_tpr_tpdcumento t
                        where m.depe_codi = '$coddepe'
                              and m.sgd_srd_codigo  = '$codserie'
                              and m.sgd_sbrd_codigo = '$tsub'
                              and t.sgd_tpr_codigo = m.sgd_tpr_codigo
                            and t.sgd_tpr_tp$ent='1'
                        order by detalle";
                  $rsTip=$db->conn->query($queryTip);
                  include "$ruta_raiz/include/tx/ComentarioTx.php";
                  print $rsTip->GetMenu2("tipo", $tipo, "0:-- Seleccione --", false,"","onChange='submit()' class='select'" );
                  ?>
                        </label>
                  </tr>
                      <tr align="center">
                          <td height="25"  class="titulos2">TIPO DE RADICACI&Oacute;N</td>
                          <td width="84%" height="30" class="listado2">
                          <?php

                              $sql = "SELECT SGD_TRAD_CODIGO,SGD_TRAD_DESCR FROM SGD_TRAD_TIPORAD";

                              $rtiprad = $db->conn->query($sql);

                              while(!$rtiprad->EOF){
                                  $ercodigo  = utf8_decode($rtiprad->fields['SGD_TRAD_CODIGO']);
                                  $nombre    = $rtiprad->fields['SGD_TRAD_DESCR'];
                                  if($ercodigo  == $tipoRad){
                                      $options2 .= "<option value='$ercodigo' selected >$nombre</option>";
                                  }else{
                                      $options2 .= "<option value='$ercodigo'>$nombre</option>";
                                  }
                                  $rtiprad->MoveNext();
                              }

                              echo "<label class='select'>
                                        <select name='tipoRad' id='Slc_Trd' onChange='submit()' class='select'>
                                          <option value='0'>-- Selecccione --</option>
                                          ". $options2 ."
                                        </select>
                                    </label>";
                          ?>
                        </td>
                      </tr>
                  </table>
                </div>

                <?
                $queryProc = "select SGD_PEXP_DESCRIP,SGD_PEXP_CODIGO
                         from SGD_PEXP_PROCEXPEDIENTES
                         WHERE SGD_SRD_CODIGO=$codserie
                         AND SGD_SBRD_CODIGO=$tsub";
                        $rs=$db->conn->query($queryProc);
                $codTmpProc = $rs->fields["SGD_PEXP_CODIGO"];
                if($codTmpProc) {
                ?>

                <div class="table-responsive">
                  <table class="table table-bordered table-striped smart-form">
                    <tr class="titulos5">
                        <td>VINCULAR A PROCESO </td>
                        <td>
                          <?php

                            echo "<label class='select'>";
                                print $rs->GetMenu2("codProceso", $codProceso, "0:-- Ningun Proceso --", false,""," class='select'  onchange='submit();'" );
                            echo "</label>";

                            include ("$ruta_raiz/include/tx/Flujo.php");
                            $objFlujo = new Flujo($db, $codProceso,$usua_doc);
                            echo $objFlujo->getMenuProximaArista($tipo, $codProceso,$codserie,$tsub,$tipoRad,'pNodo',$pNodo," class='select' onChange='submit();'");
                          ?>
                        </td>
                    </tr>
                  </table>
                  <?  } ?>
                </div>

              </div>
            </div>
          </div>

        </article>
      </div>
    </section>
  </div>
</form>
