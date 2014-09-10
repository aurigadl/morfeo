<table class="table table-bordered smart-form" >
	<tr>
	<tr/>
	<tr><td width='100%' >
	<table align="center" cellspacing="0" cellpadding="0" width="100%" class="table">
	<tr class="tablas"><td class="etextomenu" >
	<span class="etextomenu">
	<form name=form_busq_rad action='<?=$pagina_actual?>?<?=session_name()."=".session_id()?>&estado_sal=<?=$estado_sal?>&tpAnulacion=<?=$tpAnulacion?>&estado_sal=<?=$estado_sal?>&estado_sal_max=<?=$estado_sal_max?>&pagina_sig=<?=$pagina_sig?>&dep_sel=<?=$dep_sel?>&nomcarpeta=<?=$nomcarpeta?>' method=POST>
	<small>Buscar radicado(s) (Separados por coma)<small>
	<label class="input">
	<i class="icon-append fa fa-search"></i>
	<input name="busqRadicados" type="text" size="60" value="<?=$busqRadicados?>">
	</label>
	
        <input type=hidden name=estado_sal value='<?=$estado_sal?>'>
	<footer><input type=submit value='Buscar ' name=Buscar valign='middle' class='btn btn-success'>
	<?
	if($_POST["bTodasDep"]){
	 $datosss = " checked ";
	}else{
	 $datosss = "";
	}
	?>
	<!--<input type=checkbox name=bTodasDep id=bTodasDep <?=$datosss?> value="SelecionaTodas"><small> Buscar en Todas
            las Dependencias</small>-->
	</footer>
	<?
	if ($busqRadicados) {
		$busqRadicados = trim($busqRadicados);
		$textElements = split (",", $busqRadicados);
		$newText = "";
		$i = 0;
		foreach ($textElements as $item) {
			$item = trim ( $item );
			if ($item) { 
			if ($i != 0) $busq_and = " or "; else $busq_and = " ";
				if(!$varBuscada) $varBuscada = "c.RADI_NUME_RADI";
				$busq_radicados_tmp .= " $busq_and cast($varBuscada as varchar(20)) like '%$item%' ";
				$i++;
			}
		} //FIN foreach

	$dependencia_busq2 .= " and ($busq_radicados_tmp) ";
	} //FIN if ($busqRadicados)
?>
	</form>
	 </span>
	</td></tr>
	</table>
	<td/>
  <tr/>
</table>
