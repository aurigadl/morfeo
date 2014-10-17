<-{assign var="gruposHtml" value='
		<tr>

			<td class="toogletd">

				<a href="javascript:void(0);" class="button-icon" data-tipo="grupos" >
					<i class="fa fa-minus"></i>
				</a>

				<a href="javascript:void(0);" class="button-icon" data-tipo="grupos">
					<i class="fa fa-save"></i>
				</a>

			</td>

			<td class="hasinput">
				<label class="input">
					<input type="text" name="nombre" value="" required>
				</label>
			</td>

			<td class="hasinput">
				<label name="" class="input">
					<input type="text" name="descripcion" value="" required>
				</label>
			</td>

		</tr>
'}->


<-{assign var="usuariosHtml" value='
	<tr>
		<td class="toogletd">

			<a href="javascript:void(0);" class="button-icon" data-tipo="usuarios">
				<i class="fa fa-minus"></i>
			</a>

			<a href="javascript:void(0);" class="button-icon" data-tipo="usuarios">
				<i class="fa fa-save"></i>
			</a>

		</td>

		<td class="hasinput">
			<label class="input">
				<input type="text" name="nombres" value="">
			</label>
		</td>

		<td class="hasinput">
			<label class="input">
				<input type="text" name="apellidos" value="">
			</label>
		</td>

		<td class="hasinput">
			<label class="input">
				<input type="text" name="contrasena" value="">
			</label>
		</td>

		<td class="hasinput">
			<label class="input">
				<input type="text" name="correo" value="">
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

<div class="alert alert-success fade in">
	<button class="close" data-dismiss="alert"> × </button>
	<i class="fa-fw fa fa-check"></i>
	<strong>Guardado</strong>
</div>

<div class="alert alert-danger fade in">
	<button class="close" data-dismiss="alert"> × </button>
	<i class="fa-fw fa fa-times"></i>
	<strong>Error!</strong>
</div>

<div id="accordion">

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
					<table id="dt_basic" class="table table-striped table-bordered table-hover smart-form" width="100%">
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
									<td class="toogletd">

										<a href="javascript:void(0);" data-tipo="grupos" data-id="<-{$grupo.ID}->"
										   class="button-icon">
											<i class="fa fa-minus"></i>
										</a>

										<a href="javascript:void(0);" data-tipo="grupos" data-id="<-{$grupo.ID}->"
										   class="button-icon">
											<i class="fa fa-save "></i>
										</a>

									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="nombre" value="<-{$grupo.NOMBRE}->">
										</label>
									</td>

									<td class="hasinput">
										<label name="" class="input">
											<input type="text" name="descripcion" value="<-{$grupo.DESCRIPCION}->">
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
			<tr>

				<td class="toogletd">

					<a href="javascript:void(0);" data-tipo="permisos" data-id="<-{$item.ID}->"
					   class="button-icon">
						<i class="fa fa-minus"></i>
					</a>

					<a href="javascript:void(0);" data-tipo="permisos" data-id="<-{$item.ID}->"
					   class="button-icon">
						<i class="fa fa-save "></i>
					</a>

				</td>

				<td class="hasinput">
					<label class="input">
						<input type="text" name="nombre" value="<-{$item.NOMBRE}->">
					</label>
				</td>

				<td class="hasinput">
					<label name="" class="input">
						<input type="text" name="descripcion" value="<-{$item.DESCRIPCION}->">
					</label>
				</td>

				<td class="hasinput">
					<label class="select select-multiple">
						<select class="custom-scrollselectpicker" name="dependencia" multiple>
							<option value="">-- Seleccione una Opción --</option>
							<-{foreach item=i from=$dependencias}->
								<option value="<-{$i.DEPE_CODI}->">
									<-{$i.DEPE_NOMB}->
								</option>
							<-{/foreach}->
						</select> <i></i>
					</label>
				</td>

				<td class="hasinput">
					<label class="select">
						<select class="input-sm" name="crud">
							<option value="">-- Seleccione una Opción --</option>
							<-{foreach item=i from=$crud}->
								<option value="<-{$i.ID}->">
									<-{$i.NOMBRE}->
								</option>
							<-{/foreach}->
						</select> <i></i>
					</label>
				</td>

				<td class="hasinput">
					<label class="select">
						<select class="input-sm" name="grupo">
							<option value="">-- Seleccione una Opción --</option>
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
		<-{else}->

			<-{foreach item=item from=$permisos}->
				<tr>

					<td class="toogletd">

						<a href="javascript:void(0);" data-tipo="permisos" data-id="<-{$item.ID}->"
						   class="button-icon">
							<i class="fa fa-minus"></i>
						</a>

						<a href="javascript:void(0);" data-tipo="permisos" data-id="<-{$item.ID}->"
						   class="button-icon">
							<i class="fa fa-save "></i>
						</a>

					</td>

					<td class="hasinput">
						<label class="input">
							<input type="text" name="nombre" value="<-{$item.NOMBRE}->">
						</label>
					</td>

					<td class="hasinput">
						<label name="" class="input">
							<input type="text" name="descripcion" value="<-{$item.DESCRIPCION}->">
						</label>
					</td>

					<td class="hasinput">
						<label class="select select-multiple">
							<select class="custom-scroll" multiple name="dependencia">
								<option value="">-- Seleccione una Opción --</option>
								<-{foreach item=i from=$dependencias}->
									<-{foreach item=j from=$item.DEPENDENCIA}->
										<-{if $j eq $i.DEPE_CODI}->
											<option value="<-{$i.DEPE_CODI}->" selected>
												<-{$i.DEPE_NOMB}->
											</option>
											{break}
										<-{else}->
											<option value="<-{$i.DEPE_CODI}->">
												<-{$i.DEPE_NOMB}->
											</option>
										<-{/if}->
									<-{/foreach}->
								<-{/foreach}->
							</select> <i></i>
						</label>
					</td>

					<td class="hasinput">
						<label class="select">
							<select class="input-sm" name="crud">
								<option value="">-- Seleccione una Opción --</option>
								<-{foreach item=i from=$crud}->
									<-{if $item.CRUD eq $i.ID}->
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

					<td class="hasinput">
						<label class="select">
							<select class="input-sm" name="grupo">
								<option value="">-- Seleccione una Opción --</option>
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
</div> </div>

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
											class="fa fa-plus"></i></a>
							</th>
							<th>Nombres</th>
							<th>Apellidos</th>
							<th>Contraseña</th>
							<th>Correo</th>
						</tr>
						</thead>
						<tbody id="bdt_basic3">
						<-{if count($usuarios) eq 0}->
							<-{$usuariosHtml}->
						<-{else}->
							<-{foreach item=item from=$usuarios}->
								<tr>
									<td class="toogletd">

										<a href="javascript:void(0);" data-tipo="usuarios" data-id="<-{$item.ID}->"
										   class="button-icon">
											<i class="fa fa-minus"></i>
										</a>

										<a href="javascript:void(0);" data-tipo="usuarios" data-id="<-{$item.ID}->"
										   class="button-icon">
											<i class="fa fa-save "></i>
										</a>

									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="nombres" value="<-{$item.NOMBRES}->">
										</label>
									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="apellidos" value="<-{$item.APELLIDOS}->">
										</label>
									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="contrasena" value="<-{$item.CONTRASENA}->">
										</label>
									</td>

									<td class="hasinput">
										<label class="input">
											<input type="text" name="correo" value="<-{$item.CORREO}->">
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
					<table class="table table-striped table-bordered table-hover smart-form"
					       width="100%">

						<thead>
							<tr>
								<th>
									Grupo
								</th>
								<th>Usuario</th>
							</tr>
						</thead>

						<tbody id="bdt_basic4">
							<tr>
								<td class="toogletd">
									<label class="select select-multiple">
										<select data-tipo="membresias"  id="grupo_membresias" name="grupo"
										        class="custom-scroll">
											<option value="">-- Seleccione una Opción --</option>
											<-{foreach item=i from=$grupos}->
												<option value="<-{$i.ID}->"> <-{$i.NOMBRE}-> </option>
											<-{/foreach}->
										</select>
									</label>
								</td>

								<td class="hasinput">
									<-{foreach item=i from=$usuarios}->
									<label class="checkbox">
										<input data-tipo="membresias"  type="checkbox"
										       name="<-{$i.ID}->" value="<-{$i.ID}->">
										<i></i><-{$i.NOMBRES}->
									</label>
									<-{/foreach}->
								</td>

							</tr>

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
	<tr>
		<td class="toogletd">
			<a href="javascript:void(0);" data-tipo="permisos" data-id=""
			   class="button-icon">
				<i class="fa fa-minus"></i>
			</a>

			<a href="javascript:void(0);" data-tipo="permisos" data-id=""
			   class="button-icon">
				<i class="fa fa-save "></i>
			</a>
		</td>

		<td class="hasinput">
			<label class="input">
				<input type="text" name="nombre" value="">
			</label>
		</td>

		<td class="hasinput">
			<label name="" class="input">
				<input type="text" name="descripcion" value="">
			</label>
		</td>

		<td class="hasinput">
			<label class="select select-multiple">
				<select class="custom-scrollselectpicker" multiple name="dependencia">
					<option value="">-- Seleccione una Opción --</option>

										<-{foreach item=i from=$dependencias}->

					<option value="<-{$i.DEPE_CODI}->">
							<-{$i.DEPE_NOMB}->
						</option>

										<-{/foreach}->
									</select> <i></i>
			</label>
		</td>

		<td class="hasinput">
			<label class="select">
				<select class="input-sm" name="crud">
					<option value="">-- Seleccione una Opción --</option>

										<-{foreach item=i from=$crud}->

					<option value="<-{$i.ID}->">
						<-{$i.NOMBRE}->
					</option>

										<-{/foreach}->
									</select> <i></i>
			</label>
		</td>

		<td class="hasinput">
			<label class="select">
				<select class="input-sm" name="grupo">
					<option value="">-- Seleccione una Opción --</option>

										<-{foreach item=i from=$grupos}->

					<option value="<-{$i.ID}->">
						<-{$i.NOMBRE}->
					</option>

										<-{/foreach}->
									</select> <i></i>
			</label>
		</td>

	</tr>
</script>


<!-- Plantilla para la creación de los Usuarios.
Elemento necesario para duplicar los campos
de inserción para los nuevos registros. -->
<script id="plantillaUsuarios" type="text/html">
	<-{$usuariosHtml}->
</script>


<script type="text/javascript">
	(function ($) {
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
			$('#dt_basic, #dt_basic2, #dt_basic3').dataTable();
		}

		//Validacion de los campos del formulario
		function validarCampos(datos){
			var res = datos.split('&');
			$.each(res, function(index, value) {
				var dato = value.split('=')[1];

				if((dato == "" || dato.length == 0 || dato == undefined) && value.split('=')[1]){
					$('.alert-danger').show().delay(3000).fadeOut();
					return false;
				}
			});
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
			header: "h4",
			active: 3
		})

		$('.alert-success').hide();
		$('.alert-danger').hide();

		//agregar elementos
		$('#xdt_basic2, #xdt_basic, #xdt_basic3, #xdt_basic4').click(function (event) {
			var nomPlus = 'b' + $(this).attr('id').substring(1);
			switch (nomPlus) {
				case 'bdt_basic':
					//Plantillas y clonar elementos Grupos
					var plaGrup = $('#plantillaGrupos').clone();
					$('#bdt_basic').prepend($(plaGrup).html());
					break;

				case 'bdt_basic2':
					//Plantillas y clonar elementos Permisos
					var plaPerm = $('#plantillaPermisos').clone();
					$('#bdt_basic2').prepend($(plaPerm).html());
					break;

				case 'bdt_basic3':
					//Plantillas y clonar elementos Usuarios
					var plaUsua = $('#plantillaUsuarios').clone();
					$('#bdt_basic3').prepend($(plaUsua).html());
					break;

				case 'bdt_basic4':
					//Plantillas y clonar elementos Membresias
					var plaMemb = $('#plantillaMembresias').clone();
					$('#bdt_basic4').prepend($(plaMemb).html());
					break;
			}

			event.stopPropagation();

		});

		//Eliminar un campo de la selección
		$('body').on('click', '.fa-minus', function (event) {

			var tipo  = $(this).parent().data('tipo');
			var id    = $(this).parent().data('id');
			var datos = 'accion=borrar&tipo=' + tipo + '&id=' + id;
			var boton = $(this);

			//Valida si existe algun campo en blanco
			if(!validarCampos(datos)){
				return false;
			}

			if (id == undefined) {
				$($(this).closest('tr')).remove();
				return;
			}

			$.post("ajaxPermisos.php", datos).done(function (data) {
				if (data['estado'] == 1) {
					$($(boton).closest('tr')).remove();
					$('.alert-success').show().delay(3000).fadeOut();
				} else {
					$('.alert-danger').show().delay(3000).fadeOut();
				}
			})

		});


		//Agregar o editar
		$('body').on('click', '.fa-save', function (event) {

			var tipo     = $(this).parent().data('tipo');
			var id       = $(this).parent().data('id');
			var datos    = 'accion=guardar&tipo=' + tipo;
			var boton    = $(this);
			var elemnttr = $(this).closest('tr');

			//Valida si existe algun campo en blanco
			if(!validarCampos(datos)){
				return false;
			}

			if (id !== undefined) {
				datos += '&id=' + id;
			} else {
				datos += '&id='
			}

			switch (tipo) {

				case 'grupos':

					//Grupos
					elemnttr.find('input').each(function (index) {
						var inpe = elemnttr.find('input')[index];
						var name = $(inpe).attr('name');
						var valu = $(inpe).val();
						datos += '&' + name + '=' + valu;
					});

					break;

				case 'permisos':

					//Permisos
					elemnttr.find('input').each(function (index) {
						var inpe = elemnttr.find('input')[index];
						var name = $(inpe).attr('name');
						var valu = $(inpe).val();
						datos += '&' + name + '=' + valu;
					});

					elemnttr.find('select').each(function (index) {
						var inpe = elemnttr.find('select')[index];
						var name = $(inpe).attr('name');
						var valu = $(inpe).val();
						datos += '&' + name + '=' + valu;
					});

					break;


				case 'usuarios':
					//Usuarios
					elemnttr.find('input').each(function (index) {
						var inpe = elemnttr.find('input')[index];
						var name = $(inpe).attr('name');
						var valu = $(inpe).val();
						datos += '&' + name + '=' + valu;
					});

					elemnttr.find('select').each(function (index) {
						var inpe = elemnttr.find('select')[index];
						var name = $(inpe).attr('name');
						var valu = $(inpe).val();
						datos += '&' + name + '=' + valu;
					});

					break;


				case 'membresias':
					//Membresias
					$(this).closest('tr').find('input').each(function (index) {
						var nombre = $(this).val();
					});
					break;
			}

			$.post("ajaxPermisos.php", datos).done(function (data) {
				if (data['estado'] == 1) {
					boton.closest('td').find('a').each(function (index) {
						$(this).attr("data-id", data['valor']);
					});
					$('.alert-success').show().delay(3000).fadeOut();
				} else {
					$('.alert-danger').show().delay(3000).fadeOut();
				}
			});
		})


		//Selector multiple para las membresias Grupos
		$( "#grupo_membresias" ).change(function () {
			var tipo  = $(this).data('tipo');
			var datos = 'accion=buscarUsuariosDelGrupo&' + $(this).attr('name') + '=' + $(this).val();

			//Valida si existe algun campo en blanco
			if(!validarCampos(datos)){
				return false;
			}

			$.post("ajaxPermisos.php", datos).done(function (data) {
				if (data['estado'] == 1) {
					if(data['valor'].length > 0){
						$(data['valor']).each(function (index, value) {
							$("input[name='" + value +"']").prop('checked', true);
						});
					}
				}
			});
		});


		//Selector multiple para las Membresias Usuarios
		$( "input:checkbox" ).change(function () {
			var tipo   = $(this).data('tipo');
			var grupo  = $('#grupo_membresias').val();
			var idusua = $(this).val();
			var esusua = $(this).is(':checked');
			var datos  = 'accion=grabarUsuariosDelGrupo&usuario='
						+ idusua + '&estado='  + esusua + '&grupo=' + grupo;

			$.post("ajaxPermisos.php", datos).done(function (data) {
				if (data['estado'] == 1) {
					$(data['valor']).each(function (index) {
						$('#usuarios_membresias option[value=' + data['valor'][index] + ']').attr('selected', true);
					});
				}
			});
		});

	})(jQuery);
</script>
</html>
