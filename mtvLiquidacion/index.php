<?php
 $ruta_raiz = "..";
 include "../conn.php";
?>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; 

?>
<body style="background-image: url(../img/login_background.jpeg);">

<div id=res name=res> </div>
<div STYLE="position:absolute; top:10px; right:500px;width:90%; background-image: url();" align=right>adfaf </div>
<!-- widget grid -->

      <div class="row" STYLE="position:absolute; top:20px; left:50px;width:90%;" >
        <div class="col-sm-12">
              <div class="input-group "    ><label class="col-md-2 control-label"></label></div>
              
              <div  style=""><span class="input-group-addon alert-success"><b>Simulación del calculo de la obligación VIP/VIS.</b><br><br>
              Decreto Distrital 327/2004&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              Decreto Nacional 075/2013<br>
              Resoluci&oacute;n Metrovivienda 117 del 22 de agosto de 2014.
              </span>
          </div>
        </div> 
    </DIV>
    
    <div class="row" STYLE="position:absolute; top:20px; left:70px; background-image: url('');" >
      <table >
       <tr><td><img src="../imagenes/logoFrmWeb.png" height=80></td></tr>
      </table>
    </div>

    <div class="row" STYLE="position:absolute; top:20px; left:50px;width:90%;" >
      <table width="100%">
       <tr><td><img src="../imagenes/logoFrmWeb2.png" height=80 align="right" ></td></tr>
      </table>
    </div>    

    
    <!-- row -->
	<div class="row" STYLE="position:absolute; top:100px; left:50px;width:90%;"  >
                
		<!-- NEW WIDGET START -->
		<article class="col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget " id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false">
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
				<!-- widget div-->
				<div  >

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
												<a href="#tab1" data-toggle="tab"> <span class="step">1</span> <span class="title">Liquidaci&oacute;n Predio</span> </a>
											</li>
											<li data-target="#step2">
												<a href="#tab2" data-toggle="tab"> <span class="step">2</span> <span class="title">Radicaci&oacute;n Solicitud</span> </a>
											</li>
											<li data-target="#step3">
												<a href="#tab3" data-toggle="tab"> <span class="step">3</span> <span class="title">A&ntilde;adir Documentos Requeridos</span> </a>
											</li>
											<li data-target="#step4">
												<a href="#tab4" data-toggle="tab"> <span class="step">4</span> <span class="title">Finalizar Transacci&oacute;n</span> </a>
											</li>
										</ul>
										<div class="clearfix"></div>
									</div>
									<div class="tab-content">
										<div class="tab-pane active" id="tab1">
											<br>
											<br>						
											
											 <div class="row">
                        <div class="col-sm-6">
                          <div class="form-group"><span class="input-group-addon">CHIP </span>            
                              <input class="form-control input-lg" placeholder="Ingrese el Chip Ej. AAA0000HJRX " type="text" name="chip" id="chip" onChange="calcularLiquidacion();" >
                          </div>
                        </div>
                        <div class="col-sm-6">
                          <div class="form-group"><span class="input-group-addon">AREA DE OBLIGACION VIS/VIP m<sup>2</sup><div id=areaTerreno></div></span>
                              
                              <input class="form-control input-lg" placeholder="Valor Area segun documento emitido por Curaduria" type="text" name="valA1" id="valA1" onChange="calcularLiquidacion();">

                          </div>
                        </div>
											</div>

                      <div class="row">
                         <div class="col-sm-6">
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >VALOR CATASTRAL DEL PREDIO 2014 m<sup>2</sup></span>
                               <input class="form-control input-lg" placeholder="" disabled type="text" name="valM2T" id="valM2T" >
                            </div>
                         </div>
                      
                            <div class="col-sm-6">
                                <div class="input-group"><label class="col-md-2 control-label"></label></div>
                                <div><span class="input-group-addon">PROMEDIO VALOR CATASTRAL 2014 m<sup>2</sup> </span>
                                <input class="form-control input-lg" placeholder="Valor de Referencia" disabled type="text" name="valorCatastralPromedio" id="valorCatastralPromedio">
                            </div>
                         </div>   

                      </div>											
											
											<div class="row">

											    <div class="col-sm-6">
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >AREA A TRASLADAR m<sup>2</sup></span>
                               <input class="form-control input-lg" placeholder="" disabled type="text" name="valorA2" id="valorA2" >
                            </div>
                         </div>
											   <div class="col-sm-6">
                                <div class="input-group"><label class="col-md-2 control-label"></label></div>
                                <div><span class="input-group-addon">PROMEDIO VALOR  COMERCIAL DE REFERENCIA 2014/m²</span>
                                <input class="form-control input-lg" placeholder="Valor de Referencia" disabled type="text" name="valRef" id="valRef">
                            </div>
                         </div>   

                      </div>   
                      
                      <div class="row">
                         <div class="col-sm-12">
                                <div class="input-group"><label class="col-md-2 control-label"></label></div>
                                <div><span class="input-group-addon alert-success">VALOR OBLIGACION</span>
                                <input class="form-control input-lg alert-success" placeholder="Valor Obligación" type="text" name="valorO" disabled id="valorO">
                            </div>
                         </div> 
                      </DIV>   
                      
                            <div class="row" >
        <div class="col-sm-12">
              <div class="input-group "    ><label class="col-md-2 control-label"></label></div>
              
              
        </div> 
    </DIV>
        
										</div>
										<div class="tab-pane" id="tab2">
											<br>
											<br>

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
                              <input class="form-control input-lg" placeholder="Direccion" type="text" name="address" id="address">

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
												
                      <h4><strong>Datos del Proyecto</strong> </h4>

                      
                        <div class="col-sm-4">
                          <div class="form-group">
                        
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Nombre del Proyecto</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pNombre" id="pNombre" >
                            </div>

                         </div>
                        </div>
                        
                        <div class="col-sm-4">
                          <div class="form-group">
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Constructora</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pConstructora" id="pConstructora" >
                            </div>
                          </div>
                        </div>
                        
                        <div class="col-sm-4">
                            <div class="form-group">
                            
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Representante Legal</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pRep" id="pRep" >
                            </div>
                          </div>
                        </div>
                        <h4><strong>Identificaci&oacute;n del predio</H4></STRONG>
                        <div class="col-sm-4">
                          <div class="form-group">
                        
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Direccion del Predio</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pDir" id="pDir" >
                            </div>

                         </div>
                        </div>
                        
                        <div class="col-sm-4">
                          <div class="form-group">
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >FMI</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pFMI" id="pFMI" >
                            </div>
                          </div>
                        </div>
                        
                        <div class="col-sm-4">
                            <div class="form-group">
                            
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >CHIP</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pChip" id="pChip" >
                            </div>
                          </div>
                        </div>
                        
                      <h4><strong>Datos Urbanisticos</H4></STRONG>
                        <div class="col-sm-4">
                          <div class="form-group">
                        
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Licencia / Expediente</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pLic1" id="pLic1" >
                            </div>

                         </div>
                        </div>
                        
                        <div class="col-sm-4">
                          <div class="form-group">
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Area Bruta</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pAreaB" id="pAreaB" >
                            </div>
                          </div>
                        </div>
                        
                        <div class="col-sm-4">
                            <div class="form-group">
                            
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >Area Util</span>
                               <input class="form-control input-lg" placeholder=""  type="text" name="pAreaU" id="pAreaU" >
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
																						<div class="alert alert-info fade in">
												<button class="close" data-dismiss="alert">
													×
												</button>
												<i class="fa-fw fa fa-info"></i>
												<strong>Documentos Requeridos para la liquidacion!</strong> Por favor adjunte los documentos de la lista.
											</div>
											
											
											
											<div class="form-group smart-form">
											
											
                      <label class="label">Seleccionar Certificado de Libertad y tradicion</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file1">
                      A&ntilde;adir Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>

                      <label class="label">Certificado Catastral</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file2">
                      A&ntilde;adir Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>
                                            
                      <label class="label">Certificado de Existencia y Representación Legal de la sociedad constructora titular de licencia</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file3">
                      A&ntilde;adir Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>

                      <label class="label">Cédula de Ciudadanía del Titular de la licencia (En caso de ser persona natural el titular de la licencia)</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file4">
                      A&ntilde;adir Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>
                      <label class="label">Certificación de la Curaduría Urbana en donde se indiquen las áreas del proyecto, el tipo de proyecto y se establezca la provisión de VIS o VIP.</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file5">
                      A&ntilde;adir Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>


                      <label class="label">Certificado Catastral</label>
                      <label class="input input-file" for="file">
                      <div class="button">
                      <input type="file" onchange="this.parentNode.nextSibling.value = this.value" name="file2">
                      A&ntilde;adir Archivo
                      </div>
                      <input type="text" readonly="" placeholder="">
                      </label>

										</div>
										</div>
										<div class="tab-pane" id="tab4">
											<br>
																						<br>
											<h1 class="text-center text-success"><strong><i class="fa fa-check fa-lg"></i> </strong></h1>
											<h4 class="text-center"></h4>
											<br>
											<br>
											              <div id=resultadoRad>
                      
                      </div>
											                      <div id=resultado>
                      
                      </div>
											<div id=resultadoR>
											<footer><center><input type=button onClick="radicarDocumento();" class="btn btn-lg btn-primary" value="Generar Solicitud" align="center"></footer>
											</div>

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
														               
														
														 
														<li class="next">
															<a href="javascript:void(0);" class="btn btn-lg txt-color-darken"> Siguiente </a>
														</li>
													</ul><br>
													<div class="text-alert"><span class="input-group-addon alert-success">
                            * En todo caso el valor definitivo será adoptado mediante resolución motivada 
                             tras la verificación de los soportes del traslado de la obligación urbanística.</span></div> 
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

<!-- end widget grid -->



<script type="text/javascript">
	function radicarDocumento(){
	          $.post("../tx/ajaxRadicarLiq.php", {"rads":"rads"}).done(
            function( data ) {
                $('#resultadoR').html(data);
               
            }
        );
	
	}
	
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
						required : false,
						minlength : 10
					},
					hphone : {
						required : false,
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
</body>
