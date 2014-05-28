<?php
/**
* @module crearUsuario
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

$krd            = $_SESSION["krd"];
$dependencia    = $_SESSION["dependencia"];
$usua_doc       = $_SESSION["usua_doc"];
$codusuario     = $_SESSION["codusuario"];


foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

if(!isset($_SESSION['dependencia']))	include "$ruta_raiz/rec_session.php";

$entrada        = 0;
$modificaciones = 0;
$salida         = 0;

if(!$fecha_busq) $fecha_busq=date("Y-m-d");
($usModo ==1) ? $tituloCrear = "Creacion de Usuario" : $tituloCrear = "Edicion de Usuario";
?>

<html>
  <head>
    <title>Admin usuario</title>
    <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
  </head>
  <body>
<?php
  include "$ruta_raiz/config.php";
  define('ADODB_ASSOC_CASE', 1);
  include_once "$ruta_raiz/include/db/ConnectionHandler.php";

  $db = new ConnectionHandler($ruta_raiz);
  if ($usModo ==2) {	//modo editar
	if ($valRadio) {	
		$usuSelec = $valRadio;
		$usuario_mat = split("-",$usuSelec,2);
		$usuDocSel = $usuario_mat[0];
		$usuLoginSel = $usuario_mat[1];
		$isql = "SELECT * FROM USUARIO WHERE USUA_LOGIN='".$usuLoginSel."'";
        	$rsCrea = $db->conn->Execute($isql);
		if ($rsCrea->fields["USUA_CODI"] == 1)  $perfilOrig = "Jefe";
		else $perfilOrig = "Normal";
		$perfil     = $perfilOrig;
		$nusua_codi = $rsCrea->fields["USUA_CODI"];
		$cedula     = $rsCrea->fields["USUA_DOC"];
		$usuLogin   = $rsCrea->fields["USUA_LOGIN"];
		$nombre     = $rsCrea->fields["USUA_NOMB"];
		$dep_sel    = $rsCrea->fields["DEPE_CODI"];
		$fecha_nacim 	= substr($rsCrea->fields["USUA_NACIM"], 0, 11);
		$dia = substr($fecha_nacim, 8, 2);
		$mes = substr($fecha_nacim, 5, 2);
		$ano = substr($fecha_nacim, 0, 4);
		$ubicacion      = $rsCrea->fields["USUA_AT"];
		$piso           = $rsCrea->fields["USUA_PISO"];
		$extension      = $rsCrea->fields["USUA_EXT"];
    $email			= trim($rsCrea->fields["USUA_EMAIL"]);
    $email1			= trim($rsCrea->fields["USUA_EMAIL_1"]);
    $email2			= trim($rsCrea->fields["USUA_EMAIL_2"]);
		$usua_activo 	= $rsCrea->fields["USUA_ESTA"];
		$modificaciones	= $rsCrea->fields["USUA_PERM_MODIFICA"];
		$env_correo 	= $rsCrea->fields["USUA_PERM_ENVIOS"];
		$estadisticas   = $rsCrea->fields["SGD_PERM_ESTADISTICA"];
		$impresion	    = $rsCrea->fields["USUA_PERM_IMPRESION"];
		$prestamo		= $rsCrea->fields["USUA_PERM_PRESTAMO"];
		$adm_sistema 	= $rsCrea->fields["USUA_ADMIN"];
		$adm_archivo 	= $rsCrea->fields["USUA_ADMIN_ARCHIVO"];
		$usua_nuevoM 	= $rsCrea->fields["USUA_NUEVO"];
		$nivel			= $rsCrea->fields["CODI_NIVEL"];
		$salida 		= $rsCrea->fields["USUA_PRAD_TP1"];
		$masiva 		= $rsCrea->fields["USUA_MASIVA"];
		$dev_correo 	= $rsCrea->fields["USUA_PERM_DEV"];
		if ($rsCrea->fields["SGD_PANU_CODI"] == 1) $s_anulaciones = 1;
		if ($rsCrea->fields["SGD_PANU_CODI"] == 2) $anulaciones = 1;
		if ($rsCrea->fields["SGD_PANU_CODI"] == 3) {$s_anulaciones = 1; $anulaciones = 1;}
		$usua_publico   = $rsCrea->fields["USUARIO_PUBLICO"];
		$reasigna       = $rsCrea->fields["USUARIO_REASIGNAR"];
		$firma          = $rsCrea->fields["USUA_PERM_FIRMA"];
		$notifica       = $rsCrea->fields["USUA_PERM_NOTIFICA"];
    $usua_radmail   = $rsCrea->fields["USUA_PERM_RADEMAIL"];  
		$usua_permexp   = $rsCrea->fields["USUA_PERM_EXPEDIENTE"];
    $respuesta      = $rsCrea->fields["USUA_PERM_RESPUESTA"];
	}
}
?>  
  
<header class="page-title txt-color-blueDark">
	<h2>
		Administracion de usuarios y perfiles<br>
	</h2>
</header>

  <form class="smart-form" name='frmCrear' action='validar.php' method="post" data-toggle="validator">
    <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
    <input type=hidden  name=usModo value='<?=$usModo?>'>
  
<fieldset>
	<div class="row">
		<section class="col col-6">
			<label class="label">
				Perfil
			</label>
			<label class="select"></i>
				<?php
				$sql="SELECT COUNT(1) AS EXISTE FROM USUARIO WHERE DEPE_CODI = $dep_sel AND USUA_CODI = 1";
				//$db->conn->debug = true;
				$rsDep  = $db->conn->Execute($sql);
				$existe = $rsDep->fields["EXISTE"];
				if(empty($existe) || $perfil == "Jefe"){
				$perf_1 = "Normal";
				$perf_2 = "Jefe";
				if ($perfil == "Jefe") {$perf_1 = "Jefe"; $perf_2 = "Normal";}
				echo "<select name=perfil class='select'><option value='$perf_1' > $perf_1 </option><option value='$perf_2' > $perf_2 </option></select>";
				}
				else
				echo "<span class='titulosError2'>".$perfil."</span>"."<input name='perfil' type='hidden' value='$perfil'>";
				?>
			</label>
		</section>
		<section class="col col-6">
			<label class="label">
				Dependencia
			</label>
			<label class="select"></i>
				<?php
				include_once "$ruta_raiz/include/query/envios/queryPaencabeza.php";
				$sqlConcat = $db->conn->Concat($conversion, "'-'",$db->conn->substr."(depe_nomb,1,30) ");
				$sql = "select $sqlConcat ,depe_codi from dependencia where depe_estado=1 order by depe_codi";
				$rsDep = $db->conn->Execute($sql);
				if(!$depeBuscada) $depeBuscada = $dependencia;
				print $rsDep->GetMenu2("dep_sel","$dep_sel",false, false, 0," class='select'");
				?>
			</label>
		</section>
	</div>

	<div class="row">
		<input name="nombreJefe" type="hidden" value='<?=$nombreJefe?>'>
		<input name="cedulaYa" type="hidden" value='<?=$cedulaYa?>'>
		<? if ($usModo == 1) { ?>
		<section class="col col-6">
      <label class="label">No. Cedula</label>
      <label class="input">
        <input type="text" name="cedula" pattern="[0-9]*" id="cedula" value="<?=$cedula?>" size=15 maxlenght="14" placeholder="Digite C&eacute;dula" required>
        <span class="help-block with-errors">Digite el n&uacute;mero de la c&eacute;dula</span>
      </label>
      </section>
      <section class="col col-6">
        <label class="label">Usuario</label>
        <label class="input">
          <input type="text" name="usuLogin" pattern="[_A-z 0-9]*" id="usuLogin" value="<?=$usuLogin?>" size="20" maxlenght="15" placeholder="Usuario" required>
        </label>
      </section>
		<? }else { ?>
		  <section class="col col-6">
        <label class="label">Nro Cedula
          <input  type="text" name="cedula" pattern="[0-9]*" id="cedula" value="<?=$cedula?>" size="15" maxlenght="14" placeholder="Digite C&eacute;dula" required>
        </label>
      </section>
      <section class="col col-6">
        <label class="label">
          Usuario
          <input type="text" name="usuLogin" pattern="[_A-z0-9]*" id="usuLogin" value="<?=$usuLogin?>" size="20" maxlenght="15" placeholder="Usuario" required>
        </label>
      </section>
		<? } ?>
	</div>
	<div class="row">
		<section class="col col-8">
      <label class="label">Nombres y Apellidos</label>
      <label class="input">
        <input type="text" name="nombre" pattern="[_A-z 0-9]*" id="nombre" value="<?=$nombre?>" size="50" maxlenght="45" placeholder="Nombres Apellidos"required>
      </label>
    </section>
		<section class="col col-1">
      <label class="label">Fecha de Nacimiento</label>
			<label class="select">
				<select name="dia" id="select" class="form-control">
				<?php
				for($i = 0; $i <= 31; $i++) {
					if ($i == 0) {echo "<option value=''>"."Dia". "</option>";}
				else {
          if ($i == $dia)	{
            echo "<option value='$i' selected>$i</option>";
          }
				  else echo "<option value=$i>$i</option>";
				}
				}
				?>
				</select>
		</section>
		<section class="col col-1">
			<label class="label"><br></label>
			<label class="select">
				<select name="mes" id="select2" class="form-control">
				<?php
				$meses = array(0=>"",
				1=>"Enero",
				2=>"Febrero",
				3=>"Marzo",
				4=>"Abril",
				5=>"Mayo",
				6=>"Junio",
				7=>"Julio",
				8=>"Agosto",
				9=>"Septiembre",
				10=>"Octubre",
				11=>"Noviembre",
				12=>"Diciembre");
				for($i = 0; $i <= 12; $i++)
				{	if ($i == 0) {echo "<option value=" . "". ">"."Mes". "</option>";}
				else
				{	if ($i < 10) $datos = "0".$i;
				else $datos = $i;
				if ($datos == $mes)
				{	echo "<option value=$i selected>".$meses[$i]."</option>";	}
				else echo "<option value=$i>".$meses[$i]."</option>";
				}
				}
				?>
				</select>
			</label>
		</section>
		<section class="col col-1">
      <label class="label">
        <br>
      </label>
      <label class="input">
        <input name="ano" pattern="[0-9]*" placeholder="A&ntilde;o" type="text" id="ano" size="4" maxlength="4" value="<?=$ano?>">
      </label>
    </section>
	</div>
	<div class="row">
		<section class="col col-4">
      <label class="label">Ubicaci&oacute;n F&iacute;sica</label>
      <label class="input">
        <input type="text" name="ubicacion" id="ubicacion" value="<?=$ubicacion?>" size="20" placeholder="Ubicaci&oacute;n F&iacute;sica">
      </label>
    </section>
		<section class="col col-4">
      <label class="label">Piso</label>
      <label class="input">
        <input type="text" pattern="[0-9]*" name="piso" id="piso" value="<?=$piso?>" size="10" placeholder="Numero de Piso">
      </label>
    </section>
		<section class="col col-4">
      <label class="label">Extension</label>
      <label class="input">
        <input type="text" pattern="[0-9]*" name="extension" id="extension" value="<?=$extension?>" size="10">
      </label>
    </section>
	</div>
	<div class="row">
		<section class="col col-4">
      <label class="label">Correo Electr&oacute;nico (Principal)</label>
      <label class="input">
        <input type="email" name="email" id="email" value="<?=$email?>" size="40" placeholder="usuario@metrovivienda.gov.co">
      </label>
    </section>
		<section class="col col-4">
      <label class="label">Correo Electr&oacute;nico Secundario</label>
      <label class="input">
        <input type="email" name="email1" id="email1" value="<?=$email1?>" size="40" placeholder="usuario@metrovivienda.gov.co">
      </label>
    </section>
		<section class="col col-4">
      <label class="label">Correo Electr&oacute;nico opcional</label>
      <label class="input">
        <input type="email" name="email2" id="email2" value="<?=$email2?>" size="40" placeholder="usuario@metrovivienda.gov.co">
      </label>
    </section>
	</div>
	<td width="60%" height="26" class="listado2"></td>
    <input type="hidden" name=entrada id=entrada value='<?=$entrada?>'>
    <input type="hidden" name=modificaciones id=modificaciones value='<?=$modificaciones?>'>
    <input type="hidden" name=masiva id=masiva value='<?=$masiva?>'>
    <input type="hidden" name=impresion id=impresion value='<?=$impresion?>'>
    <input type="hidden" name=s_anulaciones id=s_anulaciones value='<?=$s_anulaciones?>'>
    <input type="hidden" name=anulaciones id=anulaciones value='<?=$anulaciones?>'>
    <input type="hidden" name=adm_archivo id=adm_archivo value='<?=$adm_archivo?>'>
    <input type="hidden" name=dev_correo id=dev_correo value='<?=$dev_correo?>'>
    <input type="hidden" name=adm_sistema id=adm_sistema value='<?=$adm_sistema?>'>
    <input type="hidden" name=env_correo id=env_correo value='<?=$env_correo?>'>
    <input type="hidden" name=reasigna id=reasigna value='<?=$reasigna?>'>
    <input type="hidden" name=estadisticas id=estadisticas value='<?=$estadisticas?>'>
    <input type="hidden" name=usua_activo id=usua_activo value='<?=$usua_activo?>'>
    <input type="hidden" name=usua_nuevoM id=usua_nuevoM value='<?=$usua_nuevoM?>'>
    <input type="hidden" name=nivel id=nivel value='<?=$nivel?>'>
    <input type="hidden" name=usuDocSel id=usuDocSel value='<?=$usuDocSel?>'>
    <input type="hidden" name=usuLoginSel id=usuLoginSel value='<?=$usuLoginSel?>'>
    <input type="hidden" name=perfilOrig id=perfilOrig value='<?=$perfilOrig?>'>
    <input type="hidden" name=nusua_codi id=nusua_codi value='<?=$nusua_codi?>'>
    <input type="hidden" name=usua_radmail id=usua_radmail value='<?=$usua_radmail?>'>
	</fieldset>
  <footer>
    <div class="form-group">
      <button type="submit" class="btn btn-primary" name="reg_crear" id="Continuar_button" value="Continuar">
        <i class="fa fa-save"></i>
      </button>
    </div>
  </footer>
  <div class="col-sm-12">
    <!-- widget grid -->
    <section id="widget-grid">
      <!-- row -->
      <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!-- Widget ID (each widget will need unique ID)-->
          <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">
            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">
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
