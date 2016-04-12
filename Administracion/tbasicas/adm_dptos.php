<?php
/**
* @module crearUsuario
*
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

Orfeo Models are the data definition of Orfeo Information System
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

    $ruta_raiz = "../../";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

include_once    ("$ruta_raiz/include/db/ConnectionHandler.php");
$db = new ConnectionHandler($ruta_raiz);

function valueToJsValue($value, $encoding = false){
    if (!is_numeric($value))
	{	$value = str_replace('\\', '\\\\', $value);
		$value = str_replace('"', '\"', $value);
		$value = '"'.$value.'"';
	}
	if ($encoding)
	{	switch ($encoding)
		{	case 'utf8' :	return iconv("ISO-8859-2", "UTF-8", $value);
							break;
		}
	}
	else
	{	return $value;	}
}

function arrayToJsArray( $array, $name, $nl = "\n", $encoding = false ){
    if (is_array($array))
	{	$jsArray = $name . ' = new Array();'.$nl;
		foreach($array as $key => $value)
		{	switch (gettype($value))
			{	case 'unknown type':
				case 'resource':
				case 'object':	break;
				case 'array':	$jsArray .= arrayToJsArray($value,$name.'['.valueToJsValue($key, $encoding).']', $nl);
								break;
				case 'NULL':	$jsArray .= $name.'['.valueToJsValue($key,$encoding).'] = null;'.$nl;
								break;
				case 'boolean':	$jsArray .= $name.'['.valueToJsValue($key,$encoding).'] = '.($value ? 'true' : 'false').';'.$nl;
								break;
				case 'string':	$jsArray .= $name.'['.valueToJsValue($key,$encoding).'] = '.valueToJsValue($value, $encoding).';'.$nl;
								break;
				case 'double':
				case 'integer':	$jsArray .= $name.'['.valueToJsValue($key,$encoding).'] = '.$value.';'.$nl;
								break;
				default:	trigger_error('Hoppa, egy új típus a PHP-ben?'.__CLASS__.'::'.__FUNCTION__.'()!', E_USER_WARNING);
			}
		}
		return $jsArray;
	}
	else
	{	return false;	}
}

if ($db->conn)
{
	if (isset($_POST['btn_accion']))
	{	$record = array();
		$record['ID_PAIS'] = $_POST['idpais'];
		$record['DPTO_CODI'] = $_POST['txtIdDpto'];
		$record['ID_CONT'] = $_POST['idcont'];
		$record['DPTO_NOMB'] = $_POST['txtModelo'];
		switch($_POST['btn_accion'])
		{	Case 'Agregar':
			Case 'Modificar':{	$res = $db->conn->Replace('DEPARTAMENTO', $record, array('ID_CONT','ID_PAIS','DPTO_CODI'), $autoquote = true);
								($res) ? ($res == 1 ? $error = 3 : $error = 4 ) : $error = 2;
					 		 }break;
			Case 'Eliminar':
            {
					$sql = "SELECT * FROM SGD_DIR_DRECCIONES WHERE DPTO_CODI = ".$record['DPTO_CODI'];
					$rs = $db->conn->Execute($sql);
					if ($rs->RecordCount() > 0)
					{	$error = 5;	}
					else
                    {
						$ok = $db->conn->Execute('DELETE FROM MUNICIPIO WHERE DPTO_CODI=?',$record['DPTO_CODI']);
						if ($ok)
						{	$record = array_slice($record, 0, 2);
							$ok = $db->conn->Execute('DELETE FROM DEPARTAMENTO WHERE ID_PAIS=? AND DPTO_CODI=?',$record);
						}
					}
				}break;
		}
		unset($record);
	}

	$sql_cont = "SELECT NOMBRE_CONT,ID_CONT FROM SGD_DEF_CONTINENTES ORDER BY NOMBRE_CONT";
	$Rs_cont = $db->conn->Execute($sql_cont); 	//Query en cache por 24 horas.
	if (!($Rs_cont)) $error = 2;

	$sql_pais = "SELECT ID_PAIS,NOMBRE_PAIS,ID_CONT FROM SGD_DEF_PAISES ORDER BY NOMBRE_PAIS";
	$Rs_pais = $db->conn->Execute($sql_pais);
	if ($Rs_pais)
	{	$vpaises = $db->conn->GetAssoc($sql_pais,$inputarr=false,$force_array=false,$first2cols=false);
		$vpaisesk = array_keys($vpaises);
		$vpaisesv = array_values($vpaises);
		$idx=0;
		foreach ($vpaisesk as $vpk)
			{	$vpaisesv[$idx]['ID_PAIS'] = $vpk;
				$idx += 1;
			}
	}
	else
		$error = 2;

	if ($_POST['idpais'] > 0)
	{	$sql_dpto = "SELECT dpto_nomb,dpto_codi FROM DEPARTAMENTO WHERE ID_PAIS=".$_POST['idpais']." ORDER BY dpto_nomb";
		$Rs_dpto = $db->conn->Execute($sql_dpto);
	}


}
else
{	$error = 1;
}
?>
<html>
<script language="JavaScript">
<!--
function Actual()
{
var Obj = document.getElementById('iddpto');
var i = Obj.selectedIndex;
document.getElementById('txtModelo').value = Obj.options[i].text;
document.getElementById('txtIdDpto').value = Obj.value;
}

function rightTrim(sString)
{	while (sString.substring(sString.length-1, sString.length) == ' ')
	{	sString = sString.substring(0,sString.length-1);  }
	return sString;
}

function addOpt(oCntrl, iPos, sTxt, sVal)
{	var selOpcion=new Option(sTxt, sVal);
	eval(oCntrl.options[iPos]=selOpcion);
}

function cambia(oCntrl)
{	while (oCntrl.length)
	{	oCntrl.remove(0);	}
	$indice = 0;
	addOpt(oCntrl, $indice, "<< Seleccione Pais >>", $indice);
	for ($x=0; $x < vp.length; $x++)
	{	if (vp[$x]["ID_CONT"] == document.form1.idcont.options[document.form1.idcont.selectedIndex].value)
		{	$indice += 1;
			addOpt(oCntrl, $indice, vp[$x]["NOMBRE_PAIS"], vp[$x]["ID_PAIS"]);
		}
	}
}


function ver_listado()
{
	window.open('listados.php?<?=session_name()."=".session_id()?>&var=dpt','','scrollbars=yes,menubar=no,height=600,width=800,resizable=yes,toolbar=no,location=no,status=no');
}

<? echo arrayToJsArray($vpaisesv, 'vp'); ?>
//-->
</script>
<head>
  <title>Orfeo - Admor de Departamentos.</title>
  <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>
<body>
<form name="form1" method="post" action="<?= $_SERVER['PHP_SELF']?>">
<input type="hidden" name="hdBandera" value="">

  <div class="col-sm-12">
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
                Administrador de departamentos
              </h2>
            </header>

            <!-- widget div-->
            <div>
              <!-- widget content -->
              <div class="widget-body no-padding">

                <table class="table table-bordered table-striped">

                <tr bordercolor="#FFFFFF">
                  <td width="3%" align="center" class="titulos2">1.</td>
                  <td width="25%" align="left" class="titulos2" height="26"><b>&nbsp;Seleccione Continente</b></td>
                  <td width="72%" class="listado2">
                    <?php
                        // Listamos los continentes.
                      echo $Rs_cont->GetMenu2('idcont',$_POST['idcont'],"0:&lt;&lt; SELECCIONE &gt;&gt;",false,0,"class='select' onchange=\"cambia(document.form1.idpais)\"");
                  ?>	</td>
                </tr>

                <tr bordercolor="#FFFFFF">
                  <td align="center" class="titulos2">2.</td>
                  <td align="left" class="titulos2" height="26"><b>&nbsp;Seleccione Pa&iacute;s</b></td>
                    <td align="left" class="listado2">
                    <select name="idpais" class='select' onChange="this.form.submit()">
                      <option value="0" selected>&lt;&lt; Seleccione Continente &gt;&gt;</option>
                        <?php
                            // Listamos los paises segun continente.
                      if ($_POST['idpais'] > 0)
                      while ($Reg2 = $Rs_pais->FetchRow())
                      {	if ($Reg2['ID_CONT'] == $_POST['idcont'])
                        {	($Reg2['ID_PAIS'] == $_POST['idpais']) ? $s="selected" : $s="" ;
                          echo '<option value="'.$Reg2['ID_PAIS'].'"'.$s.' >'.$Reg2['NOMBRE_PAIS'].'</option>';
                        }
                      }
                    ?>
                    </select></td>
                </tr>

                <tr bordercolor="#FFFFFF">
                  <td align="center" class="titulos2">3.</td>
                  <td align="left" class="titulos2" height="26"><b>&nbsp;Seleccione Dpto.</b></td>
                  <td class="listado2" height="1">
                    <?php
                    if (isset($_POST['idpais']) and $_POST['idpais'] > 0)
                    {	// Listamos los Departamentos según pais seleccionado
                        echo $Rs_dpto->GetMenu2('iddpto',$_POST['iddpto'],"0:&lt;&lt; SELECCIONE &gt;&gt;",false,0,"class='select'  id=\"iddpto\" onchange=\"Actual();\"");
                    }
                    else
                    {	echo "<select name='iddpto' class='select'><option value='' selected>&lt;&lt; Seleccione Pa&iacute;s &gt;&gt;</option></select>";
                    }
                    ?>	</td>
                </tr>
                <tr bordercolor="#FFFFFF">
                  <td rowspan="2" valign="middle" class="titulos2">4.</td>
                  <td align="left" class="titulos2" height="26"><b>&nbsp;Ingrese c&oacute;digo del Dpto.</b></td>
                  <td class="listado2"><input name="txtIdDpto" id="txtIdDpto" type="text" size="10" maxlength="3"></td>
                </tr>
                <tr bordercolor="#FFFFFF">
                  <td align="left" class="titulos2" height="26"><b>&nbsp;Ingrese nombre del Dpto.</b></td>
                  <td class="listado2"><input name="txtModelo" id="txtModelo" type="text" size="50" maxlength="70"></td>
                </tr>
                <?php
                if ($error)
                {	echo '<tr bordercolor="#FFFFFF">
                      <td width="3%" align="center" class="titulosError" colspan="3" bgcolor="#FFFFFF">';
                  switch ($error)
                  {	case 1:	//NO CONECCION A BD
                        echo "Error al conectar a BD, comuníquese con el Administrador de sistema !!";
                        break;
                    case 2:	//ERROR EJECUCCIÓN SQL
                        echo "Error al gestionar datos, comuníquese con el Administrador de sistema !!";
                        break;
                    case 3:	//ACUTALIZACION REALIZADA
                        echo "Información actualizada!!";break;
                    case 4:	//INSERCION REALIZADA
                        echo "Departamento creado satisfactoriamente!!";break;
                    case 5:	//IMPOSIBILIDAD DE ELIMINAR PAIS, ESTÁ LIGADO CON DIRECCIONES
                        echo "No se puede eliminar departamento, se encuentra ligado a direcciones.";break;
                  }
                  echo '</td></tr>';
                }
                ?>
              </table>

              <table class="table table-bordered table-striped">
                <tr bordercolor="#FFFFFF">
                  <td width="10%" class="listado2">&nbsp;</td>
                  <td width="20%" class="listado2">
                    <span class="e_texto1"><center>
                    <input name="btn_accion" type="button" class="botones" id="btn_accion" value="Listado" onClick="ver_listado();">
                    </center></span>
                  </td>
                  <td width="20%" class="listado2">
                    <span class="e_texto1"><center>
                    <input name="btn_accion" type="submit" class="botones" id="btn_accion" value="Agregar" onClick="document.form1.hdBandera.value='A'; return ValidarInformacion();">
                    </center></span>
                  </td>
                  <td width="20%" class="listado2">
                    <span class="e_texto1"><center>
                    <input name="btn_accion" type="submit" class="botones" id="btn_accion" value="Modificar" onClick="document.form1.hdBandera.value='M'; return ValidarInformacion();">
                    </center></span>
                  </td>
                  <td width="20%" class="listado2">
                    <span class="e_texto1"><center>
                    <input name="btn_accion" type="submit" class="botones" id="btn_accion" value="Eliminar" onClick="document.form1.hdBandera.value='E'; return ValidarInformacion();">
                    </center></span>
                  </td>
                  <td width="10%" class="listado2">&nbsp;</td>
                </tr>
              </table>
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

<script ID="clientEventHandlersJS" LANGUAGE="JavaScript">
<!--
function ValidarInformacion()
{	var strMensaje = "Por favor ingrese las datos.";

	if(document.form1.idcont.value == "0")
	{	alert("Debe seleccionar el continente.\n" + strMensaje);
		document.form1.idcont.focus();
		return false;
	}

	if(document.form1.idpais.value == "0")
	{	alert("Debe seleccionar el pais.\n" + strMensaje);
		document.form1.idpais.focus();
		return false;
	}

	if(document.form1.txtIdDpto.value <= "0")
	{	alert("Debe ingresar el Codigo del Dpto.\n" + strMensaje);
		document.form1.txtIdDpto.focus();
		return false;
	}
	else if(isNaN(document.form1.txtIdDpto.value))
	{	alert("El Codigo del dpto debe ser numerico.\n" + strMensaje);
		document.form1.txtIdDpto.select();
		document.form1.txtIdDpto.focus();
		return false;
	}

	if(document.form1.hdBandera.value == "A")
	{	if(document.form1.txtModelo.value == "")
		{	alert("Debe ingresar nombre del Dpto.\n" + strMensaje);
			document.form1.txtModelo.focus();
			return false;
		}
		else
		{	document.form1.submit();
		}
	}
	else if(document.form1.hdBandera.value == "M")
	{	if(document.form1.txtModelo.value == "")
		{	alert("Primero debe seleccionar el Dpto a modificar.\n" + strMensaje);
			return false;
		}
		else
		{	document.form1.submit();
		}
	}
	else if(document.form1.hdBandera.value == "E")
	{	if(confirm("Esta seguro de borrar el registro ?\n La eliminación del Dpto incluye sus municipios."))
		{	document.form1.submit();	}
		else
		{	return false;	}
	}
}
//-->
</script>
