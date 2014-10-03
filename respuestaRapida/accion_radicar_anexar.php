<?php
  #echo "estoy entrando a radicar anexar"; exit;

  session_start();
  define ('RADICAR' , 0);
  define ('ANEXAR'  , 1);
  define ('GUARDAR_CAMBIOS', 2);

  $acciones = array('Radicar' => RADICAR,
                    'Grabar como Anexo' => ANEXAR,
                    'Guardar Cambios' => GUARDAR_CAMBIOS); // Revisar HTML Button tipo submit
  $accion   = 0;

  foreach ($_POST as $key => $valor)  ${$key} = $valor;
  foreach ($_GET as $key => $valor)   ${$key} = $valor;

  $krd = (isset($_SESSION["krd"]))? $_SESSION["krd"] : null;
  
  $accion = $acciones[$Button];

  if ($accion == RADICAR) {
    #echo "radicar";
    include ('./procRespuesta.php');
    #include ('procRespuesta.php');
  } elseif ($accion == ANEXAR || $accion == GUARDAR_CAMBIOS) {
    #echo "Grabar anexo"; exit;
    include ('./grabar_anexo.php');
    #include ('grabar_anexo.php');
  }
?>
