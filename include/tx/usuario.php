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
#require '/var/www/html/orfeocore/config.php';

class Usuario {
    /*** Attributes:
     * Clase que maneja los usuarios
     */

    var $db;
    var $result;

    function __construct($db){
        $this->db=$db;
# $midriver=$this->db->driver;
    }


    /**
     * crear y editar usuario
     * @param  array son necesarios el id_usuario, el tipo de usuario y datos
     * @return bool
     */
    function usuarioCreaEdita($datos){
        // Usuario ....................................................................
        $idUser = intval($datos['id_table']); //Id del usuario

        switch ( $datos['sgdTrd'] ){
            case 0:
                if(empty($idUser)){
                    $nextval=$this->db->nextId("sec_ciu_ciudadano");

                    if ($nextval==-1){
                        $this->result[] = array( "error"  => 'No se encontr&oacute; la secuencia sec_ciu_ciudadano');
                        return false;
                    }
                } else {
                    $nextval = $idUser;
                }

                $record = array();
                $record['sgd_ciu_codigo']     = $nextval;
                $record['sgd_ciu_nombre']     = $datos['nombre'];
                $record['sgd_ciu_apell1']     = $datos['apellido'];
                $record['sgd_ciu_direccion']  = $datos['direccion'];
                $record['sgd_ciu_telefono']   = $datos['telef'];
                $record['sgd_ciu_email']      = $datos['email'];
                $record['sgd_ciu_cedula']     = $datos['cedula'];
                $record['tdid_codi']          = $datos['tdid_codi'];
                $record['muni_codi']          = $datos['muni_tmp'];
                $record['dpto_codi']          = $datos['dpto_tmp'];
                $record['id_cont']            = $datos['cont_tmp'];
                $record['id_pais']            = $datos['pais_tmp'];

                $insertSQL = $this->db->conn->Replace("sgd_ciu_ciudadano",$record,'sgd_ciu_codigo',$autoquote = true);

                //Regresa 0 si falla, 1 si efectuo el update y 2 si no se
                //encontro el registro y el insert fue con exito
                if($insertSQL){
                    $this->result = $nextval;
                    return true;
                }

                break;

            // Empresas ....................................................................
            case 2:
                if(empty($idUser)){
                    $nextval=$this->db->nextId("sgd_oem_oempresas");

                    if ($nextval==-1){
                        $this->result = array( "error"  => 'No se encontr&oacute; la secuencia sgd_oem_oempresas');
                        return false;
                    }

                } else {
                    $nextval = $idUser;
                }

                $record = array();
                $record['sgd_oem_codigo']     = $nextval;
                $record['tdid_codi']          = $datos['tdid_codi'];
                $record['sgd_oem_oempresa']   = $datos['nombre'];
                $record['sgd_oem_rep_legal']  = $datos['apellido'];
                $record['sgd_oem_nit']        = $datos['cedula'];

                $record['sgd_oem_direccion']  = $datos['direccion'];
                $record['sgd_oem_telefono']   = $datos['telef'];
                $record['sgd_oem_email']      = $datos['email'];

                $record['muni_codi']          = $datos['muni_tmp'];
                $record['dpto_codi']          = $datos['dpto_tmp'];
                $record['id_cont']            = $datos['cont_tmp'];
                $record['id_pais']            = $datos['pais_tmp'];

                $insertSQL = $this->db->conn->Replace("sgd_oem_oempresas",$record,'sgd_ciu_codigo',$autoquote = true);

                if($insertSQL){
                    $this->result = $codigo;
                    return true;
                }

                break;

            // Funcionario .................................................................
            case 6:
                $this->result = $idUser;
                return true;
                break;
        }
    }



    /**
     * Buscar todos lo usuarios de las dependencias seleccionadas
     * @param array dependencias seleccionadas
     * @return bool
     */
    public function usuariospordependencias($dependencia){

        $isql = " select
                        u.usua_nomb,
                        u.usua_codi
                      from
                        dependencia d,
                        usuario u
                      where
                        d.depe_codi = u.depe_codi and
                        d.depe_codi = $dependencia";

        $rs   = $this->db->query($isql);

        while(!$rs->EOF){
            $this->result[] = $rs->fields;
            $rs->MoveNext();
        }

        return true;
    }

    /**
     * Borrar usuario de sgd_dir_codigo
     * @param array parametros de usuarios a borrar
     * @param numero de radicado
     * @return bool
     */
    public function borrarUsuarioRadicado($user, $nurad){
        $isql = "DELETE FROM
                    sgd_dir_drecciones
                 WHERE
                    radi_nume_radi = $nurad and
                    sgd_dir_codigo = $user";

        $rs   = $this->db->query($isql);
    }

    /**
     * Borrar usuario de sgd_dir_codigo
     * @param array parametros de usuarios a borrar
     * @param numero de radicado
     * @return bool
     */
    public function usuariosDelRadicado($nurad){

        $isql = "select
                    sgd_dir_codigo
                 from
                    SGD_DIR_DRECCIONES
                 where
                    RADI_NUME_RADI = $nurad";

        $rs = $this->db->query($isql);

        while(!$rs->EOF){
            $codi[] = $rs->fields['SGD_DIR_CODIGO'];
            $rs->MoveNext();
        }

        $this->result = $codi;
        return true;
    }

    /**
     * consecutivo _ sgdTrd _ id_sgd_dir_dre _ id_table
     * 1) Un usuario nuevo (0_0_XX_XX)....
     * 2) Un usuario existente en el sistema, NO asociado a un radicado (0_0_XX_12)
     * 3) Un usuario existen (0_0_123_17) (0_0_327_123)
     *
     * @param  array parametros del usuario a crear
     * @return bool
     *
     */
    public function guardarUsuarioRadicado($user, $nurad){

        $idUser       = intval($user['id_table']); //Id del usuario
        $idInRadicado = intval($user['id_sgd_dir_dre']);//Id usuario registrado en radicado

        //Modificar o Crea un usuario
        if($this->usuarioCreaEdita($user)){
            $coduser = $this->result;
        };

        //agregar usuario al radicado
        if(empty($idInRadicado)){
            $nextval = $this->db->nextId("sgd_dir_drecciones");
            if ($nextval==-1){
                $this->result[] = array( "error"  => 'No se encontr&oacute; la secuencia para grabar el usuario seleccionado');
                return false;
            }
        //Modificar usuario ya registrado
        }else{
            $nextval = $idInRadicado;
        }

        $record = array();

        $record['MUNI_CODI']         = $user['muni_tmp'];
        $record['DPTO_CODI']         = $user['dpto_tmp'];
        $record['ID_PAIS']           = $user['pais_tmp'];
        $record['ID_CONT']           = 1;
        $record['SGD_TRD_CODIGO']    = $user['sgdTrd']; // Tipo de documento

        $record['SGD_DIR_DIRECCION'] = $user['direccion'];
        $record['SGD_DIR_TELEFONO']  = $user['telef'];
        $record['SGD_DIR_MAIL']      = $user['email'];
        $record['SGD_DIR_TIPO']      = $user['cont_tmp'];
        $record['SGD_DIR_CODIGO']    = $nextval; // Identificador unico
        $record['SGD_DIR_NOMBRE']    = $user['nombre'].' '.$user['apellido'];

        if($user['dignatario']){
            $record['SGD_DIR_NOMREMDES'] = $user['dignatario'];
        }

        $record['SGD_DIR_DOC']       = empty($user['cedula'])?  '0' : $user['cedula'];

        $record['RADI_NUME_RADI']    = $nurad; // No de radicado
        $record['SGD_SEC_CODIGO']    = 0;


        switch ( $user['sgdTrd'] ){
            // Usuario ....................................................................
            case 0:
                $record['SGD_CIU_CODIGO']    = $coduser;
                break;

            // Empresas ....................................................................
            case 2:
                $record['SGD_OEM_CODIGO']    = $coduser;
                break;

            // Funcionario .................................................................
            case 6:
                $record['SGD_DOC_FUN']       = $coduser;
                break;
        }

        $insertSQL =  $this->db->conn->Replace("SGD_DIR_DRECCIONES",
        $record,
        'SGD_DIR_CODIGO',
        $autoquote = true);

        if(!empty($insertSQL)){
            $this->result =  array( "state"  => true, "value" => $nextval);
            return true;
        }else{
            $this->result = array( "error"  => 'No se puedo agregar usuario al radicado');
            return false;
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

        $select = "  SELECT
                       tdid_codi, tdid_desc
                     FROM tipo_doc_identificacion";

        $rs = $this->db->query($select);

        while(!$rs->EOF){
            $codi = $rs->fields[0];
            $desc = $rs->fields[1];
            if($result["TDID_CODI"] === $codi && !empty($result["TDID_CODI"])){
                $options .= "<option value=' $codi ' selected >$desc</option>";
            }else{
                $options .= "<option value=' $codi '>$desc</option>";
            }
            $rs->MoveNext();
        }

        foreach ($this->result as $k => $result){
            $tipo = intval($result["TIPO"]);
            switch ( $tipo ) {
                case 0:
                case 2:
                    $codigo = $result["SGD_CIU_CODIGO"];
                    break;
                case 2:
                    $codigo = $result["SGD_OEM_CODIGO"];
                    break;
                case 6:
                    $codigo = $result["SGD_DOC_FUN"];
                    break;
            }

            if(empty($codigo)){
                $codigo = 'XX';
            }

            /**
             * Identificador para realizar transaccion y eventos desde
             * la pagina de radicacion, el identificador se compone por:
             * @tipo tipo de usuario (usuario, funcionario, empresa)
             * @codigo numero asignado en la respectiva tabla id
             * @codigo codigo grabado en la tabla sgd_dir_direcciones
             * si esta vacio se grabara como nuevo.
            */

            //Si es un registro nuevo mostramos los campos para editar
            $idtx = $k.'_'.$result["TIPO"].'_'.$codigo.'_'.$result["CODIGO"];

            $html = '<td class="search-table-icon">
                        <div class="row-fluid">
                            <span class="inline widget-icon txt-color-red"
                              rel="tooltip"
                              data-placement="right"
                              data-original-title="Eliminar Usuario">
                              <i class="fa fa-minus"></i></span>
                        </div>
                        <input type="hidden" class="hide" name="usuario[]" value="'.$idtx.'">
                      </td>';

            $html .= '  <td>
                          <label name="inp_'.$idtx.'_tdid_codi" class="select">
                            <select name="'.$idtx.'_tdid_codi">
                                '.$options.'
                            </select>
                          </label>
                        </td>';

            if(empty($result["CEDULA"])){
                $html .= '<td>
                  <label name="inp_'.$idtx.'_ced" class="input">
                    <input type="text" name="'.$idtx.'_cedula" value="'.$result["CEDULA"].'">
                  </label>
                </td>';
            }else{
                $html .= '<td>
                  <label name="inp_'.$idtx.'_ced" class="input">
                    <input readonly type="text" name="'.$idtx.'_cedula" value="'.$result["CEDULA"].'">
                  </label>
                </td>';
            }

            $html .= '  <td>
                          <label name="inp_'.$idtx.'_nomb" class="input">
                            <input type="text" name="'.$idtx.'_nombre" value="'.$result["NOMBRE"].'">
                          </label>
                        </td>';


            $html .= '  <td>
                          <label name="inp_'.$idtx.'_apell" class="input">
                            <input type="text" name="'.$idtx.'_apellido" value="'.$result["APELLIDO"].'">
                          </label>
                        </td>';

            $html .= '  <td>
                          <label name="inp_'.$idtx.'_tel" class="input">
                            <input type="text" name="'.$idtx.'_telefono" value="'.$result["TELEF"].'">
                          </label>
                        </td>';

            $html .= '  <td>
                          <label name="inp_'.$idtx.'_dire" class="input">
                            <input type="text" name="'.$idtx.'_direccion" value="'.$result["DIRECCION"].'">
                          </label>
                        </td>';

            $html .= '  <td>
                          <label name="inp_'.$idtx.'_email" class="input">
                            <input type="text" name="'.$idtx.'_email" value="'.$result["EMAIL"].'">
                          </label>
                        </td>';

            $html .= '  <td>
                          <label name="inp_'.$idtx.'_digna" class="input">
                            <input type="text" name="'.$idtx.'_dignatario" value="'.$result["DIGNATARIO"].'">
                          </label>
                        </td>';

            $html .= '  <td class="toogletd">
                          <label name="inp_'.$idtx.'_muni" class="input">
                            <input type="text" name="'.$idtx.'_muni" value="'.$result["MUNI"].'">
                            <input type="hidden" name="'.$idtx.'_muni_codigo" value="'.$result["MUNI_CODIGO"].'">
                          </label>
                        </td>';

            $html .= '  <td class="toogletd">
                          <label name="inp_'.$idtx.'_dep" class="input">
                            <input type="text" name="'.$idtx.'_dep" value="'.$result["DEP"].'">
                            <input type="hidden" name="'.$idtx.'_dep_codigo" value="'.$result["DEP_CODIGO"].'">
                          </label>
                        </td>';

            $html .= '  <td class="toogletd">
                          <label name="inp_'.$idtx.'_pais" class="input">
                            <input type="text" name="'.$idtx.'_pais" value="'.$result["PAIS"].'">
                            <input type="hidden" name="'.$idtx.'_pais_codigo" value="'.$result["PAIS_CODIGO"].'">
                          </label>
                        </td>';

            $htmltotal .= '<tr>'.$html.'</tr>';
        }

        return $htmltotal;
    }



    public function usuarioPorRadicado($nurad) {
         $isql = "
            select
                s.SGD_DIR_CODIGO    as codigo
              , s.SGD_DIR_NOMBRE    as nombre
              , s.SGD_DIR_NOMREMDES as dignatario
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

        $tipo   = (is_array($search['tdoc']))? $search['tdoc']['value'] : $search['tdoc'];
        $docu   = (is_array($search['docu']))? $search['docu']['value'] : $search['docu'];
        $name   = (is_array($search['name']))? $search['name']['value'] : $search['name'];
        $tele   = (is_array($search['tele']))? $search['tele']['value'] : $search['tele'];
        $mail   = (is_array($search['mail']))? $search['mail']['value'] : $search['mail'];
        $codi   = (is_array($search['codi']))? $search['codi']['value'] : $search['codi'];

        switch ( $tipo ) {

            // Usuario ........................................................
            case 0:

                if(!empty($name)){

                    $where = $this->db->conn->Concat("(UPPER(s.SGD_CIU_NOMBRE) LIKE '%". strtoupper($name) ."%' OR
                                                       UPPER(s.SGD_CIU_APELL1) LIKE '%". strtoupper($name) ."%' OR
                                                       UPPER(s.SGD_CIU_APELL2) LIKE '%". strtoupper($name) ."%')") ;
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
    $concatApell = $this->db->conn->Concat('s.SGD_CIU_APELL1',"' '",'s.SGD_CIU_APELL2');

                #LLAMO UNA FUNCIÓN CONNECCIÓN HANDLER LLAMADA LIMIT LA CUAL ME DEVUELVE LA ESTRUCTURA CORRECTA
                $this->db->limit(24);
                $limitMsql = $this->db->limitMsql;
                $limitOci8 = $this->db->limitOci8;
                $limitPsql = $this->db->limitPsql;
    $isql = "SELECT $limitMsql
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
                  ,s.TDID_CODI         as tdid_codi
                 ,$concatApell as apellido
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
                  
      $limitOci8
                 ORDER BY s.SGD_CIU_NOMBRE, s.SGD_CIU_APELL1, s.SGD_CIU_APELL2
     $limitPsql";



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
                  ,s.TDID_CODI         as tdid_codi
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
                  ORDER  BY sgd_oem_oempresa ";
  switch ($db->driver)
 {case 'mssql': $isql= $isql."  LIMIT 24"; break;
  case 'oracle': $isql= $isql."  ROWNUM<=24"; break;
  case 'oci8':   $isql= $isql."  ROWNUM<=24"; break;
  case 'postgres': $isql= $isql."  LIMIT 24"; break;}

                break;

            case 6:
                // Funcionario ..............................................................................
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
                  ,0              as tdid_codi
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
                ORDER  BY usua_nomb ";

/*  switch ($db->driver)
 {case 'mssql': $isql= $isql."  LIMIT 24"; break;
  case 'oracle': $isql= $isql."  ROWNUM<=24"; break;
  case 'oci8':   $isql= $isql."  ROWNUM<=24"; break;
  case 'postgres': $isql= $isql."  LIMIT 24"; break;}*/

                break;
        }
#$this->db->conn->debug=true;
        $rs = $this->db->query($isql);

        while(!$rs->EOF){
            $this->result[] = $rs->fields;
            $rs->MoveNext();
        }

        return !empty($this->result) ? true : false;

    }
}
