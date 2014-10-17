<?php
session_start();
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

header('Content-Type: application/json');

switch ($_POST['accion']){

    /**************************************
     * ********** Edición de grupos ********
     * ************************************/

    // Borrar registros de las distintas acciones..........................................
    case 'borrar':
        $id = $_POST['id'];

        switch($_POST['tipo']){

            case 'grupos':
                if($roles->borrarGrupo($id)){
                    $resultado = array('estado' => 1, 'valor' => $roles->id);
                }else{
                    $resultado = array('estado' => 0, 'valor' => '');
                }
                break;

            case 'permisos':
                if($roles->borrarPermiso($id)){
                    $resultado = array('estado' => 1, 'valor' => $roles->id);
                }else{
                    $resultado = array('estado' => 0, 'valor' => '');
                }
                break;

            case 'usuarios':
                if($roles->borrarUsuario($id)){
                    $resultado = array('estado' => 1, 'valor' => $roles->id);
                }else{
                    $resultado = array('estado' => 0, 'valor' => '');
                }
                break;
        }
        break;


    // Guardar registros...........................................
    case 'guardar':

        $id = $_POST['id'];

        switch($_POST['tipo']){

            case 'grupos':
                $nombre      = $_POST['nombre'];
                $descripcion = $_POST['descripcion'];
                if($roles->creaEditaGrupo($nombre,$descripcion, $id)){
                    $resultado = array('estado' => 1, 'valor' => $roles->id);
                }else{
                    $resultado = array('estado' => 0, 'valor' => '');
                }
                break;


            case 'permisos':
                $nombre      = $_POST['nombre'];
                $descripcion = $_POST['descripcion'];
                $dependencia = $_POST['dependencia'];
                $crud        = $_POST['crud'];
                $grupo       = $_POST['grupo'];

                if($roles->creaEditaPermiso($nombre, $descripcion, $dependencia, $crud, $grupo, $id)){
                    $resultado = array('estado' => 1, 'valor' => $roles->id);
                }else{
                    $resultado = array('estado' => 0, 'valor' => '');
                }
                break;


            case 'usuarios':
                $nombres     = $_POST['nombres'];
                $apellidos   = $_POST['apellidos'];
                $contrasena  = $_POST['contrasena'];
                $correo      = $_POST['correo'];

                if($roles->creaEditaUsuario($nombres, $apellidos, $contrasena, $correo, $id)){
                    $resultado = array('estado' => 1, 'valor' => $roles->id);
                }else{
                    $resultado = array('estado' => 0, 'valor' => '');
                }
                break;
        }
        break;

    // Buscar registros de los usuairos del grupo para realizar las memebresias.............
    case 'buscarUsuariosDelGrupo':
        $grupo  = $_POST['grupo'];
        if($roles->buscarUsuariosGrupo($grupo)){
            $resultado = array('estado' => 1, 'valor' => $roles->users);
        }else{
            $resultado = array('estado' => 0, 'valor' => '');
        }
        break;


    // Guardar registros cuando el usuario seleccione un usuario en un grupo................
    case 'grabarUsuariosDelGrupo':
        $usuario  = $_POST['usuario'];
        $estado   = $_POST['estado'];
        $grupo    = $_POST['grupo'];

        if($roles->modificarMembresia($grupo,$usuario,$estado)){
            $resultado = array('estado' => 1, 'valor' => '');
        }else{
            $resultado = array('estado' => 0, 'valor' => '');
        }
        break;

}

echo json_encode($resultado);
