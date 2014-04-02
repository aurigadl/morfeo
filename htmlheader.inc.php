<?php
/**
* @module  bandejas
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

$str = <<<EOF

      <title>Sistema de informaci&oacute;n integrado de Metrovivienda</title>

      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="description" content="SIIM2">
      <meta name="keywords" content="siim, metrovivienda, gestion, misional">

      <link rel="shortcut icon" href="$ruta_raiz/img/favicon.png">
      <!-- Bootstrap core CSS -->
      <link href="$ruta_raiz/estilos/bootstrap.min.css" rel="stylesheet">
      <!-- font-awesome CSS -->
      <link href="$ruta_raiz/estilos/font-awesome.css" rel="stylesheet">
      <!-- Bootstrap core CSS -->
      <link href="$ruta_raiz/estilos/font-awesome.min.css" rel="stylesheet">
      <link href="$ruta_raiz/estilos/smartadmin-production.css" rel="stylesheet">
      <link href="$ruta_raiz/estilos/smartadmin-skins.css" rel="stylesheet">
      <link href="$ruta_raiz/estilos/demo.css" rel="stylesheet">
      <link href="$ruta_raiz/estilos/siim_temp.css" rel="stylesheet">

      <script type="text/javascript" src="$ruta_raiz/js/jquery.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/jquery-ui.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/jarvis.widget.min.js"></script>
      
      
      <script type="text/javascript" src="$ruta_raiz/js/notification/SmartNotification.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/sparkline/jquery.sparkline.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/jquery-validate/jquery.validate.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/masked-input/jquery.maskedinput.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/select2/select2.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/msie-fix/jquery.mb.browser.min.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/smartclick/smartclick.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/demo.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/app.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/plugin/fuelux/wizard/wizard.js"></script>
      <script type="text/javascript" src="$ruta_raiz/js/bootstrap.js"></script>
     
EOF;
echo $str;
?>
