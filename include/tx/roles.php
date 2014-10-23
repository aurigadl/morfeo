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

class Roles {
    /*** Attributes:
     * Clase que maneja los usuarios
     */

    var $db; //Conexion a la base de datos
    var $id;
    var $users;
    var $permisos;
    var $opciones;
    var $grupos;
    var $usuario;
    var $usuarios;
    var $dependencias;
    var $membresias;
    var $permisosUsuario;


    function __construct($db){
        $this->db=$db;
        //$this->db->conn->debug=true;
    }

    /**
     * retornar Permisos
     * @return bool
     */
    public function retornarPermisos(){
        $sql_perm = " SELECT
                          id,
                          nombre,
                          crud,
                          descripcion
                      FROM
                          autp_permisos";

        $perm     = $this->db->conn->query($sql_perm);

        if($perm->EOF){
            return false;
        }

        while(!$perm->EOF){

            $idperm = $perm->fields['ID'];

            $sql_perm_grup = " SELECT
                                  autg_id
                               FROM
                                  autr_restric_grupo
                               where
                                  autp_id = '$idperm'";

            $perm_grup     = $this->db->conn->query($sql_perm_grup);

            while(!$perm_grup->EOF){
                $grupPer[] = $perm_grup->fields['AUTG_ID'];
                $perm_grup->MoveNext();
            }

            $this->permisos[] = array(
            'ID'          => $idperm,
            'NOMBRE'      => $perm->fields['NOMBRE'],
            'CRUD'        => $perm->fields['CRUD'],
            'AUTG_ID'     => $grupPer,
            'DESCRIPCION' => $perm->fields['DESCRIPCION']);

            $perm->MoveNext();
        }


        return true;
    }


    /**
     * retornar Opciones
     * @return array de opciones
     */
    public function retornarOpcionesPermisos(){
        return array(  array('ID' => 1, 'NOMBRE' => 'Leer'),
                       array('ID' => 2, 'NOMBRE' => 'Editar'),
                       array('ID' => 3, 'NOMBRE' => 'Crear y Borrar')
                    );
    }


    /**
     * Retorna Grupos
     * @return bool, carga variable de grupos
     */
    public function retornarGrupos(){
        $sql_grup = " SELECT
                          id,
                          nombre,
                          descripcion
                      FROM
                          autg_grupos";

        $grup = $this->db->conn->query($sql_grup);

        if($grup->EOF){
            return false;
        }

        while (!$grup->EOF) {
            $this->grupos[] = $grup->fields;
            $grup->MoveNext();
        }

        return true;

    }



    /**
     * Retorna usuarios
     * @param  string nombre del usuario a retornar
     * @return bool, carga variable de usuarios
     */
    public function retornarUsuarios($usuario=false, $password=false){

        $sql_usua = " SELECT
                          id,
                          usua_nomb  as nombres,
                          usua_email as correo,
                          usua_pasw  as contrasena,
                          usua_login as usuario,
                          usua_esta  as estado
                      FROM
                          usuario";

        if(empty($usuario)){
            $usua = $this->db->conn->query($sql_usua);

            if($usua->EOF){
                return false;
            }

            while (!$usua->EOF) {
                //Todo requiere conversor para el password
                $this->usuarios[] = $usua->fields;
                $usua->MoveNext();
            }
        }else{
            $usuario = strtoupper($usuario);
            $sql_usua .= " where usua_esta like '1' and usua_login like '$usuario' ";

            if($password){
                $sql_usua  .= " AND (USUA_PASW ='".SUBSTR(md5($password),1,26)."' or USUA_NUEVO='0')";
            }

            $usua = $this->db->conn->query($sql_usua);

            if($usua->EOF){
                return false;
            }

            $this->usuario = $usua->fields;

        }

        return true;
    }


    /**
     * Retorna Dependencias
     * @return bool, carga variable de Dependencias
     */
    public function retornarDependencias(){
        $sql_depe = " SELECT
                        depe_nomb,
                        depe_codi
                      FROM
                        dependencia";

        $depe = $this->db->conn->query($sql_depe);

        if($depe->EOF){
            return false;
        }

        while (!$depe->EOF) {
            $this->dependencias[] = $depe->fields;
            $depe->MoveNext();
        }

        return true;
    }


    /**
     * Retorna Membresias
     * @return bool, carga variable de membresias
     */
    public function retornarMembresias(){
        $sql_memb = "SELECT
                        id,
                        autg_id,
                        autu_id
                      FROM
                        autm_membresias";

        $memb = $this->db->conn->query($sql_memb);

        if($memb->EOF){
            return false;
        }

        while (!$memb->EOF) {
            $this->membresias[] = $memb->fields;
            $memb->MoveNext();
        }

        return true;
    }



    /**
     * crear Grupo
     * @param  string nombre del grupo
     * @param  string descripcion delgrupo
     * @param  integer id del grupo
     * @return bool
    */
    public function creaEditaGrupo($nombre, $descripcion, $id){
        if($id){
            $nextval    = $id;
        }else{
            $sql_sel_id = "SELECT max(id) AS ID FROM autg_grupos";
            $sql_sel    = $this->db->conn->query($sql_sel_id);
            $nextval    = $sql_sel->fields["ID"] + 1;
        }

        $record = array();
        $record['id']           = $nextval;
        $record['nombre']       = $nombre;
        $record['descripcion']  = $descripcion;

        $insertSQL = $this->db->conn->Replace("autg_grupos",$record,'id',$autoquote = true);
        if(empty($insertSQL)){
            return false;
        }else{
            $this->id = $nextval;
            return true;
        }
    }




    /**
     * Borrar Grupo
     * @param  integer id del grupo
     * @return bool
     */
    public function borrarGrupo($id){
        $sql_sel_id = "delete from autg_grupos where id = $id";
        $sql_sel    = $this->db->conn->query($sql_sel_id);

        if(!$sql_sel->EOF){
            return false;
        }else{
            return true;
        }
    }


    /**
     * Crear y Edita Permisos
     * @param  string nombre del permiso
     * @param  string descripcion del permiso
     * @param  string dependencia del permiso
     * @param  string crud del permiso
     * @param  string grupo delpermiso
     * @param  integer id del permiso
     * @return bool
     */

    public function creaEditaPermiso($nombre, $descripcion, $crud, $grupo, $id){
        if($id){
            $nextval    = $id;
        }else{
            $sql_sel_id = "SELECT max(id) AS ID FROM autp_permisos";
            $sql_sel    = $this->db->conn->query($sql_sel_id);
            $nextval    = $sql_sel->fields["ID"] + 1;
        }

        $record = array();
        $record['id']          = $nextval;
        $record['nombre']      = $nombre;
        $record['descripcion'] = $descripcion;
        $record['crud']        = $crud;

        $insertSQL = $this->db->conn->Replace("autp_permisos",$record,'id',$autoquote = true);
        if(empty($insertSQL)){
            return false;
        }else{
            $this->id = $nextval;

            $del_sql = "delete from autr_restric_grupo where autp_id = '$nextval'";
            $this->db->conn->query($del_sql);

            foreach (explode(",",$grupo) as $value) {
                $sql_sel_id = "SELECT max(id) AS ID FROM autr_restric_grupo";
                $sql_sel    = $this->db->conn->query($sql_sel_id);
                $valnext    = $sql_sel->fields["ID"] + 1;

                $registro            = array();
                $registro['id']      = $valnext;
                $registro['autg_id'] = $value;
                $registro['autp_id'] = $nextval;


                $insertSQL = $this->db->conn->Replace("autr_restric_grupo",$registro,'autg_id, autg_id',
                    $autoquote = true);

                if(empty($insertSQL)){
                    return false;
                }
            }
            return true;
        }
    }

    /**
     * Borrar Permiso
     * @param  integer id del permiso
     * @return bool
     */
    public function borrarPermiso($id){
        $sql_sel_id = "delete from autp_permisos where id = $id";
        $sql_sel    = $this->db->conn->query($sql_sel_id);

        if(!$sql_sel->EOF){
            return false;
        }else{
            return true;
        }
    }


    /**
     * Crear y Editar Usuarios
     * @param  string nombre del usuario
     * @return bool
     */

    public function creaEditaUsuario($usuario, $nombres, $apellidos, $contrasena, $correo, $estado, $id){
        if($id){
            $nextval    = $id;
        }else{
            $sql_sel_id = "SELECT max(id) AS ID FROM usuario";
            $sql_sel    = $this->db->conn->query($sql_sel_id);
            $nextval    = $sql_sel->fields["ID"] + 1;
        }
        //Todo metodos para salvar correctamente las credenciales del usuario
        $record = array();

        $record['id']         = $nextval;
        $record['usua_nomb']  = $nombres;
        $record['usua_email'] = $correo;
        $record['usua_login'] = $usuario;
        $record['usua_esta']  = $estado;
        $record['usua_pasw']  = $contrasena;

        $insertSQL = $this->db->conn->Replace("usuario",$record,'id',$autoquote = true);

        if(empty($insertSQL)){
            return false;
        }else{
            $this->id = $nextval;
            return true;
        }

    }


    /**
     * Borrar Permiso
     * @param  integer id del permiso
     * @return bool
     */
    public function borrarUsuario($id){
        $sql_sel_id = "delete from autu_usuarios where id = $id";
        $sql_sel    = $this->db->conn->query($sql_sel_id);

        if(!$sql_sel->EOF){
            return false;
        }else{
            return true;
        }
    }

    /**
     * Buscar usuarios del grupo
     * @param  integer id del grupo
     * @return bool
     */
    public function buscarUsuariosGrupo($grupo){
        $sql_usu_id = "SELECT autu_id FROM autm_membresias where autg_id = $grupo";
        $sql_usu    = $this->db->conn->query($sql_usu_id);

        if(!$sql_usu->EOF){
            while (!$sql_usu->EOF && $sql_usu!=false) {
                $this->users[] = $sql_usu->fields['AUTU_ID'];
                $sql_usu->MoveNext();
            }
            return true;
        }else{
            return false;
        }
    }


    /**
     * Modificar Membresia
     * @param  integer id del grupo
     * @return array id's usuarios
     */
    public function modificarMembresia($grupo,$usuario,$estado){
        if(filter_var($estado, FILTER_VALIDATE_BOOLEAN)){

            $sql_sel_id = "SELECT max(id) AS ID FROM autm_membresias";
            $sql_sel    = $this->db->conn->query($sql_sel_id);
            $nextval    = $sql_sel->fields["ID"] + 1;

            $record = array();
            $record['id']       = $nextval;
            $record['autg_id']  = $grupo;
            $record['autu_id']  = $usuario;

            $insertSQL = $this->db->conn->Replace("autm_membresias",$record,'autg_id, autu_id',$autoquote = true);

            if(!$insertSQL->EOF){
                return false;
            }else{
                return true;
            }
        }else{
            $sql_sel_id = "delete from autm_membresias where autg_id = $grupo and autu_id = $usuario";
            $sql_sel    = $this->db->conn->query($sql_sel_id);

            if(empty($sql_sel)){
                return false;
            }else{
                return true;
            }
        }

    }


    /**
     * Valida el usuario y retorna los permisos
     * @param  string nombre del usuario
     * @return bool, cargar variable de permisos del usuario
     */

    public function traerPermisos($usuario, $password){
        if($this->retornarUsuarios($usuario, $password)){
            $id    = $this->usuario['ID'];
            //Todo se debe agregar las validaciones y encriptacion correspondiente
            //para tener el metodo seguro de ingreso
            $sql_perm = "SELECT
                            autp.nombre,
                            autp.dependencia,
                            autp.crud,
                            autp.descripcion
                         FROM
                             autp_permisos autp inner join  autg_grupos  autg on autg.id = autp.autg_id
                             inner join autm_membresias autm on autg.id = autm.autg_id
                             and autm.autu_id = $id";

            $sql = $this->db->conn->query($sql_perm);

            if(!$sql->EOF){
                while (!$sql->EOF && $sql!=false){
                    $this->permisosUsuario = $sql->fields;
                    $sql->MoveNext();
                }
            }
            return true;
        }else{
            return false;
        }
    }


    /**
     * Migrar usuarios actuales a la tabla de roles
     */

    public function migrarUsuarios(){

        $sal_usua = "SELECT
                        id,
                        usua_nomb,
                        usua_email,
                        usua_login,
                        usua_esta
        FROM usuario order by id";
        $sql      = $this->db->conn->query($sal_usua);

        while (!$sql->EOF && $sql!=false){
            $this->permisosUsuario = $sql->fields;
            $sql->MoveNext();
        }

        $sql_perm = "SELECT
                                autp.nombre,
                                autp.dependencia,
                                autp.crud,
                                autp.descripcion
                             FROM
                                 autp_permisos autp inner join  autg_grupos  autg on autg.id = autp.autg_id
                                 inner join autm_membresias autm on autg.id = autm.autg_id
                                 and autm.autu_id = $id";

        $sql = $this->db->conn->query($sql_perm);


    }

}