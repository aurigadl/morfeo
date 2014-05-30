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

      <title>..:: $entidad - Caliope ::..</title>

      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
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

			<script src="$ruta_raiz/js/jquery.min.js"></script>
      <!-- <script src="$ruta_raiz/js/jsplumb/lib/jquery-1.9.0-min.js"></script> -->
      <script src="$ruta_raiz/js/jsplumb/lib/jquery-1.9.0.js"></script>
		  <script src="$ruta_raiz/js/libs/jquery-ui-1.10.4.js"></script>

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

    <script src="$ruta_raiz/js/jsplumb/lib/jquery.ui.touch-punch.min.js"></script>
		<!-- /DEP -->
		<!-- JS -->
		<!-- support lib for bezier stuff -->
		<script src="$ruta_raiz/js/jsplumb/lib/jsBezier-0.6.js"></script>
		<!-- jsplumb geom functions -->
		<script src="$ruta_raiz/js/jsplumb/lib/jsplumb-geom-0.1.js"></script>
		<!-- jsplumb util -->
		<script src="$ruta_raiz/js/jsplumb/src/util.js"></script>
        <!-- base DOM adapter -->
		<script src="$ruta_raiz/js/jsplumb/src/dom-adapter.js"></script>
		<!-- main jsplumb engine -->
		<script src="$ruta_raiz/js/jsplumb/src/jsPlumb.js"></script>
        <!-- endpoint -->
		<script src="$ruta_raiz/js/jsplumb/src/endpoint.js"></script>
        <!-- connection -->
		<script src="$ruta_raiz/js/jsplumb/src/connection.js"></script>
        <!-- anchors -->
		<script src="$ruta_raiz/js/jsplumb/src/anchors.js"></script>
		<!-- connectors, endpoint and overlays  -->
		<script src="$ruta_raiz/js/jsplumb/src/defaults.js"></script>
        <!-- bezier connectors -->
        <script src="$ruta_raiz/js/jsplumb/src/connectors-bezier.js"></script>
		<!-- state machine connectors -->
		<script src="$ruta_raiz/js/jsplumb/src/connectors-statemachine.js"></script>
		<!-- SVG renderer -->
		<script src="$ruta_raiz/js/jsplumb/src/renderers-svg.js"></script>
		<!-- canvas renderer -->
		<script src="$ruta_raiz/js/jsplumb/src/renderers-canvas.js"></script>
		<!-- vml renderer -->
		<script src="$ruta_raiz/js/jsplumb/src/renderers-vml.js"></script>

        <!-- jquery jsPlumb adapter -->
		<script src="$ruta_raiz/js/jsplumb/src/jquery.jsPlumb.js"></script>
EOF;
echo  $str;
?>
