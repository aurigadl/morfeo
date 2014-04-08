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
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


$ruta_raiz = "../../..";
$entrada = 0;
$modificaciones = 0;
$salida = 0;
include_once "$ruta_raiz/include/query/flujos/queryEtapas.php";
include_once "$ruta_raiz/include/query/flujos/queryAristas.php";
?>

<header>
  <h2>
    Etapas que tiene el flujo actualmente <br>
  </h2>
</header>

<div class="table-responsive">
  <table class="table table-bordered table-striped">
    <tr bgcolor='#6699cc' class='etextomenu' align='middle'>
        <th width='5%'  class="titulos2">ORDEN</th>
        <th width='5%'  class="titulos2">C&Oacute;DIGO</th>
        <th  width='80%' class="titulos2">DESCRIPCI&Oacute;N</th>
        <th width='10%'  class="titulos2">DURACI&Oacute;N (D&iacute;as)</th>
        <?php if ($crear == 0) { ?>
          <th width='15%'  class="titulos2">ELIMINAR</th>
          <th  width='5%' class="titulos2">MODIFICAR</th>
        <?php } ?>
    </tr>
    <?php
    $rs=$db->query($sqlEtapas);
    while(!$rs->EOF) {
      $nombreEtapa = $rs->fields["SGD_FEXP_DESCRIP"];
      $ordenEtapa = $rs->fields["SGD_FEXP_ORDEN"];
      $codigoEtapa  = $rs->fields["SGD_FEXP_CODIGO"];
      $terminos = $rs->fields["SGD_FEXP_TERMINOS"];
    ?>
    <tr>
      <td width="10%" class='listado2' >
        <center><? echo $ordenEtapa ?></center>
      </td>
      <td width="10%" class='listado2' >
        <center><? echo $codigoEtapa ?></center>
      </td>
      <td width="60%" class='listado2' >
        <center><? echo $nombreEtapa ?></center>

        <table class="table table-bordered table-striped">
        <tr bgcolor='#6699cc' class='etextomenu' align='middle'>
          <td width="80%" class='titulos2' ><center> CONEXIONES </center></td>
          <td width="20%" class='titulos2' ><center>
            Crear
              <a  href='javascript:Start("creaArista.php?<?=session_name().'='.session_id().'&$encabezado'?>&proceso=<?=$procesoSelected?>&etapaCreaArista=<?=$codigoEtapa?>",750,600)'>
                <img src="../../../imagenes/add.png" style="border:0">
              </a>
            </center>
          </td>
        </tr>
          <?php
            $sqlListadoAristasEntrada = "select * from sgd_fars_faristas where sgd_pexp_codigo = $procesoSelected  ";
            $sqlListadoAristasEntrada .= " and sgd_fexp_codigofin = $codigoEtapa order by  sgd_fars_codigo";

            $rsAristasEntrada=$db->query( $sqlListadoAristasEntrada );

            while( !$rsAristasEntrada->EOF ){
              $nombreArista = $rsAristasEntrada->fields["SGD_FARS_DESC"];
              $codigoArista  = $rsAristasEntrada->fields["SGD_FARS_CODIGO"];
              $codigoEtapaArista  = $rsAristasEntrada->fields["SGD_FEXP_CODIGOINI"];

              $sqlNombreEtapa = "select sgd_fexp_descrip from sgd_fexp_flujoexpedientes where sgd_fexp_codigo = $codigoEtapaArista";
              $rsNombreEtapa=$db->query( $sqlNombreEtapa );
              $nombreEtapaEntrada = $rsNombreEtapa->fields['SGD_FEXP_DESCRIP'];
              ?>
              <tr>
                <td width="10%" class='listado2' >
                  <img src="../../../imagenes/FlechasEntrada2b.gif">  <? echo $codigoArista ?> - <? echo $nombreArista ?> <font color="Green"> llega desde la etapa <? echo "'" . $nombreEtapaEntrada . "'" ?> </font>
                </td>
                <td width="10%" class='listado2' >
                  <center>
                    <a href='javascript:Start("modificaArista.php?<?=$phpsession ?>&aristaAModificar=<?=$codigoArista?>&proceso=<?=$procesoSelected?>",750,600)'>
                      <img src="../../../imagenes/modificar.gif">
                    </a>
                  </center>
                </td>
              </tr>
              <?php $rsAristasEntrada->MoveNext(); 
            }

            $sqlListadoAristasSalida = "select * from sgd_fars_faristas where sgd_pexp_codigo = $procesoSelected  ";
            $sqlListadoAristasSalida .= " and sgd_fexp_codigoini = $codigoEtapa order by  sgd_fars_codigo";

            $rsAristasSalida=$db->query( $sqlListadoAristasSalida );
            while( !$rsAristasSalida->EOF ){
                $nombreArista = $rsAristasSalida->fields["SGD_FARS_DESC"];
                $codigoArista  = $rsAristasSalida->fields["SGD_FARS_CODIGO"];
                $codigoEtapaArista  = $rsAristasSalida->fields["SGD_FEXP_CODIGOFIN"];

                $sqlNombreEtapa = "select sgd_fexp_descrip from sgd_fexp_flujoexpedientes where sgd_fexp_codigo = $codigoEtapaArista";
                $rsNombreEtapa=$db->query( $sqlNombreEtapa );
                $nombreEtapaSalida = $rsNombreEtapa->fields['SGD_FEXP_DESCRIP'];
                ?>
                <tr>
                    <td width="10%" class='listado2' >
                    <img src="../../../imagenes/FlechasSalida.gif"><? echo $codigoArista ?> - <? echo $nombreArista ?> <font color="Green"> sale a la etapa <? echo "'" . $nombreEtapaSalida . "'" ?> </font>
                    </td>
                    <td width="10%" class='listado2' >
                    <center>
                    <af href="modificaArista.php?<?=$phpsession ?>&aristaAModificar=<?=$codigoArista?>&proceso=<?=$procesoSelected?>" target="modificacinAristaInicial">
                      <img src="../../../imagenes/modificar.gif" onClick="Start('modificaArista.php?<?=$phpsession ?>&aristaAModificar=<?=$codigoArista?>&proceso=<?=$procesoSelected?>',600,600);" > </af>
                    </center>
                  </td>
                </tr>
                <?php
                $rsAristasSalida->MoveNext();
            }
            ?>
            </table>
        </td>

        <td width="10%" class='listado2' >
          <center><? echo $terminos ?></center>
        </td>

        <?php if ($crear == 0) { ?>
        <td width="60%" class='listado2' >
        <center> <?
 					include  ( "$ruta_raiz/include/query/flujos/queryEtapas.php" );

 					$cuentaAristas = 0;
 					$rsVerificaElim = $db->conn->Execute( $queryVerificaElim );
					$cuentaAristas = $rsVerificaElim -> fields["CUENTA"];

					 if($cuentaAristas > 0 ){
					 	$resultadoVerificacion = 1;
					 }else {
					 	$resultadoVerificacion = 0;
					 }

 				?>
          <input type="radio" name="etapaAEliminar" value="<?=$codigoEtapa?>" onchange="verificaEliminacion( <?=$codigoEtapa?>, <?=$resultadoVerificacion?>, this.form );">
        </center>
        </td>
        <td width="60%" class='listado2'>
          <center>
            <input type="image" name="Button" value="Modificar" src="../../../imagenes/modificar.gif" onClick="Start('modificaEtapa.php?<?=$phpsession ?>&etapaAModificar=<?=$codigoEtapa?>&proceso=<?=$procesoSelected?>',500,300);" >
          </center>
        </td>
    <?php } ?>
  </tr>
  <?php $rs->MoveNext(); } ?>
  </table>
</div>

