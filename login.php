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

  $drd = false;
  $krd = false;
  if (isset($_POST["krd"])){
      $krd = $_POST["krd"];
  }
  if (isset($_POST["drd"])){
      $drd = $_POST["drd"];
  }

  if (isset($_POST["autenticaPorLDAP"]))
      $autenticaPorLDAP = $_POST["autenticaPorLDAP"];

  $fechah        = date("dmy")."_".time("hms");
  $ruta_raiz     = ".";
  $usua_nuevo    = 3;
  $ValidacionKrd  = "";

  include ("config.php");
  $serv = str_replace(".", ".", $_SERVER['REMOTE_ADDR']);

  if ($krd) {
      //session_orfeo retorna mensaje de error
      include "$ruta_raiz/session_orfeo.php";
      require_once ("$ruta_raiz/class_control/Mensaje.php");

      if ($usua_nuevo == 0 &&  !$autenticaPorLDAP) {
          include ($ruta_raiz."/contraxx.php");
          $ValidacionKrd = "NOOOO";
          if ($j = 1)
              die("<center> -- </center>");
      }
  }

  $krd = strtoupper($krd);
  $datosEnvio = session_name()."=".trim(session_id())."&fechah=$fechah&krd=$krd&swLog=1&orno=1";

  if ($ValidacionKrd == "Si") {
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
  <meta name="description" content="SIIM2">
  <meta name="keywords" content="">
    <link rel="shortcut icon" href="./img/favicon.png">

  <title>..:: <?=$entidad?> fwCaliope  ::..</title>
    <!-- Bootstrap core CSS -->
    <link href="./estilos/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./estilos/login.css" rel="stylesheet">

  </head>
    <body>
      <!-- start Login box -->
      <div class="container" id="login-block">
        <div class="row">
          <div class="col-sm-6 col-md-4 col-sm-offset-3 col-md-offset-4 col-lg-12">
             <div class="login-box clearfix animated flipInY">
             <h3 class="animated bounceInDown"><?=$entidad_largo?></h3>
                <hr>
                <div class="login-form">

                  <div class="alert alert-error hide">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Error!</h4>
                    Los datos suministrados no son correctos.
                  </div>

                  <form action="./login.php??fecha=250314_1395788602&amp;PHPSESSID=&amp;krd=&amp;swLog=1" method="post">
                    <input name="krd" placeholder="Usuario" required="" type="text">
                    <input name="drd" placeholder="Password" required="" type="password">
                    <button type="submit" class="btn btn-login">Entrar</button>
                  </form>

                  <?if(!empty($mensajeError)){ ?>
                  <div class="login-links text-error">
                    <?=$mensajeError?>
                  </div>
                  <?}?>
                </div>
             </div>
          </div>
        </div>
      </div>
      <!-- End Login box -->

      <footer class="container">
        <p id="footer-text"><small>Copyleft 2014, basado en Caliope 0.9 de la fundaci&oacute;n <a href="http://www.correlibre.org/">Correlibre</a></small></p>
      </footer>

      <script src="./js/jquery.min.js"></script>
      <script src="./js/bootstrap.js"></script>

      <script>
        /* Custom JavaScript */
        $(document).ready(function($) {
          $('input, textarea').placeholder();
        });
      </script>

    <script src="js/placeholder-shim.min.js"></script>
</body>
</html>
