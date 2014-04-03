<?php
/**
* @module crearUsuario
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

	$ruta_raiz = "../..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");
  	include_once "$ruta_raiz/include/db/ConnectionHandler.php";

	$db = new ConnectionHandler($ruta_raiz);
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$nomcarpetaOLD = $nomcarpeta;

		if (!$carpeta)
		{
		  $carpeta = "0";
		  $nomcarpeta = "Entrada";
		}
?>
  <div class="col-sm-12">
    <!-- widget grid -->
    <section id="widget-grid">
      <!-- row -->
      <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!-- Widget ID (each widget will need unique ID)-->
          <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">
            <header>
              <h2>
                Administracion de usuarios y perfiles<br>
                <small><?=$tituloCrear ?></small>
              </h2>
            </header>

            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">

                <table class="table table-bordered table-striped">
                  <tbody>
                  <tr>
                    <td width='35%' >
                      <table width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr>
                          <td height="20"><div align="left" class="titulo1">LISTADO DE: </div></td>
                        </tr>
                    <tr class="info">
                          <td height="20"><?=$nomcarpeta?></td>
                        </tr>
                      </table>
                    </td>
                    <td width='35%' >
                      <table width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr>
                          <td height="20" ><div align="left" class="titulo1">USUARIO </div></td>
                        </tr>
                    <tr class="info">
                          <td height="20" ><?=$usua_nomb?></td>
                        </tr>
                      </table>
                    </td>
                  <?
                    if (!$swBusqDep)  {
                    ?>
                  <td width="33%">
                      <table width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr>
                          <td height="20" ><div align="left" class="titulo1">DEPENDENCIA </div></td>
                        </tr>
                    <tr class="info">
                          <td height="20" ><?=$depe_nomb?></td>
                        </tr>
                      </table>
                    </td>
                  <?
                    } else {
                    ?>
                  <td width="35%">
                      <table width="100%" border="0" cellspacing="5" cellpadding="0">
                    <tr class="info" height="20">
                      <td   ><div align="left" class="titulo1">DEPENDENCIA</div></td>
                        </tr>
                    <tr>
                      <form name=formboton action='<?=$pagina_actual?>?<?=session_name()."=".session_id()."&krd=$krd" ?>&estado_sal=<?=$estado_sal?>&estado_sal_max=<?=$estado_sal_max?>&pagina_sig=<?=$pagina_sig?>&dep_sel=<?=$dep_sel?>&nomcarpeta=<?=$nomcarpeta?>' method=get>
                      <td height="1">
                          <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
                <?php
                  include_once "$ruta_raiz/include/query/envios/queryPaencabeza.php";
                  //$sqlConcat = $db->conn->Concat($db->conn->substr."($conversion,1,5) ", "'-'",$db->conn->substr."(depe_nomb,1,30) ");
                  $sqlConcat = $db->conn->Concat($conversion, "'-'",$db->conn->substr."(depe_nomb,1,30) ");
                  $sql = "select $sqlConcat ,depe_codi from dependencia where depe_estado=1 order by depe_codi";
                  $rsDep = $db->conn->Execute($sql);
                  if(!$depeBuscada) $depeBuscada=$dependencia;
                  print $rsDep->GetMenu2("dep_sel","$dep_sel",false, false, 0," onChange='submit();' class='select'");
                ?>
                    </td>
                      </form>
                    </tr>
                      </table>
                    </td>

                  <?
                    }
                    ?>

                  </tr>
                  </body>
                </table>

              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>
