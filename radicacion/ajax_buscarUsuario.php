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
  $search = json_decode($_POST['search']);
  $tipo   = $search->tdoc;
  $docu   = $search->docu;
  $name   = $search->name;
  $tele   = $search->tele;
  $mail   = $search->mail;

  //Filtro por el tipo de usuario
  switch ( $tipo ) {

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
                and d.dpto_codi = s.dpto_codi
                and p.id_pais   = s.id_pais
                and p.id_cont   = s.id_cont
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
                and d.dpto_codi = s.dpto_codi
                and p.id_pais   = s.id_pais
                and p.id_cont   = s.id_cont
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
             s.id           AS codigo
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
            and m.muni_codi  = dp.muni_codi
            and m.dpto_codi  = d.dpto_codi
            and dp.depe_codi = s.depe_codi
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

  echo json_encode($data);
?>
