<?php /* Smarty version 2.6.26, created on 2012-08-31 18:19:10
         compiled from index.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'cycle', 'index.tpl', 184, false),)), $this); ?>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Lista de soportes</title>
        <link rel="stylesheet" type="text/css" href="../estilos/orfeo.css">
        <script type="text/javascript" src="../js/jquery-1.4.2.min.js">
        </script>
        <script type="text/javascript" src="../js/jquery.charcounter.js">
        </script>       
        <script type="text/javascript" src="../js/jquery.form.js">
        </script>
        <script type="text/javascript" src="./js/soportes.js">
        </script>       
    </head>
    <body>
        <form id="creSoporte" name="creSoporte">
            
            <table class="borde_tab" id="soporte" width="100%" align="center" margin="4">
                <input type="hidden" name="<?php echo $this->_tpl_vars['sesNam']; ?>
" value="<?php echo $this->_tpl_vars['sessid']; ?>
">
                <tr>
                    <td class="titulos4">
                        <b>Crear nuevo ticket</b>
                    </td>               
                    <td class="titulos3"> 
                        <span id="contador"></span>     
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Comentario</b>
                    </td>
                    <td>
                        <b>Tipo de soportes</b>
                    </td>
                </tr>

                <!--INICIO  Seleccion de Tipo documento-->
                <tr>
                    <td rowspan="2">
                        <textarea class="texArea" name="come_sop" id="come_sop" wrap="soft"></textarea>
                    </td>
                    <td align="left" width="15%">
                        <select name="selectTipSop" id="selectTipSop">
                            <?php $_from = $this->_tpl_vars['tipoSop']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?><option value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                            <?php endforeach; endif; unset($_from); ?>
                        </select>
                    </td>
                </tr>
                <!--FIN  Seleccion de Tipo documento-->
                
                <tr>
                    <td align="left">
                        <INPUT class="botones" TYPE=submit VALUE="Crear"/>
                    </td>
                </tr>
                
            </table>
            
            <!-- resultado de ajax al crear soporte --> 
            <div id="output1"></div>
            
        </form>
        
        
       <!--INICIO Mostrar friltros de busqueda-->
       <form id="ordSopor" name="ordSopor" action="index.php" method="post">
           <input type="hidden" name="<?php echo $this->_tpl_vars['sesNam']; ?>
" value="<?php echo $this->_tpl_vars['sessid']; ?>
">
            <table class="titulos3b">
                <tr>
                   <td align="left">
                       No Ticket
                   </td> 
                   <td align="left">
                       Tipo de soporte
                   </td>
                   <td align="left">
                       Usuario
                   </td>
                   <td align="left">
                       Estado
                   </td>
                    <td align="left">
                       Responsable
                   </td>
                    <td>
                   </td>
                   <td>
                   </td>
                </tr>
                <tr>
                    <td align="left">
                        <input type="text" name="noTicket" value="<?php echo $this->_tpl_vars['noTicket']; ?>
"  size="5" maxlength="5" />                     
                    </td>
                    <td align="left">
                        <select name="selectTipSop">
                                <option value="">-- </option>
                                <?php $_from = $this->_tpl_vars['tipoSop']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
                                    <?php if ($this->_tpl_vars['selectTipSop'] == $this->_tpl_vars['key']): ?>
                                        <option selected value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php else: ?>
                                        <option value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php endif; ?>                                    
                                <?php endforeach; endif; unset($_from); ?>                            
                         </select>                     
                    </td>
                    <td align="left">
                        <select name="usuExte">
                                <option value="">-- </option>
                                <?php $_from = $this->_tpl_vars['usuExteArr']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
                                    <?php if ($this->_tpl_vars['usuExte'] == $this->_tpl_vars['key']): ?>
                                        <option selected value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php else: ?>
                                        <option value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php endif; ?>   
                                <?php endforeach; endif; unset($_from); ?>
                            </select>
                    </td>
                    <td align="left">
                        <select name="respons">                            
                                <option value="">-- </option>
                                <?php $_from = $this->_tpl_vars['ticRespon']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
                                    <?php if ($this->_tpl_vars['respons'] == $this->_tpl_vars['key']): ?>
                                        <option selected value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php else: ?>
                                        <option value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php endif; ?>   
                                <?php endforeach; endif; unset($_from); ?>                                   
                        </select>                     
                    </td>        
                    <td align="left">
                        <select name="estadoTick">                            
                                <?php $_from = $this->_tpl_vars['ticEstado']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
                                    <?php if ($this->_tpl_vars['estadoTick'] == $this->_tpl_vars['key']): ?>
                                        <option selected value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php else: ?>
                                        <option value=<?php echo $this->_tpl_vars['key']; ?>
><?php echo $this->_tpl_vars['item']; ?>
</option>
                                    <?php endif; ?>   
                                <?php endforeach; endif; unset($_from); ?>                                   
                        </select>                     
                    </td> 
                    <td align="right">
                        <input class="botones" type="submit"  name="filtros" value="Enviar" />                                             
                    </td>               
                    <td align="right">
                            <input class="botones" name="actualizar" value="Actualizar"/>
                    </td>      
                </tr>
                <tr>
                   <td colspan="5">
                   </td>
                   <td>
                        Datos por pagina
                   </td>
                   <td>
                        Pangina Numero
                   </td>
                </tr>
                <tr>
                   <td colspan="5">
                   </td>
                    <td align="center">
                        <input type="text" name="cantidad" value="<?php echo $this->_tpl_vars['cantidad']; ?>
"  size="5" maxlength="10000" />                     
                        <input class="botones_2" value=".."/>
                    </td>
                    <td align="center">
                        <select name="pagNo">                            
                            <?php unset($this->_sections['numero']);
$this->_sections['numero']['name'] = 'numero';
$this->_sections['numero']['loop'] = is_array($_loop=$this->_tpl_vars['numPag']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['numero']['show'] = true;
$this->_sections['numero']['max'] = $this->_sections['numero']['loop'];
$this->_sections['numero']['step'] = 1;
$this->_sections['numero']['start'] = $this->_sections['numero']['step'] > 0 ? 0 : $this->_sections['numero']['loop']-1;
if ($this->_sections['numero']['show']) {
    $this->_sections['numero']['total'] = $this->_sections['numero']['loop'];
    if ($this->_sections['numero']['total'] == 0)
        $this->_sections['numero']['show'] = false;
} else
    $this->_sections['numero']['total'] = 0;
if ($this->_sections['numero']['show']):

            for ($this->_sections['numero']['index'] = $this->_sections['numero']['start'], $this->_sections['numero']['iteration'] = 1;
                 $this->_sections['numero']['iteration'] <= $this->_sections['numero']['total'];
                 $this->_sections['numero']['index'] += $this->_sections['numero']['step'], $this->_sections['numero']['iteration']++):
$this->_sections['numero']['rownum'] = $this->_sections['numero']['iteration'];
$this->_sections['numero']['index_prev'] = $this->_sections['numero']['index'] - $this->_sections['numero']['step'];
$this->_sections['numero']['index_next'] = $this->_sections['numero']['index'] + $this->_sections['numero']['step'];
$this->_sections['numero']['first']      = ($this->_sections['numero']['iteration'] == 1);
$this->_sections['numero']['last']       = ($this->_sections['numero']['iteration'] == $this->_sections['numero']['total']);
?>
                                <option  value="<?php echo $this->_tpl_vars['numPag'][$this->_sections['numero']['index']]; ?>
" 
                                    <?php if ($this->_tpl_vars['pagNo'] == $this->_tpl_vars['numPag'][$this->_sections['numero']['index']]): ?>selected="selected"<?php endif; ?>>
                                    <?php echo $this->_tpl_vars['numPag'][$this->_sections['numero']['index']]; ?>

                                </option>
                            <?php endfor; endif; ?>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
        <!--FIN Mostrar friltros de busqueda-->        
        
         <!--INICIO Mostrar ticket existentes-->
        <?php unset($this->_sections['data']);
$this->_sections['data']['name'] = 'data';
$this->_sections['data']['loop'] = is_array($_loop=$this->_tpl_vars['sopor']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['data']['show'] = true;
$this->_sections['data']['max'] = $this->_sections['data']['loop'];
$this->_sections['data']['step'] = 1;
$this->_sections['data']['start'] = $this->_sections['data']['step'] > 0 ? 0 : $this->_sections['data']['loop']-1;
if ($this->_sections['data']['show']) {
    $this->_sections['data']['total'] = $this->_sections['data']['loop'];
    if ($this->_sections['data']['total'] == 0)
        $this->_sections['data']['show'] = false;
} else
    $this->_sections['data']['total'] = 0;
if ($this->_sections['data']['show']):

            for ($this->_sections['data']['index'] = $this->_sections['data']['start'], $this->_sections['data']['iteration'] = 1;
                 $this->_sections['data']['iteration'] <= $this->_sections['data']['total'];
                 $this->_sections['data']['index'] += $this->_sections['data']['step'], $this->_sections['data']['iteration']++):
$this->_sections['data']['rownum'] = $this->_sections['data']['iteration'];
$this->_sections['data']['index_prev'] = $this->_sections['data']['index'] - $this->_sections['data']['step'];
$this->_sections['data']['index_next'] = $this->_sections['data']['index'] + $this->_sections['data']['step'];
$this->_sections['data']['first']      = ($this->_sections['data']['iteration'] == 1);
$this->_sections['data']['last']       = ($this->_sections['data']['iteration'] == $this->_sections['data']['total']);
?>
        <?php echo '<form id="'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['TICKET']; ?><?php echo '"><input type="hidden" name="'; ?><?php echo $this->_tpl_vars['sesNam']; ?><?php echo '" value="'; ?><?php echo $this->_tpl_vars['sessid']; ?><?php echo '" /><table class="fomatoCellRow" width="100%" bgcolor="'; ?><?php echo smarty_function_cycle(array('values' => "#a8bac6, #ffffff"), $this);?><?php echo '"><tr><td width="12%"><b></>No.Ticket</b></td><td><input readonly="readonly" name="ticket" type="text" value="'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['TICKET']; ?><?php echo '" /></td><td width="100%"><b>Nombre del usuario</b> : '; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['NOMBRE']; ?><?php echo '</td></tr><tr><td><b>Tipo de soporte</b></td><td>'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['TIPO']; ?><?php echo '</td><td rowspan="3">'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['COMENT']; ?><?php echo '</td></tr><tr><td><b>Fecha de inicio</b></td><td>'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['FECHAINI']; ?><?php echo '</td></tr><tr><td><b>Fecha de cierre</b></td><td>'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['FECHAFIN']; ?><?php echo '</td></tr><tr><td><b>Responsable actual</b></td><td>'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['RESPON']; ?><?php echo '</td></tr><tr><td colspan="5" align="right"><input class="botones" name="'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['TICKET']; ?><?php echo '_ticket" type="submit" value="Comentarios >" /></td></tr></table><!-- resultado de ajax al consultar comentario --><div class="subForm" id="'; ?><?php echo $this->_tpl_vars['sopor'][$this->_sections['data']['index']]['TICKET']; ?><?php echo '_resul"></div></form>'; ?>
        
        <?php endfor; endif; ?>        
        <!--FIN Mostrar ticket existentes-->
        
                
    </body>
</html>