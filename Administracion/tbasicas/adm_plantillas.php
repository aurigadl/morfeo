<?php

/**
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

foreach ($_POST as $key => $valor) ${$key} = $valor;

$doc    = new DOMDocument();

//Abrir o crear el archivo de listado en
//boveda con el nombre plantillas.txt
$direcTor = "$ruta_raiz/bodega/plantillas/";
$archivo1 = $direcTor."combiSencilla.xml";
$archivo2 = $direcTor."combiMasiva.xml";
$archivo3 = $direcTor."plantillas.xml";

$tamArchi = 5054432;

/****************************************
* creo el directorio con los permisos.
*****************************************/
if (@!file_exists($direcTor)) {
    $directorio = mkdir("$direcTor",0777);
}


/****************************************
* Plantillas agregar y eliminar
*****************************************/
//Eliminar plantillas si se envian la solicitud
if(($btn_acc == "Borrar")){
    if(!empty($nomPlant)){
        $doc->load($archivo3);
        $campos     = $doc->getElementsByTagName("campo");

        $doc4 = new DOMDocument();
        $doc4->formatOutput = true;

        $r = $doc4->createElement("campos");
        $doc4->appendChild($r);

        foreach($campos as $campo){
            $campTemp1 = $campo->getElementsByTagName("nombre");
            $campTemp2 = $campo->getElementsByTagName("ruta");
            $temp1     = $campTemp1->item(0)->nodeValue;
            $temp2     = $campTemp2->item(0)->nodeValue;

            if(!in_array($temp2,$nomPlant)){
                $b = $doc4->createElement("campo");
                $nombre = $doc4->createElement("nombre");
                $nombre->appendChild(
                    $doc4->createTextNode(trim($temp1))
                );
                $b->appendChild($nombre);

                $ruta = $doc4->createElement("ruta");
                $ruta->appendChild(
                    $doc4->createTextNode($temp2)
                );

                $b->appendChild($ruta);
                $r->appendChild($b);
            }
        }
        $doc4->save($archivo3);
    }
}

//Leer archivo con listado de plantillas
if(@!$doc->load($archivo3)){
    $handler    = fopen($archivo3, "w+");
    $msg        .= " Se creo el archivo $archivo3</br>";
    fclose($handler);
}else{
    $campos     = $doc->getElementsByTagName("campo");
    foreach($campos as $campo){
        $campTemp1 = $campo->getElementsByTagName("nombre");
        $campTemp2 = $campo->getElementsByTagName("ruta");
        $temp1     = $campTemp1->item(0)->nodeValue;
        $temp2     = $campTemp2->item(0)->nodeValue;

        $plantill[] = array('nombre' => $temp1,
                            'ruta'   => $temp2);
    }
}


if($btn_acc == "adjuntar"){

    $extension = end(explode('.',$_FILES['userfile']['name']));
    $nomb       = "plant".time().rand(0,1000).".".$extension;
    $uploadfile = $direcTor.$nomb;
var_dump($uploadfile);
    $tipValidoOdt  = 'application/vnd.oasis.opendocument.text';
    $tipoValidoDocx = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    $tipoValidoXls = 'application/vnd.ms-excel';
var_dump(move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile));
    $tipValidoOds = 'application/vnd.oasis.opendocument.spreadsheet';
    if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile) &&
           ($_FILES['userfile']['type']==$tipoValidoXls) ||  ($_FILES['userfile']['type']==$tipValidoOds) || ($_FILES['userfile']['type'] == $tipValidoOdt) || ($_FILES['userfile']['type'] == $tipoValidoDocx)){

        //crear listado de plantillas
        $doc3 = new DOMDocument();
        $doc3->formatOutput = true;

        $r = $doc3->createElement("campos");
        $doc3->appendChild($r);

        $plantill[] = array('nombre' => $_FILES['userfile']['name'],
                            'ruta'   => $nomb);

        foreach($plantill as $campo){
            $b = $doc3->createElement( "campo" );
            if(!empty($campo)){
                $nombre = $doc3->createElement("nombre");
                $nombre->appendChild(
                    $doc3->createTextNode(trim($campo['nombre']))
                );
                $b->appendChild($nombre);

                $ruta = $doc3->createElement("ruta");
                $ruta->appendChild(
                    $doc3->createTextNode($campo['ruta'])
                );
                $b->appendChild($ruta);
            }
            $r->appendChild($b);
        }
        $doc3->save($archivo3);

        $msg .= "El archivo fue grabado</br>";
    } else {
        $msg .= "No se grabo el archivo</br>";
    }
}

if(!empty($plantill)){
    foreach($plantill as $campo){
        $ruta   = $campo['ruta'];
        $nombre = $campo['nombre'];
        $nombArc .= "<input type='checkbox' name='nomPlant[]' value='$ruta'>$nombre<br/>";
    }
}

/****************************************
 * Modificar datos en el xml
 *****************************************/
if($btn_acc == "Modificar"){
    $formSim  = explode(",", trim($simple));
    $formMas  = explode(",", trim($masiva));
    $formPlan = explode(",", trim($planti));

    //crear listado combinacion simple
    $doc      = new DOMDocument();
    $doc->formatOutput = true;
    $r = $doc->createElement("campos");
    $doc->appendChild($r);

    foreach($formSim as $campo){
        $b = $doc->createElement( "campo" );
        if(!empty($campo)){
            $nombre = $doc->createElement("nombre");
            $nombre->appendChild(
                $doc->createTextNode(trim($campo))
            );
            $b->appendChild($nombre);
        }
        $r->appendChild($b);
    }

    $doc->save($archivo1);


    //crear listado combinacion masiva
    $doc2        = new DOMDocument();
    $doc2->formatOutput = true;

    $r = $doc2->createElement("campos");
    $doc2->appendChild($r);

    foreach($formMas as $campo){
        $b = $doc2->createElement( "campo" );
        if(!empty($campo)){
            $nombre = $doc2->createElement("nombre");
            $nombre->appendChild(
                $doc2->createTextNode(trim($campo))
            );
            $b->appendChild($nombre);
        }
        $r->appendChild($b);
    }

    $doc2->save($archivo2);

    $msg    .= "Se actulizo la informacion de los campos</br>";
}



/*****************************************
 * Leer el archivo existente o crearlo
 * ***************************************/
if(@!$doc->load($archivo1)){
    $handler    = fopen($archivo1, "w+");
    $msg        .= " Se creo el archivo $archivo1</br>";
    fclose($handler);
}else{
    $plantill[] = array('nombre' => $temp1,
                                'ruta'   => $temp2);
    $campos     = $doc->getElementsByTagName("campo");
    foreach($campos as $campo){
        $campTemp = $campo->getElementsByTagName("nombre");
        $valor    = $campTemp->item(0)->nodeValue;
        $nombSe   .= empty($nombSe)? $valor : ", $valor";
    }
}

if(@!$doc->load($archivo2)){
    $handler    = fopen($archivo2, "w+");
    $msg        .= " Se creo el archivo $archivo2</br>";
    fclose($handler);
}else{
    $campos     = $doc->getElementsByTagName("campo");
    foreach($campos as $campo){
        $campTemp = $campo->getElementsByTagName("nombre");
        $valor    = $campTemp->item(0)->nodeValue;
        $nombMa  .= empty($nombMa)? $valor : ", $valor";
    }
}


if(empty($nombSe)){
    $nombSe = "*TIPO*
                , *NOMBRE*
                , *EMPRESA*
                , *DIR*
                , *EMAIL*
                , *MUNI_NOMBRE*
                , *DEPTO_NOMBRE*
                , *PAIS_NOMBRE* ";
}

if(empty($nombMa)){
    $nombMa = "
            *RAD_S*, *RAD_E_PADRE*, *CTA_INT*
            , *ASUNTO*, *F_RAD_E*, *SAN_FECHA_RADICADO*
            , *NOM_R*,  *DIR_R*, *DIR_E*
            , *DEPTO_R*,  *MPIO_R*,  *TEL_R*
            , *MAIL_R*,  *DOC_R*,  *NOM_P*
            , *DIR_P*,   *DEPTO_P*,  *MPIO_P*
            , *TEL_P*,   *MAIL_P*,  *DOC_P*
            , *NOM_E*,   *DIR_E*,  *MPIO_E*
            , *DEPTO_E*,  *TEL_E*,  *MAIL_E*
            , *NIT_E*,  *NUIR_E*,  *F_RAD_S*
            , *RAD_E*,  *SAN_RADICACION*, *SECTOR*
            , *NRO_PAGS*,  *DESC_ANEXOS*,  *F_HOY_CORTO*
            , *F_HOY*,  *NUM_DOCTO*,  *F_DOCTO*
            , *F_DOCTO1*,   *FUNCIONARIO*,   *LOGIN*
            , *DEP_NOMB*,   *CIU_TER*,  *DEP_SIGLA*
            , *TER*,   *DIR_TER* *TER_L*
            , *NOM_REC*,  *EXPEDIENTE*,  *NUM_EXPEDIENTE*
            , *DIGNATARIO*, *DEPE_CODI*,   *DEPENDENCIA*
            , *DEPENDENCIA_NOMBRE*
         ";
}

?>


<html>
    <head>
        <title>Orfeo- Admon de soportes.</title>
        <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
        <script language="Javascript">
        </script>
    </head>

    <body>
        <form enctype="multipart/form-data" name="formSeleccion" id="formSeleccion" method="post" action="">
            <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
            <input type="hidden" name="MAX_FILE_SIZE" value="<?=$tamArchi?>" />
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
                          Administrador de plantillas<br>
                          <small><?=$tituloCrear ?></small>
                        </h2>
                      </header>

                      <!-- widget div-->
                      <div>
                        <!-- widget content -->
                        <div class="widget-body no-padding">

                          <table class="table table-bordered table-striped">

                          <tr class=timparr>
                              <td width="15%" align="left" class="titulos2"><b>&nbsp;Campos para combinaci&oacute;n sencilla separados por comas</b></td>
                          </tr>
                          <tr class=timparr>
                              <td class="listado2"><textarea rows="1" name="simple" class="select100"><?=$nombSe ?></textarea></td>
                          </tr>
                          <tr class=timparr>
                              <td width="15%" align="left" class="titulos2"><b>&nbsp;Campos combinaci&oacute;n masiva:</b> separados por comas</td>
                          </tr>
                          <tr class=timparr>
                              <td class="listado2"><textarea rows="1" name="masiva" class="select100"><?=$nombMa ?></textarea></td>
                          </tr>
                      </table>

                      <table class="table table-bordered table-striped">
                          <tr><td><center><?=$msg?></center></td></tr>
                      </table>

                      <table class="table table-bordered table-striped">
                        <tr>
                            <td width="20%" align="center"><input name="btn_acc" type="submit" class="botones" value="Modificar"></td>
                        </tr>
                      </table>

                      <table class="table table-bordered table-striped">
                        <tr>
                            <td width="50%" align="left" class="titulos2"><b>&nbsp;Plantillas en formato ODT</b></td>
                        </tr>
                        <tr class="listado1">
                            <td align="left" valign="top">
                                <input name="userfile" type="file">
                                <input class="botones" type="submit" name="btn_acc" value="adjuntar" class="botones">
                                <br/><br/>
                                <?=$nombArc ?>
                                <br/><input name="btn_acc" type="submit" class="botones" value="Borrar">
                            </td>
                        </tr>
                    </table>
                  </div>
                </div>
              </div>
            </article>
          </div>
        </section>
      </div>
    </form>
  </body>
</html>
