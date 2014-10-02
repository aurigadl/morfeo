<?php
session_start();
$ruta_raiz = "..";
include_once "../include/db/ConnectionHandler.php";
include('./captcha/simple-php-captcha.php');
$_SESSION['captcha_consulta'] = captcha();
?>
<html>
<head>
<?php include_once("$ruta_raiz/htmlheader.inc.php") ?>
    <link href="../estilos/login.css" rel="stylesheet">
</head>

<body>
<body>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
<div class="container">
<div class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable">
<div id="content" style="opacity: 1;">
<form name="formulario" method="post"  class="smart-form"  action=''>
<fieldset>
<div class="row">
<section class="col col-6">
<label class="label">N&uacute;mero de Radicado (s&oacute;lo n&uacute;meros)</label>
<label class="input"><input name="numeroRadicado" type="text" class="ecajasfecha" id="cuentai" size="35" value=""></label>
</section>

<section class="col col-6">
<label class="label">C&oacute;digo verificaci&oacute;n radicado </label>
<label class="input"><input name="codigoVerificacion" type="text" class="ecajasfecha" id="buscar_por_radicado" size="35" value=""></label>
</section>

</div>

<div class="row">
<section class="col col-6">
<label class="label">Im&aacute;gen de verificaci&oacute;n (Sensible a min&uacute;sculas y may&uacute;sculas)</label>
<label class="input"><input name="buscar_por_exp" type="text" class="ecajasfecha" id="buscar_por" size="35" value="<?=$buscar_por_exp ?>"></label>
</section>
<section class="col col-6">
<?php
	echo '<img id="imgcaptcha" src="' . $_SESSION['captcha_consulta']['image_src'] . '" alt="CAPTCHA" /><br>';
	echo '<a href="#" onClick="return reloadImg(\'imgcaptcha\');">Cambiar im&aacute;gen<a>'

	?>
</section>
</div>

</fieldset>
<footer>
<input type="submit" name="Submit"  value="buscar"  class="btn btn-primary">
<a class="btn btn-success" href=''>Nuevo</a>
</footer>
<input type='hidden' name='pnom' value=''>
</form>
</div>
</body>
</html>
