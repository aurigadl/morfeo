<?php
  ini_set("display_errors",1);
  session_start();
  define ('RADICAR' , 0);
  define ('ANEXAR'  , 1);

  $acciones = array('Radicar' => RADICAR,
                    'Grabar como Anexo' => ANEXAR); // Revisar HTML Button tipo submit
  $accion   = 0;

  foreach ($_POST as $key => $valor)  ${$key} = $valor;
  foreach ($_GET as $key => $valor)   ${$key} = $valor;

  $krd = (isset($_SESSION["krd"]))? $_SESSION["krd"] : null;
  
  $accion = $acciones[$Button];

  if ($accion == RADICAR) {
    include ('./procRespuesta.php');
  } elseif ($accion == ANEXAR) {
    include ('./grabar_anexo.php');
  }
?>
