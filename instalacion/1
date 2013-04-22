<html>
<head>
    <link rel="stylesheet" href="../estilos/orfeo38/orfeo.css">
</head>
<body>
<?
ini_set("display_errors",1);
define('ADODB_ASSOC_CASE', 1);
$ruta_raiz= "..";
$myServer = "172.16.1.123"; //This would be the ip address of your server running mssql
$myServer = "minps19\sql2005";
$myUser = "lgomezv"; //This would be the username that you have assigned on your server with access rights to the database
$myPass = "lgomezv"; //This would be the password for the user you have assigned on your server with access rights to the database
$myDB= "P_correspondencia"; //This would by the Database Name
include('../include/class/adodb/adodb.inc.php'); 
$db = & ADONewConnection("mssql");
$db->SetFetchMode(ADODB_FETCH_ASSOC);
//$db->charSet="UTF-8";<
if($db->Connect($myServer, $myUser, $myPass, 'p_correspondencia')==false){echo "<br>No se conecto a Melba";} else echo("<br>Si se conecto a Melba<br>");
$usuario = "postgres";
$contrasena= "G3Ssoporte2o12pg";
$servidor = "172.16.1.241:5432";
$base= "orfeo382_produccion"; //This would by the Database Name
include('../include/class/adodb/adodb.inc.php'); 
$dbOrfeo = & ADONewConnection("postgres");
$db->SetFetchMode(ADODB_FETCH_ASSOC);
if($dbOrfeo->Connect($servidor, $usuario, $contrasena, $base)==false){echo "<br>No se conecto a Orfeo";} else echo("<br>Si se conecto a Orfeo");
$varFinalizo = "INICIA EL CARGUE";
?>
<table class=borde_tab>
<tr class=tilutos5>
<td class=listado2> <?=$varFinalizo?></td>
</tr>
<?
$iSqlHistorico = "select 
  radicado,
  ano,
  operacion,
  estado,
  fecha,
  tipo_llegada,
  dirigido,
  institucion,
  direccion,
  telefono,
  ciudad,
  apellidos,
  nombres,
  cargo,
  cedula,
  dependencia_origen,
  dependencia_destino,
  fun_descar,
  fecha_limite,
  respuesta,
  referido_radicado,
  referido_ano,
  referido_radicado2,
  referido_ano2,
  referido_radicado3,
  referido_ano3,
  referido_radicado4,
  referido_ano4,
  referido_radicado5,
  referido_ano5,
  funcionario,
  firma,
  dependencia,
  tarifa,
  login,
  tipo_poblacion,
  comentario,
  usuario 
from
hist_eventostemp 
order by radicado
";
$rs = $db->Execute($iSqlHistorico);

/*$iSqlDependencias = "select 
        codigo,
	nombre,
	funcion,
	activo,
	central,
        ciudad,
        departamento
from
dependencia_temp
";
$rs = $db->Execute($iSqlDependencias);*/
/*$iSqlUsuarios = "select 
        login,
        apellidos,
	nombres,
	cargo,
	activo,
	dependencia,
        firma
from
usuario_temp
";
$rs = $db->Execute($iSqlUsuarios);*/


?>
<table class=borde_tab>
<tr class=tilutos5>
<td class=listado2> <?=$varFinalizo?></td>
</tr>
<?
$i=0;
$k=0;
while(!$rs->EOF){
  foreach($rs->fields as $campo=>$valorCampo) {
   $campo=strtoupper($campo);
   $valorCampo=utf8_encode($valorCampo);
      if(($valorCampo)){ $record[$campo] =$valorCampo; }
    else {$record[$campo] = 0; }
   
  }
     $insertSQL = $dbOrfeo->Replace('hist_eventostemp',$record,array('radicado','ano','operacion','estado','fecha','tipo_llegada','dirigido','institucion','direccion','telefono','ciudad','apellidos','nombres','cargo','cedula','dependencia_origen','comentario','usuario'), $autoquote = true);
       //$insertSQL = $dbOrfeo->Replace('dependencia_temp',$record,array('codigo','nombre','funcion','activo','central'), $autoquote = true);
      // $insertSQL = $dbOrfeo->Replace('usuario_temp',$record,array('login','apellidos','nombres','cargo','activo','dependencia'), $autoquote = true);        
  if(($i==$k)) echo "$i > ". date("H:i:s")."<br>";
 $k=$k+40000 ;
 $i++;
 $rs->MoveNext();
}
$varFinalizo = "FINALIZO EL CARGUE";
?>
<td class=listado2> <?=$varFinalizo?></td>
</table>
</body>
</html>
