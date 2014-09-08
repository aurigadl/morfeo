<?php
 $ruta_raiz = "..";
 include "../conn.php";
?>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; 

?>
<div class="row">
	<div class="col-xs-8 col-sm-7 col-md-7 col-lg-8">
		<h1 class="page-title txt-color-blueDark"><i class="fa fa-pencil-square-o fa-fw "></i> Formularios <span>>
			Radicaci&oacute;n de solicitud de traslado VIS / VIP</span></h1>
	</div>

</div>

<div id=res name=res> </div>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-sm-8 col-md-8 col-lg-8">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false">
				<!-- widget options:
				usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				data-widget-colorbutton="false"
				data-widget-editbutton="false"
				data-widget-togglebutton="false"
				data-widget-deletebutton="false"
				data-widget-fullscreenbutton="false"
				data-widget-custombutton="false"
				data-widget-collapsed="true"
				data-widget-sortable="false"

				-->
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2>Liquidacion valor de un proyecto </h2>

				</header>

				<!-- widget div-->
				<div >

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body ">

						<div class="row class ">
							<form id="wizard-1" novalidate="novalidate">
								<div id="bootstrap-wizard-1" class="col-sm-12">
									<div class="form-bootstrapWizard">
										<ul class="bootstrapWizard form-wizard">
											<li class="active" data-target="#step1">
												<a href="#tab1" data-toggle="tab"> <span class="step">1</span> <span class="title">Liquidacion Predio</span> </a>
											</li>
											<li data-target="#step2">
												<a href="#tab2" data-toggle="tab"> <span class="step">2</span> <span class="title">Radicacion Solicitud</span> </a>
											</li>
											<li data-target="#step3">
												<a href="#tab3" data-toggle="tab"> <span class="step">3</span> <span class="title">Adjuntar Documentos</span> </a>
											</li>
											<li data-target="#step4">
												<a href="#tab4" data-toggle="tab"> <span class="step">4</span> <span class="title">Finalizar Transaccion</span> </a>
											</li>
										</ul>
										<div class="clearfix"></div>
									</div>
									<div class="tab-content">
										<div class="tab-pane active" id="tab1">
											<br>
											<h3><strong>Paso 1 </strong> - Liquidacion</h3>

											<div class="row">
                         <div class="col-sm-12">
                          <div class="form-group">
                            <div class="input-group">
                              <span class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></span>
                              <input class="form-control input-lg" placeholder="Ingrese el CHIP " type="text" name="chip" id="chip" onChange="calcularLiquidacion();" >
                            </div>
                            </div>
                            <div class="input-group"></div><div>
                              <span class="input-group-addon">Area a Trasladar<div id=areaTerreno></div></span>
                              <input class="form-control input-lg" placeholder="Ingrese el Valor del Area a Trasladar" type="text" name="valA1" id="valA1" onChange="calcularLiquidacion();">
                            </div>
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                                <span class="input-group-addon">Valor de Referencia</span>
                                <input class="form-control input-lg" placeholder="Valor de Referencia" disabled type="text" name="valRef" id="valRef">
                            </div>
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Valor del Terreno en m<sup>2</sup></span>
                               <input class="form-control input-lg" placeholder="Valor del terreno en m<sup>2</sup>" disabled type="text" name="valM2T" id="valM2T" >
                            </div>
                            <div class="input-group"> </label></div><div>
                              <span class="input-group-addon">Valor Obligación</span>
                              <input class="form-control input-lg" placeholder="Valor Obligación" type="text" name="valorO" disabled id="valorO">
                            </div>
                                                </div>
											</div>

										</div>
										<div class="tab-pane" id="tab2">
											<br>
											<h3><strong>Paso 2</strong> - Radicacion</h3>

											<div class="row">
											
											                        <div class="col-sm-12">
                          <div class="form-group">
                            <div class="input-group">
                              <span class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></span>
                              <input class="form-control input-lg" placeholder="email@address.com" type="text" name="email" id="email">

                            </div>
                          </div>

                        </div>

                      </div>

                      <div class="row">
                        <div class="col-sm-6">
                          <div class="form-group">
                            <div class="input-group">
                              <span class="input-group-addon"><i class="fa fa-user fa-lg fa-fw"></i></span>
                              <input class="form-control input-lg" placeholder="Nombre Solicitante" type="text" name="fname" id="fname">

                            </div>
                          </div>
                        </div>
                        <div class="col-sm-6">
                          <div class="form-group">
                            <div class="input-group">
                              <span class="input-group-addon"><i class="fa fa-user fa-lg fa-fw"></i></span>
                              <input class="form-control input-lg" placeholder="Apellidos" type="text" name="lname" id="lname">

                            </div>
                          </div>
                        </div>
											
                                           
                        <div class="col-sm-12">
                          <div class="form-group">
                            <div class="input-group">
                              <span class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></span>
                              <input class="form-control input-lg" placeholder="Direccion" type="text" name="address" id="addrees">

                            </div>
                          </div>

                        </div>

                      	

                      	
												<div class="col-sm-4">
													<div class="form-group">
														<div class="input-group">
														
														
														
														
														
															<span class="input-group-addon"><i class="fa fa-flag fa-lg fa-fw"></i></span>
															<?php
															 $query = "Select dpto_nomb,dpto_codi from departamento where id_pais=170 order by dpto_nomb ";
															   $rs = $db->conn->query($query);

                                  $depselect = $rs->GetMenu2("coddepe",
                                    11,
                                    '0:-- Seleccione un Departamento--',
                                    false,
                                    false,
                                    "class='form-control input-lg' id=coddepe");
															 
															 echo $depselect;
															?>

														</div>
													</div>
												</div>
												<div class="col-sm-4">
													<div class="form-group">
														<div class="input-group">
															<span class="input-group-addon"><i class="fa fa-map-marker fa-lg fa-fw"></i></span>
															<select class="form-control input-lg" name="city">
																<option value="" selected="selected">Ciudad</option>
																<option value=1>Bogota</option>
															</select>
														</div>
													</div>
												</div>
												
											</div>
											<div class="row">
												<div class="col-sm-6">
													<div class="form-group">
														<div class="input-group">
															<span class="input-group-addon"><i class="fa fa-phone fa-lg fa-fw"></i></span>
															<input class="form-control input-lg" data-mask="(999) 999-9999" data-mask-placeholder= "X" placeholder="Numero Celular" type="text" name="wphone" id="wphone">
														</div>
													</div>
												</div>
												<div class="col-sm-6">
													<div class="form-group">
														<div class="input-group">
															<span class="input-group-addon"><i class="fa fa-mobile fa-lg fa-fw"></i></span>
															<input class="form-control input-lg" data-mask="(9) 9999999" data-mask-placeholder= "X" placeholder="Numero Fijo" type="text" name="hphone" id="hphone">
														</div>
													</div>
												</div>
												<div class="smart-form">
                        <div class="col-sm-6">
                          <div class="form-group">
                            <div class="input-group">
                              <label class="checkbox">
                              <input type="checkbox" checked="checked" name="checkbox">
                              <i></i>
                              Acepto notificaci&oacute;n y envio de copia por correo electr&oacute;nico.
                              </label>
                            </div>
                          </div>
                        </div>
                        </div>
											</div>
										</div>
										<div class="tab-pane" id="tab3">
											<br>
											<h3><strong>Step 3</strong> - Documentacion requerida</h3>
											<div class="alert alert-info fade in">
												<button class="close" data-dismiss="alert">
													×
												</button>
												<i class="fa-fw fa fa-info"></i>
												<strong>Documentos Requeridos para la liquidacion!</strong> Por favor adjunte los documentos de la lista.
											</div>
											
											
											
											<div class="form-group smart-form">
											
											
                      <label class="label">Seleccionar Certificado de Libertar y tradicion</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file1">
                      Escoger Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>

                      <label class="label">Certificado Catastral</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file2">
                      Escoger Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>
                                            
                      <label class="label">Certificado de Existencia y Representación Legal de la sociedad constructora titular de licencia</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file3">
                      Escoger Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>

                      <label class="label">Cédula de Ciudadanía del Titular de la licencia (En caso de ser persona natural el titular de la licencia)</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file4">
                      Escoger Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>
                      <label class="label">Certificación de la Curaduría Urbana en donde se indiquen las áreas del proyecto, el tipo de proyecto y se establezca la provisión de VIS o VIP.</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file5">
                      Escoger Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>


                      <label class="label">Certificado Catastral</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file2">
                      Escoger Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>

										</div>
										</div>
										<div class="tab-pane" id="tab4">
											<br>
											<h3><strong>Paso 4</strong> - Finalizar Liquidación</h3>
											<br>
											<h1 class="text-center text-success"><strong><i class="fa fa-check fa-lg"></i> Se ha completado la solicitud</strong></h1>
											<h4 class="text-center">Descargue aqui el documento de radicacion No. 2014900000000002</h4>
											<br>
											<br>
											<div id=resultado> </div>
										</div>

										<div class="form-actions">
											<div class="row">
												<div class="col-sm-12">
													<ul class="pager wizard no-margin">
														<!--<li class="previous first disabled">
														<a href="javascript:void(0);" class="btn btn-lg btn-default"> First </a>
														</li>-->
														<li class="previous disabled">
															<a href="javascript:void(0);" class="btn btn-lg btn-default"> Anterior </a>
														</li>
														<!--<li class="next last">
														<a href="javascript:void(0);" class="btn btn-lg btn-primary"> Last </a>
														</li>-->
														<li class="next">
															<a href="javascript:void(0);" class="btn btn-lg txt-color-darken"> Siguiente </a>
														</li>
													</ul>
												</div>
											</div>
										</div>

									</div>
								</div>
							</form>
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
	/* DO NOT REMOVE : GLOBAL FUNCTIONS!
	 *
	 * pageSetUp(); WILL CALL THE FOLLOWING FUNCTIONS
	 *
	 * // activate tooltips
	 * $("[rel=tooltip]").tooltip();
	 *
	 * // activate popovers
	 * $("[rel=popover]").popover();
	 *
	 * // activate popovers with hover states
	 * $("[rel=popover-hover]").popover({ trigger: "hover" });
	 *
	 * // activate inline charts
	 * runAllCharts();
	 *
	 * // setup widgets
	 * setup_widgets_desktop();
	 *
	 * // run form elements
	 * runAllForms();
	 *
	 ********************************
	 *
	 * pageSetUp() is needed whenever you load a page.
	 * It initializes and checks for all basic elements of the page
	 * and makes rendering easier.
	 *
	 */

	pageSetUp();

	// PAGE RELATED SCRIPTS

	// pagefunction
	
	function calcularLiquidacion(){
	 var chip;
	 //alert("Calculando Liquidacion");
	 chip = $("#chip").val();
	 valA1 = $("#valA1").val();
	 $.post("../tx/ajaxCalculoLiqMtv.php", {"chip":chip,"valA1":valA1}).done(
            function( data ) {
                $('#res').html(data);
            }
        );
	 
	}

	var pagefunction = function() {

		// load bootstrap wizard
		
		loadScript("<?=$ruta_raiz?>/js/plugin/bootstrap-wizard/jquery.bootstrap.wizard.min.js", runBootstrapWizard);

		//Bootstrap Wizard Validations

		function runBootstrapWizard() {

			var $validator = $("#wizard-1").validate({

				rules : {
					email : {
						required : true,
						email : "Su  email debera tener un formato como name@domain.com"
					},
					fname : {
						required : true
					},
					lname : {
						required : true
					},
					country : {
						required : true
					},
					city : {
						required : true
					},
					postal : {
						required : true,
						minlength : 4
					},
					wphone : {
						required : true,
						minlength : 10
					},
					hphone : {
						required : true,
						minlength : 10
					}
				},

				messages : {
					fname : "Especifique su Nombre",
					lname : "Especifique su Apellido",
					email : {
						required : "Se requiere su  email",
						email : "el correo debe tener un formato como : name@domain.com"
					}
				},

				highlight : function(element) {
					$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
				},
				unhighlight : function(element) {
					$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
				},
				errorElement : 'span',
				errorClass : 'help-block',
				errorPlacement : function(error, element) {
					if (element.parent('.input-group').length) {
						error.insertAfter(element.parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

			$('#bootstrap-wizard-1').bootstrapWizard({

				'tabClass' : 'form-wizard',
				'onNext' : function(tab, navigation, index) {
					var $valid = $("#wizard-1").valid();
					if (!$valid) {
						$validator.focusInvalid();
						return false;
					} else {
						$('#bootstrap-wizard-1').find('.form-wizard').children('li').eq(index - 1).addClass('complete');
						$('#bootstrap-wizard-1').find('.form-wizard').children('li').eq(index - 1).find('.step').html('<i class="fa fa-check"></i>');
					}
				}
			});

		};

		// load fuelux wizard
		
		loadScript("<?=$ruta_raiz?>/js/plugin/fuelux/wizard/wizard.min.js", fueluxWizard);
		
		function fueluxWizard() {

			var wizard = $('.wizard').wizard();

			wizard.on('finished', function(e, data) {
				//$("#fuelux-wizard").submit();
				//console.log("submitted!");
				$.smallBox({
					title : "Formulario ha sido completado correctamente.",
					content : "<i class='fa fa-clock-o'></i><i>1 seconds ago...</i>",
					color : "#5F895F",
					iconSmall : "fa fa-check bounce animated",
					timeout : 4000
				});

			});

		};

	};

	// end pagefunction
	
	// Load bootstrap wizard dependency then run pagefunction
	pagefunction();

</script>