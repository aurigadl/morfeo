<input type="hidden" name="menu_ver_tmp" value=4>
<input type="hidden" name="menu_ver" value=4>
<table width="92%" class="table-bordered  table-condensed  " align="left">
<?
	if($verrad) $expediente->expedienteArchivado( $verrad, $numExpediente );
	$isqlDepR = "SELECT USUA_DOC_RESPONSABLE, SGD_EXP_PRIVADO,SGD_SEXP_PAREXP1,SGD_SEXP_PAREXP2
			FROM SGD_SEXP_SECEXPEDIENTES
			WHERE SGD_EXP_NUMERO = '$numExpediente' ORDER BY SGD_SEXP_FECH DESC ";
	$rsDepR = $db->conn->Execute($isqlDepR);
	$nivelExp= $rsDepR->fields['SGD_EXP_PRIVADO'];
	$docRes= $rsDepR->fields['USUA_DOC_RESPONSABLE'];
        $param1 = substr($rsDepR->fields['SGD_SEXP_PAREXP1'],0,30);
        $param1 = $param1.' '.substr($rsDepR->fields['SGD_SEXP_PAREXP2'],0,50);
	$isqlDepR = "SELECT USUA_NOMB from USUARIO WHERE USUA_DOC = '$docRes'";
	$rsDepR = $db->conn->Execute($isqlDepR);
	$responsable= $rsDepR->fields['USUA_NOMB'];
	$isql = "SELECT USUA_PERM_EXPEDIENTE from USUARIO WHERE USUA_LOGIN = '$krd'";
	$rs = $db->conn->Execute($isql);
	$krdperm= $rs->fields['USUA_PERM_EXPEDIENTE'];
	$sqlb="select sgd_exp_archivo from sgd_exp_expediente
                where sgd_exp_numero like '$num_expediente'";

	$rsb=$db->conn->Execute($sqlb);
	$arch=$rsb->fields['SGD_EXP_ARCHIVO'];
	$mostrar=true;
?>
<tr >
  <td >
   <?php
	if ( $usuaPermExpediente ) {
   ?><table width="100%">
     <tr><td width=140>
       <span class="dropdown">
    		<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">Expediente <b class="caret"></b> </a>
				<ul class="dropdown-menu">
				<?
				if($usuaPermExpediente) {
					?>
					<li>
						<a href="#" onClick="insertarExpediente();">Incluir en...</a>
					</li>
					<li>
						<a href="#" onClick="excluirExpediente();">Excluir de...</a>
					</li>
					<li>
						<a href="#" onClick="verTipoExpediente('<?=$num_expediente?>',<?=$codserie?>,<?=$tsub?>,<?=$tdoc?>,'MODIFICAR');">Crear Nuevo Expediente</a>
					</li>
					<li>
						<a href="#" onClick="Responsable('<?=$num_expediente?>');">Cambiar Responsable</a>
					</li>
					<li>
						<a href="#" onClick="CambiarE(2,'<?=$num_expediente?>');">Cerrar Expediente</a>
					</li>
					<li>
						<a href="#" onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
					</li>

					<?
					}
				?>
			</ul>
			</span>
    </td>
    <td>
    <?=$num_expediente?>
    <input name="num_expediente" type="hidden" size="30" maxlength="18" id='num_expediente' value="<?=$num_expediente?>" class="tex_area" >
     Cod :  <span class=leidos2> <? echo $param1;?>
     Responsable: <span class=leidos2> <? echo $responsable;?>
     </td>
	<?
	}

  ?>
    <input type="hidden" name='funExpediente' id='funExpediente' value="" >
    <input type="hidden" name='menu_ver_tmp' id='menu_ver_tmp' value="4" >
<?
	// CONSULTA SI EL EXPEDIENTE TIENE UNA CLASIFICACION TRD

	error_reporting(7);
	$codserie = "";
	$tsub = "";
	include_once ("$ruta_raiz/include/tx/Expediente.php");
	$trdExp 	= new Expediente($db);
	$mrdCodigo 	= $trdExp->consultaTipoExpediente("$numExpediente");
	$trdExpediente 	= $trdExp->descSerie." / ".$trdExp->descSubSerie;
	$descPExpediente = $trdExp->descTipoExp;
	$procAutomatico = $trdExpediente->pAutomatico;
	$codserie = $trdExp->codiSRD;
	$tsub = $trdExp->codiSBRD;
	$tdoc = $trdExp->codigoTipoDoc;
	$texp = $trdExp->codigoTipoExp;
	$descFldExp 	= $trdExp->descFldExp;
	$codigoFldExp 	= $trdExp->codigoFldExp;
	if(!$codserie) $codserie=0;
	if(!$tsub) $tsub=0;
	if(!$tdoc) $tdoc=0;

	error_reporting(7);
	$resultadoExp = 0;
	if($funExpediente == "INSERT_EXP") {
		$resultadoExp = $expediente->insertar_expediente($num_expediente,
								$verrad,
								$dependencia,
								$codusuario,
								$usua_doc);
		if($resultadoExp==1) {
			echo '<hr>Se anex&oacute; este radicado al expediente correctamente.<hr>';
		}else {
			echo '<hr><font color=red>No se anex&oacute; este radicado al expediente. V
				Verifique que el numero del expediente exista e intente de nuevo.</font><hr>';
		}
	}

	if($funExpediente == "CREAR_EXP") {
		$resultadoExp = $expediente->crearExpediente($num_expediente,
								$verrad,
								$dependencia,
								$codusuario,
								$usua_doc);
		if($resultadoExp==1) {
			echo '<hr>El expediente se creo correctamente<hr>';
		}else{
		  echo '<hr><font color=red>El expediente ya se encuentra creado.
			  <br>A continuaci&oacute;n aparece la lista de documentos pertenecientes al expediente que intento crear
			  <br>Si esta seguro de incluirlo en este expediente haga click sobre el boton  "Grabar en Expediente"
			  </font><hr>';
		}
	}
	// echo "<hr>jjjjj  $usuaPermExpediente $num_expediente aa $carpeta";
	// if ($carpeta==8) {
	if ($carpeta==99998) {
		//<input type="button"0. name="UPDATE_EXP" value="ACTUALIZAR EXPEDIENTE" class="botones_mediano" onClick="Start('buscar_usuario.php?busq_salida=',1024,400);">
	}
	if($ASOC_EXP and !$funExpediente) {
    		for($ii=1;$ii<$i;$ii++) {
			$expediente->num_expediente =  "";
			$exp_num = $expediente->consulta_exp("$radicados_anexos[$ii]");
			$exp_num = $expediente->num_expediente;

			 //echo "===>$exp_num==>".$radicados_anexos[$ii]."<br>";
			if($exp_num=="") {
				$expediente->insertar_expediente($num_expediente,
								$radicados_anexos[$ii],
								$dependencia,
								$codusuario,
								$usua_doc);
			}
		}
	}
	echo "<br>$mensaje";
	?>
<?
if(!$codigoFldExp) $codigoFldExp= "0";
$num_expediente = $numExpediente;
if($numExpediente !=""){
if ( $expIncluido != "" ) {
	$arrTRDExp = $expediente->getTRDExp( $expIncluido, "", "", "" );
} else if( $num_expediente != "" ){
	$arrTRDExp = $expediente->getTRDExp( $num_expediente, "", "", "" );
}
?>
<Tr><td>Clasificacion D.</td><td><?php print $arrTRDExp['serie']." / ".$arrTRDExp['subserie']; ?>
 <?php
	if ( $expIncluido != "" ) {
		$arrDatosParametro = $expediente->getDatosParamExp( $expIncluido, $dependencia );
	}
	else if( $numExpediente != "" ) {
		$arrDatosParametro = $expediente->getDatosParamExp( $numExpediente, $dependencia );
	}
	if( $arrDatosParametro != "" ) {
		foreach( $arrDatosParametro as $clave => $datos ) {
           echo ">  ".$datos['etiqueta'].":".print $datos['parametro'];
        }
      }
    ?>

  </td></tr>
	<tr>
	<td><span class="dropdown">		<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"> Proceso <b class="caret"> </b> </a>

	<ul class="dropdown-menu">
	<?
		if($usuaPermExpediente) {
			?>
			<li>
				<a href="#" onClick="verHistExpediente('<?=$numExpediente?>');">Historial del Proceso/Exp</a>
			</li>
			<li>
				<a href="#" onClick="verWorkFlow('<?=$numExpediente?>','<?=$texp?>');">Ver WorkFlow</a>
			</li>
			<li>
				<a href="#" onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
			</li>
				<?
			}
			?>
		</ul>
		</span>
		</td><td>
					<?php
			if( $arrTRDExp['proceso'] != "" ) {
			  echo $arrTRDExp['proceso']." / ".$arrTRDExp['terminoProceso'];
			}
			?>
</td></tr>

<?
if($descPExpediente){
	$expediente->consultaTipoExpediente($num_expediente);
	include_once ("$ruta_raiz/include/tx/Flujo.php");
	$objFlujo = new Flujo($db, $texp, $usua_doc);
	$kk = $objFlujo->getArista($texp, $codigoFldExp);
	$aristasSig = $objFlujo->aristasSig;
 $frm = array();
 $iA = 0;
 $ventana = "Default";
 if($aristasSig){
 foreach($aristasSig as $key => $arista){
  if(trim($arista["FRM_NOMBRE"])){
    $ventana = "Max";
    If(!$numeroExpediente) $numeroExpediente = $numExpedente;
    $frm[$iA]["FRM_NOMBRE"] = $arista["FRM_NOMBRE"];
    $frm[$iA]["FRM_LINK"] = $arista["FRM_LINK"];
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroRadicado}","$verrad", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINK"]);

		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroRadicado}","$numRad", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINKSELECT"]);
		$iA++;
	}
	} // Fin si hay Aristas....
 }
}
?>
  <tr><td>
  <span class="dropdown">
  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
Estado<b class="caret"></b></a>
		<ul class="dropdown-menu dropdown-menu-large row">
			<?

			if($usuaPermExpediente) {
				?>
				<li>
					<a href="#" onClick="verHistExpediente('<?=$num_expediente?>');"></a>
				</li>
				<li>
					<a href="#" onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
				</li>

				<li>
					<a href="#" onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
				</li>
					<?
				}
				?>
				<li>
					<a href="#" onClick="modFlujo('<?=$num_expediente?>',<?=$texp?>,<?=$codigoFldExp?>,'<?=$ventana?>')">Modificar Estado</a>
				</li>
		</ul>
	</span>
	<?
	if($frm){
		foreach($frm as $arista){
	?>
		</Td><td><span class="dropdown">
		  <lu>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#"><?=$descFldExp?>
		<b class="caret"></b>
			</a>
		<ul class="dropdown-menu dropdown-menu-large row">
		<li>
		<a href="#" onClick="window.open('<?=$arista["FRM_LINK"]?>','frm<?=date('ymdhis')?>','fullscreen=yes, scrollbars=auto')"><?=$arista["FRM_NOMBRE"]?></a>
	 </lu>
	 </span>
 	</td>
	<?php
	}
	}else{
	?>

		</B></Td><td><?=$descFldExp?>
		</td><?
		}
		?>
		</tr>
		<tr><td>
     Fecha Inicio: </td><td><?php print $arrTRDExp['fecha']; ?></td>
    </tr>
    </table>
  </td>
</tr>
<tr >
<td colspan="2" >
	<?php
}
?>
<table width="100%" align=left><tr><td>
<?
 include "$ruta_raiz/expediente/expedienteTree.php";
?>
</td></tr></table>
</td>
<!-- </tr> -->
</table>