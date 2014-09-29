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
}
