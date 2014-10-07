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

$ruta_raiz = '../../';
if (!$_SESSION['dependencia'])
    header ("Location: $ruta_raiz/cerrar_session.php");

include_once("$ruta_raiz/include/db/ConnectionHandler.php");
include_once("$ruta_raiz/include/tx/roles.php");

$db       = new ConnectionHandler("$ruta_raiz");
$roles    = new Roles($db);

switch ($_POST['accion']){
    /**************************************
     * ********** Edición de grupos ********
     * ************************************/
    case 'borrar':
        break;

    // Guardar registros...........................................
    case 'guardar':
        $nombre      = $_POST['nombre'];
        $descripcion = $_POST['descripcion'];
        $id          = $_POST['id'];

        switch ($_POST['tipo']){

            case 'grupos':
                if($roles->creaEditaGrupo($nombre,$descripcion, $id)){
                    return array('estado' => 1, 'valor' => $roles->getidGrupo());
                }else{
                    return array('estado' => 0, 'valor' => '');
                }
                break;

        }
}
