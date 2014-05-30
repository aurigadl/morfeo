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
session_start();
$ruta_raiz = "..";

if (!$_SESSION['dependencia'])
    header ("Location: $ruta_raiz/cerrar_session.php");

header('Content-Type: application/json');
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
include_once("$ruta_raiz/include/tx/usuario.php");
$db     = new ConnectionHandler("$ruta_raiz");

if($_POST['search']){
    $usuario= new Usuario($db);
    $trans  = json_decode($_POST['search'], true);

    $search['tdoc'] = $trans['tdoc']['value'];
    $search['docu'] = $trans['docu']['value'];
    $search['name'] = $trans['name']['value'];
    $search['tele'] = $trans['tele']['value'];
    $search['mail'] = $trans['mail']['value'];

    //Filtro por el tipo de usuario
    $result = $usuario->buscarPorParametros( $search );

    if($result){
        echo json_encode($usuario->result);
    }
}

if($_POST['addUser']){
    $data    = $_POST['addUser'];
    $usuario = new Usuario($db);
    $result  = $usuario->agregarUsuario($data);
    if($result){
        echo json_encode(array($result));
    }
}