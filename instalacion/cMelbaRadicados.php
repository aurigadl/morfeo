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
if($db->Connect($myServer, $myUser, $myPass, 'p_correspondencia')==false){echo "<br>No se conecto a Melba";} else echo("<br>Si se conecto a Melba<br>");
$usuario = "postgres";
$contrasena= "G3Ssoporte2o12pg";
$servidor = "172.16.1.241:5432";
$base= "orfeo382_produccion"; //This would by the Database Name
include('../include/class/adodb/adodb.inc.php'); 
$dbOrfeo = & ADONewConnection("postgres");
$db->SetFetchMode(ADODB_FETCH_ASSOC);
//$dbOrfeo->debug = true;
if($dbOrfeo->Connect($servidor, $usuario, $contrasena, $base)==false){echo "<br>No se conecto a Orfeo";} else echo("<br>Si se conecto a Orfeo");
$varFinalizo = "INICIA EL CARGUE";
?>
<table class=borde_tab>
<tr class=tilutos5>
<td class=listado2> <?=$varFinalizo?></td>
</tr>
<?


$db->debug = true;
$iSqlRadicados = "select 
radicado, ano,fecha,tipo_radicado,
anexos,folios,tipo_documento,asunto,
tipo_anexos,tipo_poblacion,
tipo_llegada,dirigido,
remitente_persona,remitente_funcionario,
depe_origen_salida,firma_salida,
cedula_persona,apellidos_remitente,
nombres_remitente,ciudad_remitente,
direccion_remitente,institucion_remitente,
cargo_remitente,nombre_institucion,
direccion_institucion,telefono_institucion,
ciudad_institucion,depe_func_remitente,
usua_radicador,depe_radicador,
depe_destino,
depe_origen,recibido,
descargado,trasladado,
asignado,func_actu
from
radicadotemp
order by radicado
";
      $rs = $db->Execute($iSqlRadicados);

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
     $insertSQL = $dbOrfeo->Replace('radicadotemp',$record,array('radicado','ano','fecha'), $autoquote = true);
 if(($i==$k)) echo "$i > ". date("H:i:s")."<br>";
 $k=$k+10000 ;
 $i++;
 $rs->MoveNext();
}
$varFinalizo = "FINALIZO EL CARGUE";
?>
<td class=listado2> <?=$varFinalizo?></td>
</table>
</body>
</html>
