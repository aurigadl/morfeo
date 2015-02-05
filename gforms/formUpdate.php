<?php
  session_start();
  $ruta_raiz = "..";
  ini_set("display_errors",1);
?>
<?php
  if($_POST["codeForm"]) $codeForm = $_POST["codeForm"];
  if($_GET["codeForm"]) $codeForm = $_GET["codeForm"];
  /** Primer intento de tener un Generador de Formularios para Caliope
    */
  include "$ruta_raiz/conn.php";
  include "$ruta_raiz/gforms/genForm.class.php";
  
  $form = new genForm($db);
  $form->getForm($codeForm);
  $form->dataSave = $data;
  $result = $form->putFormRegister();
  //$result = "<!--".  $form->getCreateTable() ." -->";
  //echo $form->getCreateTable();
  echo $result;
?>
