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
(at your option) any later version.

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

    $radicados   = array_filter(explode(",", $_POST["rads"]));
    $codusuario  = $_SESSION["codusuario"];
    $dependencia = $_SESSION["dependencia"];

    if(!$db){
        include_once("$ruta_raiz/conn.php");
    }

    include_once("$ruta_raiz/include/tx/Tx.php");

    $tx      = new Tx($db);
    $observa = "Eliminaci&oacute;n informado";
    $infdel  = $tx->borrarInformado($radicados, "", "", $dependencia, "", $codusuario, $observa);
    $msginf  = implode(",", $infdel);

    if(!empty($infdel)){
        echo "<div class='alert alert-success fade in'>
                <button class='close' data-dismiss='alert'> × </button>
                <i class='fa-fw fa fa-check'></i>
                <strong>Borrar informados</strong>
                Se borraron los radicados $msginf de informados.
                <span id=refresh class='btn btn-ribbon' data-reset-msg='Recargar Pagina' data-html='true' rel='tooltip' data-title='refresh' data-action='resetWidgets'>
            </div>";
    } else {
        echo "<div class='alert alert-danger fade in'>
                <button class='close' data-dismiss='alert'> × </button>
                <i class='fa-fw fa fa-times'></i>
                <strong>Error al borrar los informados.</strong>
                Radicados $msginf
            </div>";
    }