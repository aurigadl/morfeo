<?php
session_start();

$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc = $_SESSION["usua_doc"];
$codusuario = $_SESSION["codusuario"];
$ruta_raiz = "..";
$nurad = $_GET["nurad"];
if($_GET["codserie"]) $codserie = $_GET["codserie"];
if($_GET["coddepe"]) $coddepe = $_GET["coddepe"];

if($_GET["tsub"]) $tsub = $_GET["tsub"];
if($_GET["tdoc"]) $tdoc = $_GET["tdoc"];
if($_GET["insertar_registro"]) $insertar_registro = $_GET["insertar_registro"];
if($_GET["actualizar"]) $actualizar = $_GET["actualizar"];

if($_GET["borrar"]) $borrar = $_GET["borrar"];
if($_GET["linkarchivo"]) $linkarchivo = $_GET["linkarchivo"];
if($_GET["codiTRDEli"]) $codiTRDEli = $_GET["codiTRDEli"];

if (!$ruta_raiz) $ruta_raiz= "..";
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
$db = new ConnectionHandler("$ruta_raiz");
if (!defined('ADODB_FETCH_ASSOC')) define('ADODB_FETCH_ASSOC',2);
$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
include_once ("../include/query/busqueda/busquedaPiloto1.php");
include_once "$ruta_raiz/include/tx/Historico.php";
include_once ("$ruta_raiz/class_control/TipoDocumental.php");
$trd = new TipoDocumental($db);
if ($borrar)
{
  $sqlE = "SELECT $radi_nume_radi as RADI_NUME_RADI
    FROM SGD_RDF_RETDOCF r
    WHERE RADI_NUME_RADI = '$nurad'
    AND  SGD_MRD_CODIGO =  '$codiTRDEli'";
  $rsE=$db->conn->query($sqlE);
  $i=0;
  while(!$rsE->EOF)
  {
    $codiRegE[$i] = $rsE->fields['RADI_NUME_RADI'];
    $i++;
    $rsE->MoveNext();
  }
  $TRD = $codiTRDEli;
  include "$ruta_raiz/radicacion/detalle_clasificacionTRD.php";

  $nrobs = $codiRegE[0];

  //TRAIGO EL RADICADO PADRE
  $_isql ="select radi_nume_deri from radicado where radi_nume_radi = $nrobs";
  $_rsisql =$db->conn->query($_isql);
  $Rad_padre = intval($_rsisql->fields['RADI_NUME_DERI']);

  if($Rad_padre > 0){
    $_Tx_id = 98;
    $observa = "*Eliminado TRD Anexo *".$deta_serie."/".$deta_subserie."/".$deta_tipodocu ." - ".$nrobs;
    $codiRegE[0]=$Rad_padre;
  }else{
    $_Tx_id = 33;
    $observa = "*Eliminado TRD*".$deta_serie."/".$deta_subserie."/".$deta_tipodocu;
  }

  $Historico = new Historico($db);

  $radiModi = $Historico->insertarHistorico($codiRegE, $dependencia, $codusuario, $dependencia, $codusuario, $observa, $_Tx_id);
  $radicados = $trd->eliminarTRD($nurad,$coddepe,$usua_doc,$codusua,$codiTRDEli);
  $mensaje="TRD eliminada<br> ";
}
/*
 * Proceso de modificacion de una clasificacion TRD
 */
if ($actualizar)
{
  if ($tdoc !=0 && $tsub !=0 && $codserie !=0 )
  { 
    $sqlH = "SELECT $radi_nume_radi as RADI_NUME_RADI,
      SGD_MRD_CODIGO
      FROM SGD_RDF_RETDOCF r
      WHERE RADI_NUME_RADI = '$nurad'
      AND  DEPE_CODI       =  '$coddepe'";
    $rsH=$db->conn->query($sqlH);
    $codiActu = $rsH->fields['SGD_MRD_CODIGO'];
    $i=0;
    while(!$rsH->EOF)
    {
      $codiRegH[$i] = $rsH->fields['RADI_NUME_RADI'];
      $i++;
      $rsH->MoveNext();
    }
    $TRD = $codiActu;
    $mensaje="El Registro NO Puede Modificarse por Pertenecer a otra dependencia   <br> ";
    if ($TRD != '')
    {
      include "$ruta_raiz/radicacion/detalle_clasificacionTRD.php";

      $observa = "*Modificado TRD* ".$deta_serie."/".$deta_subserie."/".$deta_tipodocu;
      $Historico = new Historico($db);
      //$radiModi = $Historico->insertarHistorico($codiRegH, $coddepe, $codusua, $coddepe, $codusua, $observa, 32);
      $radiModi = $Historico->insertarHistorico($codiRegH, $dependencia, $codusuario, $dependencia, $codusuario, $observa, 32);
      /*
       *Actualiza el campo tdoc_codi de la tabla Radicados
       */
      $radiUp = $trd->actualizarTRD($codiRegH,$tdoc);
      $mensaje="Registro Modificado";
      $isqlTRD = "select SGD_MRD_CODIGO
        from SGD_MRD_MATRIRD
        where DEPE_CODI = '$coddepe'
        and SGD_SRD_CODIGO = '$codserie'
        and SGD_SBRD_CODIGO = '$tsub'
        and SGD_TPR_CODIGO = '$tdoc'";

      $rsTRD = $db->conn->Execute($isqlTRD);
      $codiTRDU = $rsTRD->fields['SGD_MRD_CODIGO'];
      $sqlUA = "UPDATE SGD_RDF_RETDOCF SET SGD_MRD_CODIGO = '$codiTRDU',
        USUA_CODI = '$codusuario'
        WHERE RADI_NUME_RADI = '$nurad' AND  DEPE_CODI =  '$coddepe'";
      $rsUp = $db->conn->query($sqlUA);
      $mensaje="Registro Modificado   <br> ";
    }

  }

}
$tdoc = '';
$tsub = '';
$codserie = '';

?>

</script>
<body bgcolor="#FFFFFF" topmargin="0">
<br>
<div align="center">
<p>
<?=$mensaje?>
</p>
<input type='button' value='   Cerrar   ' class='botones_largo' onclick='opener.regresar();window.close();'>
</body>
</html>
