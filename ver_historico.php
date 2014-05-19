<?php
ini_set("display_errors",1);
 if(!$ruta_raiz) $ruta_raiz = ".";
 if(!$db) include "$ruta_raiz/conn.php";
	   require_once("$ruta_raiz/class_control/Transaccion.php");
		 require_once("$ruta_raiz/class_control/Dependencia.php");
		 require_once("$ruta_raiz/class_control/usuario.php");

	   error_reporting(7);
	   $trans = new Transaccion($db);
	   $objDep = new Dependencia($db);
	   $objUs = new Usuario($db);
	   $isql = "select USUA_NOMB from usuario where depe_codi=$radi_depe_actu and usua_codi=$radi_usua_actu";
	   $rs = $db->query($isql);
	   $usuario_actual = $rs->fields["USUA_NOMB"];
	   $isql = "select DEPE_NOMB from dependencia where depe_codi=$radi_depe_actu";
	   $rs = $db->query($isql);
	   $dependencia_actual = $rs->fields["DEPE_NOMB"];
	   $isql = "select USUA_NOMB from usuario where depe_codi=$radi_depe_radicacion and usua_codi=$radi_usua_radi";

	   $rs = $db->query($isql);
	   $usuario_rad = $rs->fields["USUA_NOMB"];
	   $isql = "select DEPE_NOMB from dependencia where depe_codi=$radi_depe_radicacion";
	   $rs = $db->query($isql);
	   $dependencia_rad = $rs->fields["DEPE_NOMB"];
?>
<table  width="80%"  align="center"  class="table table-bordered ">
  <tr   align="left" >
    <td width=10%><small>Usuario Actual</small></td>
    <td  width=15% align="left"><small><?=$usuario_actual?></small></td>
    <td width=10%><small>Dependencia Actual</small></td>
    <td  width=15%><small><?=$dependencia_actual?></small></td>
  </tr>
</table>
<table  width="100%" align="center" class="table table-striped table-hover"  >
  <thead>
    <tr align="center">
      <th width=10%>DEPENDENCIA</th>
      <th  width=35>FECHA</th>
      <th  width=15%>TRANSACCION</th>
      <th  width=15%>US. ORIGEN</th>
      <th  width=40%>COMENTARIO</th>
    </tr>
  </thead>
  <?
  $sqlFecha = $db->conn->SQLDate("d-m-Y H:i A","a.HIST_FECH");

	$isql = "select $sqlFecha AS HIST_FECH1
      , a.DEPE_CODI
			, a.USUA_CODI
			,a.RADI_NUME_RADI
			,a.HIST_OBSE
			,a.USUA_CODI_DEST
			,a.USUA_DOC
			,a.HIST_OBSE
			,a.SGD_TTR_CODIGO
			from hist_eventos a
		 where
			a.radi_nume_radi =$verrad
			order by hist_fech desc ";

	$i=1;
	//$db->conn->debug = true;
	$rs = $db->query($isql);
	IF($rs)
	{
    while(!$rs->EOF)
	 {
		$usua_doc_dest = "";
		$usua_doc_hist = "";
		$usua_nomb_historico = "";
		$usua_destino = "";
		$numdata =  trim($rs->fields["CARP_CODI"]);
		if($data =="") $rs1->fields["USUA_NOMB"];
	   		$data = "NULL";
		$numerot = $rs->fields["NUM"];
		$usua_doc_hist = $rs->fields["USUA_DOC"];
		$usua_codi_dest = $rs->fields["USUA_CODI_DEST"];
		$usua_dest=intval(substr($usua_codi_dest,3,3));
		$depe_dest=intval(substr($usua_codi_dest,0,3));
		$usua_codi = $rs->fields["USUA_CODI"];
		$depe_codi = $rs->fields["DEPE_CODI"];
		$codTransac = $rs->fields["SGD_TTR_CODIGO"];
		$descTransaccion = $rs->fields["SGD_TTR_DESCRIP"];
		if(!$codTransac) $codTransac = "0";
		$trans->Transaccion_codigo($codTransac);
		$objUs->usuarioDocto($usua_doc_hist);
		$objDep->Dependencia_codigo($depe_codi);

		error_reporting(7);
		if($carpeta==$numdata)
			{
			$imagen="usuarios.gif";
			}
		else
			{
			$imagen="usuarios.gif";
			}
		if($i!=10000)
			{
		?>
  <tr > <?
		    $i=1;
			}
			 ?>
    <td  ><small>
	<?=$objDep->getDepe_nomb()?></td>
    <td ></small>
	<?=$rs->fields["HIST_FECH1"]?>
 </td>
<td   ><small>
  <?=$trans->getDescripcion()?>
</small></td>
<td   ><small>
   <?=$objUs->get_usua_nomb()?></small>
</td>
		<?
		 /**
			 *  Campo qque se limino de forma Temporal USUARIO - DESTINO
			 * <td class="celdaGris"  >
			 * <?=$usua_destino?> </td>
			 */
		?>
			 <td ><small><?=$rs->fields["HIST_OBSE"]?></small></td>
  </tr>
  <?
	$rs->MoveNext();
  	}
}
  // Finaliza Historicos
	?>
</table>
  <?
  //empieza datos de envio
include "$ruta_raiz/include/query/queryver_historico.php";

$isql = "select $numero_salida from anexos a where a.anex_radi_nume=$verrad";
$rs = $db->query($isql);
$radicado_d= "";
while(!$rs->EOF)
	{
		$valor = $rs->fields["RADI_NUME_SALIDA"];
		if(trim($valor))
		   {
		      $radicado_d .= "'".trim($valor) ."', ";
		   }
		$rs->MoveNext();
	}

$radicado_d .= "$verrad";
error_reporting(7);
//$db->conn->debug=true;
include "$ruta_raiz/include/query/queryver_historico.php";
$sqlFechaEnvio = $db->conn->SQLDate("d-m-Y H:i A","a.SGD_RENV_FECH");
$isql = "select $sqlFechaEnvio AS SGD_RENV_FECH,
		a.DEPE_CODI,
		a.USUA_DOC,
		a.RADI_NUME_SAL,
		a.SGD_RENV_NOMBRE,
		a.SGD_RENV_DIR,
		a.SGD_RENV_MPIO,
		a.SGD_RENV_DEPTO,
		a.SGD_RENV_PLANILLA,
		b.DEPE_NOMB,
		c.SGD_FENV_DESCRIP,
		$numero_sal,
		a.SGD_RENV_OBSERVA,
		a.SGD_DEVE_CODIGO,
		u.USUA_LOGIN
		from sgd_renv_regenvio a, dependencia b, sgd_fenv_frmenvio c, usuario u
		where
		a.radi_nume_sal in($radicado_d)
		AND a.depe_codi=b.depe_codi
		AND a.sgd_fenv_codigo = c.sgd_fenv_codigo
		and a.usua_doc=cast (u.usua_doc as numeric)
		order by a.SGD_RENV_FECH desc ";
$rs = $db->query($isql);
?>
 <table width="100%" align="center"  >
  <tr>
    <td height="25" class="titulos4"><small>DATOS DE ENVIO</small></td>
  </tr>
</table>
<table width="80%"  align="center"  class="table table-bordered"  >
  <tr  align="center">
    <td width=10%  ><small>RADICADO </small></td>
    <td width=10%   ><small>DEPENDENCIA</small></td>
    <td  width=15%   ><small>FECHA </small></td>
    <td  width=15%   ><small>Destinatario</small></td>
    <td  width=15%    ><small>DIRECCION </small></td>
    <td  width=15%    ><small>DEPARTAMENTO </small></td>
    <td  width=15%    ><small>MUNICIPIO</small></td>
    <td  width=15%    ><small>TIPO DE ENVIO</small></td>
    <td  width=5%   ><small> No. PLANILLA</small></td>
    <td  width=15%   ><small>OBSERVACIONES</small></td>
 <td  width=15%   ><small>Realizo Envio</small></td>
  </tr>
  <?
$i=1;
while(!$rs->EOF)
	{
	$radDev = $rs->fields["SGD_DEVE_CODIGO"];
	$radEnviado = $rs->fields["RADI_NUME_SAL"];
	if($radDev)
	{
		$imgRadDev = "<img src='$ruta_raiz/imagenes/devueltos.gif' alt='Documento Devuelto por empresa de Mensajeria' title='Documento Devuelto por empresa de Mensajeria'>";
	}else
	{
		$imgRadDev = "";
	}
	$numdata =  trim($rs->fields["CARP_CODI"]);
	if($data =="")
		$data = "NULL";
	//$numerot = $rs->RecordCount();
	if($carpeta==$numdata)
		{
		$imagen="usuarios.gif";
		}
	else
		{
		$imagen="usuarios.gif";
		}
	if($i==1)
		{
   ?>
  <tr > <?  $i=1;
			}
			 ?>
    <td  >
	<small><?=$imgRadDev?><?=$radEnviado?></small></td>
    <td  >
	<small><?=$rs->fields["DEPE_NOMB"]?></small></td>
    <td ><small>
	<?
		echo "<a class=vinculos href='./verradicado.php?verrad=$radEnviado&krd=$krd' target='verrad$radEnviado'><span class='timpar'>".$rs->fields["SGD_RENV_FECH"]."</span></a>";
	?></small> </td>
    <td ><small>
	<?=$rs->fields["SGD_RENV_NOMBRE"]
	?> </small></td>
    <td   >
	<small><?=$rs->fields["SGD_RENV_DIR"]?> </small></td>
    <td   >
	 <small><?=$rs->fields["SGD_RENV_DEPTO"] ?> </small></td>
    <td   >
	 <small><?=$rs->fields["SGD_RENV_MPIO"] ?> </small></td>
    <td   >
	 <small><?=$rs->fields["SGD_FENV_DESCRIP"] ?> </small></td>
    <td   >
	 <small><?=$rs->fields["SGD_RENV_PLANILLA"] ?> </small></td>
    <td   >
	 <small><?=$rs->fields["SGD_RENV_OBSERVA"] ?> </small></td>
   <td   >
         <small><?=$rs->fields["USUA_LOGIN"] ?> </small></td>

  </tr>
  <?
	$rs->MoveNext();
  }

  // Finaliza Historicos
	?>
</table>
</body>
</html>
