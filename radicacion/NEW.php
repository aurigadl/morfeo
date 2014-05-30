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
  include_once("$ruta_raiz/include/tx/usuario.php");

  $db              = new ConnectionHandler("$ruta_raiz");
  $usuario         = new Usuario($db);

  $showtable       = "hide";
  $hidetable       = "";
  $ddate           = date('d');
  $mdate           = date('m');
  $adate           = date('Y');
  $nurad           = trim($nurad);
  $hora            = date('H:i:s');
  $fechaf          = $date.$mdate.$adate.$hora;
  $dependencia     = $_SESSION["dependencia"];
  $ADODB_COUNTRECS = true;
  $fecha_gen_doc   = date("Y-m-d");
  $coddepe         = $dependencia;

  //CARGAR INFORMACION SI SE ENVIA NUMERO DE RADICADO PARA MODIFICAR
  if($nurad){
	  $nurad = trim($nurad);
    $query = "SELECT
                a.*
              FROM
                RADICADO A
              WHERE
                A.RADI_NUME_RADI = $nurad";

	  $rs    = $db->conn->query($query);

	  if(!$rs->EOF){
      $asu             = $rs->fields["RA_ASUN"];
		  $radicadopadre   = $rs->fields["RADI_NUME_DERI"];
		  $ane             = $rs->fields["RADI_DESC_ANEX"];
		  $cuentai         = $rs->fields["RADI_CUENTAI"];
		  $tdoc            = $rs->fields["TDOC_CODI"];
		  $med             = $rs->fields["MREC_CODI"];
		  $coddepe         = $rs->fields["RADI_DEPE_ACTU"];
		  $codusuarioActu  = $rs->fields["RADI_USUA_RADI"];
          $radi_fecha      = $rs->fields["RADI_FECH_RADI"];
		  $fecha_gen_doc   = $rs->fields["RADI_FECH_OFIC"];
          $guia            = $rs->fields["RADI_NUME_GUIA"];
    }

    $date1         = date_create($radi_fecha);
    list($adate, $mdate, $ddate)    = explode( '-', date_format($date1, 'Y-m-d') );
    list($adate1, $mdate1, $ddate1) = explode( '-', substr($fecha_gen_doc,0,10));
    $fecha_gen_doc = "$adate1-$mdate1-$ddate1";

	$ent = substr($nurad,-1);

    //Filtro por el tipo de usuario
    $result = $usuario->usuarioPorRadicado($nurad);

    if($result){
      $showUsers = $usuario->resRadicadoHtml();
      $showtable = '';
      $hidetable = 'hide';
    }

    $varEnvio  = session_name()."=".session_id()."&nurad=$nurad&ent=$ent";
    $senddata  = "<input name='nurad' value='$nurad' type=hidden>";
    $senddata .= "<input name='idCodigo' value='$nurad' type=hidden>";
  }

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

  $query    = "SELECT
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

<form  method="post" name="formulario" id="formulario">

  <input type=hidden name='ent' value='<?=$ent?>'>

  <div id="content" style="opacity: 1;">
    <div class="row">
      <div class="col-lg-3">
          <h1 class="page-title txt-color-blueDark">
              Modulo de radicaci&oacute;n
              <?=$tRadicacionDesc?>
              (Dep <?=$dependencia?>)
              <p><small id="idrad"> <?=$nurad?> <?=$encabezado?></small></p>
            </h1>
      </div>

      <div class="col-lg-6 smart-form">

          <section class="col col-3">
            <label class="label">
              DD / MM / AAAA
            </label>
            <h6> <?=$ddate?> / <?=$mdate?> / <?=$adate?> </h6>
          </section>

          <section class="col col-3">
            <label class="label">
              Referencia
            </label>
            <label class="input">
              <input id="cuentai" name="cuentai" type="text"  maxlength="20" value='<?= $cuentai; ?>' >
            </label>
          </section>

          <section class="col col-3">
              <label class="label">
                Guia
              </label>
              <label class="input">
                <input type=text name='guia' id='guia' value='<?=$guia?>' size=35>
              </label>
          </section>

          <section class="col col-3">
            <label class="label">
              Fecha Doc. dd/mm/aaaa
            </label>
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
              <input type="text" id="fecha_gen_doc"  name="fecha_gen_doc" placeholder="Fecah de radicacion" value="<?=$fecha_gen_doc ?>">
            </label>
          </section>

        </div>

        <div id="showRadicar" class="col-lg-3 <?=$hidetable?>">

            <a data-toggle="modal" id="radicarNuevo" name='Submit3' value='Radicar' class="btn btn-primary btn-lg btn-block pull-right header-btn">
              <i class="fa fa-circle-arrow-up fa-lg"></i>
              Radicar documento
            </a>

        </div>

        <div id="showModificar" class="col-lg-3 <?=$showtable?>">

          <a data-toggle="modal" id="modificaRad" name="Submit44" class="btn bg-color-greenDark txt-color-white btn-lg btn-block">
            Modificar el radicado <?=$nurad?>
            <?=$senddata?>
          </a>

          <label>
            <a href="javascript:void(0);" onClick="window.open ('./stickerWeb/index.php?<?=$varEnvio?>&alineacion=Center','sticker<?=$nurad?>','menubar=0,resizable=0,scrollbars=0,width=450,height=180,toolbar=0,location=0');" class="btn btn-link">Sticker</a>
          </label>

          <label>
            <a  href="javascript:void(0);" onClick="window.open ('../uploadFiles/uploadFileRadicado.php?busqRadicados=<?=$nurad?>&Buscar=Buscar&<?=$varEnvio?>&alineacion=Center','busqRadicados=<?=$nurad?>','menubar=0,resizable=0,scrollbars=0,width=550,height=280,toolbar=0,location=0');" class="btn btn-link">Asociar Imagen</a>
          </label>

        </div>
     </div>

     <div id="alertmessage"></div>

        <section id="widget-grid">

          <!-- row -->
          <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-lg-12">

              <div data-widget-editbutton="false" id="wid-id-0" role="widget">

                  <!-- widget content -->
                  <div class="col col-12">

                      <label class"label"> Buscar usuario radicador </label>
                      <section id="formsearch" class="form-inline smart-form">
                        <section class="col col-1">
                            <a id="idnuevo" href="javascript:void(0);" class="btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> Nuevo </a>
                        </section>

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

                      </section>

                      <!--Muestra Resultados de la busqueda-->
                      <section id="showAnswer" class="col-lg-12 hide well">
                        <ul id="resBusqueda" class="inbox-download-list"> </ul>
                      </section>

                    </div>
                    <section id="tableSection" class="well col-lg-12 smart-form <?=$showtable?>">
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
                            <th>Municipio</th>
                            <th>Departamento</th>
                            <th>Pais</th>
                          </tr>
                        </thead>
                        <tbody id="tableshow"><?=$showUsers?></tbody>
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
                  <textarea id="asu" name="asu" cols="70"  rows="4" ><?=$asu?></textarea>
                </label>
              </section>

              <section class="col col-6">
                  <label class="label">
                    Medio Recepci&oacute;n
                  </label>
                  <label class="select">
                    <?=$medioRec?>
                  </label>
                  <label class="label">
                    Dignatario
                  </label>
                  <label class="input">
                    <input type="text" value="" name="otro_us">
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
                  <input name="ane" id="ane" type="text" size="70"  value="<?=$ane?>">
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
      var INCREMENTAL1 = 0;
      // DO NOT REMOVE : GLOBAL FUNCTIONS!
      pageSetUp();

      //Datepicker muestra fecha
      $('#fecha_gen_doc').datepicker({
        dateFormat : 'yy-mm-dd',
        onSelect : function(selectedDate) {
          $('#date').datepicker('option', 'maxDate', selectedDate);
        }
      });


    /**
     * Generacion de eventos para los usuarios seleccionados
     * permitiendo cambiar la informacion antes de ser enviada al
     * servidor. Guardando de esta manera los datos del usuario con
     * las modificiaciones necesarias
    */
    $("body").on("click", '.fa-check',function(){
        $('label[name^="inp_"]').addClass('hide');
        $('div[name^="div_"]').removeClass('hide');
        var iddiv = $(this).parent().attr('name').substring(4);
        var tex_nuevo = $('label[name=inp_' + iddiv + ']').find('input').val();
        var div_nuevo = $('div[name=div_' + iddiv + ']').clone();
        $('div[name=div_' + iddiv + ']').text(tex_nuevo);
        $('div[name=div_' + iddiv + ']').append(div_nuevo.children());
    });

    $("body").on("click", 'div[name^="div_"]',function(){
        var texto = $(this).attr('name').substring(4);
        $('label[name="inp_' + texto + '"]').removeClass('hide');
        $('label[name="inp_' + texto + '"]').focus();
        $(this).addClass('hide');
    });


    /**
     * Permite crear un nuevo usurio mostrando los campos vacios y
     * dejando que el usuario registre los datos de la persona que necesita.
     * las modificiaciones necesarias
     * Se envia en el codigo dos xx para identificar que es un usuario nuevo.
     * Cuando se carga el usuario de un radicado ya existente en cambio de las dos xx
     * se muestra el codigo con el cual se guardo.
    */

    $("#idnuevo").on("click",function(){
        var iddata = [{ "CODIGO": 'XX' + INCREMENTAL1,
                        "NOMBRE":"",
                        "TELEF":"",
                        "EMAIL":"",
                        "CEDULA":"",
                        "PAIS":"COLOMBIA",
                        "PAIS_CODIGO":"170",
                        "DEP":"D.C.",
                        "DEP_CODIGO":"11",
                        "MUNI":"BOGOTA",
                        "MUNI_CODIGO":"1",
                        "TIPO":$('#tipo_usuario').val(),
                        "APELLIDO":""}];

        $.post( "./ajax_buscarUsuario.php", {addUser : JSON.stringify(iddata)}).done(
            function( data ) {
                $('table').append(data[0]);
                $('#tableSection').removeClass('hide');
            }
        );

        INCREMENTAL1++;
    });


    $("body").on("keyup", 'input[name^="muni"], input[name^="dep"], input[name^="pais"]', function(){
        if($(this).attr('autocomplete') === undefined){
            addAutocomple(this);
        };
    });


    function addAutocomple(element){
        var accion = $(element).attr('name').split("_")[4];
        var group  = $(element).attr('name').split("_")[3];
        $(element).autocomplete({
            source: function (request, response) {
                $.ajax({
                    url      : "./ajax_buscarDivipola.php",
                    dataType : "json",
                    type     : 'POST',
                    maxRows  : 12,
                    data: {
                        'action': accion,
                        'search': request.term,
                        'muni'  : $('input[name$="'+ group +'_muni"]').val(),
                        'dep'   : $('input[name$="'+ group +'_dep"]').val(),
                        'pais'  : $('input[name$="'+ group +'_pais"]').val()
                    },
                    success: function (data) {
                        response($.map( data, function( item ) {
                            return {
                                label: item.NOMBRE,
                                id   : item.CODIGO
                            }
                        }));
                    }

                });
            },
            minLength: 2,
            select   : function(event, ui) {
                var setempty    = $(this).attr('name').split("_")[4]
                var namehiddent = $(this).attr('name') + "_codigo";
                $("input[name=" + namehiddent + "]").val(ui.item.id);

                switch(setempty) {
                    case 'dep':
                        $('input[name^="muni"]').val();
                        break;

                    case 'pais':
                        $('input[name^="dep"]').val();
                        $('input[name^="muni"]').val();
                        break;

                }
            }
        });
    }


    //Deja en blanco los campos de busqueda al seleccionar
    //un nuevo usuario.
    $("#tipo_usuario").on('change',function(){
        $('#documento_us, #nombre_us, #telefono_us, #mail_us').val("").parent().removeClass('state-success state-error');
        $('#resBusqueda').empty();
        $('#showAnswer').addClass('hide');
    });

    //Eliminar usuarios y borrar el campo de seleccionados
    //si no existe ningun usuario
    $("body").on("click", ".search-table-icon", function(){
        var codUser = $(this).parent().remove();
        var tds     = $('table').children('tbody').children('tr').length;
        if(tds === 0){
            $('#tableSection').addClass('hide');
        };
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


    /**
     * Funcion para retornar los usuarios seleccionados y mostrarlos
     * en la tabla seleccionado con las opciones de modificaciones individuales
     * @iddata array de los datos ya seleccionados
     * @returns inserta html procesado a la tabla de usuarios seleccionados
    */
    function passDataToTable(iddata){
        var trTable = [ALLDATA[iddata]];
        $.post( "./ajax_buscarUsuario.php", {addUser : JSON.stringify(trTable)}).done(
            function( data ) {
                $('table').append(data[0]);
                $('#tableSection').removeClass('hide');
            }
        );
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
          var email  = (data[i].EMAIL)? data[i].EMAIL.toLowerCase() : '';
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

   //Mostrar validacion del formulario
   function mostrarAlert(objAlert) {
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
   $('#radicarNuevo, #modificaRad').on("click", function(){
        $('#alertmessage').empty();
        var acction = $(this).attr("id");
        var pass    = true;
        /* Realizar validaciones antes de enviar el radicado*/

        //Folios y Anexos
        if(/[A-Za-z]+$/.test($("#nofolios").val()) ||
           /[A-Za-z]+$/.test($("#noanexos").val())){
             mostrarAlert({ type : 'danger'
                          , message : 'Escriba un número válido en No de folios o anexos.'});
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
          mostrarAlert({type : 'danger', message : 'El documento tiene fecha anterior a 60 dias!!.'});
          pass = false;
        }else if (dias > 1500){
          mostrarAlert({type : 'danger', message : 'Verifique la fecha del documento!!'});
          pass = false;
        }else if (dias < 0) {
          mostrarAlert({type : 'danger', message : 'Verifique la fecha del documento !!, es Una fecha Superior a la Del dia de Hoy'});
          pass = false;
        };


        //Usuarios
        if($('input[name^="usuario"]').length === 0){
          mostrarAlert({type : 'danger', message : 'Seleccione un usuario'});
          pass = false;
        };

        //Asunto
        var asu = $('#asu').val();
        var min = 30;
        if(asu.length < min){
          mostrarAlert({type : 'danger', message : 'Asunto no es mayor de ' + min + ' Caracteres. '});
          pass = false;
        };

        if(!/^[0-9A-Za-z áéíóúÁÉÍÓÚÑñ]+$/.test(asu) && asu.length > 0){
          mostrarAlert({type : 'danger', message : 'Asunto con caracteres no permitidos'});
          pass = false;
        };
        //GUIA
        if($('#guia').val().length > 20){
          mostrarAlert({type : 'danger', message : 'Guia con mas de 20 caracteres'});
          pass = false;
        }

        //REFERENCIA CUENTA_I
        if($('#cuentai').val().length  > 20){
          mostrarAlert({type : 'danger', message : 'Referencia con mas de 20 caracteres'});
          pass = false;
        }

        //Dependencia
        if(parseInt($('select[name="coddepe"]').val()) === 0){
          mostrarAlert({type : 'danger', message : 'Selecciona una dependencia'});
          pass = false;
        }

        if(pass){
          //Dejar alertas en blanco
          borrarAlert();
          var datos = $("form").serialize();

          if(acction === "modificaRad"){
            datos = datos + "&modificar=true";
          }

          var jqxhr = $.post( "./ajax_radicarNuevo.php", datos ,function(data) {
            for(var k in data) {
              if(data[k].error !== undefined){
                mostrarAlert({type : 'danger', message : data[k].error});
              }else{

                if(acction !== "modificaRad"){
                  $('#modificaRad').append(data[k].answer);
                  $('#modificaRad').append("<input type=\"hidden\" name=\"nurad\" value=\"" + data[k].answer + "\" />");
                  $('#idrad').append(data[k].answer);
                }

                $('#showRadicar').remove();
                $('#showModificar').removeClass('hide');

              }
            };
          }).done(function(data){
            alert( "second success"  + data );
          }).fail(function() {
            mostrarAlert({type : 'danger', message : 'Error de conexion al servidor'})
          })
        };

    });

  </script>
</body>
</html>
