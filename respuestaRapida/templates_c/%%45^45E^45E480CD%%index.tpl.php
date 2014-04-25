<?php /* Smarty version 2.6.20, created on 2014-04-25 07:16:09
         compiled from index.tpl */ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

        <?php $_from = $this->_tpl_vars['carpetas']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['idCarpeta'] => $this->_tpl_vars['carpeta']):
?>
          <?php $_from = $this->_tpl_vars['carpeta']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['archivo']):
?>
              <span id='<?php echo $this->_tpl_vars['archivo']['id']; ?>
' style="display:none;">
                <?php echo $this->_tpl_vars['archivo']['ruta']; ?>

              </span>
          <?php endforeach; endif; unset($_from); ?>
        <?php endforeach; endif; unset($_from); ?>

        <div id="load" style="display:none;">Enviando.....</div>
        <form id="form1" name="form1" method="post" enctype="multipart/form-data"
                action='../respuestaRapida/procRespuesta.php?<?php echo $this->_tpl_vars['sid']; ?>
' onsubmit="return valFo(this)">

            <input type=hidden name="usuanomb"   value='<?php echo $this->_tpl_vars['usuanomb']; ?>
'>
            <input type=hidden name="usualog"    value='<?php echo $this->_tpl_vars['usualog']; ?>
'>
            <input type=hidden name="radPadre"   value='<?php echo $this->_tpl_vars['radPadre']; ?>
'>
            <input type=hidden name="usuacodi"   value='<?php echo $this->_tpl_vars['usuacodi']; ?>
'>
            <input type=hidden name="depecodi"   value='<?php echo $this->_tpl_vars['depecodi']; ?>
'>
            <input type=hidden name="codigoCiu"  value='<?php echo $this->_tpl_vars['codigoCiu']; ?>
'>
            <input type=hidden name="codigoCiu"  value='<?php echo $this->_tpl_vars['codigoCiu']; ?>
'>
            <input type=hidden name="codigoCiu"  value='<?php echo $this->_tpl_vars['codigoCiu']; ?>
'>
            <input type=hidden name="rutaPadre"  value='<?php echo $this->_tpl_vars['rutaPadre']; ?>
'>

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
                                  <input class="select_resp" name="archs[]" type="file" id="T7" accept="<?php echo $this->_tpl_vars['extn']; ?>
"/>
                                  <div id="T7-list" class="select_resp" ></div>
                               </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr align="center">
                  <td width="100%" height="25" class="titulos5" align="center" colspan="4">
                    <input type="submit" name="Button" value="ENVIAR" class="botones">
                  </td>
                </tr>

                <tr>
                    <td>
                        <textarea id="texrich" name="respuesta" value=''><?php echo $this->_tpl_vars['asunto']; ?>
</textarea>
                    </td>
         </form>
                    <td  style="width: 230px; vertical-align: top;">
                        <ul id="browser" class="filetree" style="font-size: 10px;">
                            <div class="titulos4" style="line-height: 30px;"> Administración de plantillas </div>
                            <br/><br/>
                            De click en la plantilla que desea cargar:

                            <form id="form3" name="form3" method="post" enctype="multipart/form-data"
                              action='../respuestaRapida/procPlantilla.php?<?php echo $this->_tpl_vars['sid']; ?>
'>
                            <?php $_from = $this->_tpl_vars['carpetas']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['idCarpeta'] => $this->_tpl_vars['carpeta']):
?>
                              <li><span class="folder"><?php echo $this->_tpl_vars['idCarpeta']; ?>
</span>
                                <ul>
                                  <?php $_from = $this->_tpl_vars['carpeta']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['archivo']):
?>
                                  <li>
                                    <span class="file">
                                    <?php if ($this->_tpl_vars['archivo']['show'] == true): ?>
                                      <input type="checkbox" name="planaborrar[]" value="<?php echo $this->_tpl_vars['archivo']['id']; ?>
">
                                    <?php endif; ?>
                                      <span ref="<?php echo $this->_tpl_vars['archivo']['id']; ?>
"><?php echo $this->_tpl_vars['archivo']['nombre']; ?>
</span>
                                    </span>
                                  </li>
                                  <?php endforeach; endif; unset($_from); ?>
                                </ul>
                              </li>
                            <?php endforeach; endif; unset($_from); ?>
                              <input type="submit" name="delPlant" value="Borrar" class="botones_largo">
                            </form>
                        </ul>
                        <div class="titulos4" style="line-height: 30px;">
                        Guardar plantilla
                        </div>
                        <form id="form2" name="form2" method="post" enctype="multipart/form-data"
                           action='../respuestaRapida/procPlantilla.php?<?php echo $this->_tpl_vars['sid']; ?>
'>
                          <div class="info">
                            Nombre plantilla:
                          </div>
                          <input type="text" name="nombre" id="nombre"/><br/>
                          <select name="nivel" id="nivel">
                              <option value="">Selecciona una Carpeta</option>
                            <?php unset($this->_sections['nr']);
$this->_sections['nr']['name'] = 'nr';
$this->_sections['nr']['loop'] = is_array($_loop=$this->_tpl_vars['perm_carps']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['nr']['show'] = true;
$this->_sections['nr']['max'] = $this->_sections['nr']['loop'];
$this->_sections['nr']['step'] = 1;
$this->_sections['nr']['start'] = $this->_sections['nr']['step'] > 0 ? 0 : $this->_sections['nr']['loop']-1;
if ($this->_sections['nr']['show']) {
    $this->_sections['nr']['total'] = $this->_sections['nr']['loop'];
    if ($this->_sections['nr']['total'] == 0)
        $this->_sections['nr']['show'] = false;
} else
    $this->_sections['nr']['total'] = 0;
if ($this->_sections['nr']['show']):

            for ($this->_sections['nr']['index'] = $this->_sections['nr']['start'], $this->_sections['nr']['iteration'] = 1;
                 $this->_sections['nr']['iteration'] <= $this->_sections['nr']['total'];
                 $this->_sections['nr']['index'] += $this->_sections['nr']['step'], $this->_sections['nr']['iteration']++):
$this->_sections['nr']['rownum'] = $this->_sections['nr']['iteration'];
$this->_sections['nr']['index_prev'] = $this->_sections['nr']['index'] - $this->_sections['nr']['step'];
$this->_sections['nr']['index_next'] = $this->_sections['nr']['index'] + $this->_sections['nr']['step'];
$this->_sections['nr']['first']      = ($this->_sections['nr']['iteration'] == 1);
$this->_sections['nr']['last']       = ($this->_sections['nr']['iteration'] == $this->_sections['nr']['total']);
?>
                              <option value="<?php echo $this->_tpl_vars['perm_carps'][$this->_sections['nr']['index']]['codigo']; ?>
"><?php echo $this->_tpl_vars['perm_carps'][$this->_sections['nr']['index']]['nombre']; ?>
</option>
                            <?php endfor; endif; ?>
                          </select>
                          <input type="submit" name="plantillas" value="Enviar" class="botones_largo">
                        </form>
                     </td>
                </tr>
          </table>

    </body>
</html>