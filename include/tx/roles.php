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
    }


    /**
     * crear roles
     * @param  string nombre del rol
     * @param  string descripcion del rol
     * @return bool
     */
    public function creaEditaGrupo($nombre, $descripcion, id){

        $record = array();
        $record['id']     = $nextval;
        $record['nombre']     = $datos['nombre'];
        $record['descripcion']     = $datos['apellido'];

        $insertSQL = $this->db->conn->Replace("sgd_ciu_ciudadano",$record,'sgd_ciu_codigo',$autoquote = true);
    }

}
