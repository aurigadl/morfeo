<?php
if (!$ruta_raiz) 	$ruta_raiz = "..";
$permArchi     = $_SESSION["permArchi"];
$permVobo      = $_SESSION["permVobo"];
$permRespuesta = $_SESSION["usua_perm_respuesta"];
//Eliminamos aquellos elementos que no son convenientes en el Get
$pattern 		= '/[^\w:()áéíóúÁÉÍÓÚ=#°,.ñÑ]+/';
$rad_asun_res 	= preg_replace($pattern, ' ', $rad_asun_res);
?>
<link rel="stylesheet" type="text/css" href="<?=$ruta_raiz?>/js/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="<?=$ruta_raiz?>/js/spiffyCal/spiffyCal_v2_1.js"></script>

<script language="javascript">
$( document ).ready(function(){

  function returnKrd(){
        return '<?=$krd?>';
  }

  setRutaRaiz ('<?=$ruta_raiz?>');
  function vistoBueno() {

      changedepesel(9);
      document.getElementById('EnviaraV').value = 'VoBo';
      envioTx();
  }

  function enviar() {
      envioTx();
  }


  function devolver() {
      changedepesel(12);
      envioTx();
  }

  function txAgendar() {
      if (!validaAgendar('SI'))
        return;
    changedepesel(14);
      envioTx();
  }

  function txNoAgendar() {
      changedepesel(15);
      envioTx();
  }

  function archivar() {
      changedepesel(13);
      envioTx();
  }

  function nrr() {
      changedepesel(16);
      envioTx();
  }

  function tipificar(){
    changedepesel(19);
    envioTx();
  }

  function masivaTRD(){
    sw=0;
    var radicados = new Array();
    var list = new Array();
    for(i=1;i<document.form1.elements.length;i++){
      if (document.form1.elements[i].checked && document.form1.elements[i].name!="checkAll") {
      sw++;
      valor = document.form1.elements[i].name;
      valor = valor.replace("checkValue[", "");
      valor = valor.replace("]", "");
      radicados[sw] = valor;
      list.push(valor);
      };
    };

    window.open("accionesMasivas/masivaAsignarTrd.php?<?=session_name()?>=<?=session_id()?>&krd=<?=$krd?>&radicados=" + list, "Masiva_Asignación_TRD", "height=650,width=750,scrollbars=yes");
  };

  function masivaIncluir(){
    sw=0;
      var list = new Array();
      var radicados = new Array();
      for(i=1;i<document.form1.elements.length;i++){

        if (document.form1.elements[i].checked && document.form1.elements[i].name!="checkAll") {
          sw++;
          valor = document.form1.elements[i].name;
          valor = valor.replace("checkValue[", "");
          valor = valor.replace("]", "");
          radicados[sw] = valor;
          list.push(valor);
        };

        window.open("accionesMasivas/masivaIncluirExp.php?<?=session_name()?>=<?=session_id()?>&krd=<?=$krd?>&radicados=" + list, "Masiva_IncluirExp", "height=650,width=750,scrollbars=yes");

      };
    };


    function envioTx(){
      sw=0;
      <? if(!$verrad){ ?>
        for(i=1;i<document.form1.elements.length;i++)
        if (document.form1.elements[i].checked && document.form1.elements[i].name!="checkAll")
            sw=1;
        if (sw==0){
          alert ("Debe seleccionar uno o mas radicados");
          return;
        }
      <?}?>
      document.form1.submit();
    }

    function clickTx(){
      sw=0;
      for(i=1;i<document.form1.elements.length;i++)
      if (document.form1.elements[i].checked && document.form1.elements[i].name!="checkAll")
          sw=1;
      if (sw==0)
      {
      document.getElementById('AccionCaliope').style.display = 'none';
      return;
      }else{
      document.getElementById('AccionCaliope').style.display = '';
      }
    }

    function markAll(){
      if(document.form1.elements.checkAll.checked)
      {
        for(i=2;i<document.form1.elements.length;i++)
        {
          document.form1.elements[i].checked=1;
        }
      }
      else
      {
        for(i=2;i<document.form1.elements.length;i++)
        {
          document.form1.elements[i].checked=0;
        }
      }
      clickTx();
    }



  function respuestaTx(){
      var valor = sw = 0;
      var params      = 'width='+screen.width;
          params      += ', height='+screen.height;
          params      += ', top=0, left=0'
          params      += ', scrollbars=yes'
          params      += ', fullscreen=yes';

    <?if(!$verrad){?>
          for(i=1;i<document.form1.elements.length;i++){
              if (document.form1.elements[i].checked && document.form1.elements[i].name!="checkAll"){
                  sw++;
                  valor = document.form1.elements[i].name;
                  valor = valor.replace("checkValue[", "");
                  valor = valor.replace("]", "");
              }
          }

          if (sw != 1){
              alert("Debe seleccionar UN(1) radicado");
              return;
          }


          var url         = "respuestaRapida/index.php?<?=session_name()?>=" +
                            "<?=session_id()?>&radicadopadre=" +
                              + valor + "&krd=<?=$krd?>";
          window.open(url, "Respuesta Rapida", params);

    <?}else{?>
          window.open("respuestaRapida/index.php?<?=session_name()?>=<?=session_id()?>&radicado=" +
                      '<?php print_r($verrad) ?>' + "&radicadopadre=" + '<?php print_r($verrad) ?>' +
                      "&asunto=" + '<?php print_r($rad_asun_res)?>' +
                      "&krd=<?=$krd?>", "Respuesta Rapida", params);
    <?}?>
  }


  function respuestaTx2(){
      var valor = sw = 0;
      var params      = 'width='+screen.width;
          params      += ', height='+screen.height;
          params      += ', top=0, left=0'
          params      += ', scrollbars=yes'
          params      += ', fullscreen=yes';

    <?if(!$verrad){?>
          for(i=1;i<document.form1.elements.length;i++){
              if (document.form1.elements[i].checked && document.form1.elements[i].name!="checkAll"){
                  sw++;
                  valor = document.form1.elements[i].name;
                  valor = valor.replace("checkValue[", "");
                  valor = valor.replace("]", "");
              }
          }

          if (sw != 1){
              alert("Debe seleccionar UN(1) radicado");
              return;
          }


          var url         = "respuestaRapida/index2.php?<?=session_name()?>=" +
                            "<?=session_id()?>&radicadopadre=" +
                              + valor + "&krd=<?=$krd?>";
          window.open(url, "Respuesta Rapida", params);

    <?}else{?>
          window.open("respuestaRapida/index2.php?<?=session_name()?>=<?=session_id()?>&radicado=" +
                      '<?php print_r($verrad) ?>' + "&radicadopadre=" + '<?php print_r($verrad) ?>' +
                      "&asunto=" + '<?php print_r($rad_asun_res)?>' +
                      "&krd=<?=$krd?>", "Respuesta Rapida", params);
    <?}?>
  }

  function window_onload2() {
    <? if ($menu_ver==3) { ?>
          $('#depsel, #carpper, #Enviar').hide();
          $('#AccionCaliope').show();
    <? } ?>
  }

  function window_onload() {
      $('#AccionCaliope, #depsel, #carpper, #Enviar').hide();
      <?  if($verrad){ ?>
      window_onload2();
      <? }

      if($carpeta==11 and $_SESSION['codusuario']==1){
       echo "document.getElementById('salida').style.display = ''; ";
       echo "document.getElementById('enviara').style.display = 'none'; ";
       echo "document.getElementById('Enviar').style.display = 'none'; ";

      }else{
       echo " ";
      }

      if($carpeta==11 and $_SESSION['codusuario']!=1){
        echo "document.getElementById('enviara').style.display = 'none'; ";
        echo "document.getElementById('Enviar').style.display = 'none'; ";
      }
    ?>
  }

  function optionSelect(control){
    var seleccionados=document.getElementById("seleccion");
    if(control.selected){
      selecionados.value= selecionados.value+","+control.value;
    }else{
      var posicion=selccionados.value.indexOf(control.value);
      if(posicion!=-1){
        selccionados.value=selccionados.value.substr(0,posicion)+selccionados.value.substr(posicion+control.value.length);
      }
    }
  }

  window_onload();

  $('#depsel').on('change', enviar);


  //pestanas.js
  function validaAgendar(argumento){
    fecha_hoy =  '<?=date('Y')."-".date('m')."-".date('d')?>';
    fecha = document.form1.elements['fechaAgenda'].value;

    if (fecha==""&&argumento=="SI"){
      alert("Debe suministrar la fecha de agenda");
      return false;
    }
    if (!fechas_comp_ymd(fecha_hoy,fecha) && argumento=="SI") {
      alert("La fecha de agenda debe ser mayor que la fecha de hoy");
      return false;
    }
    return true;
  }
  // JavaScript Document
  <!-- Esta funcion esconde el combo de las dependencia e inforados Se activan cuando el menu envie una señal de cambio.-->
  function changedepesel1(){
    codAccion= $('#AccionCaliope').val();
    changedepesel(codAccion);
  }

  <!-- Cuando existe una señal de cambio el programa ejecuta esta funcion mostrando el combo seleccionado -->

  function changedepesel(enviara){

    document.form1.codTx.value = enviara;
    $('#depsel, #carpper, #Enviar').hide();

    if(enviara==10 ){
      $('#carpper').show();
      $('#depsel, #Enviar').hide();
    }

    //Archivar
    if(enviara==13){
      document.getElementById('depsel').style.display = 'none';
      document.getElementById('carpper').style.display = 'none';
      envioTx();
    }

    //nrr
    if(enviara==16 ){
      document.getElementById('depsel').style.display = 'none';
      document.getElementById('carpper').style.display = 'none';
      envioTx();
    }

    //Devolver
    if(enviara==12)  {
      envioTx();
    }

    if(enviara==11){
      //document.getElementById('Enviar').value = "ARCHIVAR";
    }

    //Visto bueno
    if(enviara==9 || enviara==14){
      $('#depsel').show();
      $('#carpper, #Enviar').hide();
    }

    if(enviara==14){
      $('#depsel').show();
      $('#carpper, #Enviar').hide();
    }
    //Informar
    if(enviara==8 ){
      envioTx();
    }
  }

  $('#AccionCaliope').on('change', changedepesel1);

});
</script>

<?php
// Si esta en la Carpeta de Visto Bueno no muesta las opciones de reenviar
if (($mostrar_opc_envio==0) || ($_SESSION['codusuario'] == $radi_usua_actu && $_SESSION['dependencia'] == $radi_depe_actu)) {
  if ($controlAgenda==1){
      //Si el esta consultando la carpeta de documentos agendados entonces muestra el boton de sacar de la agenda
    if ($agendado){
      echo ("<input name='Submit2' type='button' class='botones_mediano' value=' Sacar de La Agenda &gt;&gt;' onClick='txNoAgendar();'>");
    } else{
      echo(" ");
		}
	}

  if (!$agendado) {
	  if (($_SESSION['depe_codi_padre'] && $_SESSION['codusuario']==1) || $_SESSION['codusuario']!=1) {
		if(!empty($permVobo) && $permVobo != 0){ ?>
		  <a href="#" onmouseout="MM_swapImgRestore()" onclick="seleccionBarra = 14;vistoBueno();" onmouseover="MM_swapImage('Image12','','<?=$ruta_raiz?>/imagenes/internas/overVobo.gif',1)"></a>
    <?}
  }

  if(!empty($_SESSION["usua_perm_trdmasiva"]) && $_SESSION["usua_perm_trdmasiva"]!=0 ){
		   	?>
		     <a href="#" onMouseOut="MM_swapImgRestore()" onClick="seleccionBarra = 19;tipificar();" onMouseOver="MM_swapImage('Image19','','<?=$ruta_raiz?>/imagenes/internas/tipificarA.gif',1)">
		     </a>
		  <?php  }

			if(!empty($permArchi) && $permArchi != 0) {

			}
	}
}
/* Final de opcion de enviar para carpetas que no son 11 y 0(VoBo)
/* si esta en la Carpeta de Visto Bueno no muesta las opciones de reenviar */
if (($mostrar_opc_envio==0) || ($_SESSION['codusuario'] == $radi_usua_actu && $_SESSION['dependencia'] == $radi_depe_actu)) {
	$row1 = array();
	// Combo en el que se muestran las dependencias, en el caso  de que el usuario escoja reasignar.
	$dependencianomb=substr($dependencianomb,0,35);
  $subDependencia = $db->conn->substr ."(depe_nomb,0,80)";
  if($_SESSION["codusuario"]!=1 && $_SESSION["usuario_reasignacion"] !=1){
	  $whereReasignar = " where depe_codi = $dependencia and depe_estado = 1";
	}else{
	  $whereReasignar = "where depe_estado = 1";
	}
	$sql      = "select $subDependencia, depe_codi from DEPENDENCIA $whereReasignar ORDER BY DEPE_NOMB";
	$rs       = $db->query($sql);
	$depencia = $rs->GetMenu2('depsel',0,"0:-- Escoja una Dependencia --",false,0," id='depsel' class=select' ");
	// genera las dependencias para informar
	$row1 = array();

	// Aqui se muestran las carpetas Personales
	$dependencianomb=substr($dependencianomb,0,35);
	$datoPersonal = "(Personal)";
	$nombreCarpeta = $db->conn->Concat("' $datoPersonal'",'nomb_carp');
	$codigoCarpetaGen = $db->conn->Concat("10000","cast(carp_codi as varchar(10))");
	$codigoCarpetaPer = $db->conn->Concat("11000","cast(codi_carp as varchar(10))");
	$sql = "select carp_desc  as nomb_carp
			,$codigoCarpetaGen as carp_codi, 0 as orden
			from carpeta
			where carp_codi <> 11
			union
			select $nombreCarpeta as nomb_carp
			,$codigoCarpetaPer as carp_codi
			,1 as orden
			from carpeta_per
			where
			usua_codi = $codusuario
			and depe_codi = $dependencia
			order by orden, carp_codi";
	$rs = $db->conn->Execute($sql);
	$rs->GetMenu2('carpSel',1,false,false,0," id=carpper class=select ");

	// Fin de Muestra de Carpetas personales
	?>
	<INPUT TYPE=hidden name=enviara value=9>
	<INPUT TYPE=hidden name=EnviaraV id=EnviaraV value=''>
	<input type="button" value='' name="Enviar" id="Enviar" valign='middle' class='botones_2' onClick="envioTx();">
	<input type="hidden" name="codTx" value=9>

<? }

if($verradPermisos=="Full"){ ?>
<div class="row">
  <fieldset>
    <div class="col col-3">
        <label class="select" >
          <select id="AccionCaliope" name="AccionCaliope" size="1" aria-controls="dt_basic">
            <option value="9" selected="selected">Escoja una accion...</option>
            <option value="9" >Enviar a...</option>
            <option value="14" >Enviar a Visto Bueno.</option>
            <option value="10">Mover a Carpeta...</option>
            <option value="8">Informar...</option>
            <option value="12	">Devolver...</option>
            <option value="13">Archivar...</option>
            <option value="14">Agendar...</option>
          </select>
        </label>
    </div>
    <div class="col-lg-3">
        <label class="select" > <?=$depencia?> </label>
    </div>
  </fieldset>
</div>
<?php } ?>
