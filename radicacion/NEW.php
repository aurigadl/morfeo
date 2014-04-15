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

  $ruta_raiz = "..";
  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

  foreach ($_GET  as $key => $valor) ${$key} = $valor;
  foreach ($_POST as $key => $valor) ${$key} = $valor;

  $krd                  = $_SESSION["krd"];
  $dependencia          = $_SESSION["dependencia"];
  $usua_doc             = $_SESSION["usua_doc"];
  $codusuario           = $_SESSION["codusuario"];
  $tpNumRad             = $_SESSION["tpNumRad"];
  $tpPerRad             = $_SESSION["tpPerRad"];
  $tpDescRad            = $_SESSION["tpDescRad"];
  $tip3Nombre           = $_SESSION["tip3Nombre"];
  $tip3img              = $_SESSION["tip3img"];
  $tpDepeRad            = $_SESSION["tpDepeRad"];
  $tip3desc             = $_SESSION["tip3desc"];
  $tip3img              = $_SESSION["tip3img"];
  $ln                   = $_SESSION["digitosDependencia"];
  $lnr                  = 11+$ln;

  $eMailRemitente       = $_SESSION['eMailRemitente'];
  $eMailNombreRemitente = $_SESSION['eMailNombreRemitente'];
  $eMailsubject         = $_SESSION['eMailSubject'];
  $tipoMedio            = $_SESSION['eMailtipoMedio'];

  /*
  * Variables de Session de Radicacion de Mails
  * Estas son variables que traen los valores con radicacoin de un correo Electronico
  */

  if($tipoMedio=="eMail"){
    if(empty($mail_us1)){
      $mail_us1 = $eMailRemitente;
    }
    if(empty($nombre_us1)){
      $nombre_us1 = $eMailRemitente;
    }
  }

  /**  Fin variables de session de Radicacion de Mail. **/
  include_once("$ruta_raiz/include/db/ConnectionHandler.php");
  $db     = new ConnectionHandler("$ruta_raiz");

  include_once("$ruta_raiz/class_control/AplIntegrada.php");
  include("crea_combos_universales.php");
  $objApl = new AplIntegrada($db);

  if($nurad){
    $nurad = trim($nurad);
    $ent   = substr($nurad,-1);
  }

  $no_tipo   = "true";
  $imgTp1    = str_replace(".jpg", "",$tip3img[1][$ent]);
  $imgTp2    = str_replace(".jpg", "",$tip3img[2][$ent]);
  $imgTp3    = str_replace(".jpg", "",$tip3img[3][$ent]);
  $descTp1   = "alt  = '".$tip3desc[1][$ent]."' title = '".$tip3desc[1][$ent]."'";
  $descTp2   = "alt  = '".$tip3desc[2][$ent]."' title = '".$tip3desc[2][$ent]."'";
  $descTp3   = "alt  = '".$tip3desc[3][$ent]."' title = '".$tip3desc[3][$ent]."'";
  $nombreTp1 = $tip3Nombre[1][$ent];
  $nombreTp2 = $tip3Nombre[2][$ent];
  $nombreTp3 = $tip3Nombre[3][$ent];

?>
<html>
  <head>
  <?php include_once("$ruta_raiz/htmlheader.inc.php") ?>
</head>

<body>
<?php
  $ddate  = date('d');
  $mdate  = date('m');
  $adate  = date('Y');
  $nurad  = trim($nurad);
  $hora   = date('H:i:s');
  $fechaf = $date.$mdate.$adate.$hora;
  // aqui se busca el radicado para editar si viene la variable $Buscar

  if($Buscar){
      $docDia = $db->conn->SQLDate('d','a.RADI_FECH_OFIC');
      $docMes = $db->conn->SQLDate('m','a.RADI_FECH_OFIC');
      $docAno = $db->conn->SQLDate('Y','a.RADI_FECH_OFIC');
      $fRad   = $db->conn->SQLDate('Y-m-d','a.RADI_FECH_RADI');

      if (!$nurad || strlen(trim($nurad))==0){
        $nurad="NULL";
      }

      $query = "select a.*
        ,$docDia AS DOCDIA
        ,$docMes AS DOCMES
        ,$docAno AS DOCANO
        ,a.EESP_CODI
        ,a.RA_ASUN
        ,$fRad AS FECHA_RADICADO
        from radicado a
        where a.radi_nume_radi=$nurad";

      $rs       = $db->conn->query($query);
      $varQuery = $query;
      $busqueda = $nurad;

      if(!$rs->EOF and is_numeric($busqueda)){
        if($cursor){
          $Submit4 = "Modificar";
        }

        $asu             = $rs->fields["RA_ASUN"];
        $tip_doc         = $rs->fields["TDID_CODI"];
        $radicadopadre   = $rs->fields["RADI_NUME_DERI"];
        $ane             = $rs->fields["RADI_DESC_ANEX"];
        $codep           = $rs->fields["DEPTO_CODI"];
        $pais            = $rs->fields["RADI_PAIS"];
        $carp_codi       = $rs->fields["CARP_CODI"];
        $cuentai         = $rs->fields["RADI_CUENTAI"];
        $carp_per        = $rs->fields["CARP_PER"];
        $depende         = $rs->fields["RADI_DEPE_ACTU"];
        $tip_rem         = $rs->fields["TRTE_CODI"]+1;
        $tdoc            = $rs->fields["TDOC_CODI"];
        $med             = $rs->fields["MREC_CODI"];
        $cod             = $rs->fields["MUNI_CODI"];
        $coddepe         = $rs->fields["RADI_DEPE_ACTU"];
        $codusuarioActu  = $rs->fields["RADI_USUA_RADI"];
        $coddepe         = $rs->fields["RADI_DEPE_ACTU"];
        $fechproc12      = $rs->fields["DOCDIA"];
        $fechproc22      = $rs->fields["DOCMES"];
        $fechproc32      = $rs->fields["DOCANO"];
        $fechaRadicacion = $rs->fields["FECHA_RADICADO"];
        $espcodi         = $rs->fields["EESP_CODI"];
        $fecha_gen_doc   = "$fechproc12/$fechproc22/$fechproc32";
        include "busca_direcciones.php";
      } else {
        echo "<p>
          <center>
            <table width='90%' class=borde_tab celspacing=5>
              <tr>
                <td class=titulosError>
                  <center>No se han encontrado registros con numero de radicado
                    <font color=blue>$nurad</font> <br>Revise el radicado escrito,
                    solo pueden ser Numeros de  $lnr digitos
                    <br>
                    <hr>
                    <a href='edtradicado.php?".session_name()."=".session_id()."&fechaf=$fechaf&krd=$krd&drde=$drde'>
                      <font color=red>
                      Intente de Nuevo
                    </a>
                  </center>
                </td>
              </tr>
            </table>
          </center>";
        if(!$rsJHLC) die("<hr>");
      }
  }
	// Fin de Busqueda del Radicado para editar
?>
  <script language="javascript">
    <?
    if(!$fecha_gen_doc || $fecha_gen_doc=='//'){
      $fecha_busq = date("d-m-Y");
      $fecha_gen_doc = $fecha_busq;
    }
    ?>
  </script>
<?php

  if($rad1 or $rad0 or $rad2){
    if($rad1) $tpRadicado = "1";
    if($rad2) $tpRadicado = "2";
    if($rad0) $tpRadicado = "0";

    echo "<input type=hidden name=tpRadicado value=$tpRadicado>";

    $docDia = $db->conn->SQLDate('D','a.RADI_FECH_OFIC');
    $docMes = $db->conn->SQLDate('M','a.RADI_FECH_OFIC');
    $docAno = $db->conn->SQLDate('Y','a.RADI_FECH_OFIC');

    if (!$radicadopadre || strlen(trim($radicadopadre))==0){
      $radicadopadre="NULL";
    }

    $query = "select a.*
      ,$docDia AS DOCDIA
      ,$docMes AS DOCMES
      ,$docAno AS DOCANO
      ,a.EESP_CODI from radicado a
      where a.radi_nume_radi=$radicadopadre";

    $varQuery = $query;
    $ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
    $rs=$db->conn->query($query);

    if(!$rs->EOF){
      echo "<!-- No hay datos: $query -->";
    }

    if(!$Buscar and !$Submit4){
      $varQuery = $query;
      $comentarioDev = 'Entro a Anexar un radicado ';
      $cuentaii =$rs->fields["RADI_CUENTAI"];
      if($cuentaii){$cuentai=$cuentaii;}
      $pnom=$rs->fields["RADI_NOMB"];
      $papl     = $rs->fields["RADI_PRIM_APEL"];
      $sapl     = $rs->fields["RADI_SEGU_APEL"];
      $numdoc   = $rs->fields["RADI_NUME_IDEN"];
      $asu      = $rs->fields["RA_ASUN"];
      $tel      = $rs->fields["RADI_TELE_CONT"];
      $guia     = $rs->fields["RADI_NUME_GUIA"];
      $noanexos = $rs->fields["RADI_NUME_ANEXO"];
      $nofolios = $rs->fields["RADI_NUME_FOLIO"];
      $rem2     = $rs->fields["RADI_REM"];
      $adress   = $rs->fields["RADI_DIRE_CORR"];
    }

    $depende              = $rs->fields["RADI_DEPE_ACTU"];
    $radi_usua_actu_padre = $rs->fields["RADI_USUA_ACTU"];
    $radi_depe_actu_padre = $rs->fields["RADI_DEPE_ACTU"];
    $tip_doc              = $rs->fields["TDID_CODI"];
    $ane                  = $rs->fields["RADI_DESC_ANEX"];
    $cod                  = $rs->fields["MUNI_CODI"];
    $codep                = $rs->fields["DPTO_CODI"];
    $pais                 = $rs->fields["RADI_PAIS"];
    $espcodi              = $rs->fields["EESP_CODI"];

    if($noradicar2){
      $fecha_gen_doc = $rs->fields["DOCDIA"] ."-".$rs->fields["DOCMES"] ."-".$rs->fields["DOCANO"];
      $fechproc12=$rs->fields["DOCDIA"];
      $fechproc22=$rs->fields["DOCMES"];
      $fechproc32=$rs->fields["DOCANO"];
    }

    $no_tipo = "true";
    include "busca_direcciones.php";
  }

	if($rad1){
	  $encabezado = "Copia de datos del Radicado  $radicadopadre ";
	  $tipoanexo = "1";
	}

	if($rad0){
	  $encabezado = "Anexo de $radicadopadre ";
	  $tipoanexo = "0";
	  $radicadopadre_exist=1;
	}

	if($rad2){
	  $encabezado = "Documento Asociado de $radicadopadre ";
	  if(!$Submit4 and !$Submit3){$cuentai = "";}
	  $tipoanexo = "2";
 	  $radicadopadre_exist=1;
	}
  if($noradicar1){
	  $radicadopadre_exist=0;
  }

  if ($Buscar1){
    include "busca_direcciones.php";
  }
  $var_envio="ent=$ent&carp_per=$carp_per&carp_codi=$carp_codi&rad=$nurad&coddepe=$coddepe&depende=$depende";
?>
  <form action='NEW.php?<?=$var_envio?>' method="post" name="formulario" id="formulario">
    <div id="content" style="opacity: 1;">
      <div class="col-lg-12">
        <div class="col-lg-4">
            <?
              if($tpRadicado) {
                echo "<input type=hidden name=tpRadicado value=$tpRadicado>";
              }
              $query = "select SGD_TRAD_CODIGO
                            , SGD_TRAD_DESCR from sgd_trad_tiporad
                          where SGD_TRAD_CODIGO=$ent";
              $rs=$db->conn->query($query);
              $tRadicacionDesc = $rs->fields["SGD_TRAD_DESCR"];
            ?>
            <h1 class="page-title txt-color-blueDark">
                Modulo de radicacion
                <?=$tRadicacionDesc?>
                (Dep <?=$dependencia?>)
                <?php
                  if($nurad){
                    echo "<br>
                          <small class=\"text-success slideInRight fast animated\">
                              <strong>
                                No. $nurad
                              </strong>
                          </small>
                          <br>";
                    $ent = substr($nurad,-1);
                  }
                ?>
                <p><small><?=$encabezado?></small></p>
              </h1>
        </div>


        <div class="col-lg-8 smart-form">
            <input type='hidden' name=radicadopadre value='<?=$radicadopadre ?>'>
            <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
            <input type='hidden' name=tipoanexo    value='<?=$tipoanexo ?>'>
            <input type='hidden' name='noradicar'  value='<?=$noradicar ?>'>
            <input type='hidden' name='noradicar1' value='<?=$noradicar1 ?>'>
            <input type='hidden' name='noradicar2' value='<?=$noradicar2 ?>'>
            <input type='hidden' name='atrasRad0'  value='<?=$rad0 ?>'>
            <input type='hidden' name='atrasRad1'  value='<?=$rad1 ?>'>
            <input type='hidden' name='atrasRad2'  value='<?=$rad2 ?>'>
            <input type='hidden' name='faxPath'    value='<?=$faxPath ?>'>

            <section class="col col-2">
              <label class="label">
                DD / MM / AAAA
              </label>
              <h3><?=$ddate?> / <?=$mdate?> / <?=$adate?>
              </h3>
            </section>


            <section class="col col-2">
              <label class="label">
                Referencia
              </label>
              <label class="input">
                <input name="cuentai" type="text"  maxlength="20" value='<?php echo $cuentai; ?>' >
              </label>
            </section>

            <section class="col col-2">
                <label class="label">
                  Guia
                </label>
                <label class="input">
                  <input type=text name='guia'name='id' value='<?=$guia ?>' <?=$bloqEdicion?>  size=35>
                  <input name="VERIFICAR" type='hidden' class="ebuttons2" value="Verifique Radicaci&oacute;n">
                </label>
            </section>

            <section class="col col-2">
              <label class="label">
                Fecha Doc. dd/mm/aaaa
              </label>
              <label class="input"> <i class="icon-append fa fa-calendar"></i>
                <input type="text" name="fecha_gen_doc" id="date" placeholder="Fecah de radicacion" value="<?=$fecha_gen_doc ?>">
              </label>
            </section>
          </div>
        </div>

        <section id="widget-grid">

          <!-- row -->
          <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-lg-12">

              <div data-widget-editbutton="false" id="wid-id-0" class="jarviswidget jarviswidget-sortable" style="" role="widget">

                  <!-- widget content -->
                  <div class="widget-body">

                      <div class="form-inline smart-form">

                        <section class="col col-2">
                          <label class="select">
                            <select name="tipo_ususario" class="form-control input-sm">
                              <option value='0'>Usuario     </option>
                              <option value='2'>Empresas    </option>
                              <option value='6'>Funcionarios</option>
                            </select>
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <input type=text name='documento_us' placeholder="Documento">
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <INPUT type=text name='nombre_us' placeholder="Nombre">
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <input type=text name='telefono_us' placeholder="Tel&eacute;fono">
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <INPUT type=text name='mail_us' placeholder="Correo Electronico">
                          </label>
                        </section>

                        <button type="button" name="Button" value="Crear" class="btn btn-success btn-sm pull-right" onClick="Start('buscar_usuario.php?&nombreTp1=<?=$nombreTp1?>&nombreTp2=<?=$nombreTp2?>&nombreTp3=<?=$nombreTp3?>&busq_salida=<?=$busq_salida?>&ent=<?=$ent?>',1024,400);">
                          Crear
                        </button>

                      </div>

                      <!--Muestra Resultados de la busqueda-->
                      <div id="resBusqueda"></div>

                      <table class="table table-bordered table-striped">
                          <thead>
                            <tr>
                              <th>Documento</th>
                              <th>Nombre</th>
                              <th>1er Apellido</th>
                              <th>2do Apellido</th>
                              <th>Telefono</th>
                              <th>Direcci&oacute;n</th>
                              <th>Correo Electronico</th>
                              <th>Dignatario</th>
                              <th>Pais</th>
                              <th>Departamento</th>
                              <th>Municipio</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td><a class="btn btn-default btn-circle" href="javascript:void(0);"><i class="glyphicon glyphicon-minus"></i></a> 123123213 </td>
                              <td>Row 2</td>
                              <td>Row 3</td>
                              <td>Row 4</td>
                              <td>Row 5</td>
                              <td>Row 6</td>
                              <td>Row 7</td>
                              <td>Row 8</td>
                              <td>Row 9</td>
                              <td>Row 10</td>
                              <td>Row 11</td>
                            </tr>
                          </tbody>

                      </table>
                      <!-- end widget content -->
                    </div>
                <!-- end widget div -->
              </div>
            </article>
            <!-- WIDGET END -->
          </div>
        </section>


        <?
            unset($contcodi);
            unset($paiscodi);
            unset($deptocodi);
            unset($municodi);

            if(empty($asu)){
                $asu =  $eMailsubject;
            }

            $asu = htmlspecialchars(stripcslashes($asu));
        ?>
        <div class="well">
          <section class="smart-form">
            <div class="row">
              <section class="col col-6">
                <label class="label">
                  Asunto
                </label>
                <label class="textarea">
                  <textarea name="asu" cols="70"  rows="2" ><?=$asu?></textarea>
                </label>
              </section>

              <section class="col col-6">
                  <label class="label">
                  <?php if($ent==2){
                    echo "Medio Recepci&oacute;n";
                  } else {
                        echo "Medio Env&iacute;o";
                  }

                  if($faxPath) $med=2;
                  if($tipoMedio) $med=4;
                  ?>
                  </label>
                  <label class="select">
                  <?php
                    $query = "Select MREC_DESC, MREC_CODI from MEDIO_RECEPCION WHERE MREC_CODI <>0 ";
                    $rs=$db->conn->query($query);
                    $varQuery = $query;
                    if($rs){
                      print $rs->GetMenu2("med", $med, "$opcMenu", false,"","class='select' " );
                    }
                  ?>
                  </label>
              </section>
            </div>

            <div class="row">

              <section class="col col-2">
                  <label class="label">
                    No. Folios
                  </label>
                  <label class="input">
                    <input name="nofolios" id="nofolios" type="text" size="10"  value="<?php echo htmlspecialchars(stripcslashes($nofolios));?>">
                  </label>
              </section>
              <section class="col col-2">
                  <label class="label">
                    No. Anexos
                  </label>
                  <label class="input">
                    <input name="noanexos" id="noanexos" type="text" size="10"  value="<?php echo htmlspecialchars(stripcslashes($noanexos));?>">
                  </label>
              </section>
              <section class="col col-2">
                  <label class="label">
                    Descripci&oacute; Anexos
                  </label>
                  <label class="input">
                      <input name="ane" id="ane" type="text" size="70"  value="<?php echo htmlspecialchars(stripcslashes($ane));?>">
                  </label>
              </section>

              <section class="col col-3">
                  <label class="label">
                    Dependencia
                  </label>
                  <label class="select">
                    <?php
                    // Busca las dependencias existentes en la Base de datos...
                    if($radi_depe_actu_padre and $tipoanexo==0 and !$coddepeinf)  $coddepe = $radi_depe_actu_padre;
                      if(!$coddepe)
                      {
                        $coddepe=$dependencia;
                      }
                      /** Solo los documentos de entrada (ent=2) muestra la posibilidad de redireccion a otras dependencias
                        * @queryWhere String opcional para la consulta.
                        */
                      if($ent!=2 || $dependencia=="4240" )
                      {
                        $queryWhere =" and d.depe_codi = $dependencia ";
                      }
                      else
                      {
                        $queryWhere = "";
                      }
                      // Modificado SGD 11-Jul-2007
                      //$query = "select DEPE_NOMB,DEPE_CODI from dependencia $queryWhere order by depe_nomb";
                      switch( $GLOBALS['entidad'] )
                      {
                        case 'SGD':
                          $query = "SELECT ".$db->conn->Concat( "d.DEPE_CODI", "'-'", "d.DEPE_NOMB" ).", d.DEPE_CODI
                          FROM DEPENDENCIA d
                                            INNER JOIN usuario u ON u.depe_codi = d.depe_codi
                                            and u.usua_codi = 1
                                            and u.usua_esta = '1'
                                            and d.depe_estado = 1
                          $queryWhere
                          ORDER BY d.DEPE_CODI, d.DEPE_NOMB";
                          break;
                        default:
                          $query = "select DEPE_NOMB,DEPE_CODI from dependencia $queryWhere order by depe_nomb";
                          $query = "SELECT ".$db->conn->Concat( "d.DEPE_CODI", "'-'", "d.DEPE_NOMB" ).", d.DEPE_CODI
                          FROM DEPENDENCIA d
                                            INNER JOIN usuario u ON u.depe_codi = d.depe_codi
                                            and u.usua_codi = 1
                                            and u.usua_esta = '1'
                                            and d.depe_estado = 1
                          $queryWhere
                          ORDER BY d.DEPE_CODI, d.DEPE_NOMB";
                      }
                      $ADODB_COUNTRECS = true;
                      $rs=$db->conn->query($query);
                      $numRegs = "!".$rs->RecordCount();
                      $varQuery = $query;
                      $comentarioDev = "Muestra las dependencias";

                      if ($ent!=2  || $dependencia=="4240"  )
                        print $rs->GetMenu2("coddepe",$coddepe, "0:-- Seleccione una Dependencia --", false,false,"class='select'");
                      else
                        print $rs->GetMenu2("coddepe","", "0:-- Seleccione una Dependencia --", false,false,"class='select'");

                      $ADODB_COUNTRECS = false;
                    ?>
                  </label>
              </section>

              <section class="col col-3">
                <label class="label">
                  Tipo Documental
                </label>
                <label class="select">
                  <input name="hoj" type=hidden value="<? echo $hoj; ?>">
                  <?php
                    $query = "SELECT
                      SGD_TPR_DESCRIP
                      ,SGD_TPR_CODIGO
                      FROM
                        SGD_TPR_TPDCUMENTO
                    WHERE
                      SGD_TPR_TP$ent='1'
                      and SGD_TPR_RADICA='1'
                      ORDER BY SGD_TPR_DESCRIP ";
                  $opcMenu = "0:-- Seleccione un tipo --";
                  $fechaHoy = date("Y-m-d");
                  $fechaHoy = $fechaHoy . "";
                  $ADODB_COUNTRECS = true;

                  $rs=$db->conn->query($query);
                  if ($rs && !$rs->EOF ) {
                    $numRegs = "!".$rs->RecordCount();
                    $varQuery = $query;
                    print $rs->GetMenu2("tdoc", $tdoc, "$opcMenu", false,"","class='ecajasfecha' " );
                  }else {
                    $tdoc = 0;
                  }
                  $ADODB_COUNTRECS = false;
                  ?>
                </label>
              </section>
            </div>

            </section>

            </div>
          <?php
          // Comprueba si el documento es una radicaci�n nueva de entrada....
          if($tipoanexo==0 and $radicadopadre and !$radicadopadreseg and (!$Submit3  and !$Submit4)){
            if($radi_depe_actu_padre==999){
              echo "<font color=red >Documento padre se encuentra en Archivo</font>";
            } elseif($radi_depe_actu_padre and $rad0){
              $query= "select USUA_NOMB, USUA_CODI from usuario where depe_codi=$radi_depe_actu_padre and usua_codi=$radi_usua_actu_padre";
              $ADODB_COUNTRECS = true;
              $rs              = $db->conn->query($query);
              $numRegs         = "!".$rs->RecordCount();
              $ADODB_COUNTRECS = false;
              $varQuery        = $query;
              $comentarioDev   = "Muestra las dependencias";
              $usuario_padre   = $rs->fields["USUA_NOMB"];
              $cod_usuario_inf = $rs->fields["USUA_CODI"];
              $coddepeinf      = $radi_depe_actu_padre;
              $informar_rad    = "Informar";
              $observa_inf     = "(Se ha generado un anexo pero ha sido enviado a la dependencia $coddepe)";
              ?>
              <input type=hidden name=radi_depe_actu_padre value="<?=$radi_depe_actu_padre?>">
              <input type=hidden name=coddepeinf value="<?=$coddepeinf?>">
              <input type=hidden name=cod_usuario_inf value="<?=$cod_usuario_inf?>">
              <?
            }
          }

          include("$ruta_raiz/include/tx/Tx.php");
          include("$ruta_raiz/include/tx/Radicacion.php");
          include("$ruta_raiz/class_control/Municipio.php");

          $hist = new Historico($db);
          $Tx   = new Tx($db);

          if($Submit3 == "Radicar") {

            echo  "<input type=hidden name='nurad'          value='$nurad'>";
            echo  "<input type=hidden name='codusuarioActu' value='$codusuarioActu'>";
            echo  "<input type=hidden name='codieesp'       value='$codieesp'>";
            echo  "<input type=hidden name='flag'           value='$flag'>";


            $ddate     = date("d");
            $mdate     = date("m");
            $adate     = date("Y");
            $fechproc4 = substr($adate,2,4);
            $fechrd    = $ddate.$mdate.$fechproc4;

            if($fechproc12 == ''){
              $fechproc12=date('d');
              $fechproc22=date('m');
              $fechproc32=date('y');
            }

            $fechrdoc       = $fecha_gen_doc;
            $apl           .= "";
            $apl            = trim(substr($apl,0,50));
            $sapl          .= "";
            $sapl           = trim(substr($sapl,0,50));
            $pnom          .= "";
            $pnom           = trim(substr($pnom,0,89));
            $adress        .= "";
            $tip_rem       += 0;
            $tip_doc       += 0;
            $numdoc        .= '';
            $numdoc         = trim(substr($numdoc,0,13));
            $long           = strlen($cod);
            $codep         += 0;
            $tel           += 0;
            $cod           += 0;
            $radicadopadre .= '';
            $asu           .= '';
            $tip_rem        = $tip_rem-1;
            $rem2          .= '';
            $dep           += 0;
            $hoj           += 0;
            $codieesp      += 0;
            $ane           .= '';
            $med           += 0;
            $acceso         = 1;

            if($acceso != 0){
              if($tip_rem < 0){
                $tip_rem=0;
              }

              if(!$documento_us3){
                $documento_us3 = 0;
              }

              if($ent != 2) {
                $carp_codi =$ent;
                $carp_per = "0";
                $radi_usua_actu = $codusuario;
              } else {
                $carp_codi ="0";
                $carp_per = "0";
                if($cod_usuario_inf!=1 and $coddepeinf==$coddepe){
                  $radi_usua_actu = $cod_usuario_inf;
                } else {
                  $radi_usua_actu = 1;
                }
              }

              if(!$radi_usua_actu and $ent == 2){
                $radi_usua_actu = $codusuario;
              }

              if(!$radi_usua_actu){
                $radi_usua_actu = 1;
              }

              if($coddepe==999){
                $carp_codi=substr($dependencia,0,2);
                $carp_per=1;
                $radi_usua_actu = 1;
              }

              if(!$radi_usua_actu){
                $radi_usua_actu==1;
              }

              if($radi_usua_actu_padre and $radi_depe_actu_padre){
                    $radi_usua_actu= "$radi_usua_actu_padre";
                    $coddepe= "$radi_depe_actu_padre";
              }

              if($ent==2 && $dependencia=="4240"){
                $radi_usua_actu = $codusuario;
              }

              // Buscamos Nivel de Usuario Destino
              $tmp_mun           = new Municipio($db);
              $tmp_mun->municipio_codigo($codep_us1,$muni_us1);
              $rad               = new Radicacion($db);
              $rad->radiTipoDeri = $tpRadicado;
              $rad->radiCuentai  = "'".trim($cuentai)."'";
              $rad->eespCodi     = $documento_us3;
              $rad->mrecCodi     = $med; // "dd/mm/aaaa"
              $fecha_gen_doc_YMD = substr($fecha_gen_doc,6 ,4)."-".substr($fecha_gen_doc,3 ,2)."-".substr($fecha_gen_doc,0 ,2);
              $rad->radiFechOfic =  "".$fecha_gen_doc_YMD."";

              if(!$radicadopadre){
                $radicadopadre = null;
              }

              $rad->radiNumeDeri = trim($radicadopadre);
              $rad->radiPais     = $tmp_mun->get_pais_codi();
              $rad->descAnex     = $ane;
              $rad->radiDepeActu = "'".$coddepe."'";
              $rad->radiDepeRadi = "'".$coddepe."'";
              $rad->radiUsuaActu = $radi_usua_actu;
              $rad->trteCodi     = $tip_rem;
              $rad->tdocCodi     = $tdoc;
              $rad->nofolios     = $nofolios;
              $rad->noanexos     = $noanexos;
              $rad->guia         = $guia;
              $rad->tdidCodi     = $tip_doc;
              $rad->carpCodi     = $carp_codi;
              $rad->carPer       = $carp_per;
              $rad->trteCodi     = $tip_rem;
              $rad->raAsun       = substr(htmlspecialchars(stripcslashes($asu)),0,349);

              if (strlen(trim($aplintegra)) == 0){
                $aplintegra = "0";
              }

              $rad->sgd_apli_codi = $aplintegra;
              $codTx = 2;
              $flag = 1;

              $noRad = $rad->newRadicado($ent, $tpDepeRad[$ent]);

              if ($noRad=="-1"){
                die("
                    <div class=\"col col-4\">
                      <div class=\"well\">
                        <h1><span class=\"semi-bold\">
                          Error no genero un Numero de Secuencia o Inserto el radicado
                          <br><br><br>
                          <small class=\"text-error slideInRight fast animated\">
                            <strong>
                            </strong>
                          </small></h1>
                      </div>
                    </div>
                ");
              }

              $radicadosSel[0] = $noRad;
              $hist->insertarHistorico($radicadosSel,  $dependencia , $codusuario, $coddepe, $radi_usua_actu, " ", $codTx);
              $nurad = $noRad;

              echo "<INPUT TYPE=HIDDEN NAME=nurad value=$nurad>";
              echo "<INPUT TYPE=HIDDEN NAME=flag value=$flag>";

                if($noRad){
                  $var_envio = session_name()."=".session_id()."&faxPath&leido=no&krd=$krd&verrad=$nurad&ent=$ent"; ?>

                  <div class="col col-4">
                    <div class="well">
                      <fieldset>
                        <h1>
                          <span class="semi-bold">Se ha generado el radicado</span> <span class="glyphicon glyphicon-ok text-success"></span><br><br>
                          <small class="text-success slideInRight fast animated">
                            <strong>
                              No. <?=$nurad?>
                            </strong>
                          </small>
                        </h1>
                        <br>
                        <p>
                          <?php if($_SESSION["enviarMailMovimientos"]==1){
                            $rutaImagen = substr($nurad,0,4)."/".substr($nurad,4,3)."/".$nurad.".tif";
                            $linkImagenes = "<a href='*SERVIDOR_IMAGEN*".$rutaImagen."'> Documento</a>";
                            $radicadosSelText = $nurad;
                            $usuaCodiMail = $radi_usua_actu;
                            $depeCodiMail = $coddepe;

                            include "../include/mail/mailInformar.php";
                          }
                          if($faxPath){
                            $varEnvio = session_name()."=".session_id()."&faxPath&leido=no&krd=$krd&faxPath=$faxPath&nurad=$nurad&ent=$ent";
                            ?>
                            <input class="botones_largo" value ="SUBIR IMAGEN DE FAX" type=button target= 'UploadFax' onclick="window.open('uploadFax.php?<?=$varEnvio?>','Cargar Archivos de Fax', 'height=300, width=400,left=350,top=300')">
                          <?php }

                          if($tipoMedio=="eMail"){
                            $varEnvio = session_name()."=".session_id()."&nurad=$nurad";
                            ?>
                            <input class="botones_largo" value ="ASOCIAR EMAIL A RADICADO" type=button target= 'UploadFax' onclick="window.open('../email/uploadMail.php?<?=$varEnvio?>','formulario', 'height=400, width=640,left=350,top=300')">
                            <?php
                          }?>
                        </p>
                        <input type=hidden id=numeroRadicado name=numeroRadicado value='<?=$nurad?>' />
                      </fieldset>
                    </div>
                  </div>
              <?php
              }else{
                echo "
                    <div class=\"col-sm-12\">
                      <div class=\"well\">
                        <h1><span class=\"semi-bold\">
                          Ha ocurrido un Problema<br>Verfique los datos e intente de nuevo
                          <br><br>
                          <small class=\"text-error slideInRight fast animated\">
                            <strong>
                            </strong>
                          </small></h1>
                      </div>
                    </div>";
              }
              $sgd_dir_us2 = 2;
              $conexion    = $db;
              $verradicado = $nurad;
              include("grb_direcciones.php");
            }
          }

          $vector = $coddepeinf;
          if($vector){
            error_reporting(0);
            foreach ($vector as $key => $coddepeinf){

              if( ($coddepeinf!=999) and ($Submit3 or $Submit4)){
                $flag=0;
                if(($coddepeinf!=$coddepe or ($cod_usuario_inf!=1 and $coddepeinf==$coddepe)) and $Submit3 and $ent==2){

                  /**
                    * INFORMACION DE ENVIO DE UN RADICADO EL CUAL EL PADRE ESTA EN UNA DEPENDENCIA DIFERENTE
                    * $observa_add   contiene el mensaje que se enviara al informado
                    * El mensaje cambia dependiendo a la persona que va.
                    * Si va a un funcinario le informa al jefe de lo contrario informa a la otra dependencia
                    **/
                  if($cod_usuario_inf!=1 and $coddepeinf==$coddepe and $ent==2){
                    $observa_inf = "El documento Anexo del Radicado $radicadopadre se envio directamente al funcionario";
                    $cod_usuario_inf = 1;
                  } else {
                    $observa_inf = "El documento Anexo del Radicado $radicadopadre se envio a la dep. $coddepe";
                    $cod_usuario_inf = 1;
                  }
                } else {
                  if(!$Submit4){
                    $observa_add = "";
                    $coddepeinf="";
                  }
                }
                /** AQUI SE ENTRA A MODIFICAR EL RADICADO * */

                if(( ($Submit4 and $coddepeinf!=$coddepe)) ){

              /**
                *	La siguiente decicion pregunta si la dependencia con la cual sale el radicado es
                * a misma que se pretende informar, ademas si es el jefe. En este caso no informa.
                */
                $observa = "$observa_inf";
                if(!$cod_usuario_inf) $cod_usuario_inf=1;
                $nombTx = "Informar Documentos";
                $radicadoSel[0] = $nurad;
                $txSql = $Tx->informar($radicadoSel, $krd,"'".$coddepeinf."'","'".$dependencia."'", $cod_usuario_inf,$codusuario, $observa, $_SESSION['usua_doc'], $ruta_raiz);
                $flagHistorico = true;
                }
              }
            }
          }

          $coddepeinf = $vector;
          if($Submit4 and !$Buscar){
              $secuens=str_pad($consec,6,"0",STR_PAD_LEFT);
              $fechproc4=substr($adate,2,4);
              $fechrd=$ddate.$mdate.$fechproc4;
              $fechrdoc=$fechproc12.$fechproc22.$fechproc32;
              $apl .=' ';$apl=trim(substr($apl,0,50));
              $sapl .=' ';$sapl=substr($sapl,0,50);
              $pnom .=' ';$pnom =substr($pnom,0,89);
              $adress .=' ';
              $tip_rem +=0;$tip_doc +=0;$numdoc .='';$numdoc =trim(substr($numdoc,0,13));
              $codieesp +=0;$radicadopadre +=0;$long=strlen($cod);
              $codep +=0;$tel +=0;$cod +=0;$asu.='';$tip_rem=$tip_rem-1;
              $guia +=0;
              $nofolios +=0;
              $noanexos +=0;
              $rem2.='';
              $dep +=0;
              $hoj +=0;
              $ane .='';
              $med +=0;
              if($tip_rem<0)
              {
                $tip_rem=0;
              }
              if(!$documento_us3)
              {
                $documento_us3 = 0;
              }
              /**  En esta linea si la dependencia es 999 ke es la dep. de salida envia el radicado a una
                *	 carpeta con el codigo de los dos primeros digitos de la dependencia
                */
              $carp_codi=$ent;
              $carp_per=0;
              if(!$radi_usua_actu) $radi_usua_actu = 1;

              if($coddepe==999){
                $carp_codi=substr($dependencia,0,2);
                $carp_per=1;
                $radi_usua_actu = 1;
              }

              $rad                                = new Radicacion($db);
              $rad->radiTipoDeri                  = $tpRadicado;
              $rad->radiCuentai                   = "'$cuentai'";
              $rad->eespCodi                      = $documento_us3;
              $rad->mrecCodi                      = $med;
              $rad->radiFechOfic                  = $fecha_gen_docF;
              $fecha_gen_doc_YMD                  = substr($fecha_gen_doc,6 ,4)."-".substr($fecha_gen_doc,3 ,2)."-".substr($fecha_gen_doc,0 ,2);
              $rad->radiFechOfic                  = $fecha_gen_doc_YMD;

              if(!$radicadopadre)  $radicadopadre = null;
              $rad->radiNumeDeri                  = $radicadopadre;
              $rad->radiPais                      = "'$pais'";
              $rad->descAnex                      = $ane; $rad->raAsun = substr(htmlspecialchars(stripcslashes($asu)),0,349);
              $rad->radiDepeActu                  = $coddepe;
              $rad->radiUsuaActu                  = $radi_usua_actu;
              $rad->trteCodi                      = $tip_rem;
              $rad->tdocCodi                      = $tdoc;
              $rad->tdidCodi                      = $tip_doc;
              $rad->nofolios                      = $nofolios;
              $rad->noanexos                      = $noanexos;
              $rad->guia                          = $guia;
              $rad->carPer                        = $carp_per;
              $rad->trteCodi                      = $tip_rem;
              $rad->ra_asun                       = $asu;

              if (strlen(trim($aplintegra)) == 0)
                $aplintegra = "0";

              $rad->sgd_apli_codi = $aplintegra;
              $resultado = $rad->updateRadicado($nurad);
              $conexion = $db;
              include "grb_direcciones.php";
              if($resultado) {
                echo "
                <div class=\"col col-4\">
                  <div class=\"well\">
                    <fieldset>
                      <h1>
                        <span class=\"semi-bold\">Se ha modificado el radicado</span> <span class=\"glyphicon glyphicon-ok text-success\"></span><br><br>
                        <small class=\"text-success slideInRight fast animated\">
                          <strong>
                            No. $nurad
                          </strong>
                        </small>
                      </h1>
                      <br>
                      <p>
                      </p>
                    </fieldset>
                  </div>
                </div>";

                $radicadosSel[] = $nurad;
                $codTx = 11;
                $hist->insertarHistorico($radicadosSel,  $dependencia , $codusuario, $coddepe, $radi_usua_actu, "Modificacion Documento.", $codTx);
              }

              if($borrarradicado) {
                $flag             = 0;
                $observa          = "Se borro de Inf. ($krd)";
                $depbrr           = substr($borrarradicado,0,3);
                $fechbrr          = substr($borrarradicado,3,20);
                $data6            = substr($borrarradicado,3,50);
                $radicadosSel [0] = $nurad;
                $nombTx           = "Borrar Informados";
                $codTx            = 7;
                //$txSql = $rs->borrarInformado( $radicadosSel, $krd,$depbrr,$dependencia,$usCodSelect, $codusuario);
                $isql_inf= "delete from informados where depe_codi=$depbrr and radi_nume_radi=$nurad and info_desc like '%$data6%'";
                $rs=$db->conn->query($isql_inf);
                $hist->insertarHistorico($radicadosSel,  $dependencia , $codusuario, $coddepe, $radi_usua_actu, $observa, $codTx);
                if($flag==1) {
                  echo "
                      <div class=\"col col-4\">
                        <div class=\"well\">
                          <fieldset>
                            <h4>
                              <span class=\"semi-bold\">
                              Se ha borrado un Inf. y registrado en eventos
                            </h4>
                            <br>
                          </fieldset>
                        </div>
                      </div>";

                }else{
                  echo "
                      <div class=\"col-col-4\">
                        <div class=\"well\">
                          <fieldset>
                            <h4>
                              <span class=\"semi-bold\">
                                No se ha borrado la inf. de la dependencia $depbrr
                            </h4>
                            <br>
                          </fieldset>
                        </div>
                      </div>";
                }
              }
            }

            echo "<INPUT TYPE=HIDDEN NAME=codusuarioActu value=$codusuarioActu>";
            echo "<INPUT TYPE=HIDDEN NAME=radicadopadre value=$radicadopadre>";
            echo "<INPUT TYPE=HIDDEN NAME=radicadopadreseg value=2>";
            echo "<INPUT TYPE=HIDDEN NAME='codieesp' value='$codieesp'>";
            echo "<INPUT TYPE=HIDDEN NAME='consec' value='$consec'>";
            echo "<INPUT TYPE=HIDDEN NAME='seri_tipo' value='$seri_tipo'>";
            echo "<INPUT TYPE=HIDDEN NAME='radi_usua_actu' value='$radi_usua_actu'>";
            $nombre = $nombre_us1 . " ".$prim_apel_us1. " ".$sseg_apel_us2;

            if(!$Submit3 and !$Submit4){?>

            <footer>
              <center>
                <input type='button' onClick='radicar_doc()' name='Submit33' value='Radicar' class="btn btn-primary">
                <input type='hidden'  name='Submit3' value='Radicar' class='ebuttons2'>
              </center>
            </footer>

            <?php }else{
              $varEnvio = session_name()."=".session_id()."&faxPath&leido=no&krd=$krd&faxPath=$faxPath&verrad=$nurad&nurad=$nurad&ent=$ent&remite=$nombre&dependenciaDestino=$dependencia";
            ?>
                <div class="col col-4">
                  <div class="well">
                    <fieldset>
                      <ul class="demo-btns">
                        <li>
                          <input type='button' onClick='modificar_doc()' name='Submit44' value='Modificar datos' class="btn btn-success btn-sm">
                        </li>
                        <li>
                          <a class="btn btn-info  btn-sm" href="hojaResumenRad.php?<?=$varEnvio?>" target="HojaResumen<?=$nurad?>">Ver Hoja Resumen</a><br>
                        </li>
                        <li>
                          <a class="btn btn-info  btn-sm" href="javascript:void(0);" onClick="window.open ('stickerWeb/index.php?<?=$varEnvio?>&alineacion=Center','sticker<?=$nurad?>','menubar=0,resizable=0,scrollbars=0,width=450,height=180,toolbar=0,location=0');">Sticker</a>
                        </li>
                        <li>
                          <a class="btn btn-info  btn-sm" href="javascript:void(0);" onClick="window.open ('../uploadFiles/uploadFileRadicado.php?busqRadicados=<?=$nurad?>&Buscar=Buscar&<?=$varEnvio?>&alineacion=Center','busqRadicados=<?=$nurad?>','menubar=0,resizable=0,scrollbars=0,width=550,height=280,toolbar=0,location=0');">Asociar Imagen</a>
                        </li>
                      </ul>
                      <input type='hidden'  name='Submit4' value='MODIFICAR DATOS' class='ebuttons2'>
                      <input type='hidden' name='nurad' value='<?=$nurad?>'></center>
                    </fieldset>
                  </div>
                </div>

            <?}

            if(($Submit4 or $Submit3) AND !$Buscar){
              if($ent==1 and !$Submit3){
                $radicar_documento = "true";
                if($num_archivos==1 and $radicado=="false"){
                  $generar_numero = "no";
                  $vp = "n";
                  $radicar_a="$nurad";
                  error_reporting(0);
                }
              }

              switch( $GLOBALS['entidad'] ){
                case 'SGD':
                  $query = "SELECT  ".$db->conn->Concat( "DEPE_CODI", "' - '", "DEPE_NOMB" ).", DEPE_CODI
                    FROM DEPENDENCIA
                    ORDER BY DEPE_CODI, DEPE_NOMB";
                  break;
                default:
                  $query ="select  ". $db->conn->concat('d.depe_nomb',"' ('",'u.USUA_LOGIN',"')'") ." AS DEPE_NOMB, d.DEPE_CODI
                    from DEPENDENCIA d, usuario u
                    WHERE
                    u.depe_codi=d.depe_codi
                    and u.usua_codi=1
                    ORDER BY d.DEPE_NOMB
                    ";
                }
                $rs=$db->conn->query($query);
                $varQuery = $query;
                ?>
                <div class="col col-4">
                  <div class="well">
                    <fieldset class="smart-form">
                      <label class="label">
                        <input type='button' onClick='modificar_doc()' name='Submit44' value='Modificar datos' class="btn btn-success btn-xs">
                      </label>
                      <label class="select select-multiple">
                        <?php print $rs->GetMenu2("coddepeinf", $coddepeinf, false, true,3,"class='custom-scroll'")?>
                      </label>

                      <table class="table table-bordered table-striped">
                        <thead>
                          <tr>
                            <th>Informado a</th>
                          </tr>
                        </thead>
                        <tbody>
                          <?php
                            $query2 = "select b.DEPE_NOMB
                                  ,a.INFO_DESC
                                  ,b.DEPE_NOMB
                                  ,a.DEPE_CODI
                                  ,a.info_fech as INFO_FECH
                                  ,INFO_DESC
                                  from informados a,dependencia b
                                  where a.depe_codi=b.depe_codi and a.radi_nume_radi ='$nurad'
                                  order by info_fech desc ";

                            $k = 1;
                            $rs=$db->conn->query($query2);
                            if ($rs){
                              while (!$rs->EOF){
                                $data = $rs->fields['INFO_DESC'];
                                $data2 = $rs->fields['DEPE_NOMB'];
                                $data3 = $rs->fields['DEPE_CODI'];
                                $data4 = date("dMy",$rs->fields['INFO_FECH']);
                                $data5 = date( "d-m-Y", $db->conn->UnixTimeStamp( $rs->fields['INFO_FECH'] ) );
                                $data6 = $db->conn->UnixTimeStamp( $rs->fields['INFO_DESC'] );
                                ?>
                                <tr><td class="text-success">
                                  <input type='radio' name='borrarradicado' value='<?=$data3.$data6?>'>
                                  <?=$data?> <?=$data2?> <?=$data5?>
                                </td></tr>
                                <?php
                                $k = $k +1;
                                $rs->MoveNext();
                              }
                            }?>
                        </tbody>
                      </table>
                      <p>Seleccione un doc. de Informado para borrar</p>
                    </fieldset>
                  </div>
                </div>
                <?php
              }

              ?>
              <input type='hidden' name='depende' value='<?php echo $depende; ?>'><BR>
              <?php
              $verrad = $nurad;
              $radi   = $nurad;
              $contra = $drde;
              $tipo   = 1;

              if($Submit3 or $Submit4 or $rad0 or $rad1 or $rad2){
                echo "<script language='JavaScript'>";
                for ($i=1; $i<=3; $i++){
                  $var_pai = "idpais".$i;
                  $var_dpt = "codep_us".$i;
                  $var_mcp = "muni_us".$i;
                  $muni_tmp = ${$var_mcp};
                  if (!(is_null($muni_tmp))){
                    echo "\n";
                    echo "cambia(document.formulario, 'idpais$i', 'idcont$i');
                      formulario.idpais$i.value = ${$var_pai};
                      cambia(document.formulario, 'codep_us$i', 'idpais$i');
                      formulario.codep_us$i.value = '${$var_dpt}';
                      cambia(document.formulario, 'muni_us$i', 'codep_us$i');
                      formulario.muni_us$i.value = '${$var_mcp}';";
                  }
                }
                echo "</script>";
              } ?>
      </div>
  </form>

  <script type="text/javascript">

    $(document).ready(function() {

      // DO NOT REMOVE : GLOBAL FUNCTIONS!
      pageSetUp();


      // DATEPICKER MUESTRA FECHA
      $('#date').datepicker({
        dateFormat : 'yy/mm/dd',
        onSelect : function(selectedDate) {
          $('#date').datepicker('option', 'maxDate', selectedDate);
        }
      });

      // AUTOCOMPLETE BUSQUEDA DE USUARIOS
      $("#documento_us, nombre_us, telefono_us, mail_us").autocomplete({
        source: function( request, respond ) {
          $.post( "./NEW.php", {student: request.term },
            function( response ) {
              //do something
            }
          );
        }
      });

    });

  </script>
</body>
</html>
