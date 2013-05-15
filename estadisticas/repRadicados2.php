<?php

session_start();



foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$ruta_raiz = ".."; 
?>

<html>
<head>
    <link rel="stylesheet" href="<?=$ruta_raiz."/estilos/orfeo38/orfeo.css"?>" >
    <script src="js/popcalendar.js"></script>
    <script src="js/mensajeria.js"></script>
    <div id="spiffycalendar" class="text"></div>
    <?php include_once "$ruta_raiz/js/funtionImage.php"; ?> 
</head>

<?php include "$ruta_raiz/envios/paEncabeza.php"; ?>

<body bgcolor="#FFFFFF" topmargin="0" onLoad="window_onload();">

<?php

include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");
require_once    ("$ruta_raiz/class_control/Mensaje.php");

if (!$db) $db = new ConnectionHandler($ruta_raiz);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

//$db->conn->debug = true;

$isql1 = "select r.depe_codi, max(d.depe_nomb), count(*)  NUMERO_RADS from radicado r, dependencia d
 where r.sgd_trad_codigo=3
	and TO_CHAR(r.RADI_FECH_RADI, 'YYYY-MM-DD') >= '2013-04-01'
	and TO_CHAR(r.RADI_FECH_RADI, 'YYYY-MM-DD') <= '2013-05-01'
	and r.depe_codi=d.depe_codi
	and r.depe_Codi not in (905,900)
	and r.depe_codi is not null
 group by r.depe_codi
 order by count(*) desc";


$fecha_ini = date("Y") . "-" . str_pad((date("m")-1),2,"0",STR_PAD_LEFT)  . "-01";
$fecha_fin = date("Y-m-d");

echo "Datos entre $fecha_ini y  $fecha_fin";

$isql2 = "SELECT sgd_trad_codigo, TO_CHAR(RADI_FECH_RADI, 'YYYY-MM-DD') FECHA, COUNT(*) NUMERO_RADS, sum(radi_nume_hoja)
FROM  RADICADO
WHERE TO_CHAR(RADI_FECH_RADI, 'YYYY-MM-DD') >= '$fecha_ini'
and TO_CHAR(RADI_FECH_RADI, 'YYYY-MM-DD') <= '$fecha_fin 24:00:00'
and sgd_trad_codigo>=1
and depe_Codi not in ('905','900')
and depe_codi is not null
group by TO_CHAR(RADI_FECH_RADI, 'YYYY-MM-DD') , sgd_trad_codigo
order by TO_CHAR(RADI_FECH_RADI, 'YYYY-MM-DD') , sgd_trad_codigo desc";

  $rs   = $db->conn->Execute($isql2);
  if ($rs->EOF)  {
      echo "<hr><center><b><span class='alarmas'>No se encuentra ningun radicado con el criterio de busqueda</span></center></b></hr>";
  }

?>
<table class="borde_tab2" >

<?php
$fechaAnterior = "";
$class1 = "listado1";
$class2 = "listado2";
 $fechaAnterior = $rs->fields["FECHA"];
while (!$rs->EOF){
 $fecha = $rs->fields["FECHA"];
 $tRadCodigo = $rs->fields["SGD_TRAD_CODIGO"];
 $v =$rs->fields["NUMERO_RADS"];

 $datos =  getdate(strtotime($fecha)) ;
 // var_dump($datos);
 $dia = $datos["wday"];

 $fechaR[$tRadCodigo][$dia] = $rs->fields["FECHA"];
 $valor[$tRadCodigo][$dia] =$rs->fields["NUMERO_RADS"];
	//sumamos para saber cual es el
		//total o 100%
		if($tRadCodigo==1) $bgColor = "#000066";
		if($tRadCodigo==2) $bgColor = "#CC9900";
		if($tRadCodigo==3) $bgColor = "#006600";
		?>

		<? if($fecha!=$fechaAnterior  ) {
				if($class=="listado2")	$class=$class1; else $class=$class2;
		}

		if($fecha!=$fechaAnterior && ($dia<=$diaAnterior)) {
		if($tRadCodigo==1) $bgColor = "#000066";
		if($tRadCodigo==2) $bgColor = "#CC9900";
		if($tRadCodigo==3) $bgColor = "#006600";
    for($iK=1; $iK<=7; $iK++){
    $b1 = $valor[1][$iK]/30;
    $b2 = $valor[2][$iK]/30;
    $b3 = $valor[3][$iK]/30;
    
    $Tvar[$iK]= "<table border=0 class=borde_tab2>
			<tr class=borde_tab2 VALIGN='TOP'>
			<td colspan=3 VALIGN='TOP'  class=listado2_0><center>".$fechaR[1][$iK] ."</center></td>
			</tr>
			<tr valign='bottom' > 
				<td  valign='bottom' height=60><table width=20  height='$b1' ><tr ><td bgColor = '#000066' width=20></td> </tr></table></td>
				<td valign='bottom'  height=60><table width=20  height='$b2'  ><tr ><td bgColor = '#CC9900' width=20></td> </tr></table></td>
				<td valign='bottom'  height=60><table width=20  height='$b3'  ><tr ><td bgColor = '#006600' width=20></td> </tr></table></td>
				</tr>
			<tr class=listado1_0> 
				<td VALIGN='bottom' class='listado2_0' height=0> ". $valor[1][$iK]."</td> 
				<td VALIGN='bottom' class='listado1_0' height=0> ". $valor[2][$iK]."</td> 
				<td VALIGN='bottom' class='listado2_0' height=0> ". $valor[3][$iK]."</td>  
				</tr>
			</table>
";
		}
		?>
		<table class="borde_tab">
			<tr class=borde_tab2>
			 <td class=listado2_0>Lun</td>	<td class=listado2_0>Mar</td>	<td class=listado2_0>Mie</td>	<td class=listado2_0>Juev</td>	<td class=listado2_0>Vie</td><td class=listado2_0>Sab</td><td class=listado2_0>Dom</td>		
			</tr>
      <tr class=borde_tab2>
			 <td VALIGN='TOP'><?=$Tvar[1]?></td>	
			 <td VALIGN='TOP'><?=$Tvar[2]?></td>
			 <td VALIGN='TOP'><?=$Tvar[3]?></td>
			 <td VALIGN='TOP'><?=$Tvar[4]?></td>
     	 <td VALIGN='TOP'><?=$Tvar[5]?></td>
			 <td VALIGN='TOP'><?=$Tvar[6]?></td>
			 <td VALIGN='TOP'><?=$Tvar[7]?></td>		
			 <td><table height=5 ><tr class=listado1_0 height=5><td bgColor = '#000066' width=5 height=0></td><td>Entrada</td> <td bgColor = '#CC9900' width=5></td><td>Salida</td>  <td bgColor = '#006600' width=5></td><td>Internos</td> </tr></table>
			</tr>
		</table>
		<?
   for($iK=1; $iK<=7; $iK++){
    $valor[1][$iK]=0;
    $valor[2][$iK]=0;
    $valor[3][$iK]=0;
    $fechaR[1][$iK]=0;
		$fechaR[2][$iK]=0;
		$fechaR[3][$iK]=0;
	 }

	}
	$fechaAnterior = $fecha;
  $diaAnterior = $dia;
  $rs->MoveNext();
}

    for($iK=1; $iK<=7; $iK++){
    $b1 = $valor[1][$iK]/30;
    $b2 = $valor[2][$iK]/30;
    $b3 = $valor[3][$iK]/30;
    
    $Tvar[$iK]= "<table border =0 class='borde_tab2'>
			<tr class='borde_tab2' VALIGN='TOP'>
			<td colspan=3 VALIGN='TOP' class=listado2_0 ><center>".$fechaR[1][$iK] ."</center></td>
			</tr>
			<tr valign='bottom'  > 
				<td  valign='bottom' height=60><table width=20  height='$b1' ><tr ><td bgColor = '#000066' width=20></td> </tr></table></td>
				<td valign='bottom'  height=60><table width=20  height='$b2'  ><tr ><td bgColor = '#CC9900' width=20></td> </tr></table></td>
				<td valign='bottom'  height=60><table width=20  height='$b3'  ><tr ><td bgColor = '#006600' width=20></td> </tr></table></td>
				</tr>
			<tr class='borde_tab2'> 
				<td VALIGN='bottom' class=listado2_0> ". $valor[1][$iK]."</td> 
				<td VALIGN='bottom' class=listado1_0> ". $valor[2][$iK]."</td> 
				<td VALIGN='bottom' class=listado2_0> ". $valor[3][$iK]."</td>  
				</tr>
			</table>
";


		}
		?>
		<table class="borde_tab">
			<tr class=listado2_0>
			 <td>Lun</td>	<td>Mar</td>	<td>Mie</td>	<td>Juev</td>	<td>Vie</td><td>Sab</td><td>Dom</td>		
			</tr>
      <tr class=listado1 >
			 <td VALIGN='TOP'><?=$Tvar[1]?></td>	
			 <td VALIGN='TOP'><?=$Tvar[2]?></td>
			 <td VALIGN='TOP'><?=$Tvar[3]?></td>
			 <td VALIGN='TOP'><?=$Tvar[4]?></td>
     	 <td VALIGN='TOP'><?=$Tvar[5]?></td>
			 <td VALIGN='TOP'><?=$Tvar[6]?></td>
			 <td VALIGN='TOP'><?=$Tvar[7]?></td>		
			 <td><table height=5><tr class=listado1_0 height=5><td bgColor = '#000066' width=5></td><td>Entrada</td> <td bgColor = '#CC9900' width=5></td><td>Salida</td>  <td bgColor = '#006600' width=5></td><td>Internos</td> </tr></table>
			</tr>
		</table>
		<?




?>
</table>

