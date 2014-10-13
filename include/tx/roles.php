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

    var $db;
    var $id;

    function __construct($db){
        $this->db=$db;
        $this->db->conn->debug=true;
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

    public function creaEditaPermiso($nombre, $descripcion, $dependencia, $crud, $grupo, $id){
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
        $record['dependencia'] = $dependencia;
        $record['crud']        = $crud;
        $record['autg_id']     = $grupo;

        $insertSQL = $this->db->conn->Replace("autp_permisos",$record,'id',$autoquote = true);
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
    public function borrarPermiso($id){
        $sql_sel_id = "delete from autp_permisos where id = $id";
        $sql_sel    = $this->db->conn->query($sql_sel_id);

        if(!$sql_sel->EOF){
            return false;
        }else{
            return true;
        }
    }
}
