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

session_start();

$ruta_raiz   = "..";
if (!$_SESSION['dependencia'])
  header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;


$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$tpNumRad    = $_SESSION["tpNumRad"];
$tpPerRad    = $_SESSION["tpPerRad"];
$tpDescRad   = $_SESSION["tpDescRad"];
$tip3Nombre  = $_SESSION["tip3Nombre"];
$tip3img     = $_SESSION["tip3img"];
$tpDepeRad   = $_SESSION["tpDepeRad"];

?>
<html>
  <head>
  <title>Buscar Radicado</title>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
    <script >
      function solonumeros(){
        jh =  document.getElementById('nurad').value;
        if(jh){
          var1 =  parseInt(jh);
          if(var1 != jh){
            alert("Atencion: El numero de Radicado debe ser de solo Numeros.");
            return false;
          }else{
            numCaracteres = document.getElementById('nurad').value.length;
            <?php
            $ln=$_SESSION["digitosDependencia"];
            $lnr=11+$ln;
            ?>
            if(numCaracteres>=6) {
                document.FrmBuscar.submit();
            }else {
                alert("Atencion: El numero de Caracteres del radicado es de <?php echo $lnr; ?>. (Digito :"+numCaracteres+")");
            }
          }
        }else{
          document.FrmBuscar.submit();
        }
      }
  </script>
</head>

<body onLoad='document.getElementById("nurad").focus();'>
  <form action='NEW.php?<?=session_name()."=".session_id()."&krd=$krd"?>&Submit3=ModificarDocumentos'  name="FrmBuscar" class=celdaGris method="POST">
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
                <h2>
                  Modificacion de radicados<br>
                  <small><?=$tituloCrear ?></small>
                </h2>
              </header>
              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body no-padding">
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr class='titulos2'>
                        <td width="25%" height="49">Numero de Radicado</td>
                        <td width="55%" class=listado2>
                          <input type='text' name=nurad class=tex_area id=nurad>
                          <input type=hidden name=modificarRad Value="ModificarR" id=modificarRad>
                          <input type=hidden name=Buscar Value="Buscar Radicado">
                          <input type=button name=Buscar1 Value="Buscar Radicado" class=botones_largo onclick="solonumeros();">
                        </td>
                      </tr>
                    </table>
                  </div>
              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>
</form>
</center>
</body>
</html>
