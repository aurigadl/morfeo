<?
/**
 * @author Jairo Losada   <jlosada@gmail.com>
 * @author Cesar Gonzalez <aurigadl@gmail.com>
 * @author Cesar Buelvas <cejebuto@gmail.com>
 * @license  GNU AFFERO GENERAL PUBLIC LICENSE
 * @copyright

SIIM2 Models are the data definition of SIIM2 Information System
 * Copyright (C) 2013 Infometrika Ltda.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
session_start();

foreach ($_GET as $key => $valor)
    ${$key} = $valor;
foreach ($_POST as $key => $valor)
    ${$key} = $valor;

$ruta_raiz = "..";
$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc = $_SESSION["usua_doc"];
$codusuario = $_SESSION["codusuario"];
$tpNumRad = $_SESSION["tpNumRad"];
$tpPerRad = $_SESSION["tpPerRad"];
$tpDescRad = $_SESSION["tpDescRad"];
$tip3Nombre = $_SESSION["tip3Nombre"];
$tpDepeRad = $_SESSION["tpDepeRad"];
$usuaPermExpediente = $_SESSION["usuaPermExpediente"];
$digitosDependencia = $_SESSION["digitosDependencia"];
$depDireccion = $_SESSION["depDireccion"];

if (!$dependenciaExp)
	$dependenciaExp = $dependencia;

$codiSRD = $codserie;
$codiSBRD = $tsub;
$trdExp = substr("00" . $codiSRD, -2) . substr("00" . $codiSBRD, -2);


$Codigo_TRD = $dependenciaExp.$trdExp;

if (!$nurad)
    $nurad = $rad;
if ($nurad) {
    $ent = substr($nurad, -1);
}
define('ADODB_ASSOC_CASE', 1);
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
$db = new ConnectionHandler("$ruta_raiz");
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

include_once "$ruta_raiz/include/tx/Historico.php";
include_once("$ruta_raiz/class_control/TipoDocumental.php");
include_once "$ruta_raiz/include/tx/Expediente.php";


$trd = new TipoDocumental($db);
$encabezadol = "$PHP_SELF?" . session_name() . "=" . session_id() . "&opcionExp=$opcionExp&numeroExpediente=$numeroExpediente&nurad=$nurad&coddepe=$coddepe&codusua=$codusua&depende=$depende&ent=$ent&tdoc=$tdoc&codiTRDModi=$codiTRDModi&codiTRDEli=$codiTRDEli&codserie=$codserie&tsub=$tsub&ind_ProcAnex=$ind_ProcAnex";

//Compruebo si los datos llegan por POST
if (isset($_POST['coduc'])) {

$coduc = $_POST['coduc'];
$fecha_inicio = $_POST['fecha_inicio'];
$fecha_final = $_POST['fecha_final'];
$folio_ini = $_POST['folio_ini'];
$folio_fin = $_POST['folio_fin'];
$observaciones = $_POST['observaciones'];
$num_caja = $_POST['num_caja'];
$num_carpeta = $_POST['num_carpeta'];
$num_estante = $_POST['num_estante'];
$num_fila = $_POST['num_fila'];
$num_columna = $_POST['num_columna'];
$num_bandeja = $_POST['num_bandeja'];

foreach ($_POST as $elementos => $valor) {
   if (strncmp($elementos, 'parExp_', 7) == 0) {
      $indice = ( int )substr($elementos, 7);
      $arrParametro[$indice] = $valor;
    }
}

}else{
	//Cargo los datos si existen

	//comprobar si es actualizar o insertar uno nuevo.
	$isql = "select nume_exp,codigo_trd,serie,subserie,proceso,fecha_ini,fecha_fin,cons_id,folio_ini,folio_fin,observaciones,num_caja,num_carpeta,num_estante,num_fila,num_columna,num_bandeja  from sgd_exp_fuid where nume_exp = '$numeroExpediente';"; 
	
	$rs = $db->conn->Execute($isql);
	$nume_exp = $rs->fields['NUME_EXP'];
	
	if ($nume_exp != ''){
	//si tiene datos los traigo. si no, los dejo default.
	$codigotrd = $rs->fields['CODIGO_TRD'];
	$codserie = $rs->fields['SERIE'];
	$tsub = $rs->fields['SUBSERIE'];
	$codProc = $rs->fields['PROCESO'];
	$fecha_inicio = $rs->fields['FECHA_INI'];
	$fecha_final = $rs->fields['FECHA_FIN'];
	$coduc = $rs->fields['CONS_ID'];
	$folio_ini = $rs->fields['FOLIO_INI'];
	$folio_fin = $rs->fields['FOLIO_FIN'];
	$observaciones = $rs->fields['OBSERVACIONES'];
	$num_caja = $rs->fields['NUM_CAJA'];
	$num_carpeta = $rs->fields['NUM_CARPETA'];
	$num_estante = $rs->fields['NUM_ESTANTE'];
	$num_fila = $rs->fields['NUM_FILA'];
	$num_columna = $rs->fields['NUM_COLUMNA'];
	$num_bandeja = $rs->fields['NUM_BANDEJA'];
	}
	$numExpediente = $numeroExpediente; 
	/* $numExpediente = substr($numeroExpediente, 0, -1);
	$numExpediente = $numExpediente."F"; */

	/*Compruebo si existe un registro */
	$isql = "select SGD_EXP_NUMERO,SGD_SEXP_PAREXP1, SGD_SEXP_PAREXP2, SGD_SEXP_PAREXP3, SGD_SEXP_PAREXP4, SGD_SEXP_PAREXP5, SGD_SEXP_PAREXP6, SGD_SEXP_PAREXP7, SGD_SEXP_PAREXP8, SGD_SEXP_PAREXP9 from SGD_SEXP_SECEXPEDIENTES where SGD_EXP_NUMERO = '$numExpediente';";
	$rs = $db->conn->Execute($isql);
	$SGD_EXP_NUMERO = $rs->fields['SGD_EXP_NUMERO'];
	if ($SGD_EXP_NUMERO != ''){
		$_POST['parExp_1'] = $arrParametro[1] = $rs->fields['SGD_SEXP_PAREXP1'];
		$_POST['parExp_2'] = $arrParametro[2] = $rs->fields['SGD_SEXP_PAREXP2'];
		$_POST['parExp_3'] = $arrParametro[3] = $rs->fields['SGD_SEXP_PAREXP3'];
		$_POST['parExp_4'] = $arrParametro[4] = $rs->fields['SGD_SEXP_PAREXP4'];
		$_POST['parExp_5'] = $arrParametro[5] = $rs->fields['SGD_SEXP_PAREXP5'];
		$_POST['parExp_6'] = $arrParametro[6] = $rs->fields['SGD_SEXP_PAREXP6'];
		$_POST['parExp_7'] = $arrParametro[7] = $rs->fields['SGD_SEXP_PAREXP7'];
		$_POST['parExp_8'] = $arrParametro[8] = $rs->fields['SGD_SEXP_PAREXP8'];
		$_POST['parExp_9'] = $arrParametro[9] = $rs->fields['SGD_SEXP_PAREXP9'];
	}

}


?>

<html>

<head>


    <title>..:: Expediente ::..</title>
    <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
<link rel="stylesheet" href="../tooltips/jquery-ui.css">
<script src="../tooltips/jquery-ui.js"></script> 
<link rel="stylesheet" href="../tooltips/tool.css">
<script src="../tooltips/tool.js"></script>
    <script>
        function regresar() {
            document.TipoDocu.submit();
        }

        function Start(URL, WIDTH, HEIGHT) {
            windowprops = "top=0,left=0,location=no,status=no, menubar=no,scrollbars=yes, resizable=yes,width=" + WIDTH + ",height=" + HEIGHT;
            preview = window.open(URL, "preview", windowprops);
        }
    </script>
</head>

<body>
<div id="spiffycalendar" class="text"></div>
<link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="../js/spiffyCal/spiffyCal_v2_1.js"></script>
<form method="post" action="<?= $encabezadol ?>" name="TipoDocu" class="smart-form">
<? /* * Adicion nuevo Registro */
if ($Actualizar && $tsub != 0 && $codserie != 0) {

	$codigotrd = $_POST['codigotrd'];
	$codserie = $_POST['codserie']; 
	$tsub = $_POST['tsub'];
	$codProc = $_POST['codProc'];
	$fecha_inicio = $_POST['fecha_inicio'];
	$fecha_final = $_POST['fecha_final'];
	$coduc = $_POST['coduc'];
	$folio_ini = $_POST['folio_ini'];
	$folio_fin = $_POST['folio_fin'];
	$observaciones = $_POST['observaciones'];
	$num_caja = $_POST['num_caja'];
	$num_carpeta = $_POST['num_carpeta'];
	$num_estante = $_POST['num_estante'];
	$num_fila = $_POST['num_fila'];
	$num_columna = $_POST['num_columna'];
	$num_bandeja = $_POST['num_bandeja'];


	//VALIDACIONES.
//Evitar que llegen datos vacios.
if($folio_ini==""){$folio_ini=0;}
if($folio_fin==""){$folio_fin=0;}
if($num_caja==""){$num_caja=0;}
if($num_carpeta==""){$num_carpeta=0;}
if($coduc==""){$coduc=0;}
if($codProc==""){$codProc=0;}
if($num_estante==""){$num_estante=0;}
if($num_fila==""){$num_fila=0;}
if($num_columna==""){$num_columna=0;}
if($num_bandeja==""){$num_bandeja=0;}


//comprobar si es actualizar o insertar uno nuevo.
	$isql = "select nume_exp from sgd_exp_fuid where nume_exp = '$numeroExpediente';";  

	$rs = $db->conn->Execute($isql);
	$nume_exp = $rs->fields['NUME_EXP'];

if ($nume_exp == ''){
//Insertamos
 	$isql = "INSERT INTO sgd_exp_fuid (
		nume_exp, 
		codigo_trd, 
		serie, 
		subserie, 
		proceso, 
		fecha_ini, 
		fecha_fin, 
		cons_id, 
		folio_ini, 
		folio_fin, 
		observaciones, 
		num_caja, 
		num_carpeta, 
		num_estante, 
		num_fila,
		num_columna,
		num_bandeja,
		tdoc_codi)
	VALUES (
		'".$numeroExpediente."', 
		'".$codigotrd ."', 
		".$codserie .", 
		".$tsub .", 
		".$codProc .", 
		'".$fecha_inicio ."', 
		'".$fecha_final ."', 
		".$coduc .",
		".$folio_ini .", 
		".$folio_fin .", 
		'".$observaciones ."', 
		".$num_caja .", 
		".$num_carpeta .", 
		0,
		".$num_estante .",
		".$num_fila .",
		".$num_columna .",
		".$num_bandeja .",
		".$codProc ."
	);";
	$tipoTx = 101;
	$observa = "Insertar al FUID";
	
}else{
//Editamos
 	$isql = "
		UPDATE sgd_exp_fuid SET 
		codigo_trd = '".$codigotrd ."',
		serie = ".$codserie .",
		subserie = ".$tsub .",
		proceso = ".$codProc .",
		fecha_ini = '".$fecha_inicio ."',
		fecha_fin = '".$fecha_final ."',
		cons_id = ".$coduc .",
		folio_ini = ".$folio_ini .",
		folio_fin = ".$folio_fin .",
		observaciones = '".$observaciones ."',
		num_caja = ".$num_caja .",
		num_carpeta = ".$num_carpeta .",
		num_estante =  ".$num_estante .",
		num_fila = ".$num_fila .",
		num_columna = ".$num_columna .",
		num_bandeja = ".$num_bandeja .",
		tdoc_codi = ".$codProc ."
		WHERE 
		nume_exp = '$numeroExpediente';";
	$tipoTx = 102;
	$observa = "Actualizar el FUID";
}	

//ejecuto 
//echo "<pre>$isql</pre>"; exit;
//$db->conn->debug = true; 
$rs = $db->conn->Execute($isql);
//$rs = true;
if ($rs){
	$MSG_response =  " Registro Actualizado Correctamente";
	$MSG_style ="color:green";

	include_once "$ruta_raiz/include/tx/Historico.php";
	$radicados[] = $nurad;
	$Historico = new Historico($db);
	$h =	$Historico->insertarHistoricoExp($numeroExpediente, $radicados, $dependencia, $codusuario, $observa, $tipoTx, 0);

	//Recrro los datos para construir el sql
if (is_array($arrParametro)) {
   foreach ($arrParametro as $orden => $datoParametro) {
          $coma = ", ";
   if ($p == count($arrParametro)) {
	  $coma = "";
	      }
	  $campoParametro .= "SGD_SEXP_PAREXP" . $orden . $coma;
	  $valorParametro .= "'" . $datoParametro . "'" . $coma;
	  $campoParametroU .= "SGD_SEXP_PAREXP" . $orden . " = '" . $datoParametro ."'".$coma;
	  $p++;
	  }
	}
	
	$campoParametro = trim($campoParametro,", ");
	$valorParametro = trim($valorParametro,", ");
	$campoParametroU = trim($campoParametroU,", ");

	//$numExpediente = substr($numeroExpediente, 0, -1);
	//$numExpediente = $numExpediente."F";
	$numExpediente = $numeroExpediente;
	$fecha_hoy = Date("Y-m-d");	
	$sqlFechaHoy = $db->conn->DBDate($fecha_hoy);
	$depe_codi = $dependencia;
	$secExp = 1 ;
	$anoExp = substr($numExpediente, 0, 4);
	$usuaDocExp = $usua_doc ;
	$codiPROC = 0;

	/*Compruebo si existe un registro */
	$isql = "select SGD_EXP_NUMERO from SGD_SEXP_SECEXPEDIENTES where SGD_EXP_NUMERO = '$numExpediente';";
	$rs = $db->conn->Execute($isql);
	$SGD_EXP_NUMERO = $rs->fields['SGD_EXP_NUMERO'];

	if ($SGD_EXP_NUMERO == ''){
		$_query = "select id from SGD_SEXP_SECEXPEDIENTES order by id desc limit 1";
		$_rs = $db->conn->Execute($_query);
		$nextval = $_rs->fields['ID']+1; 

/////////////////CONSTRUYO EL SQL  PARA INSERTAR EN EL SECEXPEDIENTE ///////////////
	$query = "insert into SGD_SEXP_SECEXPEDIENTES(SGD_EXP_NUMERO,SGD_SEXP_FECH,DEPE_CODI,USUA_DOC,SGD_FEXP_CODIGO,SGD_SRD_CODIGO,SGD_SBRD_CODIGO,SGD_SEXP_SECUENCIA, SGD_SEXP_ANO, USUA_DOC_RESPONSABLE, SGD_PEXP_CODIGO,ID";
	if ($campoParametro != "") {    $query .= ", $campoParametro";}
	$query .= " )";
	$query .= " VALUES ('$numExpediente'," . $sqlFechaHoy . " ,'$depe_codi','$usua_doc',0,$codiSRD,$codiSBRD ,'$secExp' ,$anoExp, $usuaDocExp, $codiPROC,$nextval";
	if ($valorParametro != "") {  $query .= " , $valorParametro"; } 
	$query .= " )";
//////////FIN DEL SQL PARA INSERTAR EN SECEXPEDIENTE ////////////////////////
	
	}else{
	$query = "update SGD_SEXP_SECEXPEDIENTES set ".$campoParametroU." where SGD_EXP_NUMERO = '$numExpediente';"; 
	}

//	echo $query; exit;
//	$db->conn->debug = true;
	$rsf = $db->conn->Execute($query);
	
	if($rsf){
		//Si se insertó correctamente, intenta
	$MSG_response .=  "/ OK ";
	$MSG_style ="color:green";
	}else{
	$MSG_response =  " Ocurrio un error en sexcexpediente";
	$MSG_style ="color:red";
	}

}else{
	$MSG_response =  " No se pudo actualizar el registro "; 
	$MSG_style ="color:red";
}

} ?>

<div class="widget-body no-padding" width=80% align=center>
    <!--<div class="alert alert-info no-margin fade in" width=80%>
    <i class="fa-fw fa fa-info"></i>
    Creaci&otilde;n y/o Adici&otilde;n de Expediente (Carpteta Virtual)
</div> -->

</div>
<br>
<?php if (!isset($Actualizar)) { ?>
    <div>
		    <table class="table table-bordered table-striped" style="width:850;" align=center>

                        <tr>
                            <td>
                                <small>Codigo TRD</small>
                            </td>
                            <td align="left" colspan="2" >
				<small>
				<input type="hidden" size="25" value="<?=$Codigo_TRD?>" name="codigotrd">	
				<?=$Codigo_TRD?>
                                </small>
                            </td>
			</tr>
<?php /* ?>
                        <tr>
                            <td>
                                <small>Dependencia</small>
                            </td>
                            <td>
                                <small>
                                    <label class=select>
                                        <?php
                                        $queryDep = "select depe_nomb||' - '||depe_codi, d.depe_codi
                            from dependencia d
                            order by depe_nomb
                          ";
                                        $rsD = $db->conn->Execute($queryDep);
                                        $comentarioDev = "Muestra las Series Docuementales";
                                        include "$ruta_raiz/include/tx/ComentarioTx.php";
                                        if (!$dependenciaExp)
                                            $dependenciaExp = $dependencia;
                                        print $rsD->GetMenu2("dependenciaExp", $dependenciaExp, "0:-- Seleccione --", false, "", "onChange='submit()' class='select'");
                                        ?><i></i>
                                    </label></small>
                            </td>
			</tr>

<?php */ ?>
                        <tr>
                            <td>
                                <small>Serie</small>
                            </td>
                            <td>
                                <small>
                                    <label class=select>
                                        <?php
                                        if (!$tdoc)
                                            $tdoc = 0;
                                        if (!$codserie)
                                            $codserie = 0;
                                        if (!$tsub)
                                            $tsub = 0;
                                        $fechah = date("dmy") . " " . time("h_m_s");
                                        $fecha_hoy = Date("Y-m-d");
                                        $sqlFechaHoy = $db->conn->DBDate($fecha_hoy);
                                        $check = 1;
                                        $fechaf = date("dmy") . "_" . time("hms");
                                        $num_car = 4;
                                        if (!$dependenciaExp)
                                            $dependenciaExp = $dependencia;
                                        $nomb_varc = "s.sgd_srd_codigo";
                                        $nomb_varde = "s.sgd_srd_descrip";
                                        include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";
                                        if (!$depDireccion)
                                            $depDireccion = $dependencia;
                                        $querySerie = "select distinct ($sqlConcat) as detalle, s.sgd_srd_codigo, s.sgd_srd_descrip
                            from sgd_mrd_matrird m, sgd_srd_seriesrd s
                            where
                            (cast(m.depe_codi as varchar(" . $digitosDependencia . ")) = '$dependenciaExp' or cast(m.depe_codi_aplica as varchar(" . $digitosDependencia . ")) like '%$dependenciaExp%' or cast(m.depe_codi as varchar(" . $digitosDependencia . "))='$depDireccion')
                              and s.sgd_srd_codigo = m.sgd_srd_codigo
			      and " . $db->sysdate() . " between s.sgd_srd_fechini and s.sgd_srd_fechfin
			      and s.sgd_srd_codigo = $codserie
                            order by  s.sgd_srd_descrip, s.sgd_srd_codigo
                          ";
                                        $rsD = $db->conn->Execute($querySerie);
                                        $comentarioDev = "Muestra las Series Docuementales";
                                        include "$ruta_raiz/include/tx/ComentarioTx.php";
                                        print $rsD->GetMenu2("codserie", $codserie, "", false, "", "onChange='submit()' class='select'");
                                        ?><i></i>
                                    </label></small>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <small>SubSerie</small>
                            </td>
                            <td>
                                <small><label class=select> <?
                                        $nomb_varc = "su.sgd_sbrd_codigo";
                                        $nomb_varde = "su.sgd_sbrd_descrip";
                                        include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";
                                        $querySub = "select distinct ($sqlConcat) as detalle, su.sgd_sbrd_codigo
                            from sgd_mrd_matrird m, sgd_sbrd_subserierd su
                            where (cast(m.depe_codi as varchar(10)) = '$coddepe' or cast(m.depe_codi_aplica as varchar(10)) like '%$coddepe%' or cast(m.depe_codi as varchar(10))='$depDireccion')
                              and m.sgd_srd_codigo = '$codserie'
                              and su.sgd_srd_codigo = '$codserie'
                              and su.sgd_sbrd_codigo = m.sgd_sbrd_codigo
			      and " . $db->sysdate() . " between su.sgd_sbrd_fechini and su.sgd_sbrd_fechfin
			      and su.sgd_sbrd_codigo = $tsub
                            order by detalle
			    ";
                                        $rsSub = $db->conn->Execute($querySub);
					include "$ruta_raiz/include/tx/ComentarioTx.php";
					
					print $rsSub->GetMenu2("tsub", $tsub, "", false, "", "onChange='submit()' class='select'");

                                        if (!$codiSRD) {
                                            $codiSRD = $codserie;
                                            $codiSBRD = $tsub;
                                        }

                                        $queryPEXP = "select SGD_PEXP_DESCRIP,SGD_PEXP_CODIGO FROM
                          SGD_PEXP_PROCEXPEDIENTES
                          WHERE
                            SGD_SRD_CODIGO=$codiSRD
                            AND SGD_SBRD_CODIGO=$codiSBRD ";
					
					$rs = $db->conn->Execute($queryPEXP);
                                        $texp = $rs->fields["SGD_PEXP_CODIGO"];
                                        ?><i></i>
                                    </label>
                                </small>
                            </td>
			</tr>
<?php /*
                        <tr>
                            <td>
                                <small>Proceso</small>
                            </td>
                            <td colspan="2">
                                <label class=select>
                                    <?
                                    $comentarioDev = "Muestra los procesos segun la combinacion Serie-Subserie";
                                    include "$ruta_raiz/include/tx/ComentarioTx.php";
				    
				    print $rs->GetMenu2("codProc", $codProc, "0:-- Seleccione --", false, "", "onChange='submit()' class='select'");

                                    $rs->MoveFirst();
                                    while (!$rs->EOF) {
                                        $arrProceso[$rs->fields["SGD_PEXP_CODIGO"]] = $rs->fields["SGD_PEXP_DESCRIP"];
                                        $rs->MoveNext();
                                    }

				    // Si se selecciono Serie-Subserie-Proceso
                                    if ($codProc != "" && $codProc != 0 && $codserie != "" && $codserie != 0 && $tsub != "" && $tsub != 0) {
                                        // Termino del proceso seleccionado
                                        $queryPEXP = "select SGD_PEXP_TERMINOS";
                                        $queryPEXP .= " FROM SGD_PEXP_PROCEXPEDIENTES";
                                        $queryPEXP .= " WHERE SGD_PEXP_CODIGO  = " . $codProc;

                                        //$rs = $db->conn->Execute($queryPEXP);

					//$expTerminos = $rs->fields["SGD_PEXP_TERMINOS"];
 					$expTerminos = "";	
                                        if ($expTerminos != "") {
                                            $expDesc = "<small> $expTerminos Dias Calendario de Termino Total </small>";
                                        }
                                    }
                                    if ($expDesc)
                                        print "<small>&nbsp;" . $expDesc . "</small>";
   ?>
                                    <i></i>
                                </label>
                            </td>
			 </tr>
 */ ?>
                    </table>
                  </div>
                  <div>
                      <table class="table table-bordered table-striped" style="width:850;" align=center>

			<?php /* ?>
<td align="center" colspan=6 >
			<button type="button" class="btn btn-success btn-xs" id ="OcultarMostrarCampos" >Mostrar/Ocultar Descriptores</button>
</td>
<?php */
			    $db->limit(5);
			    $limitMsql = $db->limitMsql;
			    $limitOci8 = $db->limitOci8;
			    $limitPsql = $db->limitPsql; 

                          $sqlParExp = "SELECT SGD_PAREXP_ETIQUETA, SGD_PAREXP_ORDEN,";
                          $sqlParExp .= " SGD_PAREXP_EDITABLE";
                          $sqlParExp .= " FROM SGD_PAREXP_PARAMEXPEDIENTE PE";
                          $sqlParExp .= " WHERE PE.DEPE_CODI = " . $dependenciaExp;
			  $sqlParExp .= " ORDER BY SGD_PAREXP_ORDEN ASC $limitPsql";


                          #$db->conn->debug=true;
                          $rsParExp = $db->conn->Execute($sqlParExp);
                            $auxiliar_formulario = 0;
                          while (!$rsParExp->EOF) { ?>
                              <tr align="center" <?php if($auxiliar_formulario>=0){echo 'class = "my_toogle" style = "" ';} ?> >
                                  <td align="left" colspan=2>
                                      <SMALL>
                                          <?php

                                           $valorTxt = "";
                                          print $rsParExp->fields['SGD_PAREXP_ETIQUETA'];

                                          if ($rsParExp->fields['SGD_PAREXP_EDITABLE'] == 1) {
                                              $readonly = "";
                                          } else {
                                              $readonly = "readonly";
                                          }

                                          if ($rsParExp->fields['SGD_PAREXP_ETIQUETA'] == "NIT") {
                                              $valorTxt = $_SESSION['DOC_US3'];
                                          }

                                          if ($rsParExp->fields['SGD_PAREXP_ETIQUETA'] == "SIGLA") {
                                              $valorTxt = $_SESSION['SIGLA_US3'];
                                              if (!$valorTxt)
                                                  $valorTxt = $_SESSION['NOMBRE_US3'];
                                              $valorTxt = trim(substr($valorTxt, 0, 120));
                                          }
                                           ?>

                                      </SMALL>
                                  </td>
                                  <td align="left" colspan=5>
                                      <?
                                      $parExpOrden = $rsParExp->fields['SGD_PAREXP_ORDEN'];
                                      $nombreInput = "parExp_" . $rsParExp->fields['SGD_PAREXP_ORDEN'];
                                      if ($_GET[$nombreInput])
                                          $valorTxt = $_GET[$nombreInput];
                                      if ($_POST[$nombreInput])
                                          $valorTxt = $_POST[$nombreInput];
                                      $valorTxt = strtoupper(trim($valorTxt));
                                      if ($parExpOrden == 4) { ?>
                                          <textarea name="<?= $nombreInput ?>" rows="2"
                                                    cols="60" <?php print $readonly; ?>><?= $valorTxt ?></textarea>
					<? } else {
					if($auxiliar_formulario==2){$helpnombre = "Para contratos escriba sigla sección, consecutivos de la contratación y año. Ej CDGCID45-15";}
					if($auxiliar_formulario==4){$helpnombre = "Escriba aquí información complementaria o No. de Tomo Ej_ TOMO 1 - Contrato CDGCID45-15";}
                                          ?>
					  <input type="text" name="<?= $nombreInput ?>" placeholder="<?=$helpnombre?>" title= "<?=$helpnombre?>" value="<?= $valorTxt ?>"
                                                 size="60" <?php print $readonly; ?>>
				      <? $helpnombre = "";
 } ?>
                                  </td>
                              </tr>
                              <?php $rsParExp->MoveNext();
                              $auxiliar_formulario = $auxiliar_formulario +1;
			  }  ?>



                         <tr>
                             <td>
                                 <small>Fecha Inicial</small>
                             </td>
                             <td align="left" colspan="5" >
				 <small>
				 <input type="text" name ="fecha_inicio" id="fecha_inicio" value="<?=$fecha_inicio?>" ><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                 </small>
                             </td>
                         </tr>

                         <tr>
                             <td>
                                 <small>Fecha Final</small>
                             </td>
                             <td align="left" colspan="5" >
                                 <small>
				 <input type="text" name ="fecha_final" id="fecha_final" value="<?=$fecha_final?>" ><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                 </small>
                             </td>
                         </tr>

                          <tr>
                              <td>
                                  <SMALL>Unidad de Conservación</SMALL>
                              </td>
                              <td>
                                  <label class=select>
                                      <?
                                      $queryUs = "select  ucons_nomb, ucons_id from sgd_unidad_conservacion";
                                      //  -- And D.Dep_Direccion In (Select Dep_Direccion From Dependencia Where Depe_Codi=$dependencia)
			  	      $rsUs = $db->conn->Execute($queryUs); //var_dump($rsUS);
					if ($coduc == ""){$coduc=1;}
                                      print $rsUs->GetMenu2("coduc", "$coduc", "", false, "", " class='select'");
                                      ?>
                                  </label>
                                  <i></i>
                              </td>
                              <td>
                                  <small>Folio Inicial</small>
                              </td>
			      <td>
				<small>
				<input type="text" size="5" name="folio_ini" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$folio_ini?>" >
				</small>		
                              </td>
                              <td>
                                  <small>Folio Final</small>
                              </td>
			      <td>
				<small>
				<input type="text" size="5" name="folio_fin" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$folio_fin?>" >
				</small>		
                              </td>
			  </tr>

                         <tr>
                             <td>
                                 <small>Observaciones</small>
                             </td>
                             <td align="left" colspan="5" >
                                 <small>
				 <textarea class="form-control" rows="3" name ="observaciones"><?=$observaciones?></textarea>
                                 </small>
                             </td>
			 </tr>

                         <tr>
                              <td></td>
                              <td>
                                  <SMALL>No. Caja</SMALL>
                              </td>
                              <td>
				<small>
				<input type="text" size="5" name="num_caja" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$num_caja?>" >
				</small>		
                              </td>
                              <td>
                                  <small>No. Carpeta</small>
                              </td>
			      <td>
				<small>
				<input type="text" size="5" name="num_carpeta" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$num_carpeta?>" >
				</small>		
                              </td>
			  </tr>
                         <tr>
                              <td></td>
                              <td>
                                  <SMALL>No. Estante</SMALL>
                              </td>
                              <td>
				<small>
				<input type="text" size="5" name="num_estante" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$num_estante?>" >
				</small>		
			      </td>

                              <td>
                                  <small>No. Fila</small>
                              </td>
			      <td>
				<small>
				<input type="text" size="5" name="num_fila" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$num_fila?>" >
				</small>		
                              </td>
			  </tr>
                         <tr>
                              <td></td>
                              <td>
                                  <SMALL>No. Columna</SMALL>
                              </td>
                              <td>
				<small>
				<input type="text" size="5" name="num_columna" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$num_columna?>" >
				</small>		
                              </td>
                              <td>
                                  <small>No. Bandeja</small>
                              </td>
			      <td>
				<small>
				<input type="text" size="5" name="num_bandeja" onkeypress="return justNumbers(event);" maxlength="5" value="<?=$num_bandeja?>" >
				</small>		
                              </td>
			  </tr>

          <tr>
             <td colspan="6">
                 <center>
                     <input name="crear" type="submit" class="btn btn-success" id="inserta" value="Grabar / Actualizar" >
                 </center>
             </td>
         </tr>
                      </table>
		  </div>

<? /*UTILIZAR ESTE CODIGO PARA CONFIRMAR LA CREACION DEL FUID */ ?>
		<? if ($_POST['crear'] == "Grabar / Actualizar") { 
?>
	<div id='confirmacionExp' style="position:absolute;left:10px; top:20px;height=1400;width=400">
            <table class="table table-striped smart-form dataTable " height="500">
                <tr align="center">
                    <td align="center" height=800>
                        <center class="alert alert-info no-margin fade in">
                            ESTA SEGURO DE ACTUALIZAR EL FUID <BR>
                            PARA ESTE EXPEDIENTE ? 
                        </center>
                        <b>
                            <center class="style1"><?= $numeroExpediente ?></center>
                        </b>

                        <div align="justify"><br>
                            <small><b>Recuerde:</b>No podr&aacute; modificar el numero de expediente si hay un error en
                                el expediente, mas adelante tendr&aacute; que excluir este radicado del expediente y si
                                es el caso solicitar la anulac                            </small>
                        </div>
			<footer>
                            <input name="Actualizar" type=submit class="btn btn-primary btn-xs"
                                   value="Confirmar" >
                            <input name="Actualizar" type=button class="btn btn-success btn-xs"
                                   value=" Cancelar Actualizaci&oacute;n " onclick="ocultarConfirmaExp();">
                        </footer>
                    </td>
            </table>

        </div>
    <? }

} ?>
<div>
    <table class="table table-bordered">
        <tr align="center">
            <td align="center">
                <center>
                    <?php
                    if ($tsub and $codserie && !$Actualizar and $usuaDocExp) {
                        #echo "---------------------------";
                        if (!$crearExpediente) {
                            if (is_array($arrProceso) && $codProc == 0) {
                                echo "<input name=\"crearExpediente\" type=\"button\" class=\"btn btn-primary btn-xs\" value=\" Crear Expediente \" onClick=\"alert('Por favor seleccione un proceso.'); document.TipoDocu.codProc.focus();\">";
                            } else {
                                echo "<input name=\"crearExpediente\" type=submit class=\"btn btn-primary btn-xs\" value=\" Crear Expediente \">";
                            }
                        } else {
                            // echo "<input name=\"Actualizar\" type=submit class=\"btn btn-primary btn-xs\" value=\" Confirmacion Creacion de Expediente \">";
                        }
                    }
                    ?>
                </center>
            </td>
        </tr>
        <tr>
            <td width="750">
		<center>
		 <?php if($MSG_response != ""){ ?>
		 <center class="style1" style="<?=$MSG_style?>" ><?=$MSG_response?></center>	
		 <?php } ?>
                </center>
            </td>
            <td width="750">
                <center>
                    <input name="cerrar" type="button" class="btn btn-primary btn-xs" id="envia22"
                           onClick="window.opener.$.fn.cargarPagina('expediente/lista_expedientes.php','tabs-a'); window.close();"
                           value=" Cerrar ">
                </center>
            </td>
        </tr>
    </table>
</div>
</div>
</div>
</div>
</article>
</div>
</section>
</div>
</form>
<script>
$.datepicker.regional['es'] = {
closeText: 'Cerrar',
prevText: '<Ant',
nextText: 'Sig>',
currentText: 'Hoy',
monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
weekHeader: 'Sm',
dateFormat: 'dd/mm/yy',
firstDay: 1,
isRTL: false,
showMonthAfterYear: false,
yearSuffix: ''
 };
$.datepicker.setDefaults($.datepicker.regional['es']);
</script>
  <script>
     $(function() {
    $( "#fecha_inicio" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat : "yy-mm-dd",
      numberOfMonths: 2,
      onClose: function( selectedDate ) {
       $( "#fecha_final" ).datepicker( "option", "minDate", selectedDate );
      }
    });

    $( "#fecha_final" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat : "yy-mm-dd",
      numberOfMonths: 2,
      onClose: function( selectedDate ) {
           $( "#fecha_inicio" ).datepicker( "option", "maxDate", selectedDate );
       }
    });
  });
  </script>
<script>
/*$( document ).ready(function() {
$.getScript("../tooltips/jquery-ui.js");
$.getScript("../tooltips/tool.js");
});*/
</script>
<script>

    function borrarArchivo(anexo, linkarch) {
        if (confirm('Esta seguro de borrar este Registro ?')) {
            nombreventana = "ventanaBorrarR1";
            url = "tipificar_documentos_transacciones.php?borrar=1&usua=<?=$krd?>&codusua=<?=$codusua?>&coddepe=<?=$coddepe?>&nurad=<?=$nurad?>&codiTRDEli=" + anexo + "&linkarchivo=" + linkarch;
            window.open(url, nombreventana, 'height=250,width=300');
        }
        return;
    }

    function procModificar() {
        if (document.TipoDocu.tdoc.value != 0 && document.TipoDocu.codserie.value != 0 && document.TipoDocu.tsub.value != 0) {
            <?php
                $sql = "SELECT RADI_NUME_RADI
              FROM SGD_RDF_RETDOCF
              WHERE RADI_NUME_RADI = '$nurad'
                AND  DEPE_CODI =  '$coddepe'";
              $rs=$db->conn->Execute($sql);
              $radiNumero = $rs->fields["RADI_NUME_RADI"];
              if ($radiNumero !='') {
                ?>
            if (confirm('Esta Seguro de Modificar el Registro de su Dependencia ?')) {
                nombreventana = "ventanaModiR1";
                url = "tipificar_documentos_transacciones.php?modificar=1&usua=<?=$krd?>&codusua=<?=$codusua?>&tdoc=<?=$tdoc?>&tsub=<?=$tsub?>&codserie=<?=$codserie?>&coddepe=<?=$coddepe?>&nurad=<?=$nurad?>";
                window.open(url, nombreventana, 'height=200,width=300');
            }
            <?php }else { ?>
            alert("No existe Registro para Modificar ");
            <?php } ?>
        } else {
            alert("Campos obligatorios ");
        }
        return;
    }
    function ocultarConfirmaExp() {
        // $("#confirmacionExp").addClass('hide');
        $("#confirmacionExp").hide();
    }

</script>
<?= $mensaje_err ?>
</body>
</html>
<!-- Ocultamos los campos inecesarios por el momento -->
<script>
$( "#OcultarMostrarCampos" ).click(function() { 
$( ".my_toogle" ).toggle( "slow", function() { });
});
 </script>
 <script type="text/javascript">
  function justNumbers(e)
  {
          var keynum = window.event ? window.event.keyCode : e.which;
   if ((keynum == 8) || (keynum == 46) || (keynum == 0))
   return true;
   return /\d/.test(String.fromCharCode(keynum));
  }
</script>
