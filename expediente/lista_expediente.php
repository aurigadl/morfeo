<script>
function verTipoExpediente(numeroExpediente,codserie,tsub,tdoc,opcionExp) {
  <?php
		$isqlDepR = "SELECT RADI_DEPE_ACTU,
				RADI_USUA_ACTU
				FROM radicado
				WHERE RADI_NUME_RADI = '$numrad'";
		$rsDepR = $db->conn->Execute($isqlDepR);
		$coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
		$codusua = $rsDepR->fields['RADI_USUA_ACTU'];
		$ind_ProcAnex = "N";
	  	$fechaH = Date("Ymdhis");
  ?>
  window.open("<?=$ruta_raiz?>/expediente/tipificarExpediente.php?opcionExp="+opcionExp+"&numeroExpediente="+numeroExpediente+"&nurad=<?=$verrad?>&codserie="+codserie+"&tsub="+tsub+"&tdoc="+tdoc+"&krd=<?=$krd?>&dependencia=<?=$dependencia?>&fechaExp=<?=$radi_fech_radi?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>","MflujoExp<?=$fechaH?>","height=450,width=750,scrollbars=yes");
}
function verHistExpediente(numeroExpediente,codserie,tsub,tdoc,opcionExp) {
  <?php
		$isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
		            WHERE RADI_NUME_RADI = '$numrad'";
		$rsDepR = $db->conn->Execute($isqlDepR);
		$coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
		$codusua = $rsDepR->fields['RADI_USUA_ACTU'];
		$ind_ProcAnex = "N";
?>
window.open("<?=$ruta_raiz?>/expediente/verHistoricoExp.php?sessid=<?=session_id()?>&opcionExp="+opcionExp+"&numeroExpediente="+numeroExpediente+"&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>","HistExp<?=$fechaH?>","height=800,width=1060,scrollbars=yes");
}
function crearProc(numeroExpediente){
  window.open("<?=$ruta_raiz?>/expediente/crearProceso.php?sessid=<?=session_id()?>&numeroExpediente="+numeroExpediente+"&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>","HistExp<?=$fechaH?>","height=450,width=680,scrollbars=yes");
}
function seguridadExp(numeroExpediente,nivelExp){
  window.open("<?=$ruta_raiz?>/seguridad/expediente.php?<?=session_name()?>=<?=session_id()?>&num_expediente="+numeroExpediente+"&nurad=<?=$verrad?>&nivelExp="+nivelExp+"&ind_ProcAnex=<?=$ind_ProcAnex?>","HistExp<?=$fechaH?>","height=350,width=700,scrollbars=yes");
}
function verTipoExpedienteOld(numeroExpediente)
{
<?php
  $isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
	      WHERE RADI_NUME_RADI = '$numrad'";
  $rsDepR = $db->conn->Execute($isqlDepR);
  $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
  $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
  $ind_ProcAnex="N";
  ?>
  window.open("<?=$ruta_raiz?>/expediente/tipificarExpedienteOld.php?numeroExpediente="+numeroExpediente+"&nurad=<?=$verrad?>&krd=<?=$krd?>&dependencia=<?=$dependencia?>&fechaExp=<?=$radi_fech_radi?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>","Tipificacion_Documento","height=450,width=750,scrollbars=yes");
}
function modFlujo(numeroExpediente,texp,codigoFldExp,ventana='default')
{
<?php
	$isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU from radicado
							WHERE RADI_NUME_RADI = '$numrad'";
	$rsDepR = $db->conn->Execute($isqlDepR);
	$coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
	$codusua = $rsDepR->fields['RADI_USUA_ACTU'];
	$ind_ProcAnex="N";


?>
if(ventana=="Max"){
   opcVentana = "fullscreen=yes, scrollbars=auto";
  }else{
   opcVentana = "height=250,width=750,scrollbars=yes";
  }

window.open("<?=$ruta_raiz?>/flujo/modFlujoExp.php?codigoFldExp="+codigoFldExp+"&krd=<?=$krd?>&numeroExpediente="+numeroExpediente+"&numRad=<?=$verrad?>&texp="+texp+"&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>","TexpE<?=$fechaH?>",opcVentana);
}
function Responsable(numeroExpediente) {
<?php
	$isqlDepR = "SELECT RADI_DEPE_ACTU,RADI_USUA_ACTU
			FROM radicado
			WHERE RADI_NUME_RADI = '$numrad'";
	$rsDepR = $db->conn->Execute($isqlDepR);
	$coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
	$codusua = $rsDepR->fields['RADI_USUA_ACTU'];
	$isql = "SELECT USUA_DOC_RESPONSABLE, SGD_EXP_PRIVADO
			FROM SGD_SEXP_SECEXPEDIENTES
			WHERE SGD_EXP_NUMERO = '$numeroExpediente'";
	$rs = $db->conn->Execute($isql);
	$responsable= $rs->fields['USUA_DOC_RESPONSABLE'];
	$nivelExp= $rs->fields['SGD_EXP_PRIVADO'];
?>
window.open("<?=$ruta_raiz?>/expediente/responsable.php?&numeroExpediente=" + numeroExpediente +
				"&numRad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>&responsable=<?=$responsable?>&coddepe=<?=$coddepe?>&codusua=<?=$codusua?>","Responsable","height=300,width=450,scrollbars=yes");
}
function CambiarE(est,numeroExpediente) {
	window.open("<?=$ruta_raiz?>/archivo/cambiar.php?krd=<?=$krd?>&numRad=<?=$verrad?>&expediente="+ numeroExpediente +"&est="+ est +"&dependencia=<?=$dependencia?>","Cambio Estado Expediente","height=100,width=100,scrollbars=yes");
}
function insertarExpediente()
{
    window.open( "<?=$ruta_raiz?>/expediente/insertarExpediente.php?sessid=<?=session_id()?>&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>","HistExp<?=$fechaH?>","height=600,width=700,scrollbars=yes" );
}
function verWorkFlow()
{
		<?php
			//  include "./proceso/workFlow.php"; //?verrad=$verrad&numeroExpediente=$numExpediente&".session_name()."=".session_id()."";
			$pWorkFlow = "./proceso/workFlow.php?verrad=$verrad&numeroExpediente=$numExpediente&".session_name()."=".session_id()."";
		?>
    window.open("<?=$pWorkFlow?>","HistExp<?=$fechaH?>","height=750,width=850,scrollbars=yes" );
}
function crearExpediente()
{
	numExpediente = document.getElementById('num_expediente').value;
	numExpedienteDep = document.getElementById('num_expediente').value.substr(4,3);
	if(numExpedienteDep==<?=$dependencia?>)
	{
	if(numExpediente.length==13)
	{
		insertarExpedienteVal = true;
	}else
	{
		alert("Error. El numero de digitos debe ser de 13.");
		insertarExpedienteVal = false;
	}
	}
	else
	{
		alert("Error. Para crear un expediente solo lo podra realizar con el codigo de su dependencia. ");
		insertarExpedienteVal = false;
	}
		if(insertarExpedienteVal == true)
	{
		respuesta = confirm("Esta apunto de crear el EXPEDIENTE No. " + numExpediente + " Esta Seguro ? ");
		insertarExpedienteVal = respuesta;
		if(insertarExpedienteVal == true)
		{
			dv = digitoControl(numExpediente);
			document.getElementById('num_expediente').value = document.getElementById('num_expediente').value + "E" + dv;
			document.getElementById('funExpediente').value = "CREAR_EXP"
			document.form2.submit();
		}
	}
}
</script>
<script language="javascript">
var varOrden = 'ASC';
function ordenarPor( campo ) {
    if ( document.getElementById('orden').value == 'ASC' ) {
        varOrden = 'DESC';
    }
    else {
        varOrden = 'ASC';
    }
    document.getElementById('orden').value = varOrden;
    document.getElementById('ordenarPor').value = campo + ' ' + varOrden;
    document.form2.submit();
}

var i = 1;
var numRadicado;
function cambiarImagen( imagen )
{
    numRadicado = imagen.substr( 13 );
    if ( i == 1 ) {
        document.getElementById( 'anexosRadicado' ).value = numRadicado;
        i = 2;
    } else {
        document.getElementById( 'anexosRadicado' ).value = "";
        i = 1;
    }

    document.form2.submit();
}

function excluirExpediente() {
    window.open( "<?=$ruta_raiz?>/expediente/excluirExpediente.php?sessid=<?=session_id()?>&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>","HistExp<?=$fechaH?>","height=400,width=730,scrollbars=yes" );
}
// Incluir Anexos y Asociados a un Expediente.
function incluirDocumentosExp()
{
    var strRadSeleccionados = "";
    frm = document.form2;
    if( typeof frm.check_uno.length != "undefined" ) {
        for( i = 0; i < frm.check_uno.length; i++ ) {
            if( frm.check_uno[i].checked ) {
                if( strRadSeleccionados == "" ) {
                    coma = "";
                }
                else {
                    coma = ",";
                }
                strRadSeleccionados += coma + frm.check_uno[i].value;
            }
        }
    } else {
        if( frm.check_uno.checked ) {
            strRadSeleccionados = frm.check_uno.value;
        }
    }

    if( strRadSeleccionados != "" ) {
        window.open( "<?=$ruta_raiz?>/expediente/incluirDocumentosExp.php?sessid=<?=session_id()?>&nurad=<?=$verrad?>&krd=<?=$krd?>&ind_ProcAnex=<?=$ind_ProcAnex?>&strRadSeleccionados="+strRadSeleccionados,"HistExp<?=$fechaH?>","height=300,width=600,scrollbars=yes" );
	} else {
		alert( "Error. Debe seleccionar por lo menos un \n\r documento a incluir en el expediente." );
		return false;
	}
}
// Crear Subexpediente
function incluirSubexpediente( numeroExpediente, numeroRadicado )
{
    window.open( "<?=$ruta_raiz?>/expediente/datosSubexpediente.php?sessid=<?=session_id()?>&nurad="+numeroRadicado+"&krd=<?=$krd?>&num_expediente="+numeroExpediente,"HistExp<?=$fechaH?>","height=350,width=700,scrollbars=yes" );
}
</script>
<script language="JavaScript" src="./js/funciones.js"></script>
<input type="hidden" name="ordenarPor" id="ordenarPor" value="">
<input type="hidden" name="orden" id="orden" value="<?php print $orden; ?>">
<input type="hidden" name="verAnexos" id="verAnexos" value="">
<input type="hidden" name="anexosRadicado" id="anexosRadicado" value="">
<?php
function microtime_float()
{
   list($usec, $sec) = explode(" ", microtime());
   return ((float)$usec + (float)$sec);
}
$time_start = microtime_float();
	/*
	 *  Modificado: 23-Agosto-2006 Supersolidaria
	 *  Ajuste para ver los anexos borrados de un radicado al ingresar a la pesta�a EXPEDIENTES.
	 */
	 // Modificado Infom�trika 23-Julio-2009
	// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
	//if( !isset( $_POST['verBorrados'] ) ) {
	if( !isset( $verBorrados ) ) {
		// Modificado Infom�trika 23-Julio-2009
		// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
		//print '<input type="hidden" name="verBorrados" id="verBorrados" value="'.$_POST['anexosRadicado'].'">';
		print '<input type="hidden" name="verBorrados" id="verBorrados" value="'.$anexosRadicado.'">';
	}

	error_reporting(7);
	include ("$ruta_raiz/include/js/digitoControl.js");
	$verradicado = $verrad;
	if($menu_ver_tmp) {
		$menu_ver=$menu_ver_tmp;
	}
	if($verradicado) {
		$verrad= $verradicado;
	}
	$numrad = $verrad;
	if(!$menu_ver) {
		$menu_ver=4;
	}
	$fechah = date("dmy_h_m_s") . " ". time("h_m_s");
	$check = 1;
	$numeroa = 0;
	$numero = 0;
	$numeros = 0;
	$numerot = 0;
	$numerop = 0;
	$numeroh = 0;
		$rs =$db->conn->Execute($isql);
		include_once "$ruta_raiz/tx/verLinkArchivo.php";

	  $verLinkArch = new verLinkArchivo($db);


	if($radi_nume_deri and ($radi_tipo_deri==0 or $radi_tipo_deri==2)) {
	?>
<input type="hidden" name="menu_ver_tmp" value=4>
<input type="hidden" name="menu_ver" value=4>
<table  class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox"  width=90%>
  <tr>
    <td ><span class="leidos"> DOCUMENTO <?=$nombre_deri ?>
      <b> <?=$radi_nume_deri ?> </b></span></td>
</tr></table>
<table  width=90% class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox">
	<?
		$isql = "select a.* from radicado a where a.radi_nume_radi = $radi_nume_deri";
		if(!$rs->EOF) {
			while(!$rs->EOF) {
				$radicado_d = $rs->fields["RADI_NUME_RADI"];
				$fechaRadicadoPadre = $rs->fields["RADI_FECH_RADI"];
				$radicado_path = $rs->fields["RADI_PATH"];
				$raAsunAnexo = $rs->fields["RA_ASUN"];
				$cuentaIAnexo = $rs->fields["RADI_CUENTAI"];
				if($radicado_path) {
				  /*
			           * Modificacion link ingreso a imagenes del documento
			           * @author Liliana Gomez Velasquez
			           * @since 10 noviembre 2009
			          */

	                          $resulVal = $verLinkArch->valPermisoRadi($radicado_d);
	                          echo "Paso ....";
                                  $verImg = $resulVal['verImg'];
                                  $radicado_path = $resulVal['pathImagen'];
                                  if($verImg == "SI")
                                    {
	                             //$ref_radicado = "<a href='bodega$radicado_path' >$radicado_d </a>";
	                               $ref_radicado = "<a class=\"vinculos\" href=\"#2\" onclick=\"funlinkArchivo('$radicado_d','$ruta_raiz');\"> $radicado_d</a>";
                                    }elseif ($verImg == "NO") {
                   	              $ref_radicado = "<a href='#2' onclick=\"alert('El documento posee seguridad y no posee los suficientes permisos'); return false;\"><span class=leidos>$radicado_d</span></a>";
                                   }
                                }
	                  else {
					$ref_radicado = "$radicado_d";
				}
	?>
	<tr  class='leidos2' ><TD class="listado5"><span class="leidos2"><?=$ref_radicado ?></span>
	</td>
	<TD  class="listado5"><span class="leidos2">Fecha Rad:
	<?

	  $resulVal = $verLinkArch->valPermisoRadi($radicado_d);

          $verImg = $resulVal['verImg'];

	  if ($verImg == "NO") {

             echo "<a href='#2' onclick=\"alert('El documento posee seguridad y no posee los suficientes permisos'); return false;\"><span class=leidos>";

         } else
         {

	?>

	  <a href="<?=$ruta_raiz?>/verradicado.php?verrad=<?=$radicado_d ?>&<?=session_name()?>=<?=session_id()?>&krd=<?=$krd?>" target="VERRAD<?=$radicado_d?>">

	 <? }?>
	<?=$fechaRadicadoPadre?>
	</a></span>
	</TD>
	<TD class="listado5"><span class="leidos2">Asunto:<?=$raAsunAnexo ?></span></TD>
	<TD class="listado5"><span class="leidos2">Ref:<?=$cuentaIAnexo ?></span></TD></tr>
		<?
				$rs->MoveNext();
			}
		}
?>
</table>
<?
	}
?>

<table class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox" width=100%>
  <tr class="titulos2">
<?php
     if($numrad){
	$q_exp  = "SELECT  SGD_EXP_NUMERO as valor, SGD_EXP_NUMERO as etiqueta, SGD_EXP_FECH as fecha";
	$q_exp .= " FROM SGD_EXP_EXPEDIENTE ";
	$q_exp .= " WHERE RADI_NUME_RADI = " . $numrad ."";
	$q_exp .= " AND SGD_EXP_ESTADO <> 2";
	$q_exp .= " ORDER BY fecha desc";
     }else{
	$q_exp  = "SELECT  SGD_EXP_NUMERO as valor, SGD_EXP_NUMERO as etiqueta, SGD_EXP_FECH as fecha";
	$q_exp .= " FROM SGD_EXP_EXPEDIENTE ";
	$q_exp .= " WHERE SGD_EXP_NUMERO = '" . trim($numeroExpediente) . "'";
	$q_exp .= " AND SGD_EXP_ESTADO <> 2";
	$q_exp .= " ORDER BY fecha desc";
     }
	$rs_exp =&$db->conn->Execute( $q_exp );

	if( $rs_exp->RecordCount( ) == 0 ) {
		$mostrarAlerta = "<td align=\"center\" class=\"titulos2\">";
		$mostrarAlerta .= "<span class=\"alert alert-block alert-success\" class=\"titulos2\" align=\"center\">
				<b>ESTE DOCUMENTO NO HA SIDO INCLUIDO EN NINGUN EXPEDIENTE.</b>
			</span>
			</td>";
			$sqlt="select RADI_USUA_ACTU,RADI_DEPE_ACTU from RADICADO where RADI_NUME_RADI LIKE '$numrad'";
			$rsE=$db->conn->query($sqlt);
			$depe=$rsE->fields['RADI_DEPE_ACTU'];
			$usua=$rsE->fields['RADI_USUA_ACTU'];
			if($depe == '999' and $usua=='1'){
			?>

    <td align="left">
    <a href="#" onClick="insertarExpediente();" ><span class="leidos2"><b> INCLUIR EN</b></span></a>

      <?php

if($usuaPermExpediente >= 1  ) {

      ?>
	<a href="#" onClick="verTipoExpediente('<?=$num_expediente?>','<?=$codserie?>','<?=$tsub?>','<?=$tdoc?>','MODIFICAR')" >
	<b>CREAR</b></a>
	<?php
	}


	  }
		echo $mostrarAlerta;
	} else {
?>
    <td align="center" colspan=3 >
      <div class="alert alert-block alert-info">
        ESTE DOCUMENTO SE ENCUENTRA INCLUIDO EN EL(LOS) SIGUIENTE(S) EXPEDIENTE(S).
        </div>
    </td>
    <td align="center">
      <label class="select">
      <?php print $rs_exp->GetMenu( 'expIncluido', $expIncluido, false, true, 3, "class='select' onChange='document.form2.submit();'", false ); ?>
      </LABEL>
    </td>
<?php
}
?>
  </tr>
</table>

<table width="100%" class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox">
<?
	error_reporting(7);
	include_once ("$ruta_raiz/include/tx/Expediente.php");
	$expediente = new Expediente($db);
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

	if($radi_tipo_deri==0 and $radi_nume_deri) {
		$verrad_padre = $radi_nume_deri;
	} else {
		$verrad_padre = $verrad;
	}

	if( $numExpediente == "" ) {
        	$numExpediente = $expediente->consulta_exp("$verrad");
    	}
	// Modificado Infom�trika 23-Julio-2009
	// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
    	//if ( $num_expediente != "" && !isset( $_POST['expIncluido'][0] ) ) {
    	if ( $num_expediente != "" && !isset( $expIncluido ) ) {
        	$numExpediente = $num_expediente;
	}else if ( isset( $expIncluido ) && $expIncluido != "" ) {
		$numExpediente = $expIncluido;
  }
	if($verrad) $expediente->expedienteArchivado( $verrad, $numExpediente );

	// Si el radicado no ha sido excluido del expediente
	if( $expediente->estado_expediente != 2 ) {
		// $numExpediente = $expediente->consulta_exp("$verrad");
		// Si tiene expediente
 		if ($numExpediente) {

			$num_expediente = $numExpediente;
			$datoss = " readonly ";

			if($expediente->estado_expediente == 0) {
				//$mensaje = "<br>Expediente No Ubicado fisicamente en Archivo<br>";
			}
			else if( $expediente->estado_expediente == 1 ) {
                		$mensaje ="<br>El expediente se ha Ubicado fisicamente en Archivo<br>";
			}
        	}
        	if ($carpeta==8){
			//$datoss = " readonly ";
		}
	} else {
        	$numExpediente = "";
	}

	$isqlDepR = "SELECT USUA_DOC_RESPONSABLE, SGD_EXP_PRIVADO,SGD_SEXP_PAREXP1,SGD_SEXP_PAREXP2
			FROM SGD_SEXP_SECEXPEDIENTES
			WHERE SGD_EXP_NUMERO = '$numExpediente' ORDER BY SGD_SEXP_FECH DESC ";
	$rsDepR = $db->conn->Execute($isqlDepR);
	$nivelExp= $rsDepR->fields['SGD_EXP_PRIVADO'];
	$docRes= $rsDepR->fields['USUA_DOC_RESPONSABLE'];
        $param1 = substr($rsDepR->fields['SGD_SEXP_PAREXP1'],0,30);
        $param1 = $param1.' '.substr($rsDepR->fields['SGD_SEXP_PAREXP2'],0,50);
	$isqlDepR = "SELECT USUA_NOMB from USUARIO WHERE USUA_DOC = '$docRes'";
	$rsDepR = $db->conn->Execute($isqlDepR);
	$responsable= $rsDepR->fields['USUA_NOMB'];
	$isql = "SELECT USUA_PERM_EXPEDIENTE from USUARIO WHERE USUA_LOGIN = '$krd'";
	$rs = $db->conn->Execute($isql);
	$krdperm= $rs->fields['USUA_PERM_EXPEDIENTE'];
	$sqlb="select sgd_exp_archivo from sgd_exp_expediente
                where sgd_exp_numero like '$num_expediente'";

	$rsb=$db->conn->Execute($sqlb);
	$arch=$rsb->fields['SGD_EXP_ARCHIVO'];


	$mostar=true;
	$mostrar=true;
?>
<tr >
  <!--
  <td class="titulos4" colspan="2">EXPEDIENTE</td>
  -->
  <td class="listado5" colspan="7">
  <!--
    Nombre de Expediente
  -->
    <?php
	// Modificado Infom�trika 23-Julio-2009
	// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
	//if ($num_expediente != "" && !isset( $_POST['expIncluido'][0] )) {
	if ( $usuaPermExpediente ) {
    ?><table border=0 width="100%">
      <tr><td width=140>
        <span class="dropdown">
    			<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">Expediente <b class="caret"></b> </a>
						<ul class="dropdown-menu">
						<?
						if($usuaPermExpediente) {
							?>
							<li>
								<a href="#" onClick="insertarExpediente();">Incluir en...</a>
							</li>
							<li>
								<a href="#" onClick="excluirExpediente();">Excluir de...</a>
							</li>
							<li>
								<a href="#" onClick="verTipoExpediente('<?=$num_expediente?>',<?=$codserie?>,<?=$tsub?>,<?=$tdoc?>,'MODIFICAR');">Crear Nuevo Expediente</a>
							</li>
							<li>
								<a href="#" onClick="Responsable('<?=$num_expediente?>');">Cambiar Responsable</a>
							</li>
							<li>
								<a href="#" onClick="CambiarE(2,'<?=$num_expediente?>');">Cerrar Expediente</a>
							</li>
							<li>
								<a href="#" onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
							</li>

							<?
							}
							?>
						</ul>
						</span>
    </td>
    <td>

    <?=$num_expediente?>
    <input name="num_expediente" type="hidden" size="30" maxlength="18" id='num_expediente' value="<?=$num_expediente?>" class="tex_area" >
     Cod :  <span class=leidos2> <? echo $param1;?>
     Responsable: <span class=leidos2> <? echo $responsable;?>
     </td>
	<?
	}

  ?>
    <input type="hidden" name='funExpediente' id='funExpediente' value="" >
    <input type="hidden" name='menu_ver_tmp' id='menu_ver_tmp' value="4" >
<?
	// CONSULTA SI EL EXPEDIENTE TIENE UNA CLASIFICACION TRD

	error_reporting(7);
	$codserie = "";
	$tsub = "";
	include_once ("$ruta_raiz/include/tx/Expediente.php");
	$trdExp 	= new Expediente($db);

	$mrdCodigo 	= $trdExp->consultaTipoExpediente("$numExpediente");
	$trdExpediente 	= $trdExp->descSerie." / ".$trdExp->descSubSerie;
	$descPExpediente = $trdExp->descTipoExp;
	$procAutomatico = $trdExpediente->pAutomatico;
	$codserie = $trdExp->codiSRD;
	$tsub = $trdExp->codiSBRD;
	$tdoc = $trdExp->codigoTipoDoc;
	$texp = $trdExp->codigoTipoExp;
	$descFldExp 	= $trdExp->descFldExp;
	$codigoFldExp 	= $trdExp->codigoFldExp;
	if(!$codserie) $codserie=0;
	if(!$tsub) $tsub=0;
	if(!$tdoc) $tdoc=0;

	error_reporting(7);
	$resultadoExp = 0;
	if($funExpediente == "INSERT_EXP") {
		$resultadoExp = $expediente->insertar_expediente($num_expediente,
								$verrad,
								$dependencia,
								$codusuario,
								$usua_doc);
		if($resultadoExp==1) {
			echo '<hr>Se anex&oacute; este radicado al expediente correctamente.<hr>';
		}else {
			echo '<hr><font color=red>No se anex&oacute; este radicado al expediente. V
				Verifique que el numero del expediente exista e intente de nuevo.</font><hr>';
		}
	}

	if($funExpediente == "CREAR_EXP") {
		$resultadoExp = $expediente->crearExpediente($num_expediente,
								$verrad,
								$dependencia,
								$codusuario,
								$usua_doc);
		if($resultadoExp==1) {
			echo '<hr>El expediente se creo correctamente<hr>';
		}else{
		  echo '<hr><font color=red>El expediente ya se encuentra creado.
			  <br>A continuaci&oacute;n aparece la lista de documentos pertenecientes al expediente que intento crear
			  <br>Si esta seguro de incluirlo en este expediente haga click sobre el boton  "Grabar en Expediente"
			  </font><hr>';
		}
	}
	// echo "<hr>jjjjj  $usuaPermExpediente $num_expediente aa $carpeta";
	// if ($carpeta==8) {
	if ($carpeta==99998) {
		//<input type="button"0. name="UPDATE_EXP" value="ACTUALIZAR EXPEDIENTE" class="botones_mediano" onClick="Start('buscar_usuario.php?busq_salida=',1024,400);">
	}
	if($ASOC_EXP and !$funExpediente) {
    		for($ii=1;$ii<$i;$ii++) {
			$expediente->num_expediente =  "";
			$exp_num = $expediente->consulta_exp("$radicados_anexos[$ii]");
			$exp_num = $expediente->num_expediente;

			 //echo "===>$exp_num==>".$radicados_anexos[$ii]."<br>";
			if($exp_num=="") {
				$expediente->insertar_expediente($num_expediente,
								$radicados_anexos[$ii],
								$dependencia,
								$codusuario,
								$usua_doc);
			}
		}
	}
	echo "<br>$mensaje";
	?>
<?
  if(!$codigoFldExp) $codigoFldExp= "0";
if($num_expediente !=""){
?>
<?php
	// Modificado Infom�trika 23-Julio-2009
	// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
	//if ( $_POST['expIncluido'][0] != "" ) {
	if ( $expIncluido != "" ) {
		// Modificado Infom�trika 23-Julio-2009
		// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
		//$arrTRDExp = $expediente->getTRDExp( $_POST['expIncluido'][0], "", "", "" );
		$arrTRDExp = $expediente->getTRDExp( $expIncluido, "", "", "" );
	} else if( $num_expediente != "" ){
		$arrTRDExp = $expediente->getTRDExp( $num_expediente, "", "", "" );
	}
?>
    <Tr><td>Trd</td><td><?php print $arrTRDExp['serie']." / ".$arrTRDExp['subserie']; ?>

    <?php
	// Modificado Infom�trika 23-Julio-2009
	// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
	//if ( $_POST['expIncluido'][0] != "" ) {
	if ( $expIncluido != "" ) {
		// Modificado Infom�trika 23-Julio-2009
		// Ajuste para adaptarse al cambio de m�todo (de POST a GET) en el script verradicado.php
		//$arrDatosParametro = $expediente->getDatosParamExp( $_POST['expIncluido'][0], $dependencia );
		$arrDatosParametro = $expediente->getDatosParamExp( $expIncluido, $dependencia );
	}
	// Modificado 16-Agosto-2006 Supersolidaria
	// Se evala la variable $numExpediente en lugar de $num_expediente.
	else if( $numExpediente != "" ) {
		$arrDatosParametro = $expediente->getDatosParamExp( $numExpediente, $dependencia );
	}
	if( $arrDatosParametro != "" ) {
		foreach( $arrDatosParametro as $clave => $datos ) {
           echo ">  ".$datos['etiqueta'].":".print $datos['parametro'];
        }
      }
    ?><br>

  </td></tr>
	<tr>
	<td><span class="dropdown">		<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"> Proceso <b class="caret"> </b> </a>

	<ul class="dropdown-menu">
	<?
		if($usuaPermExpediente) {
			?>
			<li>
				<a href="#" onClick="verHistExpediente('<?=$num_expediente?>');">Historial del Proceso/Exp</a>
			</li>
			<li>
				<a href="#" onClick="verWorkFlow('<?=$num_expediente?>','<?=$texp?>');">Ver WorkFlow</a>
			</li>
			<li>
				<a href="#" onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
			</li>
				<?
			}
			?>
		</ul>
		</span>
		</td><td>
					<?php
			if( $arrTRDExp['proceso'] != "" ) {
			  echo $arrTRDExp['proceso']." / ".$arrTRDExp['terminoProceso'];
			}
			?>
</td></tr>

<?
if($descPExpediente){
	$expediente->consultaTipoExpediente($num_expediente);
	include_once ("$ruta_raiz/include/tx/Flujo.php");
	$objFlujo = new Flujo($db, $texp, $usua_doc);
	$kk = $objFlujo->getArista($texp, $codigoFldExp);
	$aristasSig = $objFlujo->aristasSig;
 $frm = array();
 $iA = 0;
 $ventana = "Default";
 foreach($aristasSig as $key => $arista){
  if(trim($arista["FRM_NOMBRE"])){
    $ventana = "Max";
    If(!$numeroExpediente) $numeroExpediente = $numExpedente;
    $frm[$iA]["FRM_NOMBRE"] = $arista["FRM_NOMBRE"];
    $frm[$iA]["FRM_LINK"] = $arista["FRM_LINK"];
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroRadicado}","$verrad", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINK"]);
		$frm[$iA]["FRM_LINK"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINK"]);

		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroRadicado}","$numRad", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{numeroExpediente}","$numeroExpediente", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{dependencia}","$dependencia", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{documentoUsuario}","$usua_doc", $frm[$iA]["FRM_LINKSELECT"]);
		$frm[$iA]["FRM_LINKSELECT"] = str_replace("{nombreUsuario}","$usua_nomb", $frm[$iA]["FRM_LINKSELECT"]);
		$iA++;
	}
 }
}
?>
  <tr><td>



  <span class="dropdown">
  <li class="dropdown dropdown-large">
  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
Estado
<b class="caret"></b>
</a>

		<ul class="dropdown-menu dropdown-menu-large row">
			<?

			if($usuaPermExpediente) {
				?>
				<li>
					<a href="#" onClick="verHistExpediente('<?=$num_expediente?>');"></a>
				</li>
				<li>
					<a href="#" onClick="crearProc('<?=$num_expediente?>');">Adicionar Proceso</a>
				</li>

				<li>
					<a href="#" onClick="seguridadExp('<?=$num_expediente?>','<?=$nivelExp?>');">Seguridad</a>
				</li>
					<?
				}
				?>
				<li>
					<a href="#" onClick="">Estado</a>
				</li>
				<li>
					<a href="#" onClick="modFlujo('<?=$num_expediente?>',<?=$texp?>,<?=$codigoFldExp?>,'<?=$ventana?>')">Modificar Estado</a>
				</li>
				</ul>
			 </li>
		</span>
						<?
						if($frm){
							foreach($frm as $arista){
						?>
						  </Td><td><span class="dropdown">
								<li class="dropdown dropdown-large">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#"><?=$descFldExp?>
              <b class="caret"></b>
								</a>
							<ul class="dropdown-menu dropdown-menu-large row">
						  <li>
							<a href="#" onClick="window.open('<?=$arista["FRM_LINK"]?>','frm<?=date('ymdhis')?>','fullscreen=yes, scrollbars=auto')"><?=$arista["FRM_NOMBRE"]?></a>
						</li>
						</lu>
						</span>
						</td>
						<?php
						}
						}else{
					?>

		</B></Td><td><?=$descFldExp?>
		</td><?
		}
		?>
		</tr>
		<tr><td>
     Fecha Inicio: </td><td><?php print $arrTRDExp['fecha']; ?></td>
    </tr>
    </table>
  </td>
</tr>

<tr class='timparr'>
<td colspan="6" class="titulos5">
  <p>Documentos Pertenecientes al expediente &nbsp;</p>
      <?php

    }
?>

<table width="100%"><tr><td>
<?

 if($verrad) $exp = $expediente->consultaExp($verrad);
 $arrExpedientes = $expediente->expedientes;


 include "$ruta_raiz/expediente/expedienteTree.php";

?>
</td></tr></table>
<table class="table-bordered table-striped table-condensed table-hover smart-form has-tickbox">
  <tr>
    <td class="titulos5">Y ESTA RELACIONADO CON EL(LOS) SIGUIENTE(S) DOCUMENTOS:</td>
    <td class="titulos5" align="center">
<? if( $usuaPermExpediente and $verradPermisos == "Full" or $dependencia=='999'){
?>
	<a href="#tblAnexoAsociado" onClick="incluirDocumentosExp();" >
		<span class="leidos2"><b>INCLUIR DOCUMENTOS EN EXPEDIENTE</b></span>
	</a>
<?
}
?>
  </td>
  </tr>
</table>
<span class="tituloListado"> </span>
<table border=0 width="100%" class="borde_tab" align="center">
  <tr class='titulos5'>
    <td class="titulos5">
	  <input type="checkbox" name="check_todos" value="checkbox" onClick="todos( document.forms[1] );">
	</td>
    <td align="center">RADICADO</td>
    <td align="center">FECHA RADICACION</td>
    <td align="center">TIPO DOCUMENTO</td>
    <td align="center">ASUNTO</td>
    <td align="center">TIPO DE RELACION</td>
  </tr>
  <?php
    if($verrad) $arrAnexoAsociado = $expediente->expedienteAnexoAsociado( $verrad );

    if( is_array( $arrAnexoAsociado ) )
    {
        /*
         *  Modificado: 29-Agosto-2006 Supersolidaria
         *  Consulta los datos de los radicados Anexo de (Padre), Anexo y Asociado.
         */
        include_once "$ruta_raiz/include/tx/Radicacion.php";
        $rad = new Radicacion( $db );

        /*
         * Modificacion link ingreso a imagenes del documento
         * @author Liliana Gomez Velasquez
         *  @since 10 noviembre 2009
         * @funcion funlinkArchivo
        */

        foreach( $arrAnexoAsociado as $clave => $datosAnexoAsociado )

        {

            if( $datosAnexoAsociado['radPadre'] != "" && $datosAnexoAsociado['radPadre'] != $verrad && $datosAnexoAsociado['anexo'] == $verrad )

            {

                $arrDatosRad = $rad->getDatosRad( $datosAnexoAsociado['radPadre'] );

                if( $arrDatosRad['ruta'] != "" )

                {

                	  $varRadi = $datosAnexoAsociado['radPadre'];

                 }

                else

                {

                    $rutaRadicado = $datosAnexoAsociado['radPadre'];

                }

                $radicadoAnexo = $datosAnexoAsociado['radPadre'];

                $tipoRelacion = "ANEXO DE (PADRE)";

            }

            else if( $datosAnexoAsociado['radPadre'] == $verrad && $datosAnexoAsociado['anexo'] != "" )

            {

                $arrDatosRad = $rad->getDatosRad( $datosAnexoAsociado['anexo'] );

                if( $arrDatosRad['ruta'] != "" )

                {

                 	  $varRadi = $datosAnexoAsociado['anexo'];

                }

                else

                {

                    $rutaRadicado = $datosAnexoAsociado['anexo'];

                }

                $radicadoAnexo = $datosAnexoAsociado['anexo'];

                $tipoRelacion = "ANEXO";

            }

            else if( $datosAnexoAsociado['radPadre'] == $verrad && $datosAnexoAsociado['asociado'] != "" )

            {

                $arrDatosRad = $rad->getDatosRad( $datosAnexoAsociado['asociado'] );

                if( $arrDatosRad['ruta'] != "" )

                {

                	  $varRadi = $datosAnexoAsociado['asociado'];

                }

                else

                {

                    $rutaRadicado = $datosAnexoAsociado['asociado'];

                }

                $radicadoAnexo = $datosAnexoAsociado['asociado'];

                $tipoRelacion = "ASOCIADO";

            }

      if( $arrDatosRad['ruta'] != "" )

        {
         $resulVali = $verLinkArchivo->valPermisoRadi($varRadi);
         $verImg = $resulVali['verImg'];
         $pathImagen = $resulVali['pathImagen'];
	     if($verImg == "SI")
	       {
		      $rutaRadicado =  "<a class=\"vinculos\" href=\"#2\" onclick=\"funlinkArchivo('$varRadi','$ruta_raiz');\">".$varRadi."</a>";

	       }else {
	   	      $rutaRadicado = "<a href='#2' onclick=\"alert('El documento posee seguridad y no posee los suficientes permisos'); return false;\"> $varRadi</a>";

	       }

      }

  ?>
  <tr class='listado5'>
    <td>
	  <input type="checkbox" name="check_uno" value="<?php print $radicadoAnexo; ?>" onClick="uno( document.forms[1] );">
	</td>
    <td>
      <?php
        print $rutaRadicado;
      ?>
    </td>
    <td>
   <?

       /*
		* Modificacion link ingreso a imagenes del documento
		* @author Liliana Gomez Velasquez
		* @since 10 noviembre 2009
		* @funcion funlinkArchivo
	   */
	$resulVal = $verLinkArch->valPermisoRadi($radicadoAnexo);
        $verImg = $resulVal['verImg'];
      	if ($verImg == "NO") {
         echo "<a href='#2' onclick=\"alert('El documento posee seguridad y no posee los suficientes permisos'); return false;\"><span class=leidos>";

        } else {
	 ?>
	  <a href='<?=$ruta_raiz?>/verradicado.php?verrad=<?=$radicadoAnexo?>&<?=session_name()?>=<?=session_id()?>&krd=<?=$krd?>' target="VERRAD<?=$radicadoAnexo?>">

	 <? }  print $arrDatosRad['fechaRadicacion'];

      ?>
      </a>
    </td>
    <td>
      <?php
        print $arrDatosRad['tipoDocumento'];
      ?>
    </td>
    <td>
      <?php
        print $arrDatosRad['asunto'];
      ?>
    </td>
    <td>
      <?php
        print $tipoRelacion;
      ?>
    </td>
  </tr>
  <?php
        }
    }
    $time_end = microtime_float();
	$time = $time_end - $time_start;
	echo "<span class='info'>";
	echo "<br><b>Se demor&oacute;: $time segundos la Operaci&oacute;n total.</b>";
	echo "</span>";
  ?>
</table>

