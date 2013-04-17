<?php /* Smarty version 2.6.26, created on 2012-08-31 18:19:39
         compiled from comentarios.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'cycle', 'comentarios.tpl', 43, false),)), $this); ?>
<!-- request Evento ajax-->
<script type="text/javascript" src="./js/soportes.js">
</script>

<!-- INICIO Crear nuevo comentario y cerrar ticket-->
<?php if ($this->_tpl_vars['mosCerrar'] > 0): ?>
<form id="coment_<?php echo $this->_tpl_vars['ticket']; ?>
" name="coment_<?php echo $this->_tpl_vars['ticket']; ?>
">
    <br/>
    <table class="fomatoCellRow" id="soporteComent" width="100%" align="center" margin="4">
        <input type="hidden" name="<?php echo $this->_tpl_vars['sesNam']; ?>
" value="<?php echo $this->_tpl_vars['sessid']; ?>
">
        <input type="hidden" name="ticket" value="<?php echo $this->_tpl_vars['ticket']; ?>
">
        
        <tr>
            <td>
                <b>Nuevo comentario</b>
            </td>
        </tr>
        
        
        <tr>
            <td width="90%">
                <textarea  class="texArea" name="comentario" wrap="soft"></textarea>
            </td>
            <td width="10%" align="right">
                <?php if ($this->_tpl_vars['mosCerrar'] > 1): ?>
                <INPUT class="botones" name="<?php echo $this->_tpl_vars['ticket']; ?>
_coment" TYPE=submit VALUE="Cerrar Ticket" />
                <br/>
                <?php endif; ?>                
                <INPUT class="botones" name="<?php echo $this->_tpl_vars['ticket']; ?>
_coment" TYPE=submit VALUE="Comentar" />                
            </td>
        </tr>
        
    </table>
    <!-- resultado de ajax al crear soporte -->
    <div id="outputCom_<?php echo $this->_tpl_vars['ticket']; ?>
"></div>    
</form>
<?php endif; ?>            
<!-- FIN Crear nuevo comentario y cerrar ticket-->

<!-- INICIO Mostrar comentarios existentes-->
<?php unset($this->_sections['data']);
$this->_sections['data']['name'] = 'data';
$this->_sections['data']['loop'] = is_array($_loop=$this->_tpl_vars['coment']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
<?php echo '<table class="fomatoCellRow" width="100%" bgcolor="'; ?><?php echo smarty_function_cycle(array('values' => "#E3E8EC,#ffffff"), $this);?><?php echo '"><tr><td width="150px" align="center" rowspan="2"><b>Fecha del comentario:</b> '; ?><?php echo $this->_tpl_vars['coment'][$this->_sections['data']['index']]['FECHACOMT']; ?><?php echo '</td><td><b>Usuario: </b> '; ?><?php echo $this->_tpl_vars['coment'][$this->_sections['data']['index']]['USUARIO']; ?><?php echo '</td></tr><tr><td>'; ?><?php echo $this->_tpl_vars['coment'][$this->_sections['data']['index']]['COMENTARIO']; ?><?php echo '</td></tr></table>'; ?>

<?php endfor; endif; ?>
<!-- FIN Mostrar comentarios existentes-->