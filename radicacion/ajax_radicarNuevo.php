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

  include("$ruta_raiz/include/tx/Tx.php");
  include("$ruta_raiz/include/tx/Radicacion.php");
  include("$ruta_raiz/class_control/Municipio.php");

  $hist = new Historico($db);
  $Tx   = new Tx($db);

  $dependencia   = $_SESSION["dependencia"];
  $codusuario    = $_SESSION["codusuario"];

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
  $rad->radiCuentai  = "'".trim($cuentai)."'";
  $rad->guia         = $guia;
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
  $rad->tdidCodi     = $tip_doc;
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
  foreach ($usuarios as &$codUsuario) {
    list($tipoUsuario, $codigo) = split('_', $codUsuario);
  }

  switch ( $tipoUsuario ) {

    // Usuario ....................................................................
    case 0:

      if(!empty($name)){
        $where = $db->conn->Concat(   " UPPER(sgd_ciu_nombre) "
                                      , " UPPER(sgd_ciu_apell1) "
                                      , " UPPER(sgd_ciu_apell2) ")
                                      . " LIKE '%". strtoupper($name->value) ."%' ";
      }

      if(!empty($docu)){
        $sub    = " UPPER(SGD_CIU_CEDULA)  LIKE '%$docu->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }


      if(!empty($tele)){
        $sub    = " UPPER(SGD_CIU_TELEFONO) LIKE '%$tele->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }

      if(!empty($mail)){
        $sub    = " UPPER(SGD_CIU_EMAIL)   LIKE '%$mail->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }

      $isql = "SELECT
                 s.SGD_CIU_CODIGO    as codigo
                ,s.SGD_CIU_NOMBRE    as nombre
                ,s.SGD_CIU_DIRECCION as direccion
                ,s.SGD_CIU_TELEFONO  as telef
                ,s.SGD_CIU_EMAIL     as email
                ,s.SGD_CIU_CEDULA    as cedula
                ,p.NOMBRE_PAIS       as pais
                ,CONCAT(d.DPTO_NOMB,' / ', m.MUNI_NOMB) as munidep
                ,CONCAT(s.SGD_CIU_APELL1,' ', s.SGD_CIU_APELL2) as apellido
              FROM
                 SGD_CIU_CIUDADANO s
                ,DEPARTAMENTO d
                ,MUNICIPIO m
                ,SGD_DEF_PAISES p
              WHERE
                $where
                and m.muni_codi = s.muni_codi
                and m.dpto_codi = s.dpto_codi
                and p.id_pais   = s.id_pais
                and p.id_cont   = s.id_cont
                and d.dpto_codi = s.dpto_codi
                and d.id_pais   = s.id_pais
                and d.id_cont   = s.id_cont
              ORDER BY s.SGD_CIU_NOMBRE, s.SGD_CIU_APELL1, s.SGD_CIU_APELL2
              LIMIT 24
          ";

      $rs = $db->query($isql);
      while(!$rs->EOF){
        $data[] = $rs->fields;
        $rs->MoveNext();
      }
      break;

    // Empresas ....................................................................
    case 2:

      if(!empty($name)){
        $where = $db->conn->Concat( "UPPER(SGD_OEM_OEMPRESA) LIKE '%". strtoupper($name->value) ."%'
                                     OR UPPER(SGD_OEM_SIGLA) LIKE '%". strtoupper($name->value) ."%'");
      }

      if(!empty($docu)){
        $sub    = " UPPER(SGD_OEM_NIT) LIKE '%$docu->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }


      if(!empty($tele)){
        $sub    = " UPPER(SGD_OEM_TELEFONO) LIKE '%$tele->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }

      if(!empty($mail)){
        $sub    = " UPPER(SGD_OEM_EMAIL)   LIKE '%$mail->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }

      $isql = "SELECT
                 s.sgd_oem_codigo    AS codigo
                ,s.sgd_oem_oempresa  AS nombre
                ,s.sgd_oem_direccion AS direccion
                ,s.sgd_oem_telefono  AS telef
                ,s.sgd_oem_email     AS email
                ,s.sgd_oem_nit       AS cedula
                ,p.NOMBRE_PAIS       AS pais
                ,CONCAT(d.DPTO_NOMB,' / ', m.MUNI_NOMB) AS munidep
                ,CONCAT(s.sgd_oem_sigla, ' / ' ,s.SGD_OEM_REP_LEGAL) AS apellido
              FROM
                 SGD_OEM_OEMPRESAS s
                ,DEPARTAMENTO d
                ,MUNICIPIO m
                ,SGD_DEF_PAISES p
              WHERE
                $where
                and m.muni_codi = s.muni_codi
                and m.dpto_codi = s.dpto_codi
                and p.id_pais   = s.id_pais
                and p.id_cont   = s.id_cont
                and d.dpto_codi = s.dpto_codi
                and d.id_pais   = s.id_pais
                and d.id_cont   = s.id_cont
                ORDER  BY sgd_oem_oempresa
              LIMIT 24
          ";

      $rs = $db->query($isql);

      while(!$rs->EOF){
        $data[] = $rs->fields;
        $rs->MoveNext();
      }

      break;

    case 6:
      // Funcionario .................................................................
      if(!empty($name)){
        $where = $db->conn->Concat(" UPPER(s.USUA_NOMB) LIKE '%". strtoupper($name->value) ."%'");
      }

      if(!empty($docu)){
        $sub    = " cast(s.usua_doc as varchar) LIKE '%$docu->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }


      if(!empty($tele)){
        $sub    = ( "UPPER(s.USU_TELEFONO1) LIKE '%". strtoupper($tele->value) ."%'
                     OR UPPER(s.usua_ext)   LIKE '%". strtoupper($tele->value) ."%'");
        $where .= (empty($where))? $sub : ' and '. $sub;
      }

      if(!empty($mail)){
        $sub    = " UPPER(s.USUA_EMAIL)   LIKE '%$mail->value%'";
        $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
      }

      $isql = "SELECT
             s.usua_codi    AS codigo
            ,s.usua_nomb    AS nombre
            ,dp.depe_nomb   AS direccion
            ,s.usua_email   AS email
            ,s.usua_doc     AS cedula
            ,p.NOMBRE_PAIS  AS pais
            ,s.usua_login   AS apellido
            ,CONCAT(s.usu_telefono1,' / ', s.usua_ext) AS telef
            ,CONCAT(d.DPTO_NOMB,' / ', m.MUNI_NOMB) AS munidep
          FROM
             USUARIO s
            ,DEPARTAMENTO d
            ,MUNICIPIO m
            ,SGD_DEF_PAISES p
            ,DEPENDENCIA dp
          WHERE
            $where
            and s.usua_esta  = '1'
            and d.dpto_codi  = dp.dpto_codi
            and dp.depe_codi = s.depe_codi
            and m.muni_codi  = dp.muni_codi
            and m.dpto_codi  = d.dpto_codi
            and p.id_pais    = s.id_pais
            and p.id_cont    = s.id_cont
          ORDER  BY usua_nomb
          LIMIT 24";

      $rs = $db->query($isql);

      while(!$rs->EOF){
        $data[] = $rs->fields;
        $rs->MoveNext();
      }

      break;
  }

  if (!is_null($muni_us1)){	
    $tmp_mun = new Municipio($conexion);
	  $tmp_mun->municipio_codigo($codep_us1,$muni_us1);
	
	$tmp_idcont = $tmp_mun->get_cont_codi();
	$tmp_idpais = $tmp_mun->get_pais_codi();
	$muni_tmp1 = explode("-",$muni_us1);
	switch (count($muni_tmp1))
	{	case 4:
			{
				$idcont1 = $muni_tmp1[0];
				$idpais1 = $muni_tmp1[1];
				$dpto_tmp1 = $muni_tmp1[2];
				$muni_tmp1 = $muni_tmp1[3];

			}break;
		case 3:
			{
				$idcont1 = $tmp_idcont;
				$idpais1 = $muni_tmp1[0];
				$dpto_tmp1 = $muni_tmp1[1];
				$muni_tmp1 = $muni_tmp1[2];
			}break;
		case 2:
			{
				$idcont1 = $tmp_idcont;
				$idpais1 = $tmp_idpais;
				$dpto_tmp1 = $muni_tmp1[0];
				$muni_tmp1 = $muni_tmp1[1];
			}break;
	}
	unset($tmp_mun);unset($tmp_idcont);unset($tmp_idpais);
}

if (!is_null($muni_us2))
{	$tmp_mun = new Municipio($conexion);
	$tmp_mun->municipio_codigo($codep_us2,$muni_us2);
	$tmp_idcont = $tmp_mun->get_cont_codi();
	$tmp_idpais = $tmp_mun->get_pais_codi();
	$muni_tmp2 = explode("-",$muni_us2);
	switch (count($muni_tmp2))
	{	case 4:
			{	$idcont2 = $muni_tmp2[0];
				$idpais2 = $muni_tmp2[1];
				$dpto_tmp2 = $muni_tmp2[2];
				$muni_tmp2 = $muni_tmp2[3];
			}break;
		case 3:
			{
				$idcont2 = $tmp_idcont;
				$idpais2 = $muni_tmp2[0];
				$dpto_tmp2 = $muni_tmp2[1];
				$muni_tmp2 = $muni_tmp2[2];
			}break;
		case 2:
			{
				$idcont2 = $tmp_idcont;
				$idpais2 = $tmp_idpais;
				$dpto_tmp2 = $muni_tmp2[0];
				$muni_tmp2 = $muni_tmp2[1];
			}break;
	}
	unset($tmp_mun);unset($tmp_idcont);unset($tmp_idpais);
}
if (!is_null($muni_us3))
{	$tmp_mun = new Municipio($conexion);
	$tmp_mun->municipio_codigo($codep_us3,$muni_us3);
	$tmp_idcont = $tmp_mun->get_cont_codi();
	$tmp_idpais = $tmp_mun->get_pais_codi();
	$muni_tmp3 = explode("-",$muni_us3);
	switch (count($muni_tmp3))
	{	case 4:
			{	$idcont3 = $muni_tmp3[0];
				$idpais3 = $muni_tmp3[1];
				$dpto_tmp3 = $muni_tmp3[2];
				$muni_tmp3 = $muni_tmp3[3];
			}break;
		case 3:
			{
				$idcont3 = $tmp_idcont;
				$idpais3 = $muni_tmp3[0];
				$dpto_tmp3 = $muni_tmp3[1];
				$muni_tmp3 = $muni_tmp3[2];
			}break;
		case 2:
			{
				$idcont3 = $tmp_idcont;
				$idpais3 = $tmp_idpais;
				$dpto_tmp3 = $muni_tmp3[0];
				$muni_tmp3 = $muni_tmp3[1];
			}break;
	}
	unset($tmp_mun);unset($tmp_idcont);unset($tmp_idpais);
}
$newId = false;
if(!$modificar)
{
   $nextval=$conexion->nextId("sec_dir_direcciones");
}
if ($nextval==-1)
{
	echo "<span class='etextomenu'>No se encontr&oacute; la secuencia sec_dir_direcciones ";
}
global $ADODB_COUNTRECS;
if($documento_us1 and !$cc)
{
	$sgd_ciu_codigo='null';
	$sgd_oem_codigo='null';
	$sgd_esp_codigo='null';
	$sgd_fun_codigo='null';
  	if($tipo_emp_us1==0)
  	{	$sgd_ciu_codigo=$documento_us1;
		$sgdTrd = "1";
	}
	if($tipo_emp_us1==1)
	{	$sgd_esp_codigo=$documento_us1;
		$sgdTrd = "3";
	}
	if($tipo_emp_us1==2)
	{	$sgd_oem_codigo=$documento_us1;
		$sgdTrd = "2";
	}
	if($tipo_emp_us1==6)
	{	$sgd_fun_codigo=$documento_us1;
		$sgdTrd = "4";
	}

	$ADODB_COUNTRECS = true;
	$ADODB_FORCE_TYPE = ADODB_FORCE_NULL;
	$record = array();
	$record['SGD_TRD_CODIGO']    = $sgdTrd;
	$record['SGD_DIR_NOMREMDES'] = $grbNombresUs1;
	$record['SGD_DIR_DOC']       = $cc_documento_us1;
	$record['MUNI_CODI']         = $muni_tmp1;
	$record['DPTO_CODI']         = $dpto_tmp1;
	$record['ID_PAIS']           = $idpais1;
	$record['ID_CONT']           = $idcont1;
	$record['SGD_DOC_FUN']       = $sgd_fun_codigo;
	$record['SGD_OEM_CODIGO']    = $sgd_oem_codigo;
	$record['SGD_CIU_CODIGO']    = $sgd_ciu_codigo;
	$record['SGD_OEM_CODIGO']    = $sgd_oem_codigo;
	$record['SGD_ESP_CODI']      = $sgd_esp_codigo;
	$record['RADI_NUME_RADI']    = $nurad;
	$record['SGD_SEC_CODIGO']    = 0;
	$record['SGD_DIR_DIRECCION'] = $direccion_us1;
	$record['SGD_DIR_TELEFONO']  = trim($telefono_us1);
	$record['SGD_DIR_MAIL']      = $mail_us1;
	$record['SGD_DIR_TIPO']      = 1;
	$record['SGD_DIR_CODIGO']    = $nextval;
	$record['SGD_DIR_NOMBRE']    = $otro_us1;

	$insertSQL = $conexion->conn->Replace("SGD_DIR_DRECCIONES", $record, array('RADI_NUME_RADI','SGD_DIR_TIPO'), $autoquote = true);
	switch ($insertSQL)
	{	case 1:	{	//Insercion Exitosa
					$dir_codigo_new = $nextval;
					$newId=true;
				}break;
		case 2:{	//Update Exitoso
					$newId = false;
				}break;
		case 0:{	//Error Transacci�n.
					echo "<span class='etextomenu'>No se ha podido actualizar la informaci&oacute;n de SGD_DIR_DRECCIONES </span><!-- $isql -->";
				}break;
	}
	unset($record);
	$ADODB_COUNTRECS = false;
}
	// ***********************  us2
if($documento_us2)
{
	$sgd_ciu_codigo='null';
	$sgd_oem_codigo='null';
	$sgd_esp_codigo='null';
	$sgd_fun_codigo='null';
  if($tipo_emp_us2==0){
		$sgd_ciu_codigo=$documento_us2;
		$sgdTrd = "1";
	}
	if($tipo_emp_us2==1){
		$sgd_esp_codigo=$documento_us2;
		$sgdTrd = "3";
	}
	if($tipo_emp_us2==2){
		$sgd_oem_codigo=$documento_us2;
		$sgdTrd = "2";
	}
	if($tipo_emp_us2==6){
		$sgd_fun_codigo=$documento_us2;
		$sgdTrd = "4";
	}
	$isql = "select * from sgd_dir_drecciones where radi_nume_radi=$nurad and sgd_dir_tipo=2";
	$rsg=$conexion->query($isql);

    if 	($rsg->EOF)
	{
		//if($newId==true)
			//{
			   $nextval=$conexion->nextId("sec_dir_direcciones");
			//}
			if ($nextval==-1)
			{
				//$db->conn->RollbackTrans();
				echo "<span class='etextomenu'>No se encontro la secuencia sec_dir_direcciones ";
			}

		$isql = "insert into SGD_DIR_DRECCIONES(SGD_TRD_CODIGO, SGD_DIR_NOMREMDES, SGD_DIR_DOC, DPTO_CODI, MUNI_CODI,
      			id_pais, id_cont, SGD_DOC_FUN, SGD_OEM_CODIGO, SGD_CIU_CODIGO, SGD_ESP_CODI, RADI_NUME_RADI, SGD_SEC_CODIGO,
      			SGD_DIR_DIRECCION, SGD_DIR_TELEFONO, SGD_DIR_MAIL, SGD_DIR_TIPO, SGD_DIR_CODIGO, SGD_DIR_NOMBRE)
	  			values('$sgdTrd', '$grbNombresUs2', '$cc_documento_us2', $dpto_tmp2, $muni_tmp2, $idpais2, $idcont2,
	  			$sgd_fun_codigo, $sgd_oem_codigo, $sgd_ciu_codigo, $sgd_esp_codigo, $nurad, 0,'".trim($direccion_us2).
	  			"', '".trim($telefono_us2)."', '$mail_us2', 2, $nextval, '$otro_us2')";
   	  $dir_codigo_new = $nextval;
   	  $newId=true;
    }
	 else
	{
	  $newId = false;
		$isql = "update SGD_DIR_DRECCIONES
				set MUNI_CODI=$muni_tmp2, DPTO_CODI=$dpto_tmp2, id_pais=$idpais2, id_cont=$idcont2
				,SGD_OEM_CODIGO=$sgd_oem_codigo
				,SGD_CIU_CODIGO=$sgd_ciu_codigo
				,SGD_ESP_CODI=$sgd_esp_codigo
				,SGD_DOC_FUN=$sgd_fun_codigo
				,SGD_SEC_CODIGO=0
				,SGD_DIR_DIRECCION='$direccion_us2'
				,SGD_DIR_TELEFONO='$telefono_us2'
				,SGD_DIR_MAIL='$mail_us2'
				,SGD_DIR_NOMBRE='$otro_us2'
				,SGD_DIR_NOMREMDES='$grbNombresUs2'
				,SGD_DIR_DOC='$cc_documento_us2'
				,SGD_TRD_CODIGO='$sgdTrd'
			 	where radi_nume_radi=$nurad and SGD_DIR_TIPO=2 ";
	}

	$rsg=$conexion->query($isql);

	if (!$rsg){
		die ("<span class='etextomenu'>No se ha podido actualizar la informaci&oacute;n de SGD_DIR_DRECCIONES </span><!-- $isql -->");
	}

}
/* Se insertan usuarios a los que se les envia copia de documentos....
   7 es el numero de tipo de cumento para los usuario de envio de copias.
   */

if($documento_us1 and $cc)
{
	$sgd_ciu_codigo='null';
	$sgd_oem_codigo='null';
	$sgd_esp_codigo='null';
	$sgd_fun_codigo='null';

	echo "--$sgd_emp_us1--";
	  if($tipo_emp_us1==0){
		$sgd_ciu_codigo=$documento_us1;
		$sgdTrd = "1";
	}
	if($tipo_emp_us1==1){
		$sgd_esp_codigo=$documento_us1;
		$sgdTrd = "3";
	}
	if($tipo_emp_us1==2){
		$sgd_oem_codigo=$documento_us1;
		$sgdTrd = "2";
	}
	if($tipo_emp_us1==6){
		$sgd_fun_codigo=$documento_us1;
		$sgdTrd = "4";
	}
	if($newId==true)
		{
		   $nextval=$conexion->nextId("sec_dir_direcciones");
		}
		if ($nextval==-1)
		{
			//$db->conn->RollbackTrans();
			echo "<span class='etextomenu'>No se encontrase&nacute;a la secuencia sec_dir_direcciones ";
		}
	$isql = "select count(1) as anexos from sgd_dir_drecciones
							where radi_nume_radi=$nurad 
										and sgd_dir_tipo>=700
						";
	$rsg=$conexion->query($isql);

  if(!$rsg->EOF)
	{
    $num_anexos = $rsg->fields["ANEXOS"];
  }
  $num_anexos = $num_anexos+1;
  $str_num_anexos = substr("00".$num_anexos,-2);
  $sgd_dir_tipo = "7".$str_num_anexos;
  if(!$grbNombresUs1) $grbNombresUs1 = $nombre_us1 . " ". $prim_apel_us1 ." ".$seg_apel_us1;
	$isql = "insert into SGD_DIR_DRECCIONES (SGD_TRD_CODIGO, SGD_DIR_NOMREMDES, SGD_DIR_DOC, MUNI_CODI, DPTO_CODI,
			id_pais, id_cont, SGD_DOC_FUN, SGD_OEM_CODIGO, SGD_CIU_CODIGO, SGD_ESP_CODI, RADI_NUME_RADI, SGD_SEC_CODIGO,
			SGD_DIR_DIRECCION, SGD_DIR_TELEFONO, SGD_DIR_MAIL, SGD_DIR_TIPO, SGD_DIR_CODIGO, SGD_ANEX_CODIGO, SGD_DIR_NOMBRE) ";
	$isql .= "values ('$sgdTrd', '$grbNombresUs1', '$cc_documento_us1', $muni_tmp1, $dpto_tmp1, $idpais1, $idcont1,
						$sgd_fun_codigo, $sgd_oem_codigo, $sgd_ciu_codigo, $sgd_esp_codigo, $nurad, 0, '$direccion_us1',
						'".trim($telefono_us1)."', '$mail_us1', $sgd_dir_tipo, $nextval, '$codigo', '$otro_us7' )";
  $dir_codigo_new = $nextval;
  $nextval++;
  $rsg=$conexion->query($isql);

	if (!$rsg)
	{
		//$conexion->conn->RollbackTrans();
		echo "<span class='etextomenu'>No se ha podido actualizar la informaci&oacute;n de SGD_DIR_DRECCIONES </span><!-- $isql -->";
	}
}
// Fin de inserci�n de copias....





  echo json_encode($data);
?>
