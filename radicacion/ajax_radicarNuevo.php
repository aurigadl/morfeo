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
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
  session_start();
  $ruta_raiz = "..";


  if (!$_SESSION['dependencia'])
      header ("Location: $ruta_raiz/cerrar_session.php");

  header('Content-Type: application/json');
  include_once("$ruta_raiz/include/db/ConnectionHandler.php");
  $db     = new ConnectionHandler("$ruta_raiz");
  $db->conn->debug = true;

	$ADODB_COUNTRECS = true;
	$ADODB_FORCE_TYPE = ADODB_FORCE_NULL;

  include("$ruta_raiz/include/tx/Tx.php");
  include("$ruta_raiz/include/tx/Radicacion.php");
  include("$ruta_raiz/include/tx/usuario.php");
  include("$ruta_raiz/class_control/Municipio.php");

  $hist    = new Historico($db);
  $usuario = new Usuario($db);
  $Tx      = new Tx($db);

  $dependencia   = $_SESSION["dependencia"];
  $codusuario    = $_SESSION["codusuario"];

  $tpDepeRad     = $_SESSION["tpDepeRad"];

  $tpRadicado    = $_POST['radicado_tipo'] || 1;
  $cuentai       = $_POST['cuentai'];
  $guia          = $_POST['guia'];
  $fecha_gen_doc = $_POST['fecha_gen_doc'];
  $usuarios      = $_POST['usuario'];
  $asu           = $_POST['asu'];
  $med           = $_POST['med'];
  $nofolios      = $_POST['nofolios'];
  $noanexos      = $_POST['noanexos'];
  $ane           = $_POST['ane'];
  $coddepe       = $_POST['coddepe'];
  $tdoc          = $_POST['tdoc'];
  $otro_us       = $_POST['otro_us'];
  $ent           = $_POST['ent'];

  //Enviados solo si es para modificar
  $modificar     = $_POST['modificar'];
  $nurad         = $_POST['nurad'];


  $carp_codi     = "0";
  $carp_per      = "0";

  if(!$radi_usua_actu){
    $radi_usua_actu = 1;
  }

  /**************************************************/
  /*********** RADICAR DOCUMENTO  *******************/
  /**************************************************/
  $rad               = new Radicacion($db);
  $rad->radiTipoDeri = $tpRadicado;
  $rad->radiCuentai  = trim($cuentai);
  $rad->guia         = trim(substr($guia,0 ,20));
  $rad->eespCodi     = $documento_us3;
  $rad->mrecCodi     = $med;// "dd/mm/aaaa"
  $rad->radiFechOfic = substr($fecha_gen_doc,0 ,4)
                       ."-".substr($fecha_gen_doc,5 ,2)
                       ."-".substr($fecha_gen_doc,8 ,2);


  if(!$radicadopadre){
    $radicadopadre = null;
  }

  if(!$ent){
    $radicadopadre = null;
  }

  $rad->radiNumeDeri = trim($radicadopadre);
  $rad->descAnex     = $ane;
  $rad->radiDepeActu = "'$coddepe'";
  $rad->radiDepeRadi = "'$coddepe'";
  $rad->radiUsuaActu = $radi_usua_actu;
  $rad->trteCodi     = $tip_rem;
  $rad->tdocCodi     = $tdoc;
  $rad->nofolios     = $nofolios;
  $rad->noanexos     = $noanexos;
  $rad->carpCodi     = $carp_codi;
  $rad->carPer       = $carp_per;
  $rad->trteCodi     = $tip_rem;
  $rad->raAsun       = substr(htmlspecialchars(stripcslashes($asu)),0,349);

  if(strlen(trim($aplintegra)) == 0){
    $aplintegra = "0";
  }

  $rad->sgd_apli_codi = $aplintegra;

  if($nurad){
    if(!$rad->updateRadicado($nurad)){
      $data[] = array( "error"   => 'No se actualizo el radicado');
    }
  }else{
    $nurad     = $rad->newRadicado($ent, $tpDepeRad[$ent]);
  }

  if ($nurad=="-1"){
    $data[] = array( "error"   => 'No se genero un numero de radicado');
  }else{
    $data[] = array( "answer"  => $nurad);
  }


  $radicadosSel[0] = $nurad;

  $hist->insertarHistorico( $radicadosSel,
                            $dependencia ,
                            $codusuario,
                            $coddepe,
                            $radi_usua_actu,
                            " ",
                            2);

  /**************************************************/
  /*********** GRABAR DIRECCIONES *******************/
  /**************************************************/

  foreach ($usuarios as $codUsuario) {
    list($sgdTrd, $codigo) = split('_', $codUsuario);
    $usuario->guardarUsuarioRadicado($nurad, $codigo, $sgdTrd, $modificar);
  }

  echo json_encode($data);
?>
