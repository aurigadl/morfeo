<!DOCTYPE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Respuesta Rapida</title>
        <meta   http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link   href="../estilos/jquery.treeview.css" type="text/css"  rel="stylesheet" />
        <link   href="../estilos/jquery-ui.css"       type="text/css"  rel="stylesheet" />
        <script src="../js/libs/jquery-2.0.2.min.js"       type="text/javascript"></script>
        <script src='../js/jquery.form.js'            type="text/javascript" language="javascript"></script>
        <script src='../js/jquery.MetaData.js'        type="text/javascript" language="javascript"></script>
        <script src='../js/jquery.MultiFile.pack.js'  type="text/javascript" language="javascript"></script>
        <script src='../js/jquery.blockUI.js'         type="text/javascript" language="javascript"></script>
        <script src='../js/jquery.treeview.js'        type="text/javascript" language="javascript"></script>
        <script src='../js/libs/jquery-ui-1.10.4.js'              type="text/javascript" language="javascript"></script>

        <script language="javascript">

        $(document).ready(function () {

          $('span[ref]').on('click', function(){
            var idString = $(this).attr('ref');
            var textnew  = $( "#" + idString).html();
            CKEDITOR.instances.texrich.setData(textnew);
          });

          $('#T7').MultiFile({
            STRING: {
              remove: '<img src="./js/bin.gif" height="16" width="16" alt="x"/>'
            },
            list: '#T7-list'
          });

          $("#browser").treeview();

          $('#form2').submit(function(e){

            var seg1    = true;
            var texcont =CKEDITOR.instances['texrich'].getData();

            if($('#nivel').val() === ''){
              alert('Selecciona una carpeta');
              seg1 = false;
            };

            if($('#nombre').val() === ''){
              alert('Escribe un nombre');
              seg1 = false;
            };

            if(!seg1){
              e.preventDefault();
              e.stopPropagation();
            }else{
              $('<input />').attr('type', 'hidden')
                .attr('name', 'contplant')
                .attr('value', texcont)
                .appendTo('#form2');
            }
          });

          $('#form3').submit(function(e){
            var seg2 = false;

            $("input[name='planaborrar[]']:checked").each(function (){
                seg2 = true;
            });

            if(!seg2){
              alert('Selecciona una plantilla');
              e.preventDefault();
              e.stopPropagation();
            };
          });
        });

        function valFo(el){
          var result = true;
          var destin = el.destinatario.value;
          var salida = destin.split(";");

          if (destin == ""){
            alert('El campo destinatario es requerido');
            el.destinatario.focus();
            result = false;
          };

          for(i = 0; i < salida.length; i++){
            if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(salida[i])){
              result = true;
            }else{
              alert('El destinatario es incorrecto:  ' + salida[i]);
              el.destinatario.focus();
              result = false;
              break;
            }
          }

          return result;
        };
      </script>

      <style type="text/css">

            HTML, BODY{
                font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
                margin: 0px;
                height: 100%;
            }

            #load{
                position:absolute;
                z-index:1;
                border:3px double #999;
                background:#f7f7f7;
                width:300px;
                height:300px;
                margin-top:-150px;
                margin-left:-150px;
                top:50%;
                left:50%;
                text-align:center;
                line-height:300px;
                font-family: verdana, arial,tahoma;
                font-size: 14pt;
            }

            img {
                border: 0 none;
            }

            .MultiFile-label{
                float: left;
                margin: 3px 15px 3px 3px;
            }

            .linkCargar{
                background: url(../estilos/images/flechaAzul.gif) no-repeat;
                cursor: pointer;
                padding-bottom: 17px;
                padding-left: 17px;
            }

        </style>

    </head>
    <body>

        <!--{foreach key=idCarpeta item=carpeta from=$carpetas}-->
          <!--{foreach key=id item=archivo from=$carpeta}-->
              <span id='<!--{$archivo.id}-->' style="display:none;">
                <!--{$archivo.ruta}-->
              </span>
          <!--{/foreach}-->
        <!--{/foreach}-->

        <div id="load" style="display:none;">Enviando.....</div>
        <form id="form1" name="form1" method="post" enctype="multipart/form-data"
                action='../respuestaRapida/procRespuesta.php?<!--{$sid}-->' onsubmit="return valFo(this)">

            <input type=hidden name="usuanomb"   value='<!--{$usuanomb}-->'>
            <input type=hidden name="usualog"    value='<!--{$usualog}-->'>
            <input type=hidden name="radPadre"   value='<!--{$radPadre}-->'>
            <input type=hidden name="usuacodi"   value='<!--{$usuacodi}-->'>
            <input type=hidden name="depecodi"   value='<!--{$depecodi}-->'>
            <input type=hidden name="codigoCiu"  value='<!--{$codigoCiu}-->'>
            <input type=hidden name="codigoCiu"  value='<!--{$codigoCiu}-->'>
            <input type=hidden name="codigoCiu"  value='<!--{$codigoCiu}-->'>
            <input type=hidden name="rutaPadre"  value='<!--{$rutaPadre}-->'>

            <table border="0" width="100%" align="center" cellspacing="0" cellpadding="0">

                <tr align="center" class="titulos2">
                    <td height="15" colspan="4" class="titulos4">RESPUESTA RAPIDA</td>
                </tr>

                <!-- <tr>
                    <td class="titulos5" height="20" colspan="2" >
                        <span>Para enviar a multiples correos Separe con ";"&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                        Para escribir una nueva linea utilice las teclas [shift] + [Enter]&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                        Para escribir un nuevo parrafo utilice la tecla [Enter]</span>
                    </td>
                </tr> -->

                <tr>
                    <td colspan=2>
                        <table border="0" width="100%" align="center" cellspacing="0" cellpadding="0">
     <!--                       <tr>
                               <td  class="listado1">Envio:</td>
                               <td  colspan="5"  class="listado1" >
                                <input type="radio" value="1" checked="" name="medioRadicar"></input>
                                  Envio correo electronico
                                <input type="radio" value="0" name="medioRadicar"></input>
                                  Envio correo fisico
                                <input type="radio" value="2" name="medioRadicar"></input>
                                  Envio Fisico y electronico
                               </td>
                            </tr> -->
                            <tr>
                               
                               <td class="titulos">Adjuntar <input type="hidden" value="2" name="medioRadicar"></td>
                               <td colspan=2>
                                  <input class="select_resp" name="archs[]" type="file" id="T7" accept="<!--{$extn}-->"/>
                                  <div id="T7-list" class="select_resp" ></div>
                               </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <!--{if $MOSTRAR_ERROR}-->
                <tr align="center">
                  <td width="100%" height="25" class="titulos5" align="center" colspan="2">
                    <strong>
                      DEBE SELECCIONAR UN TIPO DE RADICADO
                    </strong>
                  </td>
                </tr>
                <!--{/if}-->
                <tr align="center">
                  <td width="100%" height="25" class="titulos5" align="center" colspan="2">
                    <select name="tipo_radicado">
                      <option value="0">Radicar Como:</option>
                      <!--{foreach from=$TIPOS_RADICADOS key=TIPO item=VALOR}-->
                      <option value="<!--{$TIPO}-->"><!--{$VALOR}--></option>
                      <!--{/foreach}-->
                    </select>
                  </td>
                </tr>
                
                <tr align="center">
                  <td width="100%" height="25" class="titulos5" align="center" colspan="2">
                    <input type="submit" name="Button" value="ENVIAR" class="botones">
                  </td>
                </tr>

                <tr>
                    <td>
                        <textarea id="texrich" name="respuesta" value=''><!--{$asunto}--></textarea>
                    </td>
         </form>
                    <td  style="width: 230px; vertical-align: top;">
                        <ul id="browser" class="filetree" style="font-size: 10px;">
                            <div class="titulos4" style="line-height: 30px;"> Administración de plantillas </div>
                            <br/><br/>
                            De click en la plantilla que desea cargar:

                            <form id="form3" name="form3" method="post" enctype="multipart/form-data"
                              action='../respuestaRapida/procPlantilla.php?<!--{$sid}-->'>
                            <!--{foreach key=idCarpeta item=carpeta from=$carpetas}-->
                              <li><span class="folder"><!--{$idCarpeta}--></span>
                                <ul>
                                  <!--{foreach key=id item=archivo from=$carpeta}-->
                                  <li>
                                    <span class="file">
                                    <!--{if $archivo.show == true}-->
                                      <input type="checkbox" name="planaborrar[]" value="<!--{$archivo.id}-->">
                                    <!--{/if}-->
                                      <span ref="<!--{$archivo.id}-->"><!--{$archivo.nombre}--></span>
                                    </span>
                                  </li>
                                  <!--{/foreach}-->
                                </ul>
                              </li>
                            <!--{/foreach}-->
                              <input type="submit" name="delPlant" value="Borrar" class="botones_largo">
                            </form>
                        </ul>
                        <div class="titulos4" style="line-height: 30px;">
                        Guardar plantilla
                        </div>
                        <form id="form2" name="form2" method="post" enctype="multipart/form-data"
                           action='../respuestaRapida/procPlantilla.php?<!--{$sid}-->'>
                          <div class="info">
                            Nombre plantilla:
                          </div>
                          <input type="text" name="nombre" id="nombre"/><br/>
                          <select name="nivel" id="nivel">
                              <option value="">Selecciona una Carpeta</option>
                            <!--{section name=nr loop=$perm_carps}-->
                              <option value="<!--{$perm_carps[nr].codigo}-->"><!--{$perm_carps[nr].nombre}--></option>
                            <!--{/section}-->
                          </select>
                          <input type="submit" name="plantillas" value="Enviar" class="botones_largo">
                        </form>
                     </td>
                </tr>
          </table>

    </body>
</html>
