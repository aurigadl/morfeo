<-{assign var="gruposHtml" value='
	<tr>

		<td class="toogletd">
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Borrar" data-original-title="Collapse">
				<i class="fa fa-minus "></i>
			</a>
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Guardar" data-original-title="Collapse">
				<i class="fa fa-save "></i>
			</a>
		</td>

		<td class="hasinput">
			<label class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

	</tr>
'}->

<-{assign var="usuariosHtml" value='
	<tr>
		<td class="toogletd">
			<a href="javascript:void(0);" class="button-icon
																		jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Borrar" data-original-title="Collapse">
				<i class="fa fa-minus "></i>
			</a>
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Guardar" data-original-title="Collapse">
				<i class="fa fa-save "></i>
			</a>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="toogletd">
			<label class="select">
				<select class="select">
					<option>900 Pruebas</option>
				</select>
			</label>
		</td>
	</tr>

'}->

<-{assign var="membresiasHtml" value='
	<tr>

		<td class="toogletd">
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Borrar" data-original-title="Collapse">
				<i class="fa fa-minus "></i>
			</a>
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Guardar" data-original-title="Collapse">
				<i class="fa fa-save "></i>
			</a>
		</td>

		<td class="toogletd">
			<label class="select">
				<select class="select">
					<option>Secretaria</option>
					<option>Contadores</option>
					<option>Archivistas</option>
				</select>
			</label>
		</td>

		<td class="toogletd">
			<label class="select">
				<select class="select">
					<option>Carlos Antonio Romero Incapie</option>
					<option>Teresa Melo Armadillo</option>
				</select>
			</label>
		</td>

	</tr>
'}->

<-{assign var="permisosHtml" value='
	<tr>
		<td class="toogletd">
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Borrar" data-original-title="Collapse">
				<i class="fa fa-minus "></i>
			</a>
			<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
			   data-placement="Guardar" data-original-title="Collapse">
				<i class="fa fa-save "></i>
			</a>
		</td>

		<td class="toogletd">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="toogletd">
			<label name="" class="input">
				<input type="text" name="" value="">
			</label>
		</td>

		<td class="toogletd">
			<label class="select">
				<select class="select" id="select-1">
					<option>Todas las Dependencias</option>
					<option>Dependencia propia</option>
					<option>Ninguna</option>
				</select>
			</label>
		</td>

		<td class="toogletd">
			<label class="select">
				<select class="select" id="select-1">
					<option>Crear y Borrar</option>
					<option>Editar</option>
					<option>Leer</option>
				</select>
			</label>
		</td>

		<td class="toogletd">
			<label class="select">
				<select class="select" id="select-1">
					<option>Secretarias</option>
				</select>
			</label>
		</td>

	</tr>
'}->


<!DOCTYPE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Administración de usuarios</title>
	<-{ include_php file="../../htmlheader.inc.php" }->
</head>

<body>

<article class="col-sm-12 col-md-12 col-lg-12">

<div id="accordion">

<div>

	<h4>Permisos</h4>

	<div class="padding-10">
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
			<header></header>
			<!-- widget div-->
			<div>

				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
				</div>
				<!-- end widget edit box -->

				<!-- widget content -->
				<div class="widget-body no-padding">
					<div class="widget-body-toolbar"></div>

					<table id="dt_basic2" class="table table-striped table-bordered table-hover smart-form"
					       width="100%">
						<thead>
						<tr>
							<th style="width: 35px;">
								<a href="javascript:void(0);" id="xdt_basic2" class="btn btn-sm"><i class="fa
										fa-plus"></i></a>
							</th>
							<th>Nombre</th>
							<th>Descripci&oacute;n</th>
							<th>Dependencias</th>
							<th>Crud</th>
							<th>Grupo</th>
						</tr>
						</thead>
						<tbody id="bdt_basic2">
						<-{if count($permisos) eq 0}->
							<-{else}->

							<-{foreach item=item from=$permisos}->
								<tr>

									<td class="toogletd">
										<a href="javascript:void(0);" data=" " class="button-icon
													jarviswidget-toggle-btn" rel="tooltip" title=""
										   data-placement="Borrar" data-original-title="Collapse">
											<i class="fa fa-minus "></i>
										</a>
										<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
										   data-placement="Guardar" data-original-title="Collapse">
											<i class="fa fa-save "></i>
										</a>
									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="NOMBRE" value="<-{$item.NOMBRE}->">
										</label>
									</td>

									<td class="hasinput">
										<label name="" class="input">
											<input type="text" name="DESCRIPTION" value="<-{$item.DESCRIPCION}->">
										</label>
									</td>

									<td class="hasinput">
										<label name="" class="input">
											<input type="text" name="DEPENDENCIA" value="<-{$item.DEPENDENCIA}->">
										</label>
									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="CRUD" value="<-{$item.CRUD}->">
										</label>
									</td>

									<td class="hasinput">
										<label class="select">
											<select class="input-sm">

												<-{foreach item=i from=$grupos}->

													<-{if $item.AUTG_ID eq $i.ID}->
														<option value="<-{$i.ID}->" selected>
															<-{$i.NOMBRE}->
														</option>
													<-{else}->
														<option value="<-{$i.ID}->">
															<-{$i.NOMBRE}->
														</option>
													<-{/if}->

												<-{/foreach}->

											</select> <i></i>
										</label>
									</td>

								</tr>
							<-{/foreach}->
							<-{/if}->
						</tbody>
					</table>

				</div>
				<!-- end widget content -->

			</div>
			<!-- end widget div -->

		</div>
		<!-- WIDGET END -->
	</div>
</div>


<div>
	<h4>Grupos</h4>

	<div class="padding-10">
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
			<header></header>
			<!-- widget div-->
			<div>

				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
				</div>
				<!-- end widget edit box -->

				<!-- widget content -->
				<div class="widget-body no-padding">
					<div class="widget-body-toolbar"></div>

					<table id="dt_basic" class="table table-striped table-bordered table-hover smart-form"
					       width="100%">
						<thead>
						<tr>
							<th style="width: 35px;">
								<a href="javascript:void(0);" id="xdt_basic" class="btn btn-sm">
									<i class="fa fa-plus"></i>
								</a>
							</th>
							<th>Nombre</th>
							<th>Descripción</th>
						</tr>
						</thead>
						<tbody id="bdt_basic">
						<-{if count($grupos) eq 0}->
							<-{$gruposHtml}->
						<-{else}->
							<-{foreach item=grupo from=$grupos}->
							<tr>
								<-{foreach key=key item=item from=$grupo}->
									<-{if $key eq 'ID'}->
										<td class="toogletd">
											<a href="javascript:void(0);" data=" " class="button-icon
										        jarviswidget-toggle-btn" rel="tooltip" title=""
											    data-placement="Borrar" data-original-title="Collapse">
												<i class="fa fa-minus "></i>
											</a>
											<a href="javascript:void(0);" class="button-icon jarviswidget-toggle-btn" rel="tooltip" title=""
											    data-placement="Guardar" data-original-title="Collapse">
												<i class="fa fa-save "></i>
											</a>
										</td>
									<-{/if}->

									<-{if $key eq 'NOMBRE'}->
										<td class="hasinput">
											<label class="input">
												<input type="text" name="" value="<-{$item}->">
											</label>
										</td>
								    <-{/if}->

									<-{if $key eq 'DESCRIPTION'}->
										<td class="hasinput">
											<label name="" class="input">
												<input type="text" name="" value="<-{$item}->">
											</label>
										</td>
									<-{/if}->

								<-{/foreach}->
							</tr>
							<-{/foreach}->
						<-{/if}->
						</tbody>
					</table>
				</div>
				<!-- end widget content -->
			</div>
			<!-- end widget div -->
		</div>
		<!-- WIDGET END -->
	</div>
</div>


<div>
	<h4>Usuarios</h4>

	<div class="padding-10">
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
			<header></header>
			<!-- widget div-->
			<div>

				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
				</div>
				<!-- end widget edit box -->

				<!-- widget content -->
				<div class="widget-body no-padding">
					<div class="widget-body-toolbar"></div>

					<table id="dt_basic3" class="table table-striped table-bordered table-hover smart-form"
					       width="100%">
						<thead>
						<tr>
							<th style="width: 35px;">
								<a href="javascript:void(0);" id="xdt_basic3" class="btn btn-sm"><i
											class="fa
											fa-plus"></i></a>
							</th>
							<th>Primer Nombre</th>
							<th>Segundo Nombre</th>
							<th>Primer Apellido</th>
							<th>Contraseña</th>
							<th>Correo</th>
							<th>Dependencias</th>
						</tr>
						</thead>
						<tbody id="bdt_basic3"></tbody>
					</table>

				</div>
				<!-- end widget content -->

			</div>
			<!-- end widget div -->

		</div>
		<!-- WIDGET END -->
	</div>
</div>


<div>
	<h4>Membresia</h4>

	<div class="padding-10">
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
			<header></header>
			<!-- widget div-->
			<div>

				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
				</div>
				<!-- end widget edit box -->

				<!-- widget content -->
				<div class="widget-body no-padding">
					<div class="widget-body-toolbar"></div>

					<table id="dt_basic4" class="table table-striped table-bordered table-hover smart-form"
					       width="100%">
						<thead>
						<tr>
							<th style="width: 35px;">
								<a href="javascript:void(0);" id="xdt_basic4" class="btn btn-sm"><i
											class="fa fa-plus"></i>
								</a>
							</th>
							<th>Grupo</th>
							<th>Usuario</th>
						</tr>
						</thead>
						<tbody id="bdt_basic4"></tbody>
					</table>

				</div>
				<!-- end widget content -->

			</div>
			<!-- end widget div -->

		</div>
		<!-- WIDGET END -->
	</div>
</div>
</div>
</article>

</body>


<!-- Plantilla para la creación de los grupos.
Elemento necesario para duplicar los campos
de inserción para los nuevos registros. -->
<script id="plantillaGrupos" type="text/html">
	<-{$gruposHtml}->
</script>


<!-- Plantilla para la creación de los permisos.
Elemento necesario para duplicar los campos
de inserción para los nuevos registros. -->
<script id="plantillaPermisos" type="text/html">
	<-{$permisosHtml}->
</script>


<!-- Plantilla para la creación de los Usuarios.
Elemento necesario para duplicar los campos
de inserción para los nuevos registros. -->
<script id="plantillaUsuarios" type="text/html">
	<-{$usuariosHtml}->
</script>


<!-- Plantilla para la creación de los Usuarios.
Elemento necesario para duplicar los campos
de inserción para los nuevos registros. -->
<script id="plantillaMembresias" type="text/html">
	<-{$membresiasHtml}->
</script>


<script type="text/javascript">
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();

	// PAGE RELATED SCRIPTS

	loadDataTableScripts();
	function loadDataTableScripts() {

		loadScript("../../js/plugin/datatables/jquery.dataTables-cust.min.js", dt_2);

		function dt_2() {
			loadScript("../../js/plugin/datatables/DT_bootstrap.js", runDataTables);
		}

	}

	function runDataTables() {
		$('#dt_basic, #dt_basic2, #dt_basic3, #dt_basic4').dataTable();
	}

	/*
	 * ACCORDION
	 * jquery accordion
	 */

	var accordionIcons = {
		header: "fa fa-plus",    // custom icon class
		activeHeader: "fa fa-minus" // custom icon class
	};

	$("#accordion").accordion({
		autoHeight: false,
		heightStyle: "content",
		collapsible: true,
		animate: 300,
		header: "h4"
	})

	//agregar elementos
	$('#xdt_basic2, #xdt_basic, #xdt_basic3, #xdt_basic4').on("click", function () {
		var nomPlus = 'b' + $(this).attr('id').substring(1);
		switch (nomPlus) {
			case 'bdt_basic2':
				//Plantillas y clonar elementos Permisos
				var plaPerm = $('#plantillaPermisos').clone();
				$('#bdt_basic2').append($(plaPerm).html());
				break;

			case 'bdt_basic':
				//Plantillas y clonar elementos Grupos
				var plaGrup = $('#plantillaGrupos').clone();
				$('#bdt_basic').prepend($(plaGrup).html());
				break;

			case 'bdt_basic3':
				//Plantillas y clonar elementos Usuarios
				var plaUsua = $('#plantillaUsuarios').clone();
				$('#bdt_basic3').append($(plaUsua).html());
				break;

			case 'bdt_basic4':
				//Plantillas y clonar elementos Membresias
				var plaMemb = $('#plantillaMembresias').clone();
				$('#bdt_basic4').append($(plaMemb).html());
				break;
		}
	});

</script>
</html>
