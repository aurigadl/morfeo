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

    /**
     *@param  array $borrar usuarios del radicado
     *@return bool
     */
    public function borrarUsuarios(){

    }


    /**
     *@param  int $nurad Numero del radicado
     *@param  int $codigo del usuario
     *@param  int $sgdTrd tipo de usuario Funcionario, Usuairo, Entidad
     *@param  string  $modifica si puede existir el o no el Usuario con este radicado
     *@param  int $idCodigo codigo de identificacion en la tabla sgd_dir_direcciones
     *@return bool
     */
    public function guardarUsuarioRadicado($nurad, $codigo, $sgdTrd, $modificar, $idCodigo){

        $filter = array('RADI_NUME_RADI','SGD_TRD_CODIGO');

        switch ( $sgdTrd ) {
            // Usuario ....................................................................
            case 0:

                $sgd_ciu_codigo = $codigo;
                $filter[] = 'SGD_CIU_CODIGO';

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
                $filter[] = 'SGD_OEM_CODIGO';

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
                $filter[] = 'SGD_DOC_FUN';

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

        }

        $rs = $this->db->query($isql);

        $idcont          = $rs->fields['ID_CONT'];
        $idpais          = $rs->fields['ID_PAIS'];
        $dpto_tmp        = $rs->fields['DPTO_CODI'];
        $muni_tmp        = $rs->fields['MUNI_CODI'];
        $grbNombresUs    = $rs->fields['NOMBRE']." ".$rs->fields['APELLIDO'];
        $direccion_us    = $rs->fields['DIRECCION'];
        $mail_us         = $rs->fields['EMAIL'];
        $cc_documento_us = $rs->fields['CEDULA'];
        $telefono_us     = $rs->fields['TELEF'];

        if(!empty($modificar)){
            $nextval = $this->db->nextId("sec_dir_direcciones");
            if ($nextval==-1){
                $this->result[] = array( "error"  => 'No se encontr&oacute; la secuencia para grabar el usuario seleccionado');
                return false;
            }
        }

        $record = array();

        $record['MUNI_CODI']         = $muni_tmp;
        $record['DPTO_CODI']         = $dpto_tmp;
        $record['ID_PAIS']           = $idpais;
        $record['ID_CONT']           = $idcont;
        $record['SGD_TRD_CODIGO']    = $sgdTrd; // Tipo de documento

        $record['SGD_DIR_DIRECCION'] = $direccion_us;
        $record['SGD_DIR_TELEFONO']  = trim($telefono_us);
        $record['SGD_DIR_MAIL']      = $mail_us;
        $record['SGD_DIR_TIPO']      = 1;
        $record['SGD_DIR_CODIGO']    = $nextval; // Identificador unico
        //$record['SGD_DIR_NOMBRE']  = '';

        $record['SGD_DIR_NOMREMDES'] = $grbNombresUs;
        $record['SGD_DIR_DOC']       = $cc_documento_us;
        $record['SGD_DOC_FUN']       = empty($sgd_fun_codigo)? 0 : $sgd_fun_codigo;
        $record['SGD_OEM_CODIGO']    = empty($sgd_oem_codigo)? 0 : $sgd_oem_codigo;
        $record['SGD_CIU_CODIGO']    = empty($sgd_ciu_codigo)? "" : $sgd_ciu_codigo;
        $record['RADI_NUME_RADI']    = $nurad; // No de radicado
        $record['SGD_SEC_CODIGO']    = 0;

        $insertSQL =  $this->db->conn->Replace("SGD_DIR_DRECCIONES",
            $record,
            $filter,
            $autoquote = true);

        if($insertSQL){
            $this->result[] = $codigo;
            return true;
        }

    }


    /**
     * Funcion para modificar agregar usuarios a la
     * tabla y permitir su ingreso en la radicacion
     * Usada principalmente en la radicacion/new.php
     * @data array datos a procesar
     */
    function agregarUsuario($data){
        $this->setRadiResultJson($data);
        return $this->resRadicadoHtml();
    }



    /**
     * Modifica la variable de intercambio
     * @data array datos a procesar
     */
    function setRadiResultJson($data){
        $this->result = json_decode($data, true);
    }


    /**
     * Retorna un html que se integra con el codigo javascript escrito
     * en el modulo en que se implemente. Inicialmente esta funcion
     * esta hecha para radicacion incluida en New.php.
     * @return html from $this->result
     *
     */

    public function resRadicadoHtml(){

        foreach ($this->result as $k => $result){
            $tipo = $result["TIPO"];
            switch ( $tipo ) {
                case $tipo < 2:
                    $codigo = $result["SGD_CIU_CODIGO"];
                    break;
                case 2:
                    $codigo = $result["SGD_OEM_CODIGO"];
                    break;
                case 6:
                    $codigo = $result["SGD_DOC_FUN"];
                    break;
            }


            /**
             * Identificador para realizar transaccion y eventos desde
             * la pagina de radicacion, el identificador se compone por:
             * @tipo tipo de usuario (usuario, funcionario, empresa)
             * @codigo numero asignado en la respectiva tabla id
             * @codigo codigo grabado en la tabla sgd_dir_direcciones
             * si esta vacio se grabara como nuevo.
            */

            if(is_int($result['CODIGO'])){
                $codigo = 'XX';
                $hidediv = "hide";
                $hideinp = "";
            }else{
                $hidediv = "";
                $hideinp = "hide";
            }

            //Si es un registro nuevo mostramos los campos para editar

            $idtx = $k.'_'.$result["TIPO"].'_'.$codigo.'_'.$result["CODIGO"];

            $html = '<td class="search-table-icon">
                <a href="javascript:void(0);"
                  rel="tooltip"
                  data-placement="right"
                  data-original-title="Eliminar Usuario"
                  class="text-danger">
                  <i class="fa fa-minus"></i>
                </a>
                <input type="hidden" class="hide" name="usuario[]" value="'.$idtx.'">
              </td>';

            if(empty($result["CEDULA"])){
                $html .= '<td>
                  <div name="div_'.$idtx.'_ced" class="'.$hidediv.'">'
                    .$result["CEDULA"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                   </div>
                  <label name="inp_'.$idtx.'_ced" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="cedula'.$idtx.'_ced" value="'.$result["CEDULA"].'">
                  </label>
                </td>';
            }else{
                $html .= '<td>'.$result["CEDULA"].'</td>';
            }

            if(empty($result["NOMBRE"])){
                $html .= '<td>
                  <div name="div_'.$idtx.'_nomb" class="'.$hidediv.'">'.$result["NOMBRE"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                   </div>
                  <label name="inp_'.$idtx.'_nomb" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="nombre'.$idtx.'_nomb" value="'.$result["NOMBRE"].'">
                  </label>
                </td>';
                $html .= '<td>
                  <div name="div_'.$idtx.'_apell" class="hide">
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                   </div>
                  <label name="inp_'.$idtx.'_apell" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="apllido'.$idtx.'_apell" value="">
                  </label>
                </td>';
            }else{
                $html .= '<td colspan="2">'.$result["NOMBRE"].'</td>';
            }

            $html .= '<td>
                  <div name="div_'.$idtx.'_tel" class="'.$hidediv.'">'
                .$result["TELEF"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                   </div>
                  <label name="inp_'.$idtx.'_tel" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="telef'.$idtx.'_tel" value="'.$result["TELEF"].'">
                  </label>
                </td>';

            $html .= '<td>
                  <div name="div_'.$idtx.'_dire" class="'.$hidediv.'">'.$result["DIRECCION"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                  </div>
                  <label name="inp_'.$idtx.'_dire" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="direc'.$idtx.'_dire" value="'.$result["DIRECCION"].'">
                  </label>
                </td>';

            $html .= '<td>
                  <div name="div_'.$idtx.'_email" class="'.$hidediv.'">'
                .$result["EMAIL"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                   </div>
                  <label name="inp_'.$idtx.'_email" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="email'.$idtx.'_email" value="'.$result["EMAIL"].'">
                  </label>
                </td>';

            $html .= '<td>
                  <div name="div_'.$idtx.'_muni" class="'.$hidediv.'">'
                .$result["MUNI"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                  </div>
                  <label name="inp_'.$idtx.'_muni" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="muni'.$idtx.'_muni" value="'.$result["MUNI"].'">
                    <input type="hidden" name="muni'.$idtx.'_muni_codigo" value="'.$result["MUNI_CODIGO"].'">
                  </label>
                </td>';

            $html .= '<td>
                  <div name="div_'.$idtx.'_dep" class="'.$hidediv.'">'
                .$result["DEP"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                  </div>
                  <label name="inp_'.$idtx.'_dep" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="dep'.$idtx.'_dep" value="'.$result["DEP"].'">
                    <input type="hidden" name="dep'.$idtx.'_dep_codigo" value="'.$result["DEP_CODIGO"].'">
                  </label>
                </td>';

            $html .= '<td>
                  <div name="div_'.$idtx.'_pais" class="'.$hidediv.'">'
                .$result["PAIS"].'
                    <a href="javascript:void(0);" class="pull-right"><i class="fa fa-pencil"></i></a>
                  </div>
                  <label name="inp_'.$idtx.'_pais" class="input '.$hideinp.'">
                    <i class="icon-append fa fa-check"></i>
                    <input type="text" name="pais'.$idtx.'_pais" value="'.$result["PAIS"].'">
                    <input type="hidden" name="pais'.$idtx.'_pais_codigo" value="'.$result["PAIS_CODIGO"].'">
                  </label>
                </td>';

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
              , p.ID_PAIS           as pais_codigo
              , d.DPTO_NOMB         as dep
              , d.DPTO_CODI         as dep_codigo
              , m.MUNI_NOMB         as muni
              , m.MUNI_CODI         as muni_codigo
              , s.SGD_DOC_FUN
              , s.SGD_OEM_CODIGO
              , s.SGD_CIU_CODIGO
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
                  ,p.ID_PAIS           as pais_codigo
                  ,d.DPTO_NOMB         as dep
                  ,d.DPTO_CODI         as dep_codigo
                  ,m.MUNI_NOMB         as muni
                  ,m.MUNI_CODI         as muni_codigo
                  ,0                   as tipo
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
                  ,p.NOMBRE_PAIS       as pais
                  ,p.ID_PAIS           as pais_codigo
                  ,d.DPTO_NOMB         as dep
                  ,d.DPTO_CODI         as dep_codigo
                  ,m.MUNI_NOMB         as muni
                  ,m.MUNI_CODI         as muni_codigo
                  ,2                   as tipo
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
                  ,s.usua_login   AS apellido
                  ,CONCAT(s.usu_telefono1,' ', s.usua_ext) AS telef
                  ,p.NOMBRE_PAIS  as pais
                  ,p.ID_PAIS      as pais_codigo
                  ,d.DPTO_NOMB    as dep
                  ,d.DPTO_CODI    as dep_codigo
                  ,m.MUNI_NOMB    as muni
                  ,m.MUNI_CODI    as muni_codigo
                  ,6              as tipo
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
