<?php
session_start();
	$ruta_raiz = "../..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

$sendSession     = session_name().'='.session_id(); 
?>
<html>
<head>
<head>
<title>Administracion...</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body>
<form name='frmMnuUsuarios' action='../formAdministracion.php' method="post" class="smart-form">
  <table width="32%" class="table table-bordered">
  <tr>
    <td colspan="2" "><div align="center"><strong>ADMINISTRACION DE USUARIOS Y PERFILES</strong></div></td>
  </tr>
  <tr>
    <td align="center"  ><a href='crear.php?<?=$sendSession?>&usModo=1' class="vinculos" target='mainFrame'>1. Crear Usuario</a></td>
  </tr>
  <tr>
    <td align="center"  ><a href='cuerpoEdicion.php?<?=$sendSession?>&usModo=2' class="vinculos" target='mainFrame'>2. Editar Usuario</a></td>
  </tr>
  <tr>
    <td align="center"  ><a href='cuerpoConsulta.php?<?=$sendSession?>' class="vinculos" target='mainFrame'>3. Consultar Usuario</a></td>
  </tr>
  <tr>
  	<td align="center" >
	<center><button class="btn btn-primary" type="submit" name="Submit" value="Cerrar">
	
	</button>
	</center>
	</td> </tr>
</table>
</form>
</body>
</html>
