<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
Copyright (C) 2013 Infometrika Ltda.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
  session_start();

  $ruta_raiz = "..";
  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

  foreach ($_GET  as $key => $valor) ${$key} = $valor;
  foreach ($_POST as $key => $valor) ${$key} = $valor;

  /**  Fin variables de session de Radicacion de Mail. **/
  include_once("$ruta_raiz/include/db/ConnectionHandler.php");
  $db     = new ConnectionHandler("$ruta_raiz");

  $ddate       = date('d');
  $mdate       = date('m');
  $adate       = date('Y');
  $nurad       = trim($nurad);
  $hora        = date('H:i:s');
  $fechaf      = $date.$mdate.$adate.$hora;
  $dependencia = $_SESSION["dependencia"];
  $ADODB_COUNTRECS = true;

  if(!$fecha_gen_doc || $fecha_gen_doc=='//'){
    $fecha_busq = date("d-m-Y");
    $fecha_gen_doc = $fecha_busq;
  }

  $coddepe  = $dependencia;

  $query    = "SELECT ".
              $db->conn->Concat( "d.DEPE_CODI", "'-'", "d.DEPE_NOMB" ).", d.DEPE_CODI
            FROM
              DEPENDENCIA d
              INNER JOIN usuario u ON u.depe_codi = d.depe_codi
              and u.usua_codi   = 1
              and u.usua_esta   ='1'
              and d.depe_estado = 1
            ORDER BY d.DEPE_CODI, d.DEPE_NOMB";

  $rs        = $db->conn->query($query);
  $depselect = $rs->GetMenu2("coddepe",
                              $coddepe,
                              "0:-- Seleccione una Dependencia --",
                              false,
                              false,
                              "class='select'");

  $query    = "SELECT
                MREC_DESC, MREC_CODI
               FROM MEDIO_RECEPCION WHERE MREC_CODI <> 0 ";

  $rs       = $db->conn->query($query);

  $medioRec = $rs->GetMenu2("med",
                            $med,
                            "",
                            false,
                            "",
                            "class='select'" );

  $query = "SELECT
              SGD_TPR_DESCRIP
              ,SGD_TPR_CODIGO
            FROM
              SGD_TPR_TPDCUMENTO
            WHERE
              SGD_TPR_TP$ent     ='1'
              and SGD_TPR_RADICA ='1'
              ORDER BY SGD_TPR_DESCRIP ";

  $opcMenu  = "0:-- Seleccione un tipo --";
  $fechaHoy = date("Y-m-d");
  $fechaHoy = $fechaHoy . "";
  $rs       = $db->conn->query($query);
  $tipoDoc  = $rs->GetMenu2("tdoc",
                            $tdoc,
                            "$opcMenu",
                            false,
                            "",
                            "class='ecajasfecha'");


?>
<html>
  <head>
  <?php include_once("$ruta_raiz/htmlheader.inc.php") ?>
</head>

<body>

<form action='NEW.php' method="post" name="formulario" id="formulario">
  <div id="content" style="opacity: 1;">
    <div class="row">
      <div class="col-lg-3">
          <h1 class="page-title txt-color-blueDark">
              Modulo de radicacion
              <?=$tRadicacionDesc?>
              (Dep <?=$dependencia?>)
              <p><small><?=$encabezado?></small></p>
            </h1>
      </div>

      <div class="col-lg-8 smart-form">

          <section class="col col-2">
            <label class="label">
              DD / MM / AAAA
            </label>
            <h3><?=$ddate?> / <?=$mdate?> / <?=$adate?>
            </h3>
          </section>


          <section class="col col-2">
            <label class="label">
              Referencia
            </label>
            <label class="input">
              <input name="cuentai" type="text"  maxlength="20" value='<?php echo $cuentai; ?>' >
            </label>
          </section>

          <section class="col col-2">
              <label class="label">
                Guia
              </label>
              <label class="input">
                <input type=text name='guia'name='id' value='<?=$guia ?>' <?=$bloqEdicion?>  size=35>
              </label>
          </section>

          <section class="col col-2">
            <label class="label">
              Fecha Doc. dd/mm/aaaa
            </label>
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
              <input type="text" id="fecha_gen_doc"  name="fecha_gen_doc" placeholder="Fecah de radicacion" value="<?=$fecha_gen_doc ?>">
            </label>
          </section>
        </div>

        <div class="col-lg-1">
              <a data-toggle="modal" id="radicarNuevo" name='Submit3' value='Radicar'  class="btn btn-primary btn-lg pull-right header-btn"><i class="fa fa-circle-arrow-up fa-lg"></i>Radicar documento</a>
        </div>

     </div>

     <div id="alertmessage"></div>

        <section id="widget-grid">

          <!-- row -->
          <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-lg-12">

              <div data-widget-editbutton="false" id="wid-id-0" class="jarviswidget jarviswidget-sortable" style="" role="widget">

                  <!-- widget content -->
                  <div class="col col-12">

                      <section id="formsearch" class="form-inline smart-form">

                        <section  class="col col-2">
                          <label class="select">
                            <select id="tipo_usuario" class="form-control input-sm">
                              <option value='0'>Usuario     </option>
                              <option value='2'>Empresas    </option>
                              <option value='6'>Funcionarios</option>
                            </select>
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <input type=text id='documento_us' class="required alphanumeric" placeholder="Documento">
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <INPUT type=text id='nombre_us' value="" placeholder="Nombre">
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <input type=text id='telefono_us' value="" placeholder="Tel&eacute;fono">
                          </label>
                        </section>

                        <section class="col col-2">
                          <label class="input">
                            <i class="icon-prepend fa fa-search"></i>
                            <INPUT type=text id='mail_us' value="" placeholder="Correo Electronico">
                          </label>
                        </section>

                        <button type="button" name="Button" value="Crear" class="btn btn-success btn-sm pull-right">
                          Crear
                        </button>

                      </section>

                      <!--Muestra Resultados de la busqueda-->
                      <section id="showAnswer" class="col-lg-12 hide well">
                        <ul id="resBusqueda" class="inbox-download-list"> </ul>
                      </section>

                    </div>
                    <section id="tableSection" class="well col-lg-12 hide">
                      <table class="table table-bordered">
                        <thead>
                          <tr>
                            <th></th>
                            <th>Documento</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Telefono</th>
                            <th>Direcci&oacute;n</th>
                            <th>Correo Electronico</th>
                            <th>Ubicaci&oacute;n</th>
                            <th>Pais</th>
                          </tr>
                        </thead>
                        <tbody id="tableshow"> </tbody>
                    </table>
                  </section>
              </div>
            </article>
            <!-- WIDGET END -->
          </div>
        </section>

        <div class="col-lg-12"> </div>

        <div class="well">
          <section class="smart-form">
            <div class="row">
              <section class="col col-6">
                <label class="label">
                  Asunto
                </label>
                <label class="textarea">
                  <textarea id="asu" name="asu" cols="70"  rows="2" ><?=$asu?></textarea>
                </label>
              </section>

              <section class="col col-6">
                  <label class="label">
                    Medio Recepci&oacute;n
                  </label>
                  <label class="select">
                    <?=$medioRec?>
                  </label>
              </section>
            </div>

            <div class="row">

              <section class="col col-2">
                  <label class="label">
                    No. Folios
                  </label>
                  <label class="input">
                    <input name="nofolios" id="nofolios" type="text" size="10"  value="">
                  </label>
              </section>
              <section class="col col-2">
                  <label class="label">
                    No. Anexos
                  </label>
                  <label class="input">
                    <input name="noanexos" id="noanexos" type="text" size="10" value="">
                  </label>
              </section>
              <section class="col col-2">
                  <label class="label">
                    Descripci&oacute; Anexos
                  </label>
                  <label class="input">
                      <input name="ane" id="ane" type="text" size="70"  value="">
                  </label>
              </section>

              <section class="col col-3">
                  <label class="label">
                    Dependencia
                  </label>
                  <label class="select">
                    <?=$depselect?>
                  </label>
              </section>

              <section class="col col-3">
                <label class="label">
                  Tipo Documental
                </label>
                <label class="select">
                  <?=$tipoDoc?>
                </label>
              </section>
            </div>

          </section>
        </div>
      </div>
  </form>

  <script type="text/javascript">

    $(document).ready(function() {

      var ALLDATA;
      // DO NOT REMOVE : GLOBAL FUNCTIONS!
      pageSetUp();

      //Datepicker muestra fecha
      $('#fecha_gen_doc').datepicker({
        dateFormat : 'dd/mm/yy',
        onSelect : function(selectedDate) {
          $('#date').datepicker('option', 'maxDate', selectedDate);
        }
      });


      //Deja en blanco los campos de busqueda al seleccionar
      //un nuevo usuario.
      $("#tipo_usuario").on('change',function(){
        $('#documento_us, #nombre_us, #telefono_us, #mail_us').val("").parent().removeClass('state-success state-error');
        $('#resBusqueda').empty();
        $('#showAnswer').addClass('hide');
      });

      function uppFirs(txt){
        return  txt.charAt(0).
          toUpperCase() + txt.substr(1).
          toLowerCase();
      }

      //Valida los campos antes de ser enviados al servidor
      function validate(objData){
        var pass     = false;
        var min      = 3;
        var allempty =
            alldata  = 0;

        if(!$.isEmptyObject(objData)){

          $.each(objData, function(key, val) {
            var valdata = val.value;
            alldata++;
            if((valdata.length < min && valdata.length != 0) || /^a-zA-Z0-9áéíóúÁÉÍÓÚÑñ ]+$/.test(valdata)){
              $('#' + objData[key].id).parent().removeClass('state-success').addClass('state-error');
              delete objData[key];
            }else if (valdata.length == 0){
              $('#' + objData[key].id).parent().removeClass('state-success state-error');
              delete objData[key];
              allempty++;
            }else{
              $('#' + objData[key].id).parent().removeClass('state-error').addClass('state-success');
              pass = true;
            }
          });
        }

        if(alldata === allempty){
          $('#resBusqueda').empty();
          $('#showAnswer').addClass('hide');
        }

        return pass;

      };



      function passDataToTable(iddata){

        var trTable   = ALLDATA[iddata];
        var tRow      = $('<tr>');
        var cotUser   = $('#tipo_usuario').val() +"_"+ trTable.CODIGO;

        tCell = $('<td>').html( "<td class='search-table-icon'>"
                                + "<a href='javascript:void(0);' rel='tooltip'"
                                + "data-placement='right' data-original-title='Eliminar Usuario'"
                                + "class='text-danger'><i class='fa fa-minus'></i>"
                                + "</a>"
                                + "<input class='hide' name='usuario[]' value='" + cotUser +"'>" +
                               "</td>")
                .on("click", function(){
                  var codUser = $(this).parent().remove();
                  var tds     = $('table').children('tbody').children('tr').length;

                  $('div[name="cod_'+ iddata +'"]').removeClass('hide');
                  $('#showAnswer').removeClass('hide');

                  if(tds === 0){
                    $('#tableSection').addClass('hide');
                  };
                });

        tRow.append(tCell);

        tRow.append($('<td>').html(trTable.CEDULA));
        tRow.append($('<td>').html(trTable.NOMBRE.replace(/\w\S*/g, uppFirs)));
        tRow.append($('<td>').html(trTable.APELLIDO.replace(/\w\S*/g, uppFirs)));
        tRow.append($('<td>').html(trTable.TELEF));
        tRow.append($('<td>').html(trTable.DIRECCION.toLowerCase()));
        tRow.append($('<td>').html(trTable.EMAIL.toLowerCase()));
        tRow.append($('<td>').html(trTable.MUNIDEP.replace(/\w\S*/g, uppFirs)));
        tRow.append($('<td>').html(trTable.PAIS.replace(/\w\S*/g, uppFirs)));

        $('table').append(tRow);
        $('#tableSection').removeClass('hide');

      }

      //Modifica respuesta del servidor para presentarla
      //con formato.
      function formatAnswer(data){
        var dataformat;
        var indiv   = $('#resBusqueda');

        indiv.empty();

        $.each(data, function(i){

          var li     = $('<li/>').appendTo(indiv);
          var nombre = data[i].NOMBRE.replace(/\w\S*/g, uppFirs);
          var apell  = data[i].APELLIDO.replace(/\w\S*/g, uppFirs);
          var telef  = data[i].TELEF;
          var email  = data[i].EMAIL.toLowerCase();
          var cedula = data[i].CEDULA;

          var div    = $('<div/>')
                .addClass('well well-sm')
                .html('<div  class="col col-12">'
                      + '<h6 class=" text-success semi-bold">'
                      + cedula
                      + ' <i class="fa fa-plus-square"></i>'
                      + '</h6>'
                    + '</div>'
                    + '<div class="showdot176" ><b>'   + nombre +' '+ apell + '</b></div>'
                    + '<div class="showdot176">'       + telef      + '</div>'
                    + '<div class="showdot176">'       + email      + '</div>')
                .attr('name', 'cod_' + i)
                .on("click", function(){
                  var codUser = $(this).attr('name').substring(4);
                  var count   = 0;
                  var datali  = $('#showAnswer').children('ul').children('li');
                  passDataToTable(codUser);
                  $(this).addClass('hide');

                  datali.each(function() {
                    var ishide = $( this ).children('div').hasClass("hide");
                    if(ishide){
                      count++;
                    }
                  });
                  if(datali.length === count){
                    $('#showAnswer').addClass('hide');
                  }
                })
                .appendTo(li);
        });
        $('#showAnswer').removeClass('hide');
      };

      //Autocomplete busqueda de usuarios
      $("#documento_us, #nombre_us, #telefono_us, #mail_us").on('keyup', function () {
        var data  = {};

        data.docu = { value : $("#documento_us").val(), id : "documento_us"};
        data.name = { value : $("#nombre_us").val(),    id : "nombre_us"};
        data.tele = { value : $("#telefono_us").val(),  id : "telefono_us"};
        data.mail = { value : $("#mail_us").val(),      id : "mail_us"};

        if(validate(data)){
          data.tdoc = $("#tipo_usuario").val()
          $.post( "./ajax_buscarUsuario.php", {search : JSON.stringify(data)}).done(
            function( data ) {
              ALLDATA = data;
              if(data !== null){
                formatAnswer( data );
              }
            }
          );
        }
      });
    });

   //Mostar validacion del formulario
   function mostarAlert(objAlert) {
     var type    = objAlert.type;
     var message = objAlert.message;


     var div    = $('<div/>')
       .addClass('alert alert-block alert-' + type)
       .html(
            '<a class="close" data-dismiss="alert" href="#">×</a>'
          + '<h4 class="alert-heading">' + message + '</h4>'
       ).appendTo('#alertmessage');
   };

   function borrarAlert(){
     $('#alertmessage').empty();
   }


   //Radicar documento nuevo
   $('#radicarNuevo').on("click", function(){
        $('#alertmessage').empty();
        var pass = true;
        /* Realizar validaciones antes de enviar el radicado*/

        //Folios y Anexos
        if(/[A-Za-z]+$/.test($("#nofolios").val()) ||
           /[A-Za-z]+$/.test($("#noanexos").val())){
            mostarAlert({type : 'danger', message : 'Escriba un número válido en No de folios o anexos.'});
            pass = false;
        }

        //Fecha del radicado
        var fechaActual = new Date();
        var	fecha_doc   = $('#fecha_gen_doc').val();
        var dias_doc    = fecha_doc.substring(0,2);
        var mes_doc     = fecha_doc.substring(3,5);
        var ano_doc     = fecha_doc.substring(6,10);

        var fecha       = new Date(ano_doc,mes_doc-1, dias_doc);
        var tiempoRestante = fechaActual.getTime() - fecha.getTime();
        var dias = Math.floor(tiempoRestante / (1000 * 60 * 60 * 24));

        if (dias >960 && dias < 1500){
          mostarAlert({type : 'danger', message : 'El documento tiene fecha anterior a 60 dias!!.'});
          pass = false;
        }else if (dias > 1500){
          mostarAlert({type : 'danger', message : 'Verifique la fecha del documento!!'});
          pass = false;
        }else if (dias < 0) {
          mostarAlert({type : 'danger', message : 'Verifique la fecha del documento !!, es Una fecha Superior a la Del dia de Hoy'});
          pass = false;
        };


        //Usuarios
        if($('input[name^="usuario"]').length === 0){
          mostarAlert({type : 'danger', message : 'Seleccione un usuario'});
          pass = false;
        };

        //Asunto
        var asu = $('#asu').val();
        var min = 30;
        if(asu.length < min){
          mostarAlert({type : 'danger', message : 'Asunto no es mayor de ' + min + ' Caracteres. '});
          pass = false;
        };

        if(!/^[0-9A-Za-z áéíóúÁÉÍÓÚÑñ]+$/.test(asu)){
          mostarAlert({type : 'danger', message : 'Asunto con caracteres no permitidos'});
          pass = false;
        };

        //Dependencia
        if(parseInt($('select[name="coddepe"]').val()) === 0){
          mostarAlert({type : 'danger', message : 'Selecciona una dependencia'});
          pass = false;
        }

        //Dejar alertas en blanco
        //borrarAlert();
        if(pass){
          borrarAlert();
          var jqxhr = $.post( "./ajax_radicarNuevo.php",$( "#formulario").serialize()
          ).done(function() {
            alert( "second success"  );
          }).fail(function() {
            alert( "error"  );
          }).always(function() {
            alert( "finished"  );
          });

          jqxhr.always(function() {
              alert( "second finished"  );
          });
        };
    });

  </script>
</body>
</html>
