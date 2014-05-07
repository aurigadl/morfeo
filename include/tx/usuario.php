<?php

class Usuario {
  /*** Attributes:
  * Clase que maneja los usuarios
  */

	var $db;
	var $result;

  function __construct($db){
    $this->db=$db;
  }


  public function resRadicadoHtml(){

    foreach ($this->result as $result){
      $html = '<td class="search-table-icon">
                <a href="javascript:void(0);"
                  rel="tooltip"
                  data-placement="right"
                  data-original-title="Eliminar Usuario"
                  class="text-danger">

                  <i class="fa fa-minus"></i>
                </a>
                <input class="hide" name="usuario[]" value="'.$result["TIPO"].'_'.$result["CODIGO"].'">
              </td>';

      $html .= '<td>'.$result["CEDULA"].'</td>';

      $html .= '<td colspan="2">'.$result["NOMBRE"].'</td>';

      $html .= '<td>'.$result["TELEF"].'</td>';

      $html .= '<td>'.$result["DIRECCION"].'</td>';

      $html .= '<td>'.$result["EMAIL"].'</td>';

      $html .= '<td>'.$result["MUNIDEP"].'</td>';

      $html .= '<td>'.$result["PAIS"].'</td>';

      return '<tr>'.$html.'</tr>';
    }
  }

  public function usuarioPorRadicado($nurad) {

    $isql = "
            select
                s.SGD_DIR_CODIGO    as codigo
              , s.SGD_DIR_NOMREMDES as nombre
              , s.SGD_DIR_DIRECCION as direccion
              , s.SGD_DIR_TELEFONO  as telef
              , s.SGD_DIR_MAIL      as email
              , s.SGD_TRD_CODIGO    as tipo
              , s.SGD_DIR_DOC       as cedula
              , p.NOMBRE_PAIS       as pais
              , CONCAT(d.DPTO_NOMB,' / ', m.MUNI_NOMB) as munidep
            from
                sgd_dir_drecciones s
              , DEPARTAMENTO d
              , MUNICIPIO m
              , SGD_DEF_PAISES p
            where
                  m.muni_codi      = s.muni_codi
              and m.dpto_codi      = s.dpto_codi
              and d.dpto_codi      = s.dpto_codi
              and p.id_pais        = s.id_pais
              and p.id_cont        = s.id_cont
              and d.id_pais        = s.id_pais
              and d.id_cont        = s.id_cont
              and s.radi_nume_radi = $nurad
          ";

    $rs = $this->db->query($isql);

    while(!$rs->EOF){
      $this->result[] = $rs->fields;
      $rs->MoveNext();
    }

    return !empty($this->result) ? true : false;
    break;

  }

  public function buscarPorParametros($search) {

    $tipo   = $search['tdoc'];
    $docu   = $search['docu'];
    $name   = $search['name'];
    $tele   = $search['tele'];
    $mail   = $search['mail'];
    $codi   = $search['codi'];

    switch ( $tipo ) {

      // Usuario ....................................................................
      case 0:

        if(!empty($name)){
          $where = $this->db->conn->Concat(" UPPER(sgd_ciu_nombre) "
                                         , " UPPER(sgd_ciu_apell1) "
                                         , " UPPER(sgd_ciu_apell2) ")
                                         . " LIKE '%". strtoupper($name) ."%' ";
        }

        if(!empty($docu)){
          $sub    = " UPPER(SGD_CIU_CEDULA)  LIKE '%$docu%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }


        if(!empty($tele)){
          $sub    = " UPPER(SGD_CIU_TELEFONO) LIKE '%$tele%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }

        if(!empty($mail)){
          $sub    = " UPPER(SGD_CIU_EMAIL)   LIKE '%$mail%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }

        if(!empty($codi)){
          $sub    = " UPPER(SGD_CIU_CODIGO)   LIKE '%$codi%'";
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

        $rs = $this->db->query($isql);
        while(!$rs->EOF){
          $this->result[] = $rs->fields;
          $rs->MoveNext();
        }
        return !empty($this->result) ? true : false;
        break;

      // Empresas ....................................................................
      case 2:

        if(!empty($name)){
          $where = $this->db->conn->Concat( "UPPER(SGD_OEM_OEMPRESA) LIKE '%". strtoupper($name) ."%'
                                      OR UPPER(SGD_OEM_SIGLA) LIKE '%". strtoupper($name) ."%'");
        }

        if(!empty($docu)){
          $sub    = " UPPER(SGD_OEM_NIT) LIKE '%$docu%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }


        if(!empty($tele)){
          $sub    = " UPPER(SGD_OEM_TELEFONO) LIKE '%$tele%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }

        if(!empty($mail)){
          $sub    = " UPPER(SGD_OEM_EMAIL)   LIKE '%$mail%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }

        if(!empty($codi)){
          $sub    = " UPPER(SGD_OEM_CODIGO)   LIKE '%$codi%'";
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

        $rs = $this->db->query($isql);

        while(!$rs->EOF){
          $this->result[] = $rs->fields;
          $rs->MoveNext();
        }
        return !empty($this->result) ? true : false;
        break;

      case 6:
        // Funcionario .................................................................
        if(!empty($name)){
          $where = $this->db->conn->Concat(" UPPER(s.USUA_NOMB) LIKE '%". strtoupper($name) ."%'");
        }

        if(!empty($docu)){
          $sub    = " cast(s.usua_doc as varchar) LIKE '%$docu%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }


        if(!empty($tele)){
          $sub    = ( "UPPER(s.USU_TELEFONO1) LIKE '%". strtoupper($tele) ."%'
                      OR UPPER(s.usua_ext)   LIKE '%". strtoupper($tele) ."%'");
          $where .= (empty($where))? $sub : ' and '. $sub;
        }

        if(!empty($mail)){
          $sub    = " UPPER(s.USUA_EMAIL)   LIKE '%$mail%'";
          $where .= (empty($where))? $sub : ' and '. strtoupper($sub);
        }

        if(!empty($codi)){
          $sub    = " UPPER(id)   LIKE '%$codi%'";
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

        $rs = $this->db->query($isql);

        while(!$rs->EOF){
          $this->result[] = $rs->fields;
          $rs->MoveNext();
        }
        return !empty($this->result) ? true : false;

        break;
    }
  }

}
?>
