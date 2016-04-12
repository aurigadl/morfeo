<?php
/**
 * @author Jairo Losada   <jlosada@gmail.com>
 * @author Cesar Gonzalez <aurigadl@gmail.com>
 * @license  GNU AFFERO GENERAL PUBLIC LICENSE
 * @copyright

Orfeo Models are the data definition of Orfeo Information System
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




/**
 *
 * Esta clase nos permite consultar los distintos elementos de
 * la división política, generar los combos para que se generen
 * las consultas ajax y nos retorna los respectivos resultados
 * de las consultas parciales relacionadas con la ubicación geográfica.
 * @package Tx
 */
class divipola {

    var $db;
    var $result;

    function __construct($db){
        $this->db=$db;
    }

    /** Funcion para retornar el listado llave valor de los
     * municipios dependiendo del dependencia, pais y continente
     * que se pasen como arugmento
     * @buscar array parametros para realizar el filtro del municipio
     * @return json array con verdadero si la consulta es exitosa de
     * lo contrario false
     */
    public function buscarMunicipio($buscar){
        $dep  = strtoupper($buscar['dep']);
        $pais = strtoupper($buscar['pais']);
        $muni = strtoupper($buscar['muni']);

        $this->result = array();

        if($this->buscarPais($buscar)){
            $codPais = $this->result[0]['CODIGO'];
        }else{
            return false;
        }

        $this->result = array();

        if($this->buscarDepartamento($buscar)){
            $codDep = $this->result[0]['CODIGO'];
        }else{
            return false;
        }

        $isql = "SELECT
                    muni_codi as codigo,
                    muni_nomb as nombre
                 FROM
                    municipio
                 where
                    muni_nomb like '%$muni%' and
                    id_pais   = $codPais and
                    dpto_codi = $codDep ";

        $rs = $this->db->query($isql);

        while(!$rs->EOF){
            $this->result[] = $rs->fields;
            $rs->MoveNext();
        }
        return !empty($this->result) ? true : false;
    }

    /**Funcion para retornar el listado llave valor de los
     * departamentos dependiendo del pais
     * que se pasen como arugmento
     * @buscar array parametros para realizar el filtro del municipio
     * @return json array con verdadero si la consulta es exitosa de
     * lo contrario false
     */
    public function buscarDepartamento($buscar){
        $pais   = strtoupper($buscar['pais']);
        $dep    = strtoupper($buscar['dep']);

        $this->result = array();

        if($this->buscarPais($buscar)){
            $codPais = $this->result[0]['CODIGO'];
        }else{
            return false;
        }

        $isql = "SELECT
                    dpto_codi as codigo,
                    dpto_nomb as nombre
                 FROM
                    departamento
                 WHERE
                    UPPER(dpto_nomb) LIKE '%$dep%' AND
                    id_pais = $codPais";

        $rs = $this->db->query($isql);
        $this->result = array();

        while(!$rs->EOF){
            $this->result[] = $rs->fields;
            $rs->MoveNext();
        }

        return !empty($this->result) ? true : false;
    }



    /**Funcion para retornar el listado llave valor de los
     * paises sin depender del continente
     * que se pasen como arugmento
     * @buscar array parametros para realizar el filtro del municipio
     * @return json array con verdadero si la consulta es exitosa de
     * lo contrario false
     */
    public function buscarPais($buscar){
        $pais = strtoupper($buscar['pais']);
        $isql = "SELECT
                    id_pais     as codigo,
                    nombre_pais as nombre
                FROM
                    sgd_def_paises
                WHERE
                    UPPER(nombre_pais) LIKE '%$pais%' ";

        $rs = $this->db->query($isql);

        while(!$rs->EOF){
            $this->result[] = $rs->fields;
            $rs->MoveNext();
        }

        return !empty($this->result) ? true : false;
    }

} 