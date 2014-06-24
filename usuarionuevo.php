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

include './config.php';
session_start();
ob_start();

    $ruta_raiz = ".";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];

include_once  "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler($ruta_raiz);
?>

<html>
    <title>Adm - Contrase&ntilde;as - ORFEO </title>
<HEAD>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</HEAD>
<body>
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
                Usuario Nuevo<br>
              </h2>
            </header>
            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body">
                <?php
                if(!$depsel) $depsel = $dependencia;
                if($aceptar=="grabar"){
                    $isql = "update
                                usuario
                                set
                                usua_nuevo     = '1',
                                usua_pasw      ='".SUBSTR(md5($contraver),1,26)."',
                                USUA_SESION    = 'camClav".date("Ymd")."'
                            where
                                DEPE_CODI = $dependencia and
                                USUA_CODI = $codusuario";
                    $rs = $db->conn->query($isql);
                    if($rs==-1){
                        echo "<P><P><center>No se ha podido cambiar la contrase&ntilde;a, Verifique los datos e intente de nuevo</center>";
                    }else{
                        header ("Location: $ruta_raiz/cerrar_session.php");
                        exit();
                    }
                }else{
                  if($contradrd==$contraver){
                ?>
                  </p>
                  <form action="usuarionuevo.php" class="smart-form" method=post><CENTER>
                      <input type='hidden' value="<?=$contraver?>" name='contraver'>
                      <input type='hidden' value="<?=$contradrd?>" name="contradrd">
                      <input type='hidden' value='<?=session_id()?>' name='<?=session_name()?>'>
                      <tr><td class=listado2><center><h3>Esta Seguro de estos datos ?</h3><br />
                       <input type="submit" value='grabar' name="aceptar" class="btn btn-primary btn-sm">
                       <a href="./cuerpo.php"  class="btn btn-primary btn-sm">Cancelar</a>
                      </td></tr>
                    </form>
                  <?php
                  }else {?>
                  <table class="table table-bordered table-striped">
                      <tr ><td class="listado2">
                        <center><h3>Las contrase&ntilde;as no coinciden</h3>
                        <a href="contraxx.php?<?=session_name()."=".session_id()?>"><input type="submit" value="Regresar" class="botones"/></a>
                      </td></tr>
                  </table>
                    <?
                  }
                }
                ?>
              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>
</body>
</html>