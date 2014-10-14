<?
/**
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
$ruta_raiz = ".";
if (!$_SESSION['dependencia'])
header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
?>
<HTML>
<?
$krd          = $_SESSION["krd"];
$dependencia  = $_SESSION["dependencia"];
$usua_nomb    = $_SESSION["usua_nomb"];
$depe_nomb    = $_SESSION["depe_nomb"];
$usua_doc     = $_SESSION["usua_doc"];
$codusuario   = $_SESSION["codusuario"];

$ruta_raiz = "..";
$mensaje_error = false;

$verrad="";
define('ADODB_ASSOC_CASE', 1);
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler($ruta_raiz);

   if(!$tipo_archivo) $tipo_archivo = 0;   //Para la consulta a archivados

/*********************************************************************************
 *       Filename: formEnvio.php
 *       Modificado 1/3/2006 IIAC
 *********************************************************************************/

    // formEnvio CustomIncludes begin
    include ("common.php");
    // Save Page and File Name available into variables
    $sFileName  = "formEnvio.php";
    // Variables de control
    $pageAnt    = strip($_POST["sFileName"]);
    $opcionMenu = $_POST["opcionMenu"]; //opcion: prestar(1), cancelar(3) o devolver(2)
    $ordenar    = strip($_POST["ordenar"]);//1 si se dio ordenar y 0 de otro modo

    // Recupera el identificador de los registros seleccionados
    $cantRegistros =intval($_POST["prestado"]); //cantidad de registros listados en la consulta

    if($ordenar=="1"){
       //Recupera todos los registros presentados si se da ordenar
       $setFiltroSelect=strip($_POST["s_PRES_ID"]);
    } else {
        foreach ($_POST as $key => $valor){
            if (preg_match('/rta.[0-9]/',$key)){
                $setFiltroSelect .= empty($setFiltroSelect)? $valor : ", ".$valor ;
            }
        }
    }
   // Inicializa la identificacion del usuario solicitante
   $usua_codi=strip($_POST["usua_codi"]);   

   $query="select USUA_LOGIN_ACTU from PRESTAMO where PRES_ID in ($setFiltroSelect)";  //primer usuario de los registros
   $rs = $db->conn->query($query);		 
   
   if($rs && !$rs->EOF){ $usua_codi_n=$rs->fields("USUA_LOGIN_ACTU"); } //primer usuario de los registros    		
   $cant=0;   //cantidad de registros solicitados por el mismo usuario
   if($pageAnt==$sFileName && $ordenar==0) {
      $query=" select count(PRES_ID) as TOTAL from PRESTAMO where PRES_ID in ($setFiltroSelect) and USUA_LOGIN_ACTU='".$usua_codi."'";
      $rs = $db->conn->query($query);		 
      if ($rs && !$rs->EOF) { $cant=$rs->fields("TOTAL"); }
   }
   if($cant==0){ $usua_codi=$usua_codi_n; }
   // Recupera radicado e identificador de los registros seleccionados
   include("$ruta_raiz/include/query/busqueda/busquedaPiloto1.php");    
   if($pageAnt==$sFileName && $ordenar==0){  
      $query="select PRES_ID,$radi_nume_radi AS RADI_NUME_RADI from PRESTAMO r where PRES_ID in ($setFiltroSelect) and USUA_LOGIN_ACTU='".$usua_codi."'";
   }
   else{
      $query="select PRES_ID,$radi_nume_radi AS RADI_NUME_RADI from PRESTAMO r where PRES_ID in ($setFiltroSelect)"; 
   }
   $rs = $db->conn->query($query);
   $fldRADICADO="";  //RADI_NUME_RADI separados por coma
   $setFiltroSelect=""; //PRES_ID separados por coma
   $j=0;

   while($rs && !$rs->EOF) {
      $x=$rs->fields("RADI_NUME_RADI");
	  $y=$rs->fields("PRES_ID");
	  if ($j!=0) { 
	     $fldRADICADO.=","; 
		 $setFiltroSelect.=",";
	  }
	  $setFiltroSelect.=$y;		 
	  $fldRADICADO.=$x;
      $j++; 
      $rs->MoveNext();
   }  
   
   
   // Procesamiento de los registros seleccionados 
   $encabezado="&krd=".tourl($krd)."&s_PRES_ID=".tourl($setFiltroSelect)."&dependencia=".tourl($dependencia).
               "&radicado=".tourl($fldRADICADO)."&s_PRES_REQUERIMIENTO=&FormAction=";
   $enviar=0;

   if($opcionMenu==3) {  //cancelar
      $encabezado.="delete&";	  
      $enviar=1; 	  
   }			   
   elseif ($opcionMenu==1 || $opcionMenu==2) {  //prestamo y devoluci�n
      $query="select PARAM_VALOR from SGD_PARAMETRO where PARAM_NOMB='PRESTAMO_PASW'"; 
      $rs = $db->conn->query($query);
      if ($rs && !$rs->EOF) { $verClave = $rs->fields("PARAM_VALOR"); }         
      // Inicializa las variables   
      $flds_PRES_ESTADO=strip($_POST["s_PRES_ESTADO"]);    
      if ($opcionMenu==1) { //Pr�stamo
	     if($flds_PRES_ESTADO==5){ $encabezado.="prestamoIndefinido&"; }
	     else                    { $encabezado.="prestamo&"; }	  
         $titCaj="Prestar Documento"; 	  
         // Inicializacion de la fecha de vencimiento
         if ($fechaVencimiento=="") {	  	  	  
            $query="select PARAM_VALOR,PARAM_NOMB from SGD_PARAMETRO where PARAM_NOMB='PRESTAMO_DIAS_PREST'"; 
            $rs = $db->conn->query($query);
            if(!$rs->EOF) { 
               $x = $rs->fields("PARAM_VALOR");  // d�as por defecto
			   $hastaXDias = strtotime("+".$x." day"); 
	           $fechaVencimiento=date("Y-m-d",$hastaXDias);	
			}
		 }		 
      }
      else { // Devoluci�n		
         $encabezado.="devolucion&";
         $titCaj="Devolver Documento"; 	  
      }	  
      // Procesa la solicitud
      if ($pageAnt==$sFileName){
         $enviar     = 1;
   	     $nover      = 0;
	     $observa    = strip($_POST["observa"]);
         $encabezado.= "&observa=".tourl($observa)."&";

         if ($fechaVencimiento=="") {
              $query="select PARAM_VALOR,PARAM_NOMB from SGD_PARAMETRO where PARAM_NOMB='PRESTAMO_DIAS_PREST'";
              $rs = $db->conn->query($query);
              if(!$rs->EOF) {
                  $x = $rs->fields("PARAM_VALOR");  // d�as por defecto
                  $hastaXDias = strtotime("+".$x." day");
                  $fechaVencimiento=date("Y-m-d",$hastaXDias);
              }
         }
          // Validacion de la fecha de vencimiento para los prestamos
         if ($ordenar==0 && $opcionMenu ==1){
            $dat=date("Y-m-d");
	        if ($fechaVencimiento > $dat){
			   $encabezado.="&fechaVencimiento=".tourl($fechaVencimiento)."&"; 
			     } else {
			   echo "<script> alert('La fecha de vencimiento no puede ser menor o igual que la actual'); </script>"; 
			   $nover   = 1;
         $enviar  = 0;
			       }
  	     }
         /*// Validaci�n de la contrase�a
	     $flds_CONTRASENA=strip($_POST["s_CONTRASENA"]);
		 if ($ordenar==0 && $verClave==1 && $nover!=1) {
            $query="select USUA_CODI from USUARIO where USUA_LOGIN='".$usua_codi."' and USUA_PASW='".SUBSTR(md5($flds_CONTRASENA),1,26)."'"; 
            $rs = $db->conn->query($query);		 
            if($rs && !$rs->EOF) { $enviar=1; }
	        else { 
			   echo "<script> alert('La contraseña del usuario solicitante es incorrecta'); </script>"; 
               $enviar=0;
			}			
		 } */
	  }    
   }

    // Oculta o hace visible el campo que solicita la contrase�a
    $verClave = 0;

    if ($enviar==1 and $process==1) {
          // Llama la pagina que hace el procesamiento
        echo "<form action='".$ruta_raiz."/solicitar/Reservar.php?<?=$encabezado?>' method='post' name='go'> </form>";
        echo "<script>document.go.submit();</script>";
    }
   
   
   // Build SQL
   $sSQLsele=" and P.PRES_ID in (".$setFiltroSelect.") ";   
   include $ruta_raiz."/include/query/prestamo/builtSQL1.inc";   
   include $ruta_raiz."/include/query/prestamo/builtSQL3.inc";       
   // Build ORDER statement	  	  
   $iSort=strip($_POST["FormPedidos_Sorting"]);
   $iSorted=strip($_POST["FormPedidos_Sorted"]); 
   $sDirection=strip($_POST["s_Direction"]); 
   if($pageAnt!=$sFileName) {
      if($iSorted==$iSort && $sDirection=" DESC "){ $sDirection=" ASC "; }   
	  else{ $sDirection=" DESC "; }   
   }
   if($iSorted!=$iSort){ $sDirection=" DESC ";}
   else{ 	
	  if (strcasecmp($sDirection," DESC ")==0){ $sDirection=" ASC "; }
	  else { $sDirection=" DESC "; }  
   }

   $sOrder=" order by ".$iSort.$sDirection.",PRESTAMO_ID";   
   $sSQLtot=$sSQL.$sOrder;
   // Inicializa los campos de la tabla que van a ser vistos
   
   include "inicializarRTA.inc";		
   // HTML column prestamo headers		 		 		 
?>
<head>
	<title>Enviar Datos</title>	  
	<title>Sistema de informaci&oacute;n <?=$entidad_largo?></title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="<?=$ruta_raiz?>/img/favicon.png">
	<!-- Bootstrap core CSS -->
	<?php include_once "../htmlheader.inc.php"; ?>	 
</head>

<body class="smart-form">
<table class="table table-bordered smart-form">
	<tr>
		<td width=100%>
			<form action='<?=$ruta_raiz?>/solicitar/Reservar.php?<?=$encabezado?>' method=post name="rta" class="smart-form" >
			<input type="hidden"  value='<?=$krd?>' name="krd">
            <input type="hidden"  value='0' name="process">
			<input type="hidden" value=" " name="radicado">  	 
			<input type="hidden" value="<?=$cantRegistros?>" name="prestado">  	 								
			<input type="hidden" value="<?=$sFileName?>" name="sFileName">  				 								
			<input type="hidden" name="opcionMenu" value="<?= $opcionMenu ?>">	  						
			<input type="hidden" name="usua_codi" value="<?=$usua_codi?>">				
			<input type="hidden" name="FormPedidos_Sorting" value="<?=$iSort?>">
			<input type="hidden" name="FormPedidos_Sorted" value="<?=$iSorted?>">
			<input type="hidden" name="s_Direction" value="<?=$sDirection?>">				         
			<input type="hidden" name="ordenar" value="0"> <!-- no ordena !-->
			<input type="hidden" name="s_PRES_ID" value="<?=$setFiltroSelect?>">				                 	  								
		<table width="100%" class="table table-bordered">
            <tr>
                <TD width=30% ><SMALL>USUARIO:<?=$usua_nomb?><br></SMALL></TD>
                    <TD width='30%' ><SMALL>DEPENDENCIA:<?=$depe_nomb?><br></SMALL></TD>
                <TD width="35%" ><SMALL><?=$titCaj?></SMALL></td>
                <td width='5' ><input type=button value=REALIZAR onclick="okTx();" name=enviardoc align=bottom  id=REALIZAR class="btn btn-primary"></td>
            </tr>
			<tr align="center">
				<td colspan="4"  align=center><center>
				<table class="table table-bordered">
						<tr bgcolor="White">
				<td width="300"></td>
				<td align="left">
				<label class="textarea">
					<i class="icon-append fa fa-comment"></i>
					<textarea placeholder="Comentario . . . " name="observa" rows="1"><?=$observa?></textarea>
					</label>
				</tr>  			             
<? if ($opcionMenu==1) {  // Prestamo?>
	<tr bgcolor="White">
	<td width="100" align="right" ><small>Estado:</small></td>
		<td align="left"><label class=select><select class="select" name="s_PRES_ESTADO" onChange="javascript: ver(); ">
<?    $query="select PARAM_CODI, PARAM_VALOR from SGD_PARAMETRO where PARAM_NOMB='PRESTAMO_ESTADO' and PARAM_CODI in (2,5,6) ORDER BY PARAM_CODI"; 
	$rs = $db->conn->query($query);
	while($rs && !$rs->EOF) {
			$idEstado =$rs->fields("PARAM_CODI");
			$txtEstado=$rs->fields("PARAM_VALOR");	
		$x="";	  	  		 
	if ($flds_PRES_ESTADO==$idEstado) { $x=" selected "; } 
			echo " <option ".$x." value=".$idEstado.">".strtoupper($txtEstado)."</option> ";	   
			$rs->MoveNext();
	} ?>
	</select></td>
	</tr>						  									  					  
		<tr bgcolor="White" id="fecha">
			<td width="100" align="right" class="titulosError2" title="(aaaa-mm-dd)">Fecha de Vencimiento(aaaa/mm/dd)</td>	 
            <td align="left">
                <section class="col col-3">
                    <label class="input">
                    <i class="icon-append fa fa-calendar"></i>
                    <input id="startdate" type="text" placeholder="Seleccione la Fecha" name="fechaVencimiento">
                    </label>
                </section>
		    </td>
			</tr>


	<script>
		// Oculta o hace visible el campo de la fecha de vencimiento dependiendo del estado seleccionado por el usuario
		function ver() {
		var verFecha=document.rta.s_PRES_ESTADO.options[document.rta.s_PRES_ESTADO.selectedIndex].value;
		if(verFecha==2){ fecha.style.display = ''; }
	else {           fecha.style.display = 'none'; }
	}
			ver();
	</script>					  					  
<? }
?> 
      <tr bgcolor="White" id="psduserw">
      <td width="100" align="right" class="titulosError2" title="(aaaa-mm-dd)">Contraseña del usuario:</td>   
            <td align="left">
                <input id="passrwduser" type="password"  autocomplete="off"  placeholder="" name="paswrduser">
                 <input type="button" class="btn btn-primary" value="Comprobar" onclick="compararpassword();">
         </td>
      </tr>
<?php
   if ($verClave==1) {  ?>					  
			<tr bgcolor="White">
			<td width="100" align="right"><small>Contrase&ntilde;a<br><?=$usua_codi?></small></td>
			<td align="left"><input type="password" name="s_CONTRASENA" value="<?=$flds_CONTRASENA?>"></td>
		</tr>
<? } ?>
	</table></center></td>
	</tr>
		<tr align="center">
			<td colspan="4" class="celdaGris" align=center><center>
			<table width="100%"  align="center" bgcolor="White">
					<TR bgcolor="White">
			<TD width="100%" align="center">					 
	<table align="center" class="table table-bordered" width="100%">	   
<?PHP      
   include "inicializarTabla.inc";     
   // Execute SQL statement	
   $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
   $rs=$db->query($sSQLtot);
   $db->conn->SetFetchMode(ADODB_FETCH_NUM);           
   // Display grid based on recordset
   $y=0; // Cantidad de registros presentados 
   include_once "getRtaSQLAntIn.inc"; //Une en un solo campo los expedientes
   while($rs && !$rs->EOF) {
      // Inicializa las variables con los resultados
	  include "getRtaSQL.inc";		
	  if ($antfldPRESTAMO_ID!=$fldPRESTAMO_ID) {
		 if ($y!=0) {  include "cuerpoTabla.inc"; } // Fila de la tabla con los resultados
		 include "getRtaSQLAnt.inc";
		 $y++;
	  }else {		 
		 if ($antfldEXP!=""){ 
			$antfldEXP.="<br>"; 
   	        $antfldARCH.="<br>"; 
		 }
		 $antfldEXP.=$fldEXP;
		 if ($fldARCH=='SI') {
  			$encabARCH = session_name()."=".session_id()."&buscar_exp=".tourl($fldEXP)."&krd=$krd&tipo_archivo=&nomcarpeta=";
		    $antfldARCH.="<a href='".$ruta_raiz."/expediente/datos_expediente.php?".$encabARCH."&num_expediente=".tourl($fldEXP)."&nurad=".tourl($antfldRADICADO)."' class='vinculos'>".$fldARCH."</a>";
		 }
	     else { $antfldARCH.=$fldARCH; }		 		 
	  }
      $rs->MoveNext(); 			
   }
   if ($y!=0) {	  		 
      include "cuerpoTabla.inc";  // Fila de la tabla con lso resultados						 
      $y++;	  
   } 
   $iCounter=$y-1;  //cantidad de registros
 ?>
	</table>
		</TD>
		</tr>
	</table></center></td>
	</tr>			 
</TABLE><br>
		</form></td>
	</tr>
	</table>
  <script type="text/javascript" src="jquerycript.js"></script>
 <script>

 /**/
    $(document).ready(function() {
      $("#REALIZAR").hide();
      $("#passrwduser").prop('disabled', false);
    }); 
 		// START AND FINISH DATE
		$('#startdate').datepicker({
			dateFormat : 'yy/mm/dd',
			prevText : '<i class="fa fa-chevron-left"></i>',
			nextText : '<i class="fa fa-chevron-right"></i>',
			onSelect : function(selectedDate) {
				$('#startdate').datepicker('option', 'minDate', selectedDate);
			}
		});
// Envia el formulario para que sea ordenado segun el criterio indicado
	function ordenar(i) {
		document.rta.action="formEnvio.php";
		document.rta.FormPedidos_Sorting.value=i;
		document.rta.FormPedidos_Sorted.value=<?=$iSort?>;
		document.rta.ordenar.value=1;	  	  
		document.rta.submit();
	} 
    // Marca todas las casillas si la del titulo es marcada
	function seleccionarRta() {
	   valor=document.rta.rta_.checked;
<? for ($j=0; $j<$iCounter; $j++) {
       $v = $j + 1 ;?>
       document.rta.rta_<?=$v?>.checked=valor;
<? } ?>
    } 

    // Verifica que el navegador soporte las funciones de Javascript 
    function setSel(start,end){
       document.rta.observa.focus();	
       var t=document.rta.observa;
       if(t.setSelectionRange){
          t.setSelectionRange(start,end);
          t.focus();
     }else{ alert('Su browser no soporta las funciones Javascript de esta pagina.'); }
    } 	
    // Verifica el m�ximo n�mero de caracteres permitido 
    function valMaxChars(maxchars) {
      document.rta.observa.focus();		
      if(document.rta.observa.value.length > maxchars) {
   	     alert('Demasiados caracteres en el texto, solo se permiten '+ maxchars);
 	     setSel(maxchars,document.rta.observa.value.length);
         return false; 
	  }
      else { return true; }
    } 
	// Valida los campos antes de enviar el formulario 
    function okTx() {
       valCheck = $( "input:checked" ).length - 1;
	   if(valCheck==0) {
     	  alert('Debe seleccionar al menos un radicado');	   	   
	      return 0;
	   }
       verClave=<?=$verClave?>;
	   if (verClave==1) {
		  if (document.rta.s_CONTRASENA.value=="") { 
		     alert('Digite la contraseña del usuario solicitante');
			 return 0;
		  }
	   }
	   numCaracteres = document.rta.observa.value.length;
	   if(numCaracteres>=6){
		 if (valMaxChars(550)) {
	        document.rta.prestado.value=<?=$iCounter?>;
            document.rta.action  ='<?=$sFileName?>?';
            document.rta.process.value = 1;
		    document.rta.submit(); 
		 }
	   }else{ 
	      alert("Atencion: El numero de Caracteres minimo en la Observacion es de 6. (Digito :"+numCaracteres+")"); 
		  return 0;
	   }	 	     
    }
	// Marca todas las cajas de seleccion arrancando la pagina
    document.rta.rta_.checked=true;
 	seleccionarRta();


      function compararpassword() {
         // var passhtml = md5($("#passrwduser").val());
        var passhtml = $("#passrwduser").val();
        var passphp = $("#use_paswor_dmd5").html();

        var strMD5 = $().crypt({ method: "md5", source: passhtml });
        var strMD5 = strMD5.substring(1,27);

        //console.log(passphp);
        //console.log(strMD5);

         // passhtml.toString();
          passphp.toString();

   if (strMD5==passphp){
    $("#REALIZAR").show();
    $("#passrwduser").css("border", "1px solid green");
    $("#passrwduser").prop('disabled', true);
    $("#passrwduser").val("");
  }else{
    //alert ('la contraseña es incorrecta');
  $("#passrwduser").css("border", "1px solid red");
  $("#passrwduser").val("");
  }
  }

  </script>
 </body>
</html>
