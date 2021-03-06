<?php
/**
 * @module index_frame
 *
 * @author Jairo Losada   <jlosada@gmail.com>
 * @author Cesar Gonzalez <aurigadl@gmail.com>
 * @license  GNU AFFERO GENERAL PUBLIC LICENSE
 * @copyright

 Orfeo Models are the data definition of Orfeo Information System
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

$drd           = false;
$krd           = false;
$validacionKrd = false;

if (isset($_POST["krd"])){
  $krd = $_POST["krd"];
}
if (isset($_POST["drd"])){
  $drd = $_POST["drd"];
}

if (isset($_POST["autenticaPorLDAP"])){
  $autenticaPorLDAP = $_POST["autenticaPorLDAP"];
}

$fechah         = date("dmy")."_".time("hms");
$ruta_raiz      = ".";
$usua_nuevo     = 3;

include ("config.php");
$serv = str_replace(".", ".", $_SERVER['REMOTE_ADDR']);

if ($krd) {
  //session_orfeo retorna mensaje de error
  include "$ruta_raiz/session_orfeo.php";
  require_once ("$ruta_raiz/class_control/Mensaje.php");

  if ($usua_nuevo == 0 &&  !$autenticaPorLDAP) {
    include ($ruta_raiz."/contraxx.php");
    $validacionKrd = false;
  }
}
$datosEnvio = session_name()."=".trim(session_id())."&krd=$krd&&orno=1";
if ($validacionKrd == true) {
  header ("Location: $ruta_raiz/index_frames.php?$datosEnvio");
  exit();
}

?>

<!DOCTYPE html>
<!--[if IE 8]> <html class="no-js lt-ie9" lang="en" > <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en"><!--<![endif]--><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Orfeo">
  <meta name="keywords" content="">
  <link rel="shortcut icon" href="./imagenes/favicon.png">

  <title>..:: <?=$entidad?> Morfeo ::..</title>
  <!-- Bootstrap core CSS -->
  <link href="./estilos/bootstrap.min.css" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="./estilos/login.css" rel="stylesheet">

  </head>
    <body>
      <div class="container">
          <div class="row">
              <div class="col-sm-6 col-md-4 col-md-offset-4">
                  <h1 class="text-center login-title"><?=$entidad_largo?></h1>
                  <div class="account-wall">
                      <img class="profile-img" src="http://placekitten.com/120/120" alt="">
                      <form class="form-signin" action="./login.php" method="post">
                        <div class="form-group">
                          <label for="Usuario">Usuario</label>
                          <input id="Usuario" name="krd" type="text" class="form-control" placeholder="Usuario" required autofocus>
                        </div>
                        <div class="form-group">
                          <label for="password">Contrase&ntilde;a</label>
                          <input id="password" name="drd" type="password" class="form-control" placeholder="Contrase&ntilde;a" required>
                        </div>
                        <button class="btn btn-lg btn-primary btn-block" type="submit"> Ingresar </button>
                      </form>
                  </div>
                  <?if(!empty($mensajeError)){ ?>
                    <div class="pull-left alert alert-danger" role="alert">
                      <?=$mensajeError?>
                    </div>
                  <?}?>
              </div>
          </div>
      </div>

      <footer class="container">
        <p id="footer-text"><small>Copyleft 2016, basado en Orfeo de la fundaci&oacute;n <a href="http://www.correlibre.org/">Correlibre</a></small></p>
      </footer>

      <script src="./js/jquery.min.js"></script>
      <script src="./js/bootstrap.js"></script>

<script>
/* Custom JavaScript */
$(document).ready(function($) {
  if(window.self !== window.top){
    top.location.reload();
  };
});
</script>
</body>
</html>
