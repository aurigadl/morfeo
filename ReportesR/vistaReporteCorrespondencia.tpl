<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Entrega de Documentos</title>
{LIBS}
<link rel="stylesheet" type="text/css" href="{RUTA_RAIZ}js/spiffyCal/spiffyCal_v2_1.css" />
<script  type="text/javascript" language="JavaScript" src="{RUTA_RAIZ}js/spiffyCal/spiffyCal_v2_1.js"></script>
<script  type="text/javascript" language="javascript">
   setRutaRaiz('{RUTA_RAIZ}');
  var dateAvailable = new ctlSpiffyCalendarBox("dateAvailable", "generaPlanillaEntrega", "fecha_busq","btnDate1","{FECHA_BUS}",scBTNMODE_CUSTOMBLUE);
  var dateAvailable2 = new ctlSpiffyCalendarBox("dateAvailable2", "generaPlanillaEntrega", "fecha_fin","btnDate1","{FECHA_BUS_FIN}",scBTNMODE_CUSTOMBLUE);

function validar(action){
  if(action!=2){
    document.generaPlanillaEntrega.action = "?";
   }else{
    document.generaPlanillaEntrega.action = "?generarPlanilla=1";
   }
  document.generaPlanillaEntrega.submit();
}

function rightTrim(sString){
  while (sString.substring(sString.length-1, sString.length) == ' '){
    sString = sString.substring(0,sString.length-1);
  }
	return sString;
}

function solonumeros(){
  jh =  document.getElementById('no_planilla');
	if(rightTrim(jh.value) == "" || isNaN(jh.value)){
	  alert('S\u00F3lo introduzca n\u00FAmeros.' );
		jh.value = "";
		jh.focus();
 		return false;
	}else{
	  document.new_product.submit();
	}
}
</script>
</head>
<body>
<form name="generaPlanillaEntrega"  id ="generaPlanillaEntrega" action='' method="post">
    <div class="col-sm-12">
      <!-- widget grid -->
      <h2></h2>
      <section id="widget-grid">
        <!-- row -->
        <div class="row">
          <!-- NEW WIDGET START -->
          <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">

              <header>
                <h2>
                  Generacion planillas de reasignacion de documentos
                </h2>
              </header>
              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body no-padding">
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <tr>
                        <td width="125" height="21"  class="titulos2"> Fecha Desde<br>
                      <?php  echo "(".date("Y-m-d").")"; ?>
                      </td>
                        <td width="225" align="right" valign="top" class="listado2">
                        <script language="javascript">
                                dateAvailable.date = "2003-08-05";
                              dateAvailable.writeControl();
                              dateAvailable.dateFormat="yyyy-MM-dd";
                            </script>
                        {HORA_SELECT_INI}:{MINUTOS_SELECT_INI}
                      </td>
                      </tr>
                    <tr>
                        <td height="26" class='titulos2'>Fecha Hasta</td>
                        <td valign="top" class='listado2'>
                      <script language="javascript">
                                dateAvailable2.date = "2003-08-05";
                              dateAvailable2.writeControl();
                              dateAvailable2.dateFormat="yyyy-MM-dd";
                            </script>
                      {HORA_SELECT_FIN}:{MINUTOS_SELECT_FIN}</td>
                      </tr>
                      <tr>
                        <td height="26" class='titulos2'>Tipo de Radicado </td>
                        <td valign="top" align="left" class='listado2'>{TIPO_RADICADO}</td>
                      </tr>
                    <tr>
                        <td height="26" class='titulos2'>Dependencia Destino </td>
                        <td valign="top" align="left" class='listado2'>{DEPENDENCIAS}</td>
                          </tr>
                          <tr>
                          <td height="26" class='titulos2'>Dependencia Origen </td>
                          <td valing="top" align="left" class='listado2'>{DEPENDENCIA}</td>
                          </tr>
                      <tr>
                        <td height="26" colspan="2" valign="top" class='titulos2'>
                        <center>
                          <input type='button' name='generarPlanilla' Value=' GenerarPlanilla ' class='botones_largo' onClick="validar(2);">
                        </center>
                        </td>
                      </tr>
                    </table>
                  </div>

                  <div id="spiffycalendar" class="text"></div>
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                    <tbody>
                      <tr>
                        <td>
                          <legend>{EXPORTAR_FILES}</legend>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tbody>
                      <tr>
                        <td>
                          <legend>{RESULTADOS}</legend>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </article>
      </div>
    </section>
  </div>
</form>
</body>
</html>
