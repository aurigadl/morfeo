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

$ruta_raiz   = "..";
if (!$_SESSION['dependencia'])
header ("Location: $ruta_raiz/cerrar_session.php");

define('ADODB_ASSOC_CASE', 1);
$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$codusuario  = $_SESSION["codusuario"];
$noExp       = 0 ;
$onlyonehist = true;
$expediente  = $_SESSION['dataPresExpediente']['expediente'];
$dataExpRadi = $_SESSION['dataPresExpediente'];

include_once "$ruta_raiz/include/db/ConnectionHandler.php";
include_once "$ruta_raiz/include/tx/Expediente.php";
include_once "$ruta_raiz/solicitar/common.php";
include_once "$ruta_raiz/include/tx/Historico.php";

$db     = new ConnectionHandler($ruta_raiz);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
$trdExp = new Expediente($db);
$hist   = new Historico($db);
$db->conn->debug = false;
//====================================
// Cancelar solicitud
// Esta solicitud es enviada por ajax
// desde este mismo script
//------------------------------------
if($_POST['cancelar']){
  $radicado    = $_SESSION['dataPresExpediente']['radicados'];
  $observacion = "Cancelacion del prestamos del expediente";
  $trdExp->cancPrestarExpediente($expediente, $radicado, $krd);
  $hist->insertarHistoricoExp($expediente,$radicados,$dependencia,$codUsuario,$observacion, 92,1);
  echo "true";
  die;
}

//===============================
// Procesar Datos y solicitudes
// pagina inicial.
//-------------------------------
$qyNoExpe = " SELECT
                PARAM_CODI,
                PARAM_VALOR
              FROM
                SGD_PARAMETRO
              WHERE
                PARAM_VALOR ILIKE '%EXPEDIENTE%'";

$rs = $db->conn->query($qyNoExpe);

if(!$rs->EOF){
  $valSolPrest = $rs->fields['PARAM_CODI'];
}

while(array_key_exists ($noExp,$dataExpRadi)){
  $fldPRES_FECH_PEDI = $db->conn->OffsetDate(0,$db->conn->sysTimeStamp);
  $radiprestar[]     = $dataExpRadi[$noExp]['NUM_RADICADO'];
  if(array_key_exists('ANEXOS', $dataExpRadi[$noExp])){
    foreach ($dataExpRadi[$noExp]['ANEXOS'] as $valor){
      if(!in_array($valor['NUMERO'], $radiprestar)){
        $radiprestar[] = $valor['NUMERO'];
      }
    }
  }
  $noExp++;
}

$_SESSION['dataPresExpediente']['radicados'] = $radiprestar;

$observacion = "Prestamos del expediente";
foreach ($radiprestar as $fldradicado) {
  // Obtiene la ubicacion fisica de los documentos
  $fldPRES_DEPE_ARCH=substr($fldradicado,4,3);

  $query = "SELECT
              UBIC_DEPE_ARCH
            FROM
              UBICACION_FISICA
            WHERE
              UBIC_DEPE_RADI = ".$fldPRES_DEPE_ARCH;

  $rs = $db->conn->query($query);

  if(!$rs->EOF){
    $fldPRES_DEPE_ARCH = $rs->fields['UBIC_DEPE_ARCH'];
  }

  // Genera PRES_ID
  $sec  = $db->conn->nextId('SEC_PRESTAMO');

  $sSqlE= "UPDATE
             SGD_SEXP_SECEXPEDIENTES
           SET
             SGD_SEXP_PRESTAMO = TRUE
           WHERE
             SGD_EXP_NUMERO =  '$expediente'";

  // Execute SQL statement
  $rs = $db->query($sSqlE);

  $sExis = "SELECT
            COUNT(1) as CANT
           FROM
            PRESTAMO
           WHERE SGD_EXP_NUMERO LIKE '$expediente' and
            radi_nume_radi = $fldradicado";

  $rst = $db->query($sExis);

  if($rst->fields['CANT'] == 0){

    $sSQL = " INSERT INTO PRESTAMO(
      PRES_ID,
      RADI_NUME_RADI,
      USUA_LOGIN_ACTU,
      DEPE_CODI,
      PRES_FECH_PEDI,
      PRES_DEPE_ARCH,
      PRES_ESTADO,
      SGD_EXP_NUMERO,
      PRES_REQUERIMIENTO)
      VALUES (".
      tosql($sec,"Number")."," .
      tosql($fldradicado,"Text")."," .
      tosql($krd,"Text")."," .
      tosql($dependencia,"Number")."," .
      $fldPRES_FECH_PEDI."," .
      tosql($dependencia,"Number").",
      1," .
      tosql($expediente,"Text")."," .
      tosql($valSolPrest,"Number").
      ")";
      if($onlyonehist){
        $hist->insertarHistoricoExp($expediente,$radiprestar,$dependencia,$codusuario,$observacion, 91,1);
        $onlyonehist = false;
      }
    // Execute SQL statement
    $rs = $db->query($sSQL);
  }
}

if(!empty(count($radiprestar))){

    $radijoin = implode(",", $radiprestar);

    $sqlPRES_FECH_PEDI=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_PEDI");
    $sqlPRES_FECH_CANC=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_CANC");
    $sqlPRES_FECH_DEVO=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_DEVO");
    $sqlPRES_FECH_PRES=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_PRES");
    $sqlPRES_FECH_VENC=$db->conn->SQLDate("Y-m-d H:i A","r.PRES_FECH_VENC");

    $sSQL="SELECT
             r.PRES_ID            as PRESTAMO_ID,
             r.RADI_NUME_RADI     as RADICADO,
             r.USUA_LOGIN_ACTU    as LOGIN,
             D.DEPE_NOMB          as DEPENDENCIA,".
             $sqlPRES_FECH_PEDI." as F_SOLICITUD,".
             $sqlPRES_FECH_VENC." as F_VENCIMIENTO,".
             $sqlPRES_FECH_CANC." as F_CANCELACION,".
             $sqlPRES_FECH_PRES." as F_PRESTAMO,".
             $sqlPRES_FECH_DEVO." as F_DEVOLUCION,
             G.PARAM_VALOR as REQUERIMIENTO,
             E.PARAM_VALOR as ESTADO,
             r.PRES_ESTADO as ID_ESTADO
           FROM
             PRESTAMO      r,
             DEPENDENCIA   D,
             SGD_PARAMETRO E,
             SGD_PARAMETRO G
           WHERE
             r.RADI_NUME_RADI in ($radijoin) and
             D.DEPE_CODI  = R.DEPE_CODI and
             E.PARAM_NOMB = 'PRESTAMO_ESTADO' and
             E.PARAM_CODI = R.PRES_ESTADO and
             G.PARAM_NOMB = 'PRESTAMO_REQUERIMIENTO' and
             G.PARAM_CODI = r.PRES_REQUERIMIENTO";

    // Execute SQL statement
    $rs = $db->query($sSQL);

    while($rs && !$rs->EOF) {
      $iCounter++;

      // Create field variables based on database fields
      $fldPRES_ID        = $rs->fields["PRESTAMO_ID"];
      $fldRADICADO       = tohtml($rs->fields["RADICADO"]);
      $fldEXPEDIENTE     = tohtml($rs->fields["SGD_EXP_NUMERO"]);
      $fldLOGIN          = tohtml($rs->fields["LOGIN"]);
      $fldDEPENDENCIA    = tohtml($rs->fields["DEPENDENCIA"]);
      $fldPRES_FECH_PEDI = tohtml($rs->fields["F_SOLICITUD"]);
      $fldPRES_FECH_VENC = tohtml($rs->fields["F_VENCIMIENTO"]);
      $fldPRES_FECH_CANC = tohtml($rs->fields["F_CANCELACION"]);
      $fldPRES_FECH_PRES = tohtml($rs->fields["F_PRESTAMO"]);
      $fldPRES_FECH_DEV  = tohtml($rs->fields["F_DEVOLUCION"]);
      $valSolPrest       = tohtml($rs->fields["REQUERIMIENTO"]);
      $fldPRES_ESTADO    = tohtml($rs->fields["ESTADO"]);
      $fldID_ESTADO      = tohtml($rs->fields["ID_ESTADO"]);

      if (strcasecmp($krd,$fldLOGIN)==0 && $fldID_ESTADO==1) {
         $accion="<a href=\"javascript: cancelarExpSol(); \">Cancelar Solicitud</a>";
      }

      // Indica el estilo de la fila
      if($iCounter%2==0){
        $tipoListado="class=\"listado2\"";
      } else{
        $tipoListado="class=\"listado1\"";
      }

      // HTML prestamo show begin
      $showdata .="<tr $tipoListado; align=\"center\">
                    <td class=\"leidos\"> $fldRADICADO       </td>
                    <td class=\"leidos\"> $fldLOGIN          </td>
                    <td class=\"leidos\"> $fldDEPENDENCIA    </td>
                    <td class=\"leidos\"> $fldPRES_FECH_PEDI </td>
                    <td class=\"leidos\"> $fldPRES_FECH_VENC </td>
                    <td class=\"leidos\"> $valSolPrest       </td>
                    <td class=\"leidos\"> $fldPRES_ESTADO    </td>
                  </tr>";
      $rs->MoveNext();
    }
}


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
  <body>

    <div id="content" style="opacity: 1;">
      <!-- widget grid -->
      <section id="widget-grid">

          <!-- row -->
          <div class="row" >

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

              <div>
                  <h1 class="page-title txt-color-blueDark"><i class="glyphicon glyphicon-inbox"></i>
                  Reserva de documentos del Expediente No. <?=$expediente?>  <?=$accion?> </span>
                  </h1>
              </div>

              <table class='table table-bordered'>
                <tr  align="center" valign="middle">
                    <th><a href=''>Radicado</a></th>
                    <th><a href=''>Login</a></th>
                    <th><a href=''>Dependencia</a></th>
                    <th><a href=''>Fecha<br>Solicitud</a></th>
                    <th><a href=''>Fecha<br>Vencimiento</a></th>
                    <th><a href=''>Estado</a></th>
                    <th><a href=''>Accion</a></th>
                </tr>
                <?=$showdata?>
                <tr  align="center">
                  <td  colspan="9" align="center">
                    <footer>
                      <a class="btn btn-default" href="javascript: resgresarpag();">Regresar</a>
                    </footer>
                  </td>
                </tr>
              </table>

            <!-- NEW WIDGET START -->
            </article>

          <!-- row -->
          </div>

      </section>

    </div>

  </body>

</html>

<script>

function cancelarExpSol(){
  $.post( "reservarExpediente.php", { cancelar: "true" } )
    .done(function( data  ) {
      if(data === "true"){
        window.close();
      }else{
        alert('No se realizo la cancelación');
      }
    });
}


//Funcion para regresar al formulario anterior
function resgresarpag(){
  window.close();
}



</script>
