<?php
/**
* @module crearUsuario
*
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
Copyright (C) 2013 Infometrika Ltda.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

session_start();

    $ruta_raiz = "../..";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

    include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");

    $db = new ConnectionHandler($ruta_raiz);

    if (isset($_POST['btn_accion'])){

        $record = array();

        $record['sgd_msg_etiqueta'] = $_POST['idEtiqueta'];
        $record['sgd_msg_desc']     = $_POST['idDescp'];
        $record['sgd_msg_codi']     = $_POST['idcode'];

        if(!empty($record['sgd_msg_codi'])){
            $sql = "SELECT
                        COUNT(1) AS CONNUM
                    FROM
                        sgd_msg_mensaje
                    WHERE sgd_msg_codi = ".$record['sgd_msg_codi'];

            $rs = $db->conn->Execute($sql);
        }

        switch($_POST['btn_accion']){
            Case 'Agregar':
                if(empty($record['sgd_msg_codi'])){
                    $sql100 = " SELECT
                                    max(sgd_msg_codi) + 1 as CONTSUM
                                FROM
                                    sgd_msg_mensaje";

                    $rs                         = $db->conn->Execute($sql100);
                    $record['sgd_msg_codi']     = $rs->fields['CONTSUM'];
                    $record['sgd_msg_fechdesp'] = $db->conn->DBDate(time());
                    $res = $db->conn->Replace('sgd_msg_mensaje',$record,array('sgd_msg_codi'),$autoquote = true);
                    ($res) ? ($res == 1 ? $error = 3 : $error = 4 ) : $error = 2;
                }
                break;
            Case 'Modificar':
                if (empty($rs->fields['CONNUM'])){
                    //No se permite modificar el código del país
                    $error = 6;
                }else{
                    $res = $db->conn->Replace('sgd_msg_mensaje',$record,array('sgd_msg_codi'),$autoquote = true);
                    ($res) ? ($res == 1 ? $error = 3 : $error = 4 ) : $error = 2;
                }
                break;
            Case 'Eliminar':
                if (empty($rs->fields['CONNUM'])){
                    $error = 5;
                }else{
                    $db->conn->Execute("DELETE FROM sgd_msg_mensaje WHERE sgd_msg_codi=".$record['sgd_msg_codi']);
                }
                break;
        }
    }


	$sql_cont = "SELECT
	                sgd_msg_desc,
	                sgd_msg_codi,
	                sgd_msg_etiqueta
	             FROM
	                sgd_msg_mensaje";

    $salida   = $db->conn->query($sql_cont);
    $select1  = "<select name='idmensaje' id='idmensaje' class='select'>";
    $select1 .= "<option value='0_0'>   </option>";

    while (!$salida->EOF){

        $checked  = '';
        $seleCodi = $salida->fields[1];
        $seleDesc = $salida->fields[0];
        $seleEtiq = $salida->fields[2];

        if($_POST['idcode'] == $seleCodi ){
            $checked = 'selected';
        }

        $select2 .= "<option value='$seleCodi"."_"."$seleDesc' $checked>$seleEtiq</option>";
        $salida->MoveNext ();

    }

    $select3 = "</select>";
    $select  = $select1.$select2.$select3;

?>
<html>
<head>

<title>Orfeo - Administracion de mensajes.</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>

<body>
<form name="form1" method="post" action="<?= $_SERVER['PHP_SELF']?>">
<input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
<input type="hidden" name="hdBandera" value="">
  <div class="col-sm-12">
    <br>
    <!-- widget grid -->
    <section id="widget-grid">
      <!-- row -->
      <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
          <!-- Widget ID (each widget will need unique ID)-->
          <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">

            <header>
              <h2>
                Administrador de mensajes
              </h2>
            </header>

            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">

                <table class="table table-bordered table-striped">

                  <tr bordercolor="#FFFFFF">
                    <td colspan="3" height="40" align="center" class="titulos4" valign="middle"><b><span class=etexto></span></b></td>
                  </tr>

                  <tr bordercolor="#FFFFFF">
                    <td width="3%"  align="center" class="titulos2"><b>0.</b></td>
                    <td width="25%" align="left"   class="titulos2"><b>&nbsp;Seleccione Un mensaje</b></td>
                    <td width="72%" class="listado2">
                        <?= $select?>
                    </td>
                  </tr>

                  <tr bordercolor="#FFFFFF">
                      <td width="3%"  align="center" class="titulos2"><b>1.</b></td>
                      <td width="25%" align="left"   class="titulos2"><b>&nbsp;Codigo</b></td>
                      <td class="listado2"><input name="idcode" id="idcode" type="text" size="10" maxlength="10" readonly></td>
                  </tr>

                  <tr bordercolor="#FFFFFF">
                    <td width="3%"  align="center" class="titulos2"><b>2.</b></td>
                    <td align="left" class="titulos2"><b>&nbsp;Ingrese etiqueta</b></td>
                    <td class="listado2"><input name="idEtiqueta" id="idEtiqueta" type="text" size="10" maxlength="50"></td>
                  </tr>

                  <tr bordercolor="#FFFFFF">
                    <td width="3%"  align="center" class="titulos2"><b>3.</b></td>
                    <td align="left" class="titulos2"><b>&nbsp;Ingrese descripci&oacute;n</b></td>
                    <td class="listado2"><input name="idDescp" id="idDescp" type="text" size="50" maxlength="150"></td>
                  </tr>

                  <?php
                  if ($error){
                      echo '<tr bordercolor="#FFFFFF">
                        <td width="3%" align="center" class="titulosError" colspan="3" bgcolor="#FFFFFF">';
                    switch ($error){
                        case 1:	//NO CONECCION A BD
                            echo "Error al conectar a BD, comun&iacute;quese con el Administrador de sistema !!";
                            break;

                        case 2:	//ERROR EJECUCCIÓN SQL
                            echo "Error al gestionar datos, comun&iacute;quese con el Administrador de sistema !!";
                            break;

                        case 3:	//ACUTALIZACION REALIZADA
                            echo "Informaci&oacute;n actualizada!!";
                            break;
                        case 4:	//INSERCION REALIZADA
                            echo "Etiqueta creada satisfactoriamente!!";
                            break;
                        case 5:	//IMPOSIBILIDAD DE ELIMINAR MENSAJE, EST&Aacute; LIGADO CON DIRECCIONES
                            echo "No se puede eliminar la etiqueta, se encuentra unida a otro registro";
                            break;
                        case 6:	//IMPOSIBILIDAD MODIFICAR MENSAJE,
                            echo "No se puede Modificar el Codigo del Mensaje .";
                            break;
                    }
                    echo '</td></tr>';
                  }
                  ?>
                  </table>


                  <table class="table table-bordered table-striped">
                  <tr bordercolor="#FFFFFF">
                    <td width="20%" class="listado2">
                      <span class="e_texto1"><center>
                      <input name="btn_accion" type="submit" class="botones" id="btn_accion" value="Agregar">
                      </center></span>
                    </td>
                    <td width="20%" class="listado2">
                      <span class="e_texto1"><center>
                      <input name="btn_accion" type="submit" class="botones" id="btn_accion" value="Modificar">
                      </center></span>
                    </td>
                    <td width="20%" class="listado2">
                      <span class="e_texto1"><center>
                      <input name="btn_accion" type="submit" class="botones" id="btn_accion" value="Eliminar">
                      </center></span>
                    </td>
                  </tr>
                  </table>
                </form>

<script ID="clientEventHandlersJS" LANGUAGE="JavaScript">
    $( "body" ).on( "click", "#idmensaje", function(){
        var etiq = $('#idmensaje :selected').text();
        var codi = $('#idmensaje :selected').val().split('_')[0];
        var desc = $('#idmensaje :selected').val().split('_')[1];
        if(codi != 0){
            $('#idEtiqueta').val(etiq);
            $('#idDescp').val(desc);
            $('#idcode').val(codi);
        }else{
            $('#idEtiqueta').val('');
            $('#idDescp').val('');
            $('#idcode').val('');
        }
    });
</script>
</body>
</html>