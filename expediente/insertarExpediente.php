<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

Orfeo Models are the data definition of Orfeo Information System
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
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$krd                = $_SESSION["krd"];
$dependencia        = $_SESSION["dependencia"];
$usua_doc           = $_SESSION["usua_doc"];
$codusuario         = $_SESSION["codusuario"];
$tip3Nombre         = $_SESSION["tip3Nombre"];
$tip3desc           = $_SESSION["tip3desc"];
$tip3img            = $_SESSION["tip3img"];
$tpNumRad           = $_SESSION["tpNumRad"];
$tpPerRad           = $_SESSION["tpPerRad"];
$tpDescRad          = $_SESSION["tpDescRad"];
$tip3Nombre         = $_SESSION["tip3Nombre"];
$tpDepeRad          = $_SESSION["tpDepeRad"];
$usuaPermExpediente = $_SESSION["usuaPermExpediente"];

$dir_doc_us1 = $_SESSION['dir_doc_us1'] ;
$dir_doc_us2 = $_SESSION['dir_doc_us2'] ;
$ruta_raiz = "..";

if ( !$nurad ){
    $nurad = $rad;
}

include_once( "$ruta_raiz/include/db/ConnectionHandler.php" );
$db = new ConnectionHandler( "$ruta_raiz" );
include_once( "$ruta_raiz/include/tx/Historico.php" );
include_once( "$ruta_raiz/include/tx/Expediente.php" );

$encabezado = "$PHP_SELF?".session_name()."=".session_id()."&opcionExp=$opcionExp&numeroExpediente=$numeroExpediente&nurad=$nurad&coddepe=$coddepe&codusua=$codusua&depende=$depende&ent=$ent&tdoc=$tdoc&codiTRDModi=$codiTRDModi&codiTRDEli=$codiTRDEli&codserie=$codserie&tsub=$tsub&ind_ProcAnex=$ind_ProcAnex";
$expediente = new Expediente( $db );

// Inserta el radicado en el expediente
if( $funExpediente == "INSERT_EXP" ){
    // Consulta si el radicado est� incluido en el expediente.
    $arrExpedientes = $expediente->expedientesRadicado( $nurad);
    /* Si el radicado esta incluido en el expediente digitado por el usuario.
     * != No identico no se puede poner !== por que la funcion array_search
     * tambien arroja 0 o "" vacio al ver que un expediente no se encuentra
     */
	 $arrExpedientes[] = "1";
    foreach ( $arrExpedientes as $line_num => $line){
    	if ($line == $_POST['numeroExpediente']) {
    		  print '<center><hr><font color="red">El radicado ya est&aacute; incluido en el expediente.</font><hr></center>';
    	}else {
    		  $resultadoExp = $expediente->insertar_expediente( $_POST['numeroExpediente'], $_GET['nurad'], $dependencia, $codusuario, $usua_doc );
        if( $resultadoExp == 1 )
        {
            $observa = "Incluir radicado en Expediente";
            include_once "$ruta_raiz/include/tx/Historico.php";
            $radicados[] = $_GET['nurad'];
            $tipoTx = 53;
            $Historico = new Historico( $db );
            $Historico->insertarHistoricoExp( $_POST['numeroExpediente'], $radicados, $dependencia, $codusuario, $observa, $tipoTx, 0 );

            ?>
            <script language="JavaScript">
              opener.cargarPagina('expediente/lista_expedientes.php','tabs-a');
              window.close();
            </script>
            <?php
        }
        else
        {
            print '<hr><font color=red>No se anexo este radicado al expediente. Verifique que el numero del expediente exista e intente de nuevo.</font><hr>';
        }
    	}
    }



}
?>
<html>
<head>
<title>Incluir en Expediente</title>
<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<script language="JavaScript">
function validarNumExpediente()
{
    numExpediente = document.getElementById( 'numeroExpediente' ).value;

    // Valida que se haya digitado el nombre del expediente
    // a�o dependencia serie subserie consecutivo E
    if( numExpediente.length != 0 && numExpediente != "" )
    {
        insertarExpedienteVal = true;
    }
    else if( numExpediente.length == 0 || numExpediente == "" )
    {
        alert( "Error. Debe especificar el nombre de un expediente." );
        document.getElementById( 'numeroExpediente' ).focus();
        insertarExpedienteVal = false;
    }

    if( insertarExpedienteVal == true )
	{
        document.insExp.submit();
	}
}

function confirmaIncluir()
{
    document.getElementById( 'funExpediente' ).value = "INSERT_EXP";
    document.insExp.submit();
}

function cambia_Exp(expId, expNo){
	var exp_id = document.getElementById(expId);
	numExp = exp_id.value;
	var exp_no = document.getElementById(expNo);
	exp_no.value = numExp;
	document.insExp.numeroExpediente.focus();
	}
</script>
</head>
<body onLoad="document.insExp.numeroExpediente.focus();">
<article class="col-sm-12">
<div class="content">
<div class="widget-body no-padding">
<form method="post" action="<?=$_SERVER['PHP_SELF']?>?nurad=<?=$nurad?>" name="insExpBus" class="smart-form">
      <!-- NEW WIDGET START -->
        <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">
          <div>
            <!-- widget content -->
            <div class="widget-body no-padding">
              <div class="table-responsive">
<form method="post" action="<?=$_SERVER['PHP_SELF']?>?nurad=<?=$nurad?>" name="insExpBus">
                <table class="table table-bordered table-striped">
                  <tr align="center">
                    <td  valign="middle"><br>
                      <small >Parametro de Busqueda / Numero Expediente</small>
                    </td>
                    <td  valign="middle">
                      <br><input type="text" name="criterio" id="criterio" size="30" value="<?=$_POST['criterio']?>" class="tex_area">
                    </td>
                  </tr>
                </table>
              </div>
              <div class="table-responsive">
              <table class="table table-bordered table-striped">
                <tr align="center">
                  <td width="33%" height="25" >
                    <br><input name="btnBuscaExp" type="submit" class="btn btn-primary btn-xs" id="btnBuscaExp" value="Buscar">
                  </td>
                </tr>
              </table>
            </form>

<?
//$dependencia = '230';
/************************************************/
/* Ejecucion de los QUERYS respectivos para		*/
/* filtrar los expedientes coincidentes			*/
/************************************************/
//$db->conn->debug = true;
$btnBuscaExp = $_POST['btnBuscaExp'];
if($btnBuscaExp){
	$criterio = strtoupper($_POST['criterio']);
	if(!$criterio)
	{
		$criterio="_nada_";
	}

	$sql_rad = "SELECT * FROM SGD_SEXP_SECEXPEDIENTES
			WHERE upper(SGD_SEXP_PAREXP1) LIKE '%$criterio%' 
			OR upper(SGD_SEXP_PAREXP2) LIKE '%$criterio%' 
			OR upper(SGD_SEXP_PAREXP3) LIKE '%$criterio%'  
			OR upper(SGD_SEXP_PAREXP4) LIKE '%$criterio%'  
			OR upper(SGD_SEXP_PAREXP5) LIKE '%$criterio%' 
			OR SGD_EXP_NUMERO LIKE '%$criterio%'
			";
	}
else{
	$sql_rad = "SELECT * FROM RADICADO r, BODEGA_EMPRESAS b
					WHERE b.IDENTIFICADOR_EMPRESA = r.EESP_CODI
						AND r.RADI_NUME_RADI = '$nurad'";
	$sql_rad = "select *
								from
									sgd_dir_drecciones dir, sgd_exp_expediente exp, SGD_SEXP_SECEXPEDIENTES SEXP
									,radicado r
							where dir.radi_nume_radi=exp.radi_nume_radi
						  and exp.sgd_exp_numero=sexp.sgd_exp_numero
							and r.radi_nume_radi=dir.radi_nume_radi
							and dir.sgd_dir_tipo=1
                            and sexp.depe_codi = $dependencia
							and
							(	dir.sgd_dir_doc like '%$dir_doc_us1%'  ";
		if($dir_doc_us1){
			$sql_rad .= " or cast(r.eesp_codi as varchar(15)) like '%$dir_doc_us1%'";
			$sql_rad .= " or sexp.SGD_SEXP_PAREXP1 like '%$dir_doc_us1%'";
			$sql_rad .= " or sexp.SGD_SEXP_PAREXP2 like '%$dir_doc_us1%'";
			$sql_rad .= " or sexp.SGD_SEXP_PAREXP3 like '%$dir_doc_us1%'";
			$sql_rad .= " or sexp.SGD_SEXP_PAREXP4 like '%$dir_doc_us1%' ";
		}
		if($dir_doc_us2){
			$sql_rad .= " or dir.sgd_dir_doc like '%$dir_doc_us2%'";
		}

        switch ($db->driver){
            case 'postgres':
                $sql_rad .=" AND date_part('year', SEXP.sgd_sexp_fech) = date_part('year', now()) ";
                break;
            default:
                $sql_rad .=" ";
        }


	$sql_rad .= " )";
	$rs_rad = $db->query($sql_rad);

	if(!$rs_rad->EOF){
		$sgd_sexp_parexp1 = $rs_rad->fields['NIT_DE_LA_EMPRESA'];
//		$sgd_sexp_parexp2 = $rs_rad->fields['SIGLA_DE_LA_EMPRESA'];
		if(!$sgd_sexp_parexp1)
		{
			$sgd_sexp_parexp1="_nada_";
		}

		 $sql_Fin = "SELECT * FROM SGD_SEXP_SECEXPEDIENTES
			WHERE SGD_SEXP_PAREXP1 LIKE '%$sgd_sexp_parexp1%'"; // OR SGD_SEXP_PAREXP2 LIKE '%$sgd_sexp_parexp2%'";
		}
		$sql_rad .="limit 5";
	}
//echo $sql_Fin;
/*
	$campos = array("NIT" => "SGD_SEXP_PAREXP1",
					"SIGLA" => "SGD_SEXP_PAREXP2",
					"CARPETA" => "SGD_SEXP_PAREXP3"
					);

	$sql_pex = "SELECT * FROM SGD_PAREXP_PARAMEXPEDIENTE
			WHERE DEPE_CODI = '$dependencia' AND SGD_PAREXP_CODIGO = '$exp_cod_Bus'";

	$rs_pex = $db->conn->query($sql_pex);

	$param = $rs_pex->fields['SGD_PAREXP_ETIQUETA'];

	$fieldBus = $campos[$param];
*/

	//echo $sql_Fin;
	$rs_Fin = $db->conn->query($sql_rad);
	
	if(!$btnBuscaExp){
	?>
                    <small>
                      Expedientes que coinciden con documento de remitente (Ultimos 5)
                    </small>
   <?php
   }
   ?>
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                    <?  if(!$rs_Fin->EOF){ ?>
                      <tr align="center">
                      <td  align="left" width="15%">
                      <small>Fecha
                      </td>
                      <td  align="left" width="20%">
                      <small>Expediente</small>
                      </td>
                      <td  align="left" width="7%">
                      <small>Documento</small>
                      </td>
                      <td  align="left" width="40%">
                      <small>Nombre Rel Radicado</small>
                      </td>
                      <td  align="left" width="20%">
                      <small>Parametro Exp.</small>
                      </td>
                      <td  align="left" width="10%">
                      <small>Responsable</small>
                      </td>
                      <td  align="left" width="10%">
                      <small>Acci&oacute;n</small>
                      </td>
											<td  align="left" width="50%">
                      <small></small>
                      </td>                      
                      </tr>
                      <?
                      while(!$rs_Fin->EOF){
                        $exp_Fecha = substr($rs_Fin->fields['SGD_SEXP_FECH'],0,11);
                        $exp_No = $rs_Fin->fields['SGD_EXP_NUMERO'];
                        $exp_Nit = $rs_Fin->fields['SGD_DIR_DOC'];
                        $exp_P02 = $rs_Fin->fields['SGD_DIR_NOMREMDES'];
                        $exp_P03 = $rs_Fin->fields['SGD_SEXP_PAREXP1'] ." / ". $rs_Fin->fields['SGD_SEXP_PAREXP2']." / ". $rs_Fin->fields['SGD_SEXP_PAREXP3']." / ".$rs_Fin->fields['SGD_SEXP_PAREXP4']." / ".$rs_Fin->fields['SGD_SEXP_PAREXP5'];
                        $exp_Usu = $rs_Fin->fields['USUA_DOC_RESPONSABLE'];

                        $sql_Usu = "SELECT * FROM USUARIO
                              WHERE USUA_DOC  = '$exp_Usu'";

                        $rs_Usu = $db->conn->query($sql_Usu);

                        $usu_Log = $rs_Usu->fields['USUA_LOGIN'];

                        ?>
                        <tr align="center">
                        <td  align="left" ><small>
                        <?
                        echo $exp_Fecha;
                        ?>
                        </small></td>
                        <td  align="left"><small>
                        <?=$exp_No?>
                        </small></td>
                        <td  align="left" width="7%"><small>
                        <?
                        echo $exp_Nit;
                        ?>
                        </small></td>
                        <td  align="left" width="30%"><small>
                        <?
                        echo $exp_P02; //$nom_Ent;
                        ?>
                        </small></td>
                        <td  align="left" width="15%"><small>
                        <?
                        echo $exp_P03; //$nom_Sig;
                        ?>
                        </small></td>
                        <td  align="left" width="15%"><small>
                        <?
                        echo $usu_Log;
                        ?>
                        </small></td>
                        <td  align="left" width="20%"><small>
                        <input type="hidden" id="<?=$exp_No?>" value="<?=$exp_No?>">
                        <a href="#" onClick="cambia_Exp('<?=$exp_No?>', 'numeroExpediente');">Seleccionar</a>
                        </small></td>
                        <td>-</td>
                        </tr>
                        <?
                        $rs_Fin->MoveNext();
                        }
                        ?>
                      <?
                      }
                    else{
                      ?>
                      <tr align="center">
                      <td  align="left" colspan="7"><small>
                      No hay expedientes relacionados...
                      </small></td>
                      <?
                      }
                      ?>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                      <form method="post" action="<?php print $encabezado; ?>" name="insExp" class="smart-form">
                      <input type="hidden" name='funExpediente' id='funExpediente' value="" >
                      <input type="hidden" name='confirmaIncluirExp' id='confirmaIncluirExp' value="" >
                      <tr align="center" class="titulos2">
                        <td height="15" class="titulos2" colspan="2"><small>INCLUIR EN  EL EXPEDIENTE</td>
                      </tr>
                    </table>
                  </div>

                  <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <tr align="center">
                        <td  align="left" nowrap>
                    Nombre del Expediente </td>
                        <td  align="left"><small>
                          <input type="text" name="numeroExpediente" id="numeroExpediente" value="<?php print $_POST['numeroExpediente']; ?>" size="30">
                        </small></td>
                      </tr>
                  </table>
                </div>

                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr align="center">

                    <td width="33%" height="25"  align="center">
                    <center>
                      <input name="btnIncluirExp" type="button" class="btn btn-primary btn-xs" id="btnIncluirExp" onClick="validarNumExpediente();" value="Incluir en Exp">
                      </center></TD>
                    <td width="33%"  height="25">
                    <center><input name="btnCerrar" type="button" class="btn btn-primary btn-xs" id="btnCerrar" onClick="window.opener.$.fn.cargarPagina('expediente/lista_expedientes.php','tabs-a'); window.close();" value=" Cerrar "></center></TD>
                    </tr>
                  </table>
                </div>
<?
// Consulta si existe o no el expediente.
if ( $expediente->existeExpediente( $_POST['numeroExpediente'] ) !== 0 ) {
?>
                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr align="center">
                      <td width="33%" height="25"  align="center">
                        <center >
                          ESTA SEGURO DE INCLUIR ESTE RADICADO EN EL EXPEDIENTE:
                        </center>
                        <B>
                          <center class="style1"><b><?php print $numeroExpediente; ?></b></center>
                        </B>
                        <div align="justify"><br>
                          <strong><b>Recuerde:</b>No podr&aacute; modificar el numero de expediente si hay
                          un error en el expediente, m&aacute;s adelante tendr&aacute; que excluir este radicado del
                          expediente y si es el caso solicitar la anulaci&oacute;n del mismo. Adem&aacute;s debe
                          tener en cuenta que tan pronto coloca un nombre de expediente, en Archivo crean
                          una carpeta f&iacute;sica en el cual empezaran a incluir los documentos
                          pertenecientes al mismo.
                          </strong>
                        </div>
                      </td>
                    </tr>
                  </table>
                </div>

                <div class="table-responsive">
                  <table class="table table-bordered table-striped">
                    <tr align="center">
                      <td width="33%" height="25"  align="center">
                      <center>
                        <input name="btnConfirmar" type="button" onClick="confirmaIncluir();" class="botones_funcion" value="Confirmar">
                      </center>
                      </td>
                    <td width="33%"  height="25">
                    <center><input name="cerrar" type="button" class="botones_funcion" id="envia22" onClick="window.opener.$.fn.cargarPagina('expediente/lista_expedientes.php','tabs-a'); window.close();" value=" Cerrar "></center></TD>
                    </tr>
                  </table>
                </div>
                <? }
                 else if ( $_POST['numeroExpediente'] != "" && ( $expediente->existeExpediente( $_POST['numeroExpediente'] ) === 0 ) ){?>
                      <script language="JavaScript">
                        alert( "Error. El nombre del Expediente en el que desea incluir este radicado \n\r no existe en el sistema. Por favor verifique e intente de nuevo." );
                        document.getElementById( 'numeroExpediente' ).focus();
                      </script>
               <?php } ?>
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
