		<!-- NEW WIDGET START -->
		<article class="col-sm-12 col-md-12 col-lg-6">
		<div>
			<!-- widget content -->
		<div class="widget-body">
			<div class="tree smart-form fa-folder-close">
				<ul>
			  <?
			   if($arrExpedientes){
			    foreach($arrExpedientes as $key => $datosExp){
			  ?>
					<li>
						<span><i class="fa fa-lg fa-folder-close"></i> <?=$key?></span>
						<ul>
						<?
					  foreach($datosExp as $key2 => $value){
					  ?>
							<li  style="display:none">
								<span>
								<? echo "<TABLE  WIDTH='850'><TR><TD WIDTH=30><i class='icon-leaf'></i> </TD>
								<TD width=150>";
								if($valueAnexos["PATH_RADICADO"]) echo "<a href='$ruta_raiz/".$value["PATH_RADICADO"]."' target='".date("ymdhis")."'>";
								echo $value["NUM_RADICADO"];
								if($valueAnexos["PATH_RADICADO"]) echo "</a>" ;
								echo "</TD>
								<TD width=150>".$value["FECHA_RADICADO"]."</TD><TD width=150>".$value["TIPO_DRADICADO"]."</TD><TD width=250>".$value["ASUNTO_RADICADO"]."</TD>
								</TR>
								</TABLE>"; ?></span>
									<ul>
													<?
													  $anexos = $value["ANEXOS"];
													  if($anexos){
													  foreach($anexos as $valueAnexos){
													?>
														<li style="display:none">
															<span><i class="fa fa-lg fa-plus-circle"></i><?=$valueAnexos["ANEX_NUMERO"]?></span> 
															<? if($valueAnexos["ANEX_PATH"]) {?><a href='<?=$ruta_raiz."/bodega/".$valueAnexos["ANEX_PATH"]?>' target='<?=date("ymdhis")?>'> <? } ?>
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
						?>
						</ul>
					</li>
			<?
			 }
			 }
			?>
							</ul>
						</div>
					</div>
					<!-- end widget content -->
				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->
		</article>
		<!-- WIDGET END -->
</section>
<!-- end widget grid -->

<script type="text/javascript">
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();

	// PAGE RELATED SCRIPTS

	$('.tree > ul').attr('role', 'tree').find('ul').attr('role', 'group');
	$('.tree').find('li:has(ul)').addClass('parent_li').attr('role', 'treeitem').find(' > span').attr('title', 'Collapse this branch').on('click', function(e) {
		var children = $(this).parent('li.parent_li').find(' > ul > li');
		if (children.is(':visible')) {
			children.hide('fast');
			$(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
		} else {
			children.show('fast');
			$(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
		}
		e.stopPropagation();
	});

</script>
