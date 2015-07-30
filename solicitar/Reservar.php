<?php
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

define('ADODB_ASSOC_CASE', 1);
$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$codusuario  = $_SESSION["codusuario"];
$tip3Nombre  = $_SESSION["tip3Nombre"];
$tip3desc    = $_SESSION["tip3desc"];
$tip3img     = $_SESSION["tip3img"];   $verrad = "";
$ruta_raiz = "..";

include_once "$ruta_raiz/include/db/ConnectionHandler.php";

$db   = new ConnectionHandler($ruta_raiz);

$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
/*********************************************************************************
  Facilita la interfaz para que el usuario cancele o
  solicite un documento fisico y realiza las
  actualizaciones relacionadas con el modulo de
  prestamos en la base de datos.
*********************************************************************************/
// Reservar CustomIncludes begin
   include "common.php";
// Save Page and File Name available into variables
   $sFileName = "Reservar.php";
// Save the name of the form and type of action into the variables
   // Modificado Infometrika 14-Julio-2009
   // Se mantiene la funcion get_param().
   //$sAction = $_POST["FormAction"];
   $sAction = get_param("FormAction");
   $sPRESTAMOErr=""; //Mensaje de error
   PRESTAMO_action($sAction); //insert, cancel, update


$_GLOBAL["numExpediente"] = $_GET["numExpediente"];
//===============================
// Display page
//-------------------------------
?>
   <html>
      <head>
				<title>..:: Sistema de informaci&oacute;n <?=$entidad_largo?> ::..</title>
				<meta charset="utf-8">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				 <?php include_once "../htmlheader.inc.php"; ?>
      </head>
      <body class="PageBODY">
         <table align="center">
            <tr>
               <td valign="top"><?php ESTADO_PRESTAMO_show() ?></td>
            </tr>
            <tr>
               <td valign="top"><?php PRESTAMO_show($estadoTx) ?></td>
            </tr>
         </table>
      </body>
   </html>
<?php
//-------------------------------



//===============================
// verMensaje($nombTx,$fecha) begin
//                            Presenta el mensaje con el resumen de la accion
//                            ejecutada: cancelacion, prestamo, devolucion, etc.
//-------------------------------
function verMensaje($nombTx,$fecha) {
   global $sPRESTAMOErr;
   global $usua_nomb;
   global $depe_nomb;
$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$codusuario = $_SESSION["codusuario"];
$usua_nomb = $_SESSION["usua_nomb"];
$depe_nomb = $_SESSION["depe_nomb"];
   // Modificado Infometrika 14-Julio-2009
   // Se mantiene la funcion get_param().
   //$nomRad=$_GET["radicado"];
   $nomRad=get_param("radicado");
   //if (!$nomRad) $nomRad=$_POST["radicado"];
   if(strlen($nomRad)>17) { $nomRad=str_replace(",","<br>",$nomRad); }
   $sPRESTAMOErr="no presentar";  //para que solo se haga visible esta funcion ?>
		<table  class="table table-bordered" id=tb_general align="left">
				<tr>
				<th colspan="2" ><div class="alert alert-success fade in">
					<button class="close" data-dismiss="alert"> × </button>
					<i class="fa-fw fa fa-check"></i>
					<strong>Accion Realizada</strong>
					</div></th>
				</tr>
				<tr>
				<td align="right"  >ACCION REQUERIDA:</td>
					<td  width="65%"  class="listado2_no_identa"><?=$nombTx?></td>
				</tr>
				<tr>
				<td align="right"  >RADICADOS INVOLUCRADOS:</td>
				<td  width="65%"  class="listado2_no_identa"><?=$nomRad?></td>
				</tr>
				<tr>
				<td align="right"  >FECHA:</td>
					<td  width="65%"  class="listado2_no_identa"><?=$fecha?></td>
				</tr>
				<tr>
				<td align="right"  >FECHA VENCIMIENTO:</td>
					<td  width="65%"  class="listado2_no_identa"><?=$_GET["fechaVencimiento"]?></td>
				</tr>
				<tr>
				<td align="right"  >USUARIO ORIGEN:</td>
					<td  width="65%"  class="listado2_no_identa"><?=$usua_nomb?></td>
				</tr>
				<tr>
				<td align="right"  >DEPENDENCIA ORIGEN:</td>
					<td  width="65%"  class="listado2_no_identa"><?=$depe_nomb?></td>
				</tr>
		</table>
<?
}
//-------------------------------


//===============================
// PRESTAMO_action begin
//                 Actualiza la base de datos con las
//                 acciones realiadas (solicitar,prestar,etc.)
//-------------------------------
function PRESTAMO_action($sAction) {
    global $db;
    global $krd; //usuario actual
    global $dependencia; //dependencia del usuario actual
    $ruta_raiz = "..";
    $db->conn->debug = false;

    $krd         = $_SESSION["krd"];
    $dependencia = $_SESSION["dependencia"];
    $codusuario  = $_SESSION["codusuario"];
    $setHisExp   = true;

    include_once "$ruta_raiz/include/tx/Historico.php";
    $hist = new Historico($db);

    $fldradicado   = get_param("radicado");
    $snoExpDev     = explode(",",get_param("snoExpDev"));
    $fldexpediente = $GLOBALS["numExpediente"];
    $arrRadicado   = explode(",",get_param("radicado"));
    if(!is_array($arrRadicado)){
      $arrRadicado[] = $arrRadicado;
    }

    $krd = $_SESSION["krd"];
    // Regresa al menu del radicado
    if ($sAction=="cancelar") {
        echo ".."; // dejar esto para que el navegador deje hacer el submit
        echo "<form name=Atras action='../verradicado.php?&verrad=$fldradicado' method=post class='smart-form'> </form>";
        echo "<script>document.Atras.submit();</script>";
        // Registro de una nueva solicitud
    }elseif ($sAction=="insert") {
        // Se mantiene la funcion get_param().
        //$fldPRES_REQUERIMIENTO = $_POST["s_PRES_REQUERIMIENTO"];
        $fldPRES_REQUERIMIENTO = get_param("s_PRES_REQUERIMIENTO");
        $fldPRES_FECH_PEDI = $db->conn->OffsetDate(0,$db->conn->sysTimeStamp);
        // Obtiene la ubicacion fisica de los documentos
        $fldPRES_DEPE_ARCH=substr($fldradicado,4,3);
        // $fldPRES_DEPE_ARCH=;
        $query="SELECT UBIC_DEPE_ARCH FROM UBICACION_FISICA WHERE UBIC_DEPE_RADI=".$fldPRES_DEPE_ARCH;
        $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
        $rs = $db->conn->query($query);
        if(!$rs->EOF){
            $fldPRES_DEPE_ARCH = $rs->fields['UBIC_DEPE_ARCH'];
        }
        // Genera PRES_ID
        $sec=$db->conn->nextId('SEC_PRESTAMO');
        $sSQL = "insert into PRESTAMO(
                  PRES_ID,
                  RADI_NUME_RADI,
		   	      USUA_LOGIN_ACTU,
			      DEPE_CODI,
                  PRES_FECH_PEDI,
                  PRES_DEPE_ARCH,
                  PRES_ESTADO,
                  PRES_REQUERIMIENTO)
               values (".
            tosql($sec,"Number")."," .
            tosql($fldradicado,"Text")."," .
            tosql($krd,"Text")."," .
            tosql($dependencia,"Number")."," .
            $fldPRES_FECH_PEDI."," .
            tosql($dependencia,"Number").",
                  1," .
            tosql($fldPRES_REQUERIMIENTO,"Number").
            ")";
        // Execute SQL statement
        if($db->conn->query($sSQL)) {
            // Cuando se crea el registro de prestamo enviamos una alerta a los usuarios
            // para notificarlos sobre la accion.
            // El include requiere las siguientes variables
            $codTx               = 10;
            $usuaCodiMail        = $codusuario ;
            $depeCodiMail        = $dependencia;
            $radicadosSelText    = $fldradicado;
	    $observa = "prestamo";
            $asuntoMailPrestamo  = "Se realizo el prestamo de un documento ($fldradicado)";
            include "$ruta_raiz/include/mail/mailInformar.php";
            // some statement that removes all printed/echoed items
            ob_end_clean();
        }else{
            echo "<script> alert(\" El registro no pudo ser realizado\"); </script>";
        }
    }

    // Cancelacion, prestamo o devolucion de un documento
    elseif ($sAction=="prestamo" || $sAction=="prestamoIndefinido" || $sAction=="delete" || $sAction=="devolucion") {
        $fecha=date("d-m-Y  h:i A");
        // Inicializa parametros para SQL
        $fldPRES_FECH=$db->conn->OffsetDate(0,$db->conn->sysTimeStamp);
        // Modificado Infometrika 14-Julio-2009
        // Se mantiene la funcion get_param() y se mantiene el nombre de la variable $fldPRES_ID de la versi�n original del m�dulo.
        //$sfldPRES_ID=$_POST["s_PRES_ID"];
        $fldPRES_ID=get_param("s_PRES_ID");
        // Modificado Infometrika 14-Julio-2009
        // Se mantiene el nombre de la variable $fldPRES_ID dentro de tosql() de la version original del modulo.
        //$sfldPRES_ID=str_replace("'","","".tosql($sfldPRES_ID,"Text"));  // identifiador de los registros
        $sfldPRES_ID=str_replace("'","","".tosql($fldPRES_ID,"Text"));  // identifiador de los registros
        $estadoOld="=1";
        // Prestamo
        if($sAction=="prestamoIndefinido" || $sAction=="prestamo"){
            // Modificado Infometrika 14-Julio-2009
            // Se mantiene la funcion get_param().
            //$fldDESC=tosql($_GET["observa"],"Text");
            $fldDESC=tosql(get_param("observa"),"Text");
            $setFecha="PRES_FECH_PRES=".$fldPRES_FECH.", PRES_DESC=".$fldDESC.", USUA_LOGIN_PRES='".$krd."' ";
            $nombTx="Prestar Documento";
            if($sAction=="prestamoIndefinido"){
                $estadoNew=5;
                $titError="El registro del pr&eacute;stamo indefinido no pudo ser realizado";
            }
            else{
                $estadoNew=2;
                $fechaVencimiento=$_GET["fechaVencimiento"];
                $sqlFechaVenc=$db->conn->DBDate($fechaVencimiento);
                $setFecha.=",PRES_FECH_VENC=".$sqlFechaVenc." ";
                $titError="El registro del pr&eacute;stamo no pudo ser realizado";
            }
        }
        // Cancelacion de solicitud
        elseif($sAction=="delete") {
            $estadoNew=4;
            $setFecha="PRES_FECH_CANC=".$fldPRES_FECH.", USUA_LOGIN_CANC='".$krd."'";
            $nombTx="Cancelar Solicitud de Pr&eacute;stamo";
        }

        // Devolucion
        elseif($sAction=="devolucion") {
          $estadoNew=3;
          $fldDESC   =tosql(get_param("observa"),"Text");
          $setFecha  ="PRES_FECH_DEVO=".$fldPRES_FECH.", DEV_DESC=".$fldDESC.", USUA_LOGIN_RX='".$krd."' ";
          $nombTx    ="Devolver Documento prestado";
          $titError  ="El registro de la devolucion no pudo ser realizado";
          $estadoOld ="in (2,5)";

          if(!empty($snoExpDev)){
            $sqlformatExp = $sqlformatExp2 = implode(",", $snoExpDev);
            if(is_array($sqlformatExp)){
              foreach($sqlformatExp as $key){
                $sqlformatExp .= empty($sqlformat)? "'$key'" : ",'$key'";
              }
            }else{
              $sqlformatExp = "'$sqlformatExp'";
            }

            $sSQL = "update prestamo set $setFecha, pres_estado=$estadoNew where sgd_exp_numero in ($sqlformatExp)";
            $db->conn->query($sSQL);

            $sSqlE= "update sgd_sexp_secexpedientes set sgd_sexp_prestamo = false where sgd_exp_numero in ($sqlformatExp)";
            $db->conn->query($sSqlE);

            if($setHisExp){
              if(is_array($sqlformatExp2)){
                foreach($sqlformatExp2 as $key){
                  $hist->insertarHistoricoExp($key, $arrRadicado, $dependencia, $codusuario, $nombTx, 192,1);
                }
              }else{
                $hist->insertarHistoricoExp($sqlformatExp2, $arrRadicado, $dependencia, $codusuario, $nombTx, 192,1);
              }
              $setHisExp = false;
            }
          }
        }
        // Create SQL statement
        $sSQL = "UPDATE PRESTAMO SET ".$setFecha.",PRES_ESTADO=".$estadoNew."
		             WHERE PRES_ID IN (".$sfldPRES_ID.") AND PRES_ESTADO ".$estadoOld;

        // Execute SQL statement
        if($db->conn->query($sSQL)){
            $codTx               = 10;
            $usuaCodiMail        = $codusuario ;
            $depeCodiMail        = $dependencia;
            $radicadosSelText    = $fldradicado;
            $asuntoMailPrestamo  = "Se realizo una  acción de prestamo de un documento ($fldradicado)";
	    $observa = "devoluci&oacute;n";
            include "$ruta_raiz/include/mail/mailInformar.php";
            // some statement that removes all printed/echoed items
            ob_end_clean();
            verMensaje($nombTx,$fecha);
        }else{
            echo "<script> alert(".$titError."); </script>";
        }
    }
}

//===============================
// ESTADO_PRESTAMO_show begin
// Presenta el estado del documento
// y sus anexos.
//-------------------------------

function ESTADO_PRESTAMO_show() {
   global $db;
   global $sFileName;
   global $sPRESTAMOErr;
   // Modificado Infometrika 14-Julio-2009
   // Se mantiene la funcion get_param().
   $db->conn->debug = false;
   $fldradicado=get_param("radicado");
   $fldexpediente=$GLOBALS["numExpediente"];
   $krd = $_SESSION["krd"];
   $dependencia = $_SESSION["dependencia"];
   // Modificado Infometrika 14-Julio-2009
   // Esta operacion se realiza en el script solicitar/common.php, funcion get_param().
   include_once("../include/query/busqueda/busquedaPiloto1.php");
   if ($sPRESTAMOErr=="") {
      // Build SQL statement
	  $sqlPRES_FECH_PEDI=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_PEDI");
	  $sqlPRES_FECH_CANC=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_CANC");
	  $sqlPRES_FECH_DEVO=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_DEVO");
	  $sqlPRES_FECH_PRES=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_PRES");
	  $sqlPRES_FECH_VENC=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_VENC");
	  $sSQL="select
                r.PRES_ID as PRESTAMO_ID,
                $radi_nume_radi as RADICADO,
                r.USUA_LOGIN_ACTU as LOGIN,
                D.DEPE_NOMB as DEPENDENCIA,".
                $sqlPRES_FECH_PEDI." as F_SOLICITUD,".
                $sqlPRES_FECH_VENC." as F_VENCIMIENTO,".
                $sqlPRES_FECH_CANC." as F_CANCELACION,".
                $sqlPRES_FECH_PRES." as F_PRESTAMO,".
                $sqlPRES_FECH_DEVO." as F_DEVOLUCION,
                G.PARAM_VALOR as REQUERIMIENTO,
                E.PARAM_VALOR as ESTADO,
				r.PRES_ESTADO as ID_ESTADO
             from
	      	     PRESTAMO r, DEPENDENCIA D, SGD_PARAMETRO E, SGD_PARAMETRO G
             where
		        r.RADI_NUME_RADI=$fldradicado and
                r.PRES_ESTADO in (1,2,5) and
			    D.DEPE_CODI=R.DEPE_CODI and
   			    E.PARAM_NOMB='PRESTAMO_ESTADO' and
			    E.PARAM_CODI=R.PRES_ESTADO and
			    G.PARAM_NOMB='PRESTAMO_REQUERIMIENTO' and G.PARAM_CODI=r.PRES_REQUERIMIENTO";
      // Execute SQL statement
      $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
      $rs=$db->query($sSQL);
      // Process empty recordset
      if($rs && !$rs->EOF) { ?>
                  <script>
                     /*Adecua el formulario para que se cancele la solicitud*/
                     function cancelar(i) {
                        document.Prestados.FormAction.value="delete";
                        document.Prestados.s_PRES_ID.value=i;
               	        document.Prestados.submit();
                     }
                  </script>
                  <form method="POST" action="<?=$sFileName ?>" name="Prestados" class='smart-form'>
                     <input type="hidden"  value='<?=$krd?>' name="krd">
                     <input type="hidden" value="cancelar" name="FormAction">
                     <input type="hidden" value="" name="s_PRES_ID">
                     <input type="hidden" value="<?=$fldradicado?>" name="radicado">
                      <div>
                          <h1 class="page-title txt-color-blueDark"><i class="glyphicon glyphicon-inbox"></i>
                              Reserva de documentos</span>
                          </h1>
                      </div>
                     <table class='table table-bordered'>
                        <tr  align="center" valign="middle">
                           <th><a href=''>Radicado</a></th>
                           <th><a href=''>Expediente</a></th>
                           <th><a href=''>Login</a></th>
                           <th><a href=''>Dependencia</a></th>
                           <th><a href=''>Fecha<br>Solicitud</a></th>
                           <th><a href=''>Fecha<br>Vencimiento</a></th>
                           <th><a href=''>Requerimiento</a></th>
                           <th><a href=''>Estado</a></th>
                           <th><a href=''>Accion</a></th>
                        </tr>
<?
         $iCounter = 0;
         // Display result
         while($rs && !$rs->EOF) {
             $iCounter++;
             // Create field variables based on database fields
             $fldPRES_ID=       $rs->fields["PRESTAMO_ID"];
             $fldRADICADO=      $rs->fields["RADICADO"];
             $fldEXPEDIENTE=    $rs->fields["SGD_EXP_NUMERO"];
             $fldLOGIN=         $rs->fields["LOGIN"];
             $fldDEPENDENCIA=   $rs->fields["DEPENDENCIA"];
             $fldPRES_FECH_PEDI=$rs->fields["F_SOLICITUD"];
             $fldPRES_FECH_VENC=$rs->fields["F_VENCIMIENTO"];
             $fldPRES_FECH_CANC=$rs->fields["F_CANCELACION"];
             $fldPRES_FECH_PRES=$rs->fields["F_PRESTAMO"];
             $fldPRES_FECH_DEV= $rs->fields["F_DEVOLUCION"];
             $fldPRES_REQUERIMIENTO=$rs->fields["REQUERIMIENTO"];
             $fldPRES_ESTADO=   $rs->fields["ESTADO"];
			 $fldID_ESTADO=     $rs->fields["ID_ESTADO"];
    		 $accion="";
		     if (strcasecmp($krd,$fldLOGIN)==0 && $fldID_ESTADO==1) {
		        $accion="<a href=\"javascript: cancelar($fldPRES_ID); \">Cancelar Solicitud</a>";
		     }
             $rs->MoveNext();
             // Indica el estilo de la fila
             if($iCounter%2==0){ $tipoListado="class=\"listado2\""; }
             else              { $tipoListado="class=\"listado1\""; }
             // HTML prestamo show begin	  ?>
                        <tr <? echo $tipoListado; ?> align="center">
                           <td class="leidos"><?= tohtml($fldRADICADO); ?></td>
                           <td class="leidos"><?= tohtml($fldEXPEDIENTE); ?></td>
                           <td class="leidos"><?= tohtml($fldLOGIN); ?></td>
                           <td class="leidos"><?= tohtml($fldDEPENDENCIA); ?></td>
                           <td class="leidos"><?= tohtml($fldPRES_FECH_PEDI); ?></td>
                           <td class="leidos"><?= tohtml($fldPRES_FECH_VENC); ?></td>
                           <td class="leidos"><?= tohtml($fldPRES_REQUERIMIENTO); ?></td>
                           <td class="leidos"><?= tohtml($fldPRES_ESTADO); ?></td>
                           <td class="leidos"><?=$accion?></td>
                        </tr>
<?       } ?>
                        <tr  align="center">

                           <td  colspan="9" align="center"><footer><input type="submit" class='btn btn-default' value="Regresar">
                           </footer>
                           </td>
                        </tr>
                     </table>
					 <br>
                  </form>
<?    }
   }
}
//-------------------------------



//===============================
// PRESTAMO_SHOW begin
//               Presenta el formulario para que
//               el usuario haga la solicitud de los
//               fisicos.
//-------------------------------
function PRESTAMO_show() {
   global $db;
   global $sFileName;
   global $sPRESTAMOErr;
   $db->conn->debug = false;
   $fldradicado=get_param("radicado");
   $fldexpediente=$GLOBALS["numExpediente"];
   $krd = $_SESSION["krd"];
   $dependencia = $_SESSION["dependencia"];

   $sFormTitle="Reservar";
   // Modificado Infometrika 14-Julio-2009
   // Esta operacion se realiza en el script solicitar/common.php, funcion get_param().
   /*
   $fldradicado=$_GET["radicado"];
   if (!$fldradicado) $fldradicado=$_POST["radicado"];
   */
   $historicos=999;

   if ($sPRESTAMOErr=="") {
      // SQL que verifica la existencia de anexos para el radicado
      $sSQL1 = "select
                   R.RADI_DESC_ANEX as ANEXO,
		   R.RADI_DEPE_ACTU as DEPE_RADICADO,
		   U.USUA_LOGIN as USUARIO_RADICADO,
		   R.DEPE_CODI as DEPE_CODI_RADICADO
      			from
			       RADICADO R,
				   USUARIO U
			    where
			       R.RADI_NUME_RADI=$fldradicado and
			       U.USUA_CODI=R.RADI_USUA_ACTU and
				   U.DEPE_CODI=R.RADI_DEPE_ACTU";
      //$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
      $rs1 = $db->conn->query($sSQL1);
      // Inicializacion de la variable que indica si el usuario puede o no hacer solicitudes
      if(!$rs1->EOF) {
         $fldANEXO=$rs1->fields["ANEXO"]; //campo que indica la existencia de anexos para el radicado
      	 $fldUSUARIO_RADICADO=$rs1->fields["USUARIO_RADICADO"];
	 $fldDEPE_RADICADO=$rs1->fields["DEPE_RADICADO"];
	 $fldDEPE_CODI_RADICADO=$rs1->fields["DEPE_CODI_RADICADO"];
      	 if ($fldDEPE_RADICADO!=$historicos && $fldUSUARIO_RADICADO!=$krd) {
	        $sPRESTAMOErr=" solo puede ser solicitado y prestado al usuario $fldUSUARIO_RADICADO";
	     }
      }
      // SQL con los tipos de requerimientos que se pueden realizar
      $sSQL = "select
                  P.PRES_REQUERIMIENTO as REQUERIMIENTO
               from
			      PRESTAMO P
               where
			      P.RADI_NUME_RADI=$fldradicado and
                  P.PRES_ESTADO in (1,2,5) ";
     // $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
      $rs=$db->query($sSQL);
      //$db->conn->SetFetchMode(ADODB_FETCH_NUM);
      $iCounter = 0;
      while($rs && !$rs->EOF) {
         $i[$iCounter]=$rs->fields["REQUERIMIENTO"];
         $iCounter++;
         $rs->MoveNext();
      }
      $reqPrestados = 0;
      for ($j=0; $j<$iCounter; $j++){ $reqPrestados=$reqPrestados+$i[$j]; }
      $sqlReq="";
      if ($iCounter==0) {
         if (strlen(trim($fldANEXO))==0){
           $sqlReq=" =1 ";
           if($GLOBALS["numExpediente"]) $sqlReq=" in (1,4) ";
           }
	     else                           {
	          $sqlReq=" in (1,2,3) ";
	         if($GLOBALS["numExpediente"]) $sqlReq=" in (1,2,3,4) ";
	     }
      }

      else if ($iCounter==1 && $reqPrestados<3 && $reqPrestados>0){
         if (strlen(trim($fldANEXO))!=0){ $sqlReq=" =".(3-$reqPrestados); }
      }
//$sqlReq = "aaaa";
      if (strlen($sqlReq)!=0) {
         $sqlReq="select PARAM_CODI,PARAM_VALOR from SGD_PARAMETRO where PARAM_NOMB='PRESTAMO_REQUERIMIENTO' and PARAM_CODI".$sqlReq." order by PARAM_VALOR ";
	     // Show form field
?>
               <script>
                  /*Adecua el formulario para que la pagina regrese a la anterior*/
                  function regresar() {
                     document.Prestamo.FormAction.value="cancelar";
               	     document.Prestamo.submit();
                  }
               </script>
               <form method="POST" action="<?=$sFileName ?>" name="Prestamo" class=smart-form>
                  <input type="hidden" value="insert" name="FormAction">
                  <input type="hidden" value="<?=$dependencia?>" name="dependencia">
                  <input type="hidden" value="<?=$GLOBALS["numExpediente"]?>" name="numExpediente">
                  <input type="hidden" name="radicado" value="<?= tohtml($fldradicado) ?>">
<?    // Usuario que no puede solicitar
         if ($sPRESTAMOErr!="") {
            $lookup_s = db_fill_array($sqlReq);
            $s="";
            if(is_array($lookup_s))  {
               reset($lookup_s);
               while(list($key,$value)=each($lookup_s)){
	              $s=ucfirst(strtolower($value));
		          if ($key==3) {
			         $sPRESTAMOErr=" solo pueden ser solicitados y prestados al usuario $fldUSUARIO_RADICADO<br><br>";
			         break; }
     		   }
		    }
		    $sPRESTAMOErr="El ".$s.$sPRESTAMOErr;
?>
                  <p align="center"><font class="titulosError2"><?=$sPRESTAMOErr?></font><br>
				  <input type="submit" class="botones" value="Regresar" onClick="javascript: regresar();"></p>
               </form>
<?
         }
	     else { ?>
                  <table class='table table-bordered' align="center">
                     <tr>
                        <th  colspan="2"><center><?=$sFormTitle?></center></th>
                     </tr>
               	     <tr>
            		    <td class='titulos2' width="100">Radicado</td>
            		    <td class='listado2' width="350"><?=$fldradicado?></td>
            	     </tr>
              	     <tr>
		                <td class='titulos2'>Login</td>
		                <td class='listado2'><?=$krd?></td>
                 	 </tr>
	                 <tr>
	            	    <td class='titulos2'>Dependencia</td>
	            	    <td class='listado2'><?=$dependencia?></td>
  	                 </tr>
	                 <tr>
	  	                <td class='titulos2'>Fecha Pedido</td>
		                <td class='listado2'><?=Date("d-m-Y")?></td>
	                </tr>
	                <tr>
		                <td class='titulos2'>Accion</td>
		                <td class='listado2'>Solicitar</td>
                     </tr>
                     <tr>
	                    <td class='titulos2'>Requiere</td>
                        <td class="listado5"><label class=select>
                        <select name="s_PRES_REQUERIMIENTO" class=select>
<?                               $lookup_s = db_fill_array($sqlReq);
                                 if(is_array($lookup_s))  {
                                    reset($lookup_s);
                                    while(list($key,$value)=each($lookup_s))
                                    {
                                    	echo "<option value=\"$key\">".ucfirst(strtolower($value))."</option>"; }
                                 	}		    ?>
						                     </select></label></td>
                     </tr>
                     <tr>
	                    <td class='titulos2'>Expediente</td>
                        <td class="listado5">
                          <?=$GLOBALS["numExpediente"];?>
												</td>
                     </tr>
	                 <tr>
                        <td colspan=2><footer><input type="submit" class="btn btn-primary" value="Solicitar" align=left>&nbsp;&nbsp;
                        <input type="submit" class='btn btn-default' value="Regresar" onClick="javascript: regresar();"></footer></td>
	                 </tr>
                  </table>
               </form> <?
	     }
	  }
   }
}
//-------------------------------
?>
