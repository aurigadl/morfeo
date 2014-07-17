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
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

session_start();

    $ruta_raiz = ".";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_POST as $key => $valor) ${$key} = $valor;

$direcTor = "$ruta_raiz/bodega/plantillas/";
$archivo1 = $direcTor."combiSencilla.xml";
$archivo2 = $direcTor."combiMasiva.xml";
$archivo3 = $direcTor."plantillas.xml";

$doc    = new DOMDocument();

if(file_exists($archivo3)){
    $doc->load($archivo3);
    $campos     = $doc->getElementsByTagName("campo");
    foreach($campos as $campo){
        $campTemp1 = $campo->getElementsByTagName("nombre");
        $campTemp2 = $campo->getElementsByTagName("ruta");
        $temp1     = $campTemp1->item(0)->nodeValue;
        $temp2     = $campTemp2->item(0)->nodeValue;

        $plantill  .= "&nbsp; &nbsp;<a href='".$direcTor.$temp2."'>".$temp1."</a><br/></br>";
    }
}else{
    $msg  .= " No se abrio el archivo $archivo3 generado desde la administracion de plantillas</br>";
}

if(file_exists($archivo2)){
    $doc->load($archivo2);
    $campos     = $doc->getElementsByTagName("campo");
    foreach($campos as $campo){
        $campTemp = $campo->getElementsByTagName("nombre");
        $valor    = $campTemp->item(0)->nodeValue;
        $nombMa   .= empty($nombSe)? " &nbsp; &nbsp; $valor" : "&nbsp; &nbsp;  &nbsp; &nbsp; $valor ";
    }
}else{
    $msg  .= " No se abrio el archivo $archivo2 generado desde la administracion de plantillas</br>";
}

if(file_exists($archivo1)){
    $doc->load($archivo1);
    $campos     = $doc->getElementsByTagName("campo");
    foreach($campos as $campo){
        $campTemp = $campo->getElementsByTagName("nombre");
        $valor    = $campTemp->item(0)->nodeValue;
        $nombSe   .= empty($nombSe)? "&nbsp; &nbsp;$valor" : " &nbsp; &nbsp; $valor ";
    }
}else{
    $msg  .= " No se abrio el archivo $archivo1 generado desde la administracion de plantillas</br>";
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
      <title>Plantillas A Usar en Orfeo</title>
      <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
    </head>
    <body>
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
                    Campos de masiva combinaci&oacute;n y plantillas<br>
                  </h2>
                </header>
                <!-- widget div-->
                <div>
                  <!-- widget content -->
                  <div class="widget-body no-padding">
                    <div class="table-responsive">
                      <table class="table table-bordered table-striped">
                          <tr align="left">
                              <td>
                                  <?=$msg?>
                              </td>
                          </tr>
                          <tr align="center" class="etextomenu">
                              <td class='listado2'>
                                  <?=$nombSe?>
                              </td>
                          </tr>
                          <tr class='titulos2'>
                              <td align="center" height="12">
                                  <b> Campos que se pueden usar en una combinaci&oacute;n sencilla</b>
                              </td>
                          </tr>
                          <tr align="justify" class="etextomenu">
                              <td  class='listado2'>
                                  <p><?=$nombMa?></p>
                              </td>
                          </tr>
                          <tr align="justify" class="etextomenu">
                              <td  class='listado2'>
                                  <p> Listado de Fuentes de Código de barra que debe tener instalado en el PC o Dispositivo M&oacute;vil.<br>
					
                                      - Descargar las fuentes desde GNU/Linux, MAC, OSX o Windows  y abir directamente con el Administrador de Fuentes, Luego Dar la Opci&oacute;n Instalar. <br>
                                      - o copiar estos archivos en el directorio fuentes: \fonts</br>
                                  </p>
                                      <a href='include/fuentes/FREE3OF9.TTF'   class="e"> FREE3OF9.TTF</a> -
                                      <a href='include/fuentes/free3of9.ttf'>free3of9.ttf</a> -
                                      <a href='include/fuentes/FREE3OF9X.TTF'>FREE3OF9X.TTF</a> -
                                      Licencia <a href='include/fuentes/FREE3OF9.TXT'>FREE3OF9.TXT </a>
                              </td>
                          </tr>

                          <tr align="left" class='titulos2'>
                              <td height="12">
                                  <b> Listado de plantillas</b>
                              </td>
                          </tr>

                          <tr align="center" class="etextomenu">
                              <td class='listado2'>
                                  <?=$plantill?>
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
    </body>
</html>

