<?php
  session_start();
  $ruta_raiz = "..";

  if($_POST["codeForm"]) $codeForm = $_POST["codeForm"];
  if($_GET["codeForm"])  $codeForm = $_GET["codeForm"];

  include "$ruta_raiz/conn.php";
  include "$ruta_raiz/gforms/genForm.class.php";

  $form = new genForm($db);
  $form->getForm($codeForm);
  $form->dataDelete = $data;
  $result = $form->deleteFormRegister();
  echo $result;
?>
