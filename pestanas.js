<script language="javascript">
  $( document ).ready(function(){
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
  <!-- Esta funcion esconde el combo de las dependencia e inforados Se activan cuando el menu envie una se�al de cambio.-->
  function changedepesel1()
  {
    codAccion= document.getElementById('AccionCaliope').value;
    changedepesel(codAccion);
  }

  <!-- Cuando existe una se�al de cambio el programa ejecuta esta funcion mostrando el combo seleccionado -->
  function changedepesel(enviara) {
    document.form1.codTx.value = enviara;
    $('#depsel, #carpper, #Enviar').hide();
  if(enviara==10 ){
      document.getElementById('depsel').style.display = 'none';
      document.getElementById('carpper').style.display = '';
      document.getElementById('Enviar').style.display = 'none';
    }
  //Archivar
    if(enviara==13){
      document.getElementById('depsel').style.display = 'none';
      document.getElementById('carpper').style.display = 'none';
      envioTx();
    }
    //nrr

    if(enviara==16 )
    {
      document.getElementById('depsel').style.display = 'none';
      document.getElementById('carpper').style.display = 'none';
      envioTx();
    }

    //Devolver
    if(enviara==12)  {
      envioTx();
    }

    if(enviara==11)
    {
      //document.getElementById('Enviar').value = "ARCHIVAR";
    }
    if(enviara==9 ){
    document.getElementById('depsel').style.display = '';
    document.getElementById('carpper').style.display = 'none';
    document.getElementById('Enviar').style.display = 'none';
    }

    //Visto bueno
    if(enviara==14 )
    {
    document.getElementById('depsel').style.display = '';
    document.getElementById('carpper').style.display = 'none';
    document.getElementById('Enviar').style.display = 'none';
    }


    //Informar
    if(enviara==8 )
    {
      envioTx();
    }
  }

  $('#AccionCaliope').on('change', changedepesel1);

});
</script>
