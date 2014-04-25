<?php /* Smarty version 2.6.20, created on 2014-04-25 07:39:12
         compiled from salidaRespuesta.tpl */ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Respuesta Rapida</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="../estilos/orfeo.css" type="text/css"  rel="stylesheet" />
        <?php echo $this->_tpl_vars['estilosCaliope']; ?>

        <style type="text/css">

            HTML, BODY{
                font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
                margin: 0px; 
                height: 100%;
            }
        </style>
    </head>
    <body>

        <table width="70%" border="0" align="center" margin="4" CELLPADDING="10" cellspacing="0" >

            <tr bordercolor="#FFFFFF">
                <td colspan="2" height="40" align="center" class="titulos4"
                    valign="middle">
                    <b><span class=etexto>Respuesta Rapida</span></b>
                </td>
            </tr>
            <?php if ($this->_tpl_vars['noerror'] >= 1 || $this->_tpl_vars['salida'] == 'ok'): ?>
                <tr>
                    <td <?php if (! $this->_tpl_vars['sali']): ?> colspan="2" <?php endif; ?> valign="middle">
                        <b><span class=etexto>Radicado de respuesta No. <?php echo $this->_tpl_vars['nurad']; ?>
</span></b>
                    </td>
                    <?php if ($this->_tpl_vars['sali']): ?>
                    <td valign="middle">
                        <b><span class=etexto>Anexos de la respuesta </span></b>
                            <?php unset($this->_sections['customer']);
$this->_sections['customer']['name'] = 'customer';
$this->_sections['customer']['loop'] = is_array($_loop=$this->_tpl_vars['sali']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['customer']['show'] = true;
$this->_sections['customer']['max'] = $this->_sections['customer']['loop'];
$this->_sections['customer']['step'] = 1;
$this->_sections['customer']['start'] = $this->_sections['customer']['step'] > 0 ? 0 : $this->_sections['customer']['loop']-1;
if ($this->_sections['customer']['show']) {
    $this->_sections['customer']['total'] = $this->_sections['customer']['loop'];
    if ($this->_sections['customer']['total'] == 0)
        $this->_sections['customer']['show'] = false;
} else
    $this->_sections['customer']['total'] = 0;
if ($this->_sections['customer']['show']):

            for ($this->_sections['customer']['index'] = $this->_sections['customer']['start'], $this->_sections['customer']['iteration'] = 1;
                 $this->_sections['customer']['iteration'] <= $this->_sections['customer']['total'];
                 $this->_sections['customer']['index'] += $this->_sections['customer']['step'], $this->_sections['customer']['iteration']++):
$this->_sections['customer']['rownum'] = $this->_sections['customer']['iteration'];
$this->_sections['customer']['index_prev'] = $this->_sections['customer']['index'] - $this->_sections['customer']['step'];
$this->_sections['customer']['index_next'] = $this->_sections['customer']['index'] + $this->_sections['customer']['step'];
$this->_sections['customer']['first']      = ($this->_sections['customer']['iteration'] == 1);
$this->_sections['customer']['last']       = ($this->_sections['customer']['iteration'] == $this->_sections['customer']['total']);
?>
                                <li><a href="<?php echo $this->_tpl_vars['sali'][$this->_sections['customer']['index']]['path']; ?>
"><?php echo $this->_tpl_vars['sali'][$this->_sections['customer']['index']]['desc']; ?>
</a></li>
                            <?php endfor; endif; ?>
                    </td>
                    <?php endif; ?> 
                </tr>

                <tr>
                    <td colspan="2" >
                        <b><span class=etexto><?php echo $this->_tpl_vars['error']; ?>
</span></b>
                    </td>
                </tr>
            <?php else: ?>
                <tr>
                    <td colspan="2" >
                        <b><span class=etexto><?php echo $this->_tpl_vars['error']; ?>
</span></b>
                    </td>
                </tr>
            <?php endif; ?>
        </table>
        <?php if ($this->_tpl_vars['noerror'] >= 1 || $this->_tpl_vars['salida'] == 'ok'): ?>
        <iframe src="../radicacion/tipificar_documento.php?<?php echo $this->_tpl_vars['sid']; ?>
&nurad=<?php echo $this->_tpl_vars['nurad']; ?>
&dependencia=<?php echo $this->_tpl_vars['dependencia']; ?>
&krd=<?php echo $this->_tpl_vars['krd']; ?>
&tsub=0&codserie=0" 
        width='100%' height='340px' style='border: 0px'></iframe>
        <?php endif; ?>
        <center><h1><input type="button" value="Salir" class="botones" onclick="parent.window.close();"></h1></center>
    </body>
</html>