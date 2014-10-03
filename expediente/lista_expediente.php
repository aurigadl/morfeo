<div>
<?php // include "./proceso/workFlowParcial.php"; ?>
</div>
<input type="hidden" name="menu_ver_tmp" value=4>
<input type="hidden" name="menu_ver" value=4>
<?
unset($frm);
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
	if(!$tsub)$tsub = "0";
	if(!$tdoc)$tdoc = "0";
	if(!$codserie)$codserie = "0";
?>

   <?php
	if ( $usuaPermExpediente ) {
   ?><table class="table table-bordered table-striped" colspacing=0 cellspacing=0>
     <tr><td width=140>
       <span class="dropdown">
        <a class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
          &nbsp;&nbsp;Expediente&nbsp;&nbsp;<b class="caret"></b> </a>
				<ul class="dropdown-menu">
				<?
				if($usuaPermExpediente || !$numExpediente) {
					?>
					<li>
						<a  onClick="insertarExpediente();">Incluir en...</a>
					</li>
					<li>
						<a onClick="excluirExpediente();">Excluir de...</a>
					</li>
					<li>
						<a  onClick="verTipoExpediente('<?=$numExpediente?>',<?=$codserie?>,<?=$tsub?>,<?=$tdoc?>,'MODIFICAR');">Crear Nuevo Expediente</a>
					</li>
					<li>
						<a onClick="Responsable('<?=$numExpediente?>');">Cambiar Responsable</a>
					</li>
					<li>
						<a  onClick="CambiarE(2,'<?=$numExpediente?>');">Cerrar Expediente</a>
					</li>
					<li>
						<a  onClick="seguridadExp('<?=$numExpediente?>','<?=$nivelExp?>');">Seguridad</a>
					</li>
					<li>
					<?php
							$url = $servidorPyForms."seleccion_predios/get_predios_list?expediente=$numExpediente";
							//$predios2 = file_get_contents($url);
							//$predios = str_replace('"',"'",$predios2);
							//$arrPredios = json_decode($predios2);
							//$listPredios = "";
							//&&foreach($arrPredios as $key => $valor){
							//  $listPredios .= "'".$valor->chip ."',";
							//}
							//$listPredios .= "'0'";
							$vars = "&nombreProyecto=$param1($numExpediente)";
						?>
						<a  onClick="reportePredios(&quot;<?=$numExpediente?>&quot;,&quot;<?=$listPredios?>&quot;,&quot;<?=$vars?>&quot;,'modeloPredial');">Reporte Inventario de Predios </a>
					</li>
					

					<?
					}
				?>
			</ul>
			</span>
    </td>
    <td><small>
    <?=$num_expediente?>
    <input name="num_expediente" type="hidden" size="30" maxlength="18" id='num_expediente' value="<?=$num_expediente?>" class="tex_area" >
     Cod :  <span class=leidos2> <? echo $param1;?>
     Responsable: <span class=leidos2> <?=ucwords(strtolower($responsable))	?></small>
     </td>
	<?
	}

  ?>
    <input type="hidden" name='funExpediente' id='funExpediente' value="" >
    <input type="hidden" name='menu_ver_tmp' id='menu_ver_tmp' value="4" >
<?
	// CONSULTA SI EL EXPEDIENTE TIENE UNA CLASIFICACION TRD

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
<Tr><td><small>Clasificacion D.</small></td>
         <td>
             <small>
                <?php echo ucwords(strtolower($arrTRDExp['serie']))." / ".ucwords(strtolower($arrTRDExp['subserie'])); ?>
                <br>
                 <?php if($usuaPermExpediente > 1){ ?>
                    <button type="submit" name='edittemasexp_<?=$num_expediente?>' class="btn btn-primary btn-xs" id ="editadorapidoexpediente">Editar ..</button>
                    <button type='submit' name='savetemasexp_<?=$num_expediente?>' value="<?=$num_expediente?>" id ="grabadorapidoexpediente" class='btn btn-success  btn-xs'>Grabar ..</button>
                 <?php } ?>
                    <table>
                        <?php
                        if ( $expIncluido != "" ) {
                            $arrDatosParametro = $expediente->getDatosParamExp( $expIncluido, $dependencia );
                        }else if( $numExpediente != "" ) {
                            $arrDatosParametro = $expediente->getDatosParamExp( $numExpediente, $dependencia );
                        }

                        if( $arrDatosParametro != "" ){
                            foreach( $arrDatosParametro as $clave => $datos ) {
                               echo "<tr><td><small><br><b>".ucwords(strtolower($datos['etiqueta']))." : </b><span class='showfield'>".ucwords(strtolower(htmlentities($datos['parametro']))). "</span></small></td>
                                     <td><input  class='editfield' style='display: none;' type='text' name='etique_"
                                   .$numExpediente."[]'
                                      value='".ucwords(strtolower(htmlentities($datos['parametro'])))."'></td></tr>";
                            }
                        }

                        ?>
                   </table>
            </small>
         </td>
     </tr>
	<tr>
  <td>
    <span class="dropdown">

      <a class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
        &nbsp;&nbsp;Procedimiento&nbsp;&nbsp;
        <b class="caret"></b>
      </a>

      <ul class="dropdown-menu">
       <?  if($usuaPermExpediente) { ?>
        <li>
          <a onClick="verHistExpediente('<?=$numExpediente?>');">Historial del Proceso/Exp</a>
        </li>
        <li>
           <a  onClick="verWorkFlow('<?=$numExpediente?>','<?=$texp?>');">Ver WorkFlow</a>
        </li>
        <li>
          <a onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
        </li>
       <?  } ?>
      </ul>

    </span>

		</td><td><small>
					<?php
			if( $arrTRDExp['proceso'] != "" ) {
			  echo $arrTRDExp['proceso']." / ".$arrTRDExp['terminoProceso'];
			}
			?></small>

</td></tr>
 
<?
$aristasSig="";
$frm = "";
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
 unset($frm);
 $frm = array();
 $frms = 0;
 foreach($aristasSig as $key => $arista){
  if(trim($arista["FRM_NOMBRE"]) && trim($arista["FRM_LINK"])){
    $ventana = "Max";
    If(!$numeroExpediente) $numeroExpediente = $numExpedente;
    $frm[$iA]["FRM_NOMBRE"] = $arista["FRM_NOMBRE"];
    $frm[$iA]["FRM_LINK"] = $arista["FRM_LINK"];
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroRadicado}","$verrad", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{usuarioDoc}","$usua_doc", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{usuarioDoc}","$usua_doc", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = $frm[$iA]["FRM_LINK"] . "&PHPSESSID=".session_id();

		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroRadicado}","$numRad", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{usuarioDoc}","$usua_doc", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = $frm[$iA]["FRM_LINKSELECT"] . "&PHPSESSID=".session_id();
		$iA++;
		$frms = 1;
	}
	} // Fin si hay Aristas....
 }
}
?>
  <tr><td>
  <span class="dropdown">
  <a class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown" href="#">
    &nbsp;&nbsp;Estado&nbsp;&nbsp; <b class="caret"></b>
  </a>
		<ul class="dropdown-menu dropdown-menu-large row">
			<?

			if($usuaPermExpediente) {
				?>
				<li>
					<a onClick="verHistExpediente('<?=$num_expediente?>');"></a>
				</li>
				<li>
					<a onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
				</li>

				<li>
					<a onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
				</li>
					<?
				}
				?>
				<li>
					<a onClick="modFlujo('<?=$num_expediente?>',<?=$texp?>,<?=$codigoFldExp?>,'<?=$ventana?>')">Modificar Estado</a>
				</li>
		</ul>
	</span>
	</Td><td>
	<?
	if( $frms == 1){
	?>
	<span class="dropdown">
 	 <a class="dropdown-toggle" data-toggle="dropdown" ><small><?=ucwords(strtolower($descFldExp))?></small>
		<b class="caret"></b>
		</a>
		<ul class="dropdown-menu dropdown-menu-large row">
		<?
		foreach($frm as $arista){
	?>
			<li>
				<a onClick="window.open('<?=$arista["FRM_LINK"]?>','frm<?=date('ymdhis')?>','fullscreen=yes, scrollbars=auto')"><?=trim($arista["FRM_NOMBRE"])?>
				</a>
			</li>  
	<?php
	}
	?>
	 </ul>
	 </span>
 	</td>
	<?php
	}else{
	?>
		<small><?=ucwords(strtolower($descFldExp))?></small>
		</td><?
		}
		?>
		</tr>
		<tr><td><small>
     Fecha Inicio</small></td><td><small><?php print $arrTRDExp['fecha']; ?></small></td>
    </tr>
    </table>
  </td>
</tr>
<tr >
<td colspan="2" >
	<?php
}
?>
<table width="100%" align=left  colspacing=0 cellspacing=0><tr><td>
<?
 include "$ruta_raiz/expediente/expedienteTree.php";
?>
</td></tr></table>
<script>
/*$( document ).ready(function() {
$( "#grabadorapidoexpediente" ).hide();
});*/
    $('body').on('click', "button[name^=edittemasexp]", function () {
        $('.showfield').toggle();
        $('.editfield').toggle();
    })

    $('body').on('click', "button[name^='savetemasexp']", function () {
        var complement = $(this).val();
        var datos = $("input[name^='etique_" + complement + "']").serialize() + "&saveEtiq=1";
        $.post( "./expediente/lista_expedientes.php", datos, function( data ) {
            $( ".result" ).html( data );
        });
    })

$( "#grabadorapidoexpediente" ).click(function() {
	location.reload();
	/*document.getElementsByName(mainFrame).contentDocument.location.reload(true);*/
});
/*$( "#editadorapidoexpediente" ).click(function() {
	$( "#grabadorapidoexpediente" ).show();
	$( "#editadorapidoexpediente" ).hide();
});*/

</script>