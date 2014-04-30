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
  //$db->conn->debug = true;

	$ADODB_COUNTRECS = true;
	$ADODB_FORCE_TYPE = ADODB_FORCE_NULL;

  include("$ruta_raiz/include/tx/Tx.php");
  include("$ruta_raiz/include/tx/Radicacion.php");
  include("$ruta_raiz/class_control/Municipio.php");

  $hist = new Historico($db);
  $Tx   = new Tx($db);

  $dependencia   = $_SESSION["dependencia"];
  $codusuario    = $_SESSION["codusuario"];

  //$usua_doc    = $_SESSION["usua_doc"];
  //$tpNumRad    = $_SESSION["tpNumRad"];
  //$tpPerRad    = $_SESSION["tpPerRad"];
  //$tpDescRad   = $_SESSION["tpDescRad"];
  //$tip3Nombre  = $_SESSION["tip3Nombre"];
  //$tip3img     = $_SESSION["tip3img"];
  $tpDepeRad   = $_SESSION["tpDepeRad"];
  //$tip3desc    = $_SESSION["tip3desc"];
  //$tip3img     = $_SESSION["tip3img"];
  //$ln          = $_SESSION["digitosDependencia"];





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
  $rad->radiFechOfic = "".substr($fecha_gen_doc,6 ,4)
                         ."-".substr($fecha_gen_doc,3 ,2)
                         ."-".substr($fecha_gen_doc,0 ,2)."";

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

  $nurad = $rad->newRadicado($ent, $tpDepeRad[$ent]);

  if ($nurad=="-1"){
    $data[] = array( "error"  => 'No  se genero un numero de radicado');
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
  $newId = false;

  foreach ($usuarios as &$codUsuario) {
    list($sgdTrd, $codigo) = split('_', $codUsuario);

    unset($sgd_fun_codigo);
    unset($sgd_oem_codigo);
    unset($sgd_ciu_codigo);
	  unset($record);

  }

  switch ( $sgdTrd ) {
    // Usuario ....................................................................
    case 0:

      $sgd_ciu_codigo = $codigo;

      $isql = "SELECT
                 s.MUNI_CODI
                ,s.DPTO_CODI
                ,s.ID_CONT
                ,s.ID_PAIS
                ,s.SGD_CIU_NOMBRE    as nombre
                ,s.SGD_CIU_DIRECCION as direccion
                ,s.SGD_CIU_TELEFONO  as telef
                ,s.SGD_CIU_EMAIL     as email
                ,s.SGD_CIU_CEDULA    as cedula
                ,CONCAT(s.SGD_CIU_APELL1,' ', s.SGD_CIU_APELL2) as apellido
              FROM
                 SGD_CIU_CIUDADANO s
              WHERE
                s.SGD_CIU_CODIGO = $codigo
            ";
      break;

    // Empresas ....................................................................
    case 2:

      $sgd_oem_codigo = $codigo;

      $isql = "SELECT
                 s.MUNI_CODI
                ,s.DPTO_CODI
                ,s.ID_CONT
                ,s.ID_PAIS
                ,s.sgd_oem_oempresa  AS nombre
                ,s.sgd_oem_direccion AS direccion
                ,s.sgd_oem_telefono  AS telef
                ,s.sgd_oem_email     AS email
                ,s.sgd_oem_nit       AS cedula
                ,CONCAT(s.sgd_oem_sigla, ' ' ,s.SGD_OEM_REP_LEGAL) AS apellido
              FROM
                 SGD_OEM_OEMPRESAS s
              WHERE
                s.SGD_OEM_CODIGO = $codigo
            ";
      break;

    // Funcionario .................................................................
    case 6:

      $sgd_fun_codigo = $codigo;

      $isql = "SELECT
                s.ID_PAIS
                s.ID_CONT
                m.MUNI_CODI
                d.DPTO_CODI
                ,s.usua_nomb    AS nombre
                ,dp.depe_nomb   AS direccion
                ,s.usua_email   AS email
                ,s.usua_doc     AS cedula
                ,p.NOMBRE_PAIS  AS pais
                ,s.usua_login   AS apellido
                ,CONCAT(s.usu_telefono1,' / ', s.usua_ext) AS telef
              FROM
                 USUARIO s
                ,DEPARTAMENTO d
                ,MUNICIPIO m
                ,SGD_DEF_PAISES p
                ,DEPENDENCIA dp
              WHERE
                s.id             = $codigo
                and d.dpto_codi  = dp.dpto_codi
                and m.muni_codi  = dp.muni_codi
                and m.dpto_codi  = d.dpto_codi
                and dp.depe_codi = s.depe_codi
                and p.id_pais    = s.id_pais
                and p.id_cont    = s.id_cont";
      break;

  }//mifinal :p

  $rs = $db->query($isql);

  $idcont          = $rs->fields['ID_CONT'];
  $idpais          = $rs->fields['ID_PAIS'];
  $dpto_tmp        = $rs->fields['DPTO_CODI'];
  $muni_tmp        = $rs->fields['MUNI_CODI'];
  $grbNombresUs    = $rs->fields['NOMBRE']." ".$rs->fields['APELLIDO'];
  $direccion_us    = $rs->fields['DIRECCION'];
  $mail_us         = $rs->fields['EMAIL'];
  $cc_documento_us = $rs->fields['CEDULA'];
  $telefono_us     = $rs->fields['TELEF'];

  //Nuevo id para el nuevo radicado y
  //la relacion de direcciones y radicados
  $nextval         = $db->nextId("sec_dir_direcciones");

  if ($nextval==-1){
    $data[] = array( "error"  => 'No se encontr&oacute; la secuencia para grabar el usuario seleccionado');
  }

	$record = array();

	$record['MUNI_CODI']         = $muni_tmp;
	$record['DPTO_CODI']         = $dpto_tmp;
	$record['ID_PAIS']           = $idpais;
	$record['ID_CONT']           = $idcont;
	$record['SGD_TRD_CODIGO']    = $sgdTrd;

	$record['SGD_DIR_DIRECCION'] = $direccion_us;
	$record['SGD_DIR_TELEFONO']  = trim($telefono_us);
	$record['SGD_DIR_MAIL']      = $mail_us;
	$record['SGD_DIR_TIPO']      = 1;
	$record['SGD_DIR_CODIGO']    = $nextval;
	$record['SGD_DIR_NOMBRE']    = $otro_us;

	$record['SGD_DIR_NOMREMDES'] = $grbNombresUs;
	$record['SGD_DIR_DOC']       = $cc_documento_us;
	$record['SGD_DOC_FUN']       = empty($sgd_fun_codigo)? 0 : $sgd_fun_codigo;
	$record['SGD_OEM_CODIGO']    = empty($sgd_oem_codigo)? 0 : $sgd_oem_codigo;
	$record['SGD_CIU_CODIGO']    = empty($sgd_ciu_codigo)? "" : $sgd_ciu_codigo;
	$record['RADI_NUME_RADI']    = $nurad;
	$record['SGD_SEC_CODIGO']    = 0;

  $insertSQL =  $db->conn->Replace("SGD_DIR_DRECCIONES",
                $record,
                array('RADI_NUME_RADI','SGD_DIR_TIPO'),
                $autoquote = true);

  echo json_encode($data);
?>
