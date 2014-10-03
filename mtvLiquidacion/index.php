<?php
// Inicializar la sesión.
// Si está usando session_name("algo"), ¡no lo olvide ahora!
session_start();

// Destruir todas las variables de sesión.
$_SESSION = array();

// Si se desea destruir la sesión completamente, borre también la cookie de sesión.
// Nota: ¡Esto destruirá la sesión, y no la información de la sesión!
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Finalmente, destruir la sesión.
session_destroy();
 $ruta_raiz = "..";
 include "../conn.php";
?>
<HTML>
<HEADER>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; 
?>
</HEADER>
<body style="background-image: url(../img/login_background.jpeg); background-repeat: repeat; height: 900px;">

<div id=res name=res> </div>
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
												<a href="#tab1" data-toggle="tab"> <span class="step">1</span> <span class="title">Simulaci&oacute;n</span> </a>
											</li>
											<li data-target="#step2">
												<a href="#tab2" data-toggle="tab"> <span class="step">2</span> <span class="title">Radicaci&oacute;n Solicitud</span> </a>
											</li>
											<li data-target="#step3">
												<a href="#tab3" data-toggle="tab"> <span class="step">3</span> <span class="title">A&ntilde;adir Documentos Requeridos</span> </a>
											</li>
											<li data-target="#step4">
												<a href="#tab4" data-toggle="tab"> <span class="step">4</span> <span class="title">Finalizar la simulaci&oacute;n</span> </a>
											</li>
										</ul>
										<div class="clearfix"></div>
									</div>
									<br>
									<div class="tab-content">
										<div class="tab-pane active" id="tab1">
											 <div class="row">
                        <div class="col-sm-6">
                          <div class="form-group"><span class="input-group-addon">CHIP </span>            
                              <input class="form-control input-lg" placeholder="Ingrese Los  Chip Ej. AAA000ZHRX " type="text" name="chip" id="chip" onChange="calcularLiquidacion();" >
                          </div>
                        </div>
                        <div class="col-sm-6">
                          <div class="form-group"><span class="input-group-addon">AREA DE OBLIGACION VIS/VIP m<sup>2</sup><div id=areaTerreno></div></span>
                              <input class="form-control input-lg" placeholder="Valor Area segun documento emitido por Curaduria" type="text" name="valA1" id="valA1" onChange="calcularLiquidacion();">                          </div>
                        </div>
											</div>
                      <div class="row">
                         <div class="col-sm-6">
                            <div class="input-group"><label class="col-md-2 control-label"></label></div><div>
                               <span class="input-group-addon" >VALOR CATASTRAL DEL m<sup>2</sup> EN EL PREDIO 2014 </span>
                               <input class="form-control input-lg" placeholder="" disabled type="text" name="valM2T" id="valM2T" >
                            </div>
                         </div>
                      
                            <div class="col-sm-6">
                                <div class="input-group"><label class="col-md-2 control-label"></label></div>
                                <div><span class="input-group-addon">PROMEDIO VALOR CATASTRAL 2014 m<sup>2</sup> </span>
                                <input class="form-control input-lg" placeholder="Valor de Referencia catastral /m²" disabled type="text" name="valorCatastralPromedio" id="valorCatastralPromedio">
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
                                <div><span class="input-group-addon">PROMEDIO VALOR  COMERCIAL DE REFERENCIA </span>
                                <input class="form-control input-lg" placeholder="Valor comercial de Referencia /m²" disabled type="text" name="valRef" id="valRef">
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
                      
                      <div id=chips>
                      </div>
                      
      <div class="row" >
        <div class="col-sm-12">
        <div class="input-group "    ><label class="col-md-2 control-label"></label></div>
     </div> 
        
    </DIV>
     <CENTER>
     <input type=button class="btn btn-lg txt-color-darken" value="Imprimir Simulaci&oacute;n" onClick="window.open('simuPrint.php','SimuPrin<?=date("ymdhis")?>')">
            </CENTER>             
        
										</div>
										<div class="tab-pane" id="tab2">
											<br>
											<br>

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
                              <span class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></span>
                              <input class="form-control input-lg" placeholder="email@address.com" type="text" name="email" id="email">

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
                                    "class='form-control input-lg' id=codDpto onChange='getArrayMuni();'");
															 
															 echo $depselect;
															?>

														</div>
													</div>
												</div>
												<div class="col-sm-4">
													<div class="form-group">
														<div class="input-group">
															<span class="input-group-addon"><i class="fa fa-map-marker fa-lg fa-fw"></i></span>
															<select class="form-control input-lg" name="city" id="city">
																
																<option value=1>Bogota</option>
															</select>
														</div>
													</div>
												</div>
												
												<div class="col-sm-4">
													<div class="form-group">
														<div class="input-group">
															<span class="input-group-addon"><i class="fa fa-phone fa-lg fa-fw"></i></span>
															<input class="form-control input-lg" data-mask-placeholder= "X" placeholder="Numeros de Telefono" type="text" name="wphone" id="wphone">
														</div>
													</div>
												</div>
												
                      &nbsp;&nbsp;<H4>Datos del Proyecto</H4>

                      
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
                               <span class="input-group-addon" >Urbanizador / Constructor / Patrimonio Aut&oacute;nomo</span>
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
                        
                        <!--
                        &nbsp;&nbsp;<H4>Identificaci&oacute;n del predio</H4>
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
                        
                      &nbsp;&nbsp;<H4>Datos Urbanisticos</H4>
                      
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
                        -->
												<div class="smart-form">
                        <div class="col-sm-6">
                          <div class="form-group">
                            <div class="input-group">
                              <label class="checkbox">
                              <input type="checkbox" checked="checked" name="checkbox">
                              <i></i>
                              &nbsp;&nbsp;Acepto notificaci&oacute;n y envio de copia por correo electr&oacute;nico.
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
											
											Certificado de Tradición y Libertad.
											
											<label class="label"><div class="form-group smart-form" id=""></label>
											
											
                      
                      <?php
                        $norandom = "file1";
                        
                        echo("
                        <div $addAttr id='$norandom'>A&ntilde;dir Archivos  <input  type='HIDDEN' value='' id='inp_$norandom'  /> 
                        <input type=hidden id=nFile1>
                        
                              ");
                        $scriptJS .= "
                                    var uploaderId = '$norandom';
                                    $('#$norandom').uploadFile({
                                        url:'./server.php?tx=2',
                                        fileName:'fileFormDinamic',
                                        multiple:false,
                                        dragDrop: false,
                                        showFileCounter: false,
                                        onSuccess:function(files,data,xhr){
                                            $('#inp_$norandom').val(JSON.parse(data)[0]);
                                            // alert ('Subido Ok'+ files + 'data' + data + ' xhr '+ xhr);
                                            $('#nFile1').val('files');
                                              
                                        }
                                    });
                                ";
                        echo "</div>";
                      ?>

                      <label class="label">Certificado Catastral vigente</label>
                      <?php
                        $norandom = "file2";
                        
                        echo("<div  id='$norandom'>A&ntilde;adir Archivos</div>
                              <input class='input input-file'  type='HIDDEN' value='' id='inp_$norandom'  />");
                        $scriptJS .= "
                                    var uploaderId = '$norandom';
                                    $('#$norandom').uploadFile({
                                        url:'./server.php?tx=2',
                                        fileName:'fileFormDinamic',
                                        multiple:false,
                                        dragDrop: false,
                                        showFileCounter: false,                                        
                                        onSuccess:function(files,data,xhr){
                                            $('#inp_$norandom').val(JSON.parse(data)[0]);
                                        }
                                    });
                                ";
                      ?>
                                            
                      <label class="label">Certificado de Existencia y Representación <br> (En caso de ser Persona juridica el titular de la licencia)</label>
                      <?php
                        $norandom = "file3";
                        
                        echo("<div $addAttr id='$norandom'>A&ntilde;adir Archivos</div>
                              <input  type='HIDDEN' value='' id='inp_$norandom'  />");
                        $scriptJS .= "
                                    var uploaderId = '$norandom';
                                    $('#$norandom').uploadFile({
                                        url:'./server.php?tx=2',
                                        fileName:'fileFormDinamic',
                                        multiple:false,
                                        delete:true,
                                        dragDrop: false,
                                        showFileCounter: false,                                        
                                        onSuccess:function(files,data,xhr){
                                            $('#inp_$norandom').val(JSON.parse(data)[0]);
                                        }
                                    });
                                ";
                      ?>

                      <label class="label">Cédula de Ciudadanía del Titular de la licencia (En caso de ser persona natural el titular de la licencia)</label>
                      <?php
                        $norandom = "file4";
                        
                        echo("<div $addAttr id='$norandom'>A&ntilde;adir Archivos</div>
                              <input  type='HIDDEN' value='' id='inp_$norandom'  />");
                        $scriptJS .= "
                                    var uploaderId = '$norandom';
                                    $('#$norandom').uploadFile({
                                        url:'./server.php?tx=2',
                                        fileName:'fileFormDinamic',
                                        multiple:false,
                                        dragDrop: false,
                                        showFileCounter: false,                                        
                                        onSuccess:function(files,data,xhr){
                                            $('#inp_$norandom').val(JSON.parse(data)[0]);
                                        }
                                    });
                                ";
                      ?>
                      <label class="label">Certificación de la Curaduría Urbana en donde se indiquen las áreas del proyecto, el tipo de proyecto y se establezca la provisión de VIS o VIP.</label>
<?php
                        $norandom = "file5";
                        
                        echo("<div $addAttr id='$norandom'>A&ntilde;adir Archivos</div>
                              <input  type='HIDDEN' value='' id='inp_$norandom'  />");
                        $scriptJS .= "
                                    var uploaderId = '$norandom';
                                    $('#$norandom').uploadFile({
                                        url:'./server.php?tx=2',
                                        fileName:'fileFormDinamic',
                                        multiple:false,
                                        dragDrop: false,
                                        showFileCounter: false,                                        
                                        onSuccess:function(files,data,xhr){
                                            $('#inp_$norandom').val(JSON.parse(data)[0]);
                                        }
                                    });
                                ";
                      ?>


                      <label class="label">        Poder (en caso de ser autorizado a realizar tramites ante Metrovivienda).</label>   
                      <?php
                        $norandom = "file6";
                        
                        echo("<div $addAttr id='$norandom'>A&ntilde;adir Archivos</div>
                              <input  type='HIDDEN' value='' id='inp_$norandom'  />");
                        $scriptJS .= "
                                    var uploaderId = '$norandom';
                                    $('#$norandom').uploadFile({
                                        url:'./server.php?tx=2',
                                        fileName:'fileFormDinamic',
                                        multiple:false,
                                        dragDrop: false,
                                        showFileCounter: false,                                        
                                        onSuccess:function(files,data,xhr){
                                            $('#inp_$norandom').val(JSON.parse(data)[0]);
                                        }
                                    });
                                ";
                      ?>
                  
                    
                    
										</div>
										<div class="alert alert-warning fade in">
<button class="close" data-dismiss="alert"> × </button>
<i class="fa-fw fa fa-warning"></i>
<strong>Nota.</strong>
¡Página en prueba, aun no puedes cargar los archivos!
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
                      <br><br><br>
                      <div id=resultado>
                      </div>
											<div id=resultadoR>
											<footer><center><input type=button onClick="radicarDocumento();" class="btn btn-lg btn-primary" value="Generar Solicitud" align="center"></footer>
										
										
										</div>
										<div id=resultadoRTmp>
                      <footer><center><input type=button onClick="radicarDocumento();" class="btn btn-lg btn-primary" value="Generar Solicitud" align="center"></footer>
                    </div>
                    <div class="alert alert-warning fade in">
<button class="close" data-dismiss="alert"> × </button>
<i class="fa-fw fa fa-warning"></i>
<strong>Nota.</strong>
La generación de este radicado es temporal, si desea radicar su solicitud acérquese a Metrovivienda.
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
	  radData = $('#resultado').html();
	    sEmail = $("#email").val();
      sFname = $("#fname").val();
      sAddress = $("#address").val();
      sCodDpto = $("#codDpto").val();
      sCodMuni = $("#city").val();
      sNomDpto = "";
      sPhone1 = $("#wPhone").val();
      pName = $("#pName").val();
      pNombre = $("#pNombre").val();
      pRep = $("#pRep").val();
      pConstructora = $("#pConstructora").val();
      valA1 = $("#valA1").val();
      valA2 = $("#valorA2").val();
      valM2T = $("#valM2T").val();
      valorO = $("#valorO").val();
      valorCatastralPromedio = $("#valorCatastralPromedio").val();
      valRef = $("#valRef").val();
      f1 = $("#inp_file1").val();
      f2 = $("#inp_file2").val();
      f3 = $("#inp_file3").val();
      f4 = $("#inp_file4").val();
      f5 = $("#inp_file5").val();
      f6 = $("#inp_file6").val();
      $.post("../tx/ajaxRadicarLiq.php", {"valA1":valA1,"valA2":valA2,"valorO":valorO,"valM2T":valM2T,"valorCatastralPromedio":valorCatastralPromedio,"valRef":valRef, "sEmail":sEmail, "sFname":sFname, "sAddress":sAddress, "sCodDpto":sCodDpto, "sCodMuni":sCodMuni, "sPhone1":sPhone1,"pRep":pRep, "pNombre":pNombre, "pName":pName, "fname":sFname, "pConstructora":pConstructora, "f1":f1, "f2":f2, "f3":f3, "f4":f4, "f5":f5, "f6":f6}).done(
            function( data ) {
                $('#resultadoR').html(data);
            }
        );
	
	}
	
	/* DO NOT REMOVE : GLOBAL FUNCTIONS!
	 *  $.post("../tx/ajaxRadicarLiq.php", {"valA1":valA1,"valA2":valA2,"valorO":valorO,"valM2T":valM2T,"valorCatastralPromedio":valorCatastralPromedio,"valRef":valRef, "sEmail":sEmail, "sFname":sFname, "sAddress":sAddress,"sNomDpto":sNomDpto, "sCodMuni":sNomMuni, "sCodDpto":sCodDpto, "sCodMuni":sCodMuni, "sPhone1":sPhone1,"pRep":pRep, "pNombre":pNombre, "pName":pName, "fname":sFname, "pConstructora":pConstructora, "pDir":pDir, "pLic1":pLic1, "f1":f1, "f2":f2, "f3":f3, "f4":f4, "f5":f5, "f6":f6}).done(
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
   idCity = $("#city").val();
	 
	 $.post("../tx/ajaxCalculoLiqMtv.php", {"chip":chip,"valA1":valA1}).done(
            function( data ) {
                $('#res').html(data);
            }
        );
	 
	}
	
	
    function getArrayMuni(){
   var dptoCodi;
   var idCont = 1;
   var idPais = 170;
   //alert("Calculando Liquidacion");
   dptoCodi = $("#codDpto").val();
   

   
   $.post("../tx/ajaxMunicipios.php", {"dptoCodi":dptoCodi,"idPais":idPais,"idCont":idCont,"selectIdMuni":"city"}).done(
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
					address : {
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
					timeout : 8000
				});

			});

		};

	};

	// end pagefunction
	
	// Load bootstrap wizard dependency then run pagefunction
	pagefunction();

	<?=$scriptJS?>
	
	
    // Muestra las imagenes de los radicados
    function funlinkArchivo(numrad, rutaRaiz){
        var nombreventana = "linkVistArch";
        var url           = "../linkArchivo.php?<? echo session_name()."=".session_id()?>"+"&numrad="+numrad;
        var ventana       = window.open(url,nombreventana,'scrollbars=1,height=50,width=250');
        //setTimeout(nombreventana.close, 70);
        //return;
    }
</script>
</body>
</HTML>