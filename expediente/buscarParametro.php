<?
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
$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$ruta_raiz   = "..";

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

require_once("$ruta_raiz/include/db/ConnectionHandler.php");
if (!$db)
	$db = new ConnectionHandler("$ruta_raiz");
  $db->conn->SetFetchMode( ADODB_FETCH_ASSOC );
	// $db->conn->SetFetchMode(ADODB_FETCH_NUM);
	//b->conn->debug = true;

    // Consulta los par�etros creados para la dependencia
    $sqlBuscarPor  = "SELECT SGD_PAREXP_CODIGO, SGD_PAREXP_ETIQUETA, SGD_PAREXP_ORDEN";
    $sqlBuscarPor .= " FROM SGD_PAREXP_PARAMEXPEDIENTE PE";
    $sqlBuscarPor .= " WHERE PE.DEPE_CODI = ( ";
    $sqlBuscarPor .= " SELECT U.DEPE_CODI";
    $sqlBuscarPor .= " FROM USUARIO U WHERE USUA_LOGIN = '".$krd."'";
    $sqlBuscarPor .= " )";
    // print $sqlBuscarPor;
    $rsBuscarPor = $db->query( $sqlBuscarPor );

    while( $rsBuscarPor && !$rsBuscarPor->EOF ){
        $arrComboBuscarPor[ $rsBuscarPor->fields['SGD_PAREXP_CODIGO'] ] = $rsBuscarPor->fields['SGD_PAREXP_ETIQUETA'];
        $arrParametro[ $rsBuscarPor->fields['SGD_PAREXP_ORDEN'] ] = $rsBuscarPor->fields['SGD_PAREXP_ETIQUETA'];
        $rsBuscarPor->MoveNext();
    }
?>
<html>
<head>
  <title>Busqueda Remitente / Destino</title>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>

  <script>

    function pasar_datos( idParametro, elemento ){
        dato = eval( 'document.forma.' + elemento + '.value' );
        eval( 'opener.document.TipoDocu.parExp_' + idParametro + '.value = dato' );
    }

    function procEst2(forma,tb){
      var lista = document.forma.codep.value;
      i = document.forma.codep.value;
      if (i != 0) {
        var dropdownObjectPath = document.forma.tip_doc;
        var wichDropdown = "tip_doc";
        var d=tb;
        var withWhat = document.forma.codep_nus.value;
        populateOptions2(wichDropdown, withWhat,tb);
      }
    }

    function procEst(forma,tbres){
        var lista = document.forma.codep_nus.value;
      i = document.forma.codep_nus.value;

      if (i != 0) {
        var dropdownObjectPath = document.forma.muni_nus;
        var wichDropdown = "muni_nus";
        var d=tbres;
          var withWhat = document.forma.codep_nus.value;
        populateOptions(wichDropdown, withWhat,tbres);

        }
    }

    cc_documento = new Array();
    nombre       = new Array();
    apell1       = new Array();
    apell2       = new Array();
    direccion    = new Array();
    dpto         = new Array();
    muni         = new Array();

    function pasar( indice, tipo_us ){
    <?
      $i_registros = count( $arrParametro );

      for( $i = 1; $i <= $i_registros; $i++ ){
            print "if( tipo_us == $i ){
                document.forma.cc_documento_us$i.value = cc_documento[indice];
                document.forma.nombre_us$i.value = nombre[indice];
                document.forma.prim_apell_us$i.value = apell1[indice];
                document.forma.seg_apell_us$i.value = apell2[indice];
                document.forma.direccion_us$i.value = direccion[indice];
                document.forma.dpto_us$i.value = dpto[indice];
                document.forma.muni_us$i.value = muni[indice];
            } ";
      }?>
    }
  </script>
</head>
<body>
<?php

    if($tagregar and $agregar) {
      $tbusqueda = $tagregar;
    }

		if($no_documento1 and ($agregar or $modificar)){
		  $no_documento = $no_documento1;
		}

		if(!$no_documento1 and $nombre_nus1  and ($agregar or $modificar)){
			$nombre_essp = $nombre_nus1;
		}

    if(!$forma) {
?>
<form action='buscarParametro.php?busq_salida=<?=$busq_salida?>&krd=<?=$krd?>&verrad=<?=$verrad?>&nombreTp1=<?=$nombreTp1?>&nombreTp2=<?=$nombreTp2?>&nombreTp3=<?=$nombreTp3?>&ent=<?=$ent?>' method="post" name="forma" >
<?  }
echo "<input type=hidden name=radicados value='$radicados_old'>";
?>
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

              <header>
                <h2> Buscar </h2>
              </header>

              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body no-padding">
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr>
                        <td width="33%" class="titulos5">
                          <font face="Arial, Helvetica, sans-serif" class="tituloListado">
                          BUSCAR POR
                          </font>
                        </td>
                        <td class="titulos5">
                          <select name=tbusqueda class="select">
                          <?php foreach ( $arrComboBuscarPor as $idBuscarPor => $valorBuscarPor ) {
                            if($tbusqueda==$idBuscarPor) $datoss = " selected "; else $datoss = " ";
                              print "<option value='$idBuscarPor'  $datoss>$valorBuscarPor</option>";
                            }
                          ?>
                          </select>
                        </td>
                            <td class="listado5" width="31%">
                              <input type="text" name="campoBuscar" value='<?=$_POST["campoBuscar"]?>' class="tex_area" size="50">
                            </td>
                        <td width="31%" rowspan="2" align="center" class="titulos5" >
                              <input type=submit name=buscar value='BUSCAR' class="botones">
                        </td>
                      </tr>
                    </table>
                  </div>

                  <header>
                    <h2> Resultado de busqueda </h2>
                  </header>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <!--DWLayoutTable-->
                      <tr class="titulo5" align="center">
                        <td width="10%"  class="titulos5">DOCUMENTO</td>
                        <td width="12%" class="titulos5">NOMBRE</td>
                        <td width="14%" class="titulos5">PRIM.<br>
                          APELLIDO o SIGLA</td>
                        <td width="16%" class="titulos5">SEG.<br>
                          APELLIDO o R Legal</td>
                        <td width="15%" class="titulos5">DIRECCION</td>
                        <td width="9%" class="titulos5">DPTO</td>
                        <td width="6%" class="titulos5">MUNIC</td>
                        <td colspan="3" class="titulos5">COLOCAR COMO </td>
                      </tr>
                  <?
                      $grilla = "timpar";
                      $i = 0;

                      if( $_POST['buscar'] == 'BUSCAR' && $_POST['campoBuscar'] != '' ){
                          $q_select  = "SELECT 	CASE	WHEN SGD_CAMEXP_FK = 0 THEN SGD_CAMEXP_CAMPO
                              WHEN SGD_CAMEXP_FK = 1 THEN SGD_CAMEXP_CAMPOVALOR END AS CAMPO,
                            CASE	WHEN SGD_CAMEXP_FK = 1 THEN PE.SGD_PAREXP_TABLA || '.' ||
                                    CE.SGD_CAMEXP_CAMPO || ' = ' ||
                                    CE.SGD_CAMEXP_TABLAFK || '.' ||
                                    CE.SGD_CAMEXP_CAMPOFK END AS FILTRO,
                            CASE	WHEN SGD_CAMEXP_FK = 0 THEN PE.SGD_PAREXP_TABLA
                              WHEN SGD_CAMEXP_FK = 1 THEN CE.SGD_CAMEXP_TABLAFK END AS TABLA,
                            CE.SGD_CAMPEXP_ORDEN,
                            CE.SGD_CAMEXP_CAMPOVALOR  AS CAMPO_GUARDAR
                          FROM SGD_CAMEXP_CAMPOEXPEDIENTE CE,
                            SGD_PAREXP_PARAMEXPEDIENTE PE
                          WHERE PE.SGD_PAREXP_CODIGO = CE.SGD_PAREXP_CODIGO AND
                            CE.SGD_PAREXP_CODIGO = " . $tbusqueda ;
                          $q_select .= " ORDER BY  CE.sgd_campexp_orden";

                          $rs_select = $db->query( $q_select );
                          
                          $c = 0;
                          $tmp_tabla = "";
                          if ( $rs_select->fields['CAMPO_GUARDAR'] != "" ) $campoGuardar = ",".$rs_select->fields['CAMPO_GUARDAR'];
                          while( !$rs_select->EOF ){
                              if ( $rs_select->fields['CAMPO'] != "" ) {
                                  $arr_select['campo'][ $c ] = $rs_select->fields['CAMPO'];
                              }
                              if ( $tmp_tabla != $rs_select->fields['TABLA'] ) {
                                  $arr_select['tabla'][ $c ] = $rs_select->fields['TABLA'];
                              }
                              if ( $rs_select->fields['FILTRO'] != "" ) {
                                  $arr_select['filtro'][ $c ] = $rs_select->fields['FILTRO'];
                              }

                              $c++;
                              $tmp_tabla = $rs_select->fields['TABLA'];
                              $rs_select->MoveNext();
                          }
													
                          $q_buscar  = "SELECT ".implode( ", ", $arr_select['campo'] ) ." $campoGuardar ";
                          $q_buscar .= " FROM ".implode( ", ", $arr_select['tabla'] );
                          $q_buscar .= " WHERE 1 = 1";
                          foreach( $arr_select['filtro'] as $valorFiltro ){
                              $q_buscar .= " AND ".$valorFiltro;
                          }
                          $q_buscar .= " AND (";
                          foreach ( $arr_select['campo'] as $valorCampo ){
                              if ( $q_filtro != "" )
                              {
                                  $strOR = " OR";
                              }
                              $q_filtro .= " ".$strOR." upper(".$valorCampo.") LIKE '%".strtoupper( $_POST['campoBuscar'] )."%'";
                          }

                          $q_buscar .= $q_filtro;
                          $q_buscar .= " )";
                          //print $q_buscar;
                          $db->conn->SetFetchMode( ADODB_FETCH_NUM );
                          $rsBuscar = $db->query( $q_buscar );
                          if( $rsBuscar && !$rsBuscar->EOF ){
                            while( !$rsBuscar->EOF ){
                            if( $grilla == "timparr" ){
                                $grilla = "timparr";
                            }
                            else{
                                $grilla = "tparr";
                            }
                          ?>
                          <tr class='<?=$grilla ?>'>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print $rsBuscar->fields[0];
                              ?>
                              </font>
                            </td>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print substr( $rsBuscar->fields[1], 0, 120 );
                              ?>
                              </font>
                            </td>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print substr( $rsBuscar->fields[2], 0, 70 );
                              ?>
                              </font>
                            </td>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print $rsBuscar->fields[3];
                              ?>
                              </font>
                            </td>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print $rsBuscar->fields[4];
                              ?>
                              </font>
                            </td>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print $rsBuscar->fields[5];
                              ?>
                              </font>
                            </td>
                            <td class="listado5">
                              <font size="-3">
                              <?
                                print $rsBuscar->fields[6];
                              ?>
                              </font>
                            </td>

                          <?php foreach ( $arrParametro as $idParametro => $valorParametro ){ ?>
                            <td width="5%" align="center" valign="top" class="listado5">
                              <font size="-3">
                                <a href="#datosExpediente" onClick="pasar( '<?=$i ?>', <?= $idParametro ?> );" class="titulos5" >
                                  <?php print $idParametro; ?>
                                </a>
                              </font>
                            </td>
                          <?php } ?>
                          </tr>
                      <script>
                        <?
                        $cc_documento = $rsBuscar->fields[0];
                        $nombre       = str_replace( '"', ' ', $rsBuscar->fields[1] );
                        $apell1       = str_replace( '"', ' ', $rsBuscar->fields[2] );
                        $apell2       = str_replace( '"', ' ', $rsBuscar->fields[3] );
                        $direccion    = str_replace( '"', ' ', $rsBuscar->fields[4] );
                        $dpto         = $rsBuscar->fields[5] ;
                        $muni         = $rsBuscar->fields[6] ;
                      ?>
                        cc_documento[<?=$i?>] = "<?=$cc_documento?>";
                        nombre[<?=$i?>] = "<?=$nombre?>";
                        apell1[<?=$i?>] = "<?=$apell1?>";
                        apell2[<?=$i?>] = "<?=$apell2?>";
                        direccion[<?=$i?>]= "<?=$direccion?>";
                        dpto[<?=$i?>]= "<?=$dpto?>";
                        muni[<?=$i?>]= "<?=$muni?>";
                    </script>
                      <?
                          $i++;
                          $rsBuscar->MoveNext();
                        }
                        echo "<span class='listado2'>Registros Encontrados</span>";
                          }else{
                            echo "<span class='titulosError'>No se encontraron Registros -- $no_documento</span>";
                          }
                        } ?>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr class="listado2">
                        <TD colspan="10">
                        <center>DATOS A COLOCAR EN EL EXPEDIENTE</center>
                          <center><b>NOTA: Para pasar el dato al formulario de creacion del expediente, por favor haga click en el B
                          APELLIDO o REP LEGAL</font></td>
                      </tr>

                      <?php foreach ( $arrParametro as $idParametro => $valorParametro ){ ?>
                      <tr class='<? print $grilla; ?>' >

                        <td align="center"  class="listado5" >
                          <font face="Arial, Helvetica, sans-serif">
                            <?php
                              print $idParametro." - ".$valorParametro;
                            ?>
                          </font>
                        </td>

                        <td align="center" class="listado5"><input type=hidden name='tipo_emp_us1' value='<?=$tipo_emp_us1?>'  |class=e_cajas  class="tex_area" >
                            <input type='text' name='cc_documento_us<?= $idParametro; ?>' value='<?= $_POST['cc_documento_us'.$idParametro]; ?>' class='e_cajas' size=13 class="tex_area" onClick="pasar_datos( '<?= $idParametro; ?>', 'cc_documento_us<?= $idParametro; ?>' );" onMouseOver="this.style.cursor='pointer'" readonly>
                        </td>

                        <td align="center" class="listado5">
                            <input type='text' name='nombre_us<?= $idParametro; ?>' value='<?= $_POST['nombre_us'.$idParametro]; ?>' class='ecajasfecha' size='15' onClick="pasar_datos( '<?= $idParametro; ?>', 'nombre_us<?= $idParametro; ?>' );" onMouseOver="this.style.cursor='pointer'" readonly>
                        </td>

                        <td align="center" class="listado5">
                            <input type='text' name='prim_apell_us<?= $idParametro; ?>' value='<?= $_POST['prim_apell_us'.$idParametro]; ?>' class='ecajasfecha' size='14' onClick="pasar_datos( '<?= $idParametro; ?>', 'prim_apell_us<?= $idParametro; ?>' );" onMouseOver="this.style.cursor='pointer'" readonly>
                        </td>

                        <td align="center" class="listado5">
                            <input type='text' name='seg_apell_us<?= $idParametro; ?>' value='<?= $_POST['seg_apell_us'.$idParametro]; ?>' class='ecajasfecha' size='14' onClick="pasar_datos( '<?= $idParametro; ?>', 'seg_apell_us<?= $idParametro; ?>' );" onMouseOver="this.style.cursor='pointer'" readonly>
                        </td>

                      </tr>
                  <?php } ?>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <a href="javascript:opener.focus(); window.close()" >
                        <span class="botones_largo">CERRAR</span>
                      </a>
                    </table>
                  </div>

              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>

<?  if(!$forma){ ?>
</form>
<?  } ?>

</body>
</html>
