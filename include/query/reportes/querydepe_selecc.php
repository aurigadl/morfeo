<?
$ln=$_SESSION["digitosDependencia"];
switch($db->driver)
{
case 'mssql':
  $radi_nume_sal = "convert(varchar(14), RADI_NUME_SAL)";
  $where_depe = " and ".$db->conn->substr."(".$radi_nume_sal.", 5, 3) in ($lista_depcod)";
  break;
case 'oracle':
case 'oci8':
case 'oci805':
  $where_depe = "and ".$db->conn->substr."(cast(a.radi_nume_sal as varchar(20)), 5, 3) in ($lista_depcod)";
  break;
default:
  $where_depe = "and cast(".$db->conn->substr."(cast(a.radi_nume_sal as varchar(20)), 5, $ln) as integer) in ($lista_depcod)";
  if ($_SESSION["entidad"] = 'correlibre' )
  {
    $lista_depcod  = str_replace("1400","1310,1400",$lista_depcod);
    $lista_depcod  = str_replace("1500","1320,1500",$lista_depcod);
    $lista_depcod  = str_replace("1600","1330,1600",$lista_depcod);
    $lista_depcod  = str_replace("1700","1340,1700",$lista_depcod);
  }
  $where_depe = "and cast(".$db->conn->substr."(cast(a.radi_nume_sal as varchar(20)), 5, $ln) as integer) in ($lista_depcod)";

}
?>
