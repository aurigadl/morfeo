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
      <link href="../estilos/bootstrap.min.css" rel="stylesheet">
      <!-- font-awesome CSS -->
      <link href="../estilos/font-awesome.css" rel="stylesheet">
      <!-- Bootstrap core CSS -->
      <link href="../estilos/font-awesome.min.css" rel="stylesheet">
      <link href="../estilos/smartadmin-production.css" rel="stylesheet">
      <link href="../estilos/smartadmin-skins.css" rel="stylesheet">
      <link href="../estilos/demo.css" rel="stylesheet">
      <link href="../estilos/siim_temp.css" rel="stylesheet">        

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
      <title>..:: Generacion de Documentos en Linea ::..</title>
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
        <form id="form1" name="form1" class="smart-form" method="post" enctype="multipart/form-data" action='../respuestaRapida/accion_radicar_anexar.php?<!--{$sid}-->' onsubmit="return valFo(this)">
            <input type="hidden" name="usuanomb"   value='<!--{$usuanomb}-->'>
            <input type="hidden" name="usualog"    value='<!--{$usualog}-->'>
            <input type="hidden" name="editar"     value='<!--{$editar}-->'>
            <input type="hidden" name="radPadre"   value='<!--{$radPadre}-->'>
            <input type="hidden" name="usuacodi"   value='<!--{$usuacodi}-->'>
            <input type="hidden" name="depecodi"   value='<!--{$depecodi}-->'>
            <input type="hidden" name="codigoCiu"  value='<!--{$codigoCiu}-->'>
            <input type="hidden" name="codigoCiu"  value='<!--{$codigoCiu}-->'>
            <input type="hidden" name="codigoCiu"  value='<!--{$codigoCiu}-->'>
            <input type="hidden" name="rutaPadre"  value='<!--{$rutaPadre}-->'>
            <input type="hidden" name="anexo"  value="<!--{$anexo}-->">

            <table border="0" width="100%" align="center" class="table table-bordered">
                <tr>
                                    <td colspan="1"  align="center" >
                     <small> Radicar como</small>
                      <label class="select">
                      <select name="tipo_radicado" class="select">
                      <!--{foreach from=$TIPOS_RADICADOS key=TIPO item=VALOR}-->
                      <option value="<!--{$TIPO}-->"><!--{$VALOR}--></option>
                      <!--{/foreach}-->
                    </select>
                    </label>
                  </td>
                
                <!--{if $MOSTRAR_ERROR}-->
                  <td width="100%"  align="center" colspan="2">
                    <strong>
                      DEBE SELECCIONAR UN TIPO DE RADICADO
                    </strong>
                  </td>
                <!--{/if}-->
                  <td colspan="4" >
                    <!--{if $GUARDAR_RADICADO}-->
                    <footer>
                      <input type="submit" name="Button" value="Guardar Cambios" class="btn btn-primary">
                    </footer>
                    <!--{else}-->
                    <footer>
                      <input type="submit" name="Button" value="Radicar" class="btn btn-primary">
                      &nbsp;
                      <input type="submit" name="Button" value="Grabar como Anexo" class="btn btn-success">
                    </footer>
                    <!--{/if}-->
                  </td
                </tr>
                
                <tr>
                    <td colspan=5>
                        <textarea id="texrich" name="respuesta" value=''><!--{$asunto}--></textarea>
                    </td>
         </form>
                    <td  style="width: 230px; vertical-align: top;">
                        <ul id="browser" class="filetree" style="font-size: 10px;">
                            <div  style="line-height: 30px;"> Administraci&oacute;n de plantillas </div>
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
                        <div  style="line-height: 30px;">
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
