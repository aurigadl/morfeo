<!-- NEW WIDGET START -->
<article class="col-sm-12 col-md-12" align=left>
<!--widget content -->
<div class="widget-body">
	<div class="tree smart-form fa-folder-close">
		<ul>
		<li>
			<span class="alert-success"><i class="fa fa-folder-close"></i> <?=$numExpediente?></span>
			<ul>
			<?
			foreach($datosExp as $key2 => $value){
			?>
			<li  style="display:none">
				<span>
				<? echo "<TABLE  WIDTH='950'><TR><TD WIDTH=30><i class='icon-leaf'></i> </TD>
				<TD width=150>";
				if($valueAnexos["PATH_RADICADO"]) echo "<a href='$ruta_raiz/".$value["PATH_RADICADO"]."' target='".date("ymdhis")."'>";
				echo $value["NUM_RADICADO"];
				if($valueAnexos["PATH_RADICADO"]) echo "</a>" ;
				echo "</TD>
				<TD width=150>".$value["FECHA_RADICADO"]."</TD><TD width=150>".$value["TIPO_DRADICADO"]."</TD><TD width=450>".$value["ASUNTO_RADICADO"]."</TD>
				</TR>
				</TABLE>"; ?></span>

				<ul>
        <?
            $carpetaDep = intval(substr($value["NUM_RADICADO"],4,$digitosDependencia));
            $rutaAnexos = "".substr($value["NUM_RADICADO"],0,4). "/$carpetaDep/docs/";
            $anexos = $value["ANEXOS"];
            if($anexos){
            foreach($anexos as $valueAnexos){
          ?>
          <li style="display:none">
            <?=$valueAnexos["ANEX_NUMERO"]?> - <?=$valueAnexos["RADI_SALIDA"]?>
            <? if($valueAnexos["ANEX_PATH"]) {?><a href='<?=$ruta_raiz."/bodega/$rutaAnexos".$valueAnexos["ANEX_PATH"]?>' target='<?=date("ymdhis")?>'> <? } ?>
            - <?=$valueAnexos["DESCRIPCION"]?>
            <? if($valueAnexos["ANEX_PATH"]) {?> </a> <? } ?>
          </li>
          <?
            }
          }
          ?>
          </ul>
			</li>
			<?
			}
			
		$url = "http://200.118.122.176:5380/py/pyforms/seleccion_predios/get_predios_list?expediente=$numExpediente";
		$predios = file_get_contents($url);
		$arrPredios = json_decode($predios);
		if($arrPredios){
			?>
			<li  style="display:none">
				<span  class="alert-success">
				<? echo "Predios"; ?></span>
				<ul>
				<?
					foreach($arrPredios as $key => $valor){
					?>
				<li style="display:none">
				  <a href='http://localhost/orfeoNew/verradicado.php?verrad=<?=$verrad?>&<?=session_name()?>=<?=session_id()?>&nomcarpeta=<?=nomcarpeta?>&prediosExp=<?=$predios?>#tabs-gis'>
					<?="Chip : ".$valor->chip; ?>
					</a>
				</li>	
				<?
					}
				?>
			</ul>
		</li>
		<? } ?>
		</ul>
	</div>
</div>
		<!-- end widget content -->
</article>
	<!-- WIDGET END -->
	

