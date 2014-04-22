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
  $db     = new ConnectionHandler("$ruta_raiz");
  $search = json_decode($_POST['search']);
var_dump($search["tdoc"]);die;

  //Filtro por el tipo de usuario
  switch ($test) {
    case 0:
      $data = array("cod"            => "12312312",
                    "nombre"         => "un nombre de un usuairo",
                    "direccion"      => "una direccion que es como larga",
                    "color de ojos"  => "Blancos",
                    "telefono"       => "un tefelfono 1232132");
      break;
    case 2:
      $data = array("cod"            => "44444444",
                    "nombre"         => "un nombre de un usuairo",
                    "direccion"      => "una direccion que es como larga",
                    "color de ojos"  => "Blancos",
                    "telefono"       => "un tefelfono 1232132");
      break;
    case 6:
      $data = array("cod"            => "22222222",
                    "nombre"         => "un nombre de un usuairo",
                    "direccion"      => "una direccion que es como larga",
                    "color de ojos"  => "Blancos",
                    "telefono"       => "un tefelfono 1232132");
      break;
  }

  echo json_encode($data);
?>
