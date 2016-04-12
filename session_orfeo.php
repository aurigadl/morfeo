<?php
/**
 * @module session_orfeo
 *
 * @author Cesar Gonzalez <aurigadl@gmail.com>
 * @license  GNU AFFERO GENERAL PUBLIC LICENSE
 * @copyright

Orfeo Models are the data definition of Orfeo Information System
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
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
include_once "$ruta_raiz/config.php";
include_once("$ruta_raiz/include/tx/roles.php");

//contiene función que verifica usuario y Password en LDAP
include("$ruta_raiz/autenticaMail.php");
$path_raiz = realpath(dirname(__FILE__));
include("$ruta_raiz/include/utils/Utils.php");

if ($_POST['krd']) {
   $krd = preg_replace('/[^A-Za-z0-9\-]/', '', str_replace(' ', '-', strtoupper($_POST['krd'])));
}

if ($_POST['password']) {
    $drd = $_POST['password'];
}

$db = new ConnectionHandler("$ruta_raiz");
$roles = new Roles($db);
$db->conn->SetFetchMode(ADODB_FETCH_NUM);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

if (!defined('ADODB_ASSOC_CASE'))
    define('ADODB_ASSOC_CASE', 1);

$fechah = date("Ymd") . "_" . time("hms");
$check = 1;
$numeroa =
$numero =
$numeros =
$numerot =
$numerop =
$numeroh = 0;
$validacionKrd = false;

$query = " SELECT
                a.SGD_TRAD_CODIGO AS SGD_TRAD_CODIGO,
                a.SGD_TRAD_DESCR,
                a.SGD_TRAD_ICONO AS SGD_TRAD_ICONO
            FROM
                SGD_TRAD_TIPORAD a
            order by a.SGD_TRAD_CODIGO";

$rs                = $db->conn->Execute($query);
$comentarioDev     = ' Busca todos los tipos de Radicado Existentes ';
$validacionUsuario = false;

$iTpRad = 0;
$queryTip3 = "";
$tpNumRad =
$tpDescRad =
$tpImgRad = array();

$queryTRad = "";
$queryDepeRad = "";

while (!$rs->EOF) {
    $tpNumRad[$iTpRad]  = $rs->fields["SGD_TRAD_CODIGO"];
    $tpDescRad[$iTpRad] = $rs->fields["SGD_TRAD_DESCR"];
    $tpImgRad[$iTpRad]  = $rs->fields["SGD_TRAD_ICONO"];
    $iTpRad++;
    $rs->MoveNext();
}


/**
 * BUSQUEDA DE ICONOS Y NOMBRES PARA LOS TERCEROS
 * (Remitentes/Destinarios) AL RADICAR * $tip3[][][]  Array
 *  Contiene los tipos de radicacion existentes.
 *  En la primera dimencion indica la posicion
 *  dependiendo del tipo de rad. (ej. salida -> 1, ...).
 *  En la segunda dimencion almacenara los datos de
 *  nombre del tipo de rad. inidicado,
 *  Para la tercera dimencion indicara la descripcion del
 *  tercero y en la cuarta dim. contiene el nombre del
 *  archio imagen del tipo de tercero.
 */

$query = "  SELECT
                    a.SGD_DIR_TIPO,
                    a.SGD_TIP3_CODIGO,
                    a.SGD_TIP3_NOMBRE,
                    a.SGD_TIP3_DESC,
                    a.SGD_TIP3_IMGPESTANA
					$queryTip3
                FROM
                    SGD_TIP3_TIPOTERCERO a";

$rs = $db->conn->Execute($query);

while (!$rs->EOF) {
    $dirTipo  = $rs->fields["SGD_DIR_TIPO"];
    $nombTip3 = $rs->fields["SGD_TIP3_NOMBRE"];
    $descTip3 = $rs->fields["SGD_TIP3_DESC"];
    $imgTip3  = $rs->fields["SGD_TIP3_IMGPESTANA"];

    for ($iTp = 0; $iTp < $iTpRad; $iTp++) {
        $numTp       = $tpNumRad[$iTp];
        $campoTip3   = "SGD_TPR_TP$numTp";
        $numTpExiste = $rs->fields[$campoTip3];

        if ($numTpExiste >= 1) {
            $tip3Nombre[$dirTipo][$numTp] = $nombTip3;
            $tip3desc[$dirTipo][$numTp] = $descTip3;
            $tip3img[$dirTipo][$numTp] = $imgTip3;
        }
    }
    $rs->MoveNext();
}


//Analiza la opcion de que se trate de un requerimieento de sesion desde una mÃ¡quina segura
if (isset($host_log_seguro) && $_SERVER["REMOTE_ADDR"] == $host_log_seguro) {
    $REMOTE_ADDR = $ipseguro;
    $queryRec = "";
    $swSessSegura = 1;
}

if ($roles->activoLdap($krd)) {
    //Verificamos que tenga correo en la DB, si no tiene no se puede validar por LDAP
    $correoUsuario = $roles->email;
    if (empty($correoUsuario)) {
        //No tiene correo, entonces error LDAP
        $validacionUsuario = true;
    } else {
        //Autentica  por email si $autLDAPmail existe y es igual a 1 (se configura en config.php)
        $autentica = ($autLDAPmail == 1) ? current(explode("@", $correoUsuario)) : $krd;
        //Tiene correo, luego lo verificamos por LDAP
        $res_id = Utils::checkldapuser($autentica, $drd, $userBind);
        if ($res_id == 1) {
            //$roles->listadoDePermisosPorUsuario($krd);
            $roles->traerPermisos($krd);
        } else {
            $validacionUsuario = true;
            $recOrfeo          = "loginWeb";
            $mensajeError      = $res_id;
        }
    }
} else {
    if (!$roles->traerPermisos($krd, $drd)) {
        $validacionUsuario = true;
    };
}

if (!$validacionUsuario) {
    if (!isset($tpDependencias))
        $tpDependencias = "";

      $query = "SELECT
        a.*,
        b.DEPE_NOMB,
        b.DEPE_CODI_TERRITORIAL,
        b.DEPE_CODI_PADRE
      FROM
        usuario a,
        dependencia b
      WHERE
        usua_login       = '$krd'
        and  a.usua_esta = '1'
        and  a.depe_codi = b.depe_codi";

    $comentarioDev = ' Busca Permisos de Usuarios ...';
    $rs = $db->conn->Execute($query);

    if (!$rs->EOF) {
        $fechah          = date("dmy") . "_" . time("hms");
        $dependencia     = $rs->fields["DEPE_CODI"];
        $dependencianomb = $rs->fields["DEPE_NOMB"];
        $codusuario      = $rs->fields["USUA_CODI"];
        $usua_doc        = $rs->fields["USUA_DOC"];
        $usua_nomb       = $rs->fields["USUA_NOMB"];
        $usua_piso       = $rs->fields["USUA_PISO"];
        $usua_nacim      = $rs->fields["USUA_NACIM"];
        $usua_ext        = $rs->fields["USUA_EXT"];
        $usua_at         = $rs->fields["USUA_AT"];
        $usua_nuevo      = $rs->fields["USUA_NUEVO"];
        $usua_email      = $rs->fields["USUA_EMAIL"];
        $nombusuario     = $rs->fields["USUA_NOMB"];
        $contraxx        = $rs->fields["USUA_PASW"];
        $depe_nomb       = $rs->fields["DEPE_NOMB"];
    }

    $perm_radi_salida_tp = 0;

    foreach ($tpNumRad as $key => $valueTp) {
        $campo    = "DEPE_RAD_TP$valueTp";
        $campoPer = "USUA_PRAD_TP$valueTp";

        //Recorremos los tipos de radicado
        if (array_key_exists($campoPer, $roles->permisosUsuario)) {
            $tpPerRad[$valueTp] = $roles->permisosUsuario[$campoPer]['crud'];
            if (!empty($rs->fields[$campo])) {
                $tpDepeRad[$valueTp] = $rs->fields[$campo];
            }
        }

        if (sizeof($tpPerRad) > 0) {
            $perm_radi_salida_tp = 1;
        }

        $tpDependencias .= "<" . $rs->fields[$campo] . ">";

    }

    if (array_key_exists('USUA_ADMIN_SISTEMA', $roles->permisosUsuario)) {
        $usua_admin_sistema = $roles->permisosUsuario['USUA_ADMIN_SISTEMA']['crud'];
    }

    if (array_key_exists('USUA_ADM_PLANTILLA', $roles->permisosUsuario)) {
        $crea_plantilla = $roles->permisosUsuario['USUA_ADM_PLANTILLA']['crud'];
    }

    if (array_key_exists("USUA_ADMIN_ARCHIVO", $roles->permisosUsuario)) {
        $usua_admin_archivo = $roles->permisosUsuario["USUA_ADMIN_ARCHIVO"]['crud'];
    }

    if (array_key_exists("SGD_PERM_ESTADISTICA", $roles->permisosUsuario)) {
        $usua_perm_estadistica = $roles->permisosUsuario["SGD_PERM_ESTADISTICA"]['crud'];
    }

    if (array_key_exists("PERM_RADI", $roles->permisosUsuario)) {
        $perm_radi = $roles->permisosUsuario["PERM_RADI"]['crud'];
    }

    if (array_key_exists("USUA_PERM_IMPRESION", $roles->permisosUsuario)) {
        $usua_perm_impresion = $roles->permisosUsuario["USUA_PERM_IMPRESION"]['crud'];
    }

    if (array_key_exists("PERM_TIPIF_ANEXO", $roles->permisosUsuario)) {
        $perm_tipif_anexo = $roles->permisosUsuario["PERM_TIPIF_ANEXO"]['crud'];
    }

    if (array_key_exists("PERM_BORRAR_ANEXO", $roles->permisosUsuario)) {
        $perm_borrar_anexo = $roles->permisosUsuario["PERM_BORRAR_ANEXO"]['crud'];
    }

    if (array_key_exists("USUA_MASIVA", $roles->permisosUsuario)) {
        $usua_masiva = $roles->permisosUsuario["USUA_MASIVA"]['crud'];
    }

    if (array_key_exists("DEPE_CODI_PADRE", $roles->permisosUsuario)) {
        $depe_codi_padre = $roles->permisosUsuario["DEPE_CODI_PADRE"]['crud'];
    }

    if (array_key_exists("USUA_PERM_NUMERA_RES", $roles->permisosUsuario)) {
        $usua_perm_numera_res = $roles->permisosUsuario["USUA_PERM_NUMERA_RES"]['crud'];
    }

    if (array_key_exists("USUA_PERM_TRD", $roles->permisosUsuario)) {
        $usua_perm_trd = $roles->permisosUsuario["USUA_PERM_TRD"]['crud'];
    }

    if (array_key_exists("DEPE_CODI_TERRITORIAL", $roles->permisosUsuario)) {
        $depe_codi_territorial = $roles->permisosUsuario["DEPE_CODI_TERRITORIAL"]['crud'];
    }

    if (array_key_exists("USUA_PERM_DEV", $roles->permisosUsuario)) {
        $usua_perm_dev = $roles->permisosUsuario["USUA_PERM_DEV"]['crud'];
    }

    if (array_key_exists("SGD_PANU_CODI", $roles->permisosUsuario)) {
        $usua_perm_anu = $roles->permisosUsuario["SGD_PANU_CODI"]['crud'];
    }

    if (array_key_exists("USUA_PERM_ENVIOS", $roles->permisosUsuario)) {
        $usua_perm_envios = $roles->permisosUsuario["USUA_PERM_ENVIOS"]['crud'];
    }

    if (array_key_exists("USUA_PERM_MODIFICA", $roles->permisosUsuario)) {
        $usua_perm_modifica = $roles->permisosUsuario["USUA_PERM_MODIFICA"]['crud'];
    }

    if (array_key_exists("USUARIO_REASIGNAR", $roles->permisosUsuario)) {
        $usuario_reasignacion = $roles->permisosUsuario["USUARIO_REASIGNAR"]['crud'];
    }

    if (array_key_exists("USUA_PERM_SANCIONADOS", $roles->permisosUsuario)) {
        $usua_perm_sancionad = $roles->permisosUsuario["USUA_PERM_SANCIONADOS"]['crud'];
    }

    if (array_key_exists("USUA_PERM_INTERGAPPS", $roles->permisosUsuario)) {
        $usua_perm_intergapps = $roles->permisosUsuario["USUA_PERM_INTERGAPPS"]['crud'];
    }

    if (array_key_exists("USUA_PERM_FIRMA", $roles->permisosUsuario)) {
        $usua_perm_firma = $roles->permisosUsuario["USUA_PERM_FIRMA"]['crud'];
    }

    if (array_key_exists("USUA_PERM_PRESTAMO", $roles->permisosUsuario)) {
        $usua_perm_prestamo = $roles->permisosUsuario["USUA_PERM_PRESTAMO"]['crud'];
    }

    if (array_key_exists("USUA_PERM_NOTIFICA", $roles->permisosUsuario)) {
        $usua_perm_notifica = $roles->permisosUsuario["USUA_PERM_NOTIFICA"]['crud'];
    }

    if (array_key_exists("USUA_PERM_EXPEDIENTE", $roles->permisosUsuario)) {
        $usuaPermExpediente = $roles->permisosUsuario["USUA_PERM_EXPEDIENTE"]['crud'];
    }

    if (array_key_exists("USUA_AUTH_LDAP", $roles->permisosUsuario)) {
        $usuaauthldap = $roles->permisosUsuario["USUA_AUTH_LDAP"]['crud'];
    }
    if (array_key_exists("USUA_PERM_RADEMAIL", $roles->permisosUsuario)) {
        $usuaPermRadEmail = $roles->permisosUsuario["USUA_PERM_RADEMAIL"]['crud'];
    }

    if (array_key_exists("USUA_PERM_RADFAX", $roles->permisosUsuario)) {
        $usuaPermRadFax = $roles->permisosUsuario["USUA_PERM_RADFAX"]['crud'];
    }

    if (array_key_exists("PERM_ARCHI", $roles->permisosUsuario)) {
        $permArchi = $roles->permisosUsuario["PERM_ARCHI"]['crud'];
    }

    if (array_key_exists("PERM_VOBO", $roles->permisosUsuario)) {
        $permVobo = $roles->permisosUsuario["PERM_VOBO"]['crud'];
    }
    if (array_key_exists("USUA_PERM_OWNCLOUD", $roles->permisosUsuario)) {
        $usuaPermOwncloud = $roles->permisosUsuario["USUA_PERM_OWNCLOUD"]['crud'];
    }

    if (array_key_exists("USUA_PERM_RESPUESTA", $roles->permisosUsuario)) {
        $permRespuesta = $roles->permisosUsuario["USUA_PERM_RESPUESTA"]['crud'];
    }

    if (array_key_exists("USUA_PERM_STICKER", $roles->permisosUsuario)) {
        $permStiker = $roles->permisosUsuario["USUA_PERM_STICKER"]['crud'];
    }

    if (array_key_exists("USUA_PERM_RECOVER_RAD", $roles->permisosUsuario)) {
        $usuapermrecoverrad = $roles->permisosUsuario["USUA_PERM_RECOVER_RAD"]['crud'];
    }

    if (array_key_exists("USUA_PERM_RAD_ESPECIAL", $roles->permisosUsuario)) {
        $permRadEspecial = $roles->permisosUsuario["USUA_PERM_RAD_ESPECIAL"]['crud'];
    }

    if (array_key_exists("USUA_PERM_TRANS_RAD", $roles->permisosUsuario)) {
        $permTransRad = $roles->permisosUsuario["USUA_PERM_TRANS_RAD"]['crud'];
    }

    if (array_key_exists("USUA_PERM_RECOVER_RAD", $roles->permisosUsuario)) {
        $usuapermrecoverrad = $roles->permisosUsuario["USUA_PERM_RECOVER_RAD"]['crud'];
    }

    /* Fraqmentar usuarios y perfiles*/
    if (array_key_exists("USUA_PERM_ONLY_USER", $roles->permisosUsuario)) {
        $usuapermonlyuser = $roles->permisosUsuario["USUA_PERM_ONLY_USER"]['crud'];
    }

    if (array_key_exists("USUA_LESS_PERM_USER", $roles->permisosUsuario)) {
        $usualesspermuser = $roles->permisosUsuario["USUA_LESS_PERM_USER"]['crud'];
    }

    if (array_key_exists("USUA_LESS_PERM_USER_PROFILE", $roles->permisosUsuario)) {
        $usualesspermuserprofile = $roles->permisosUsuario["USUA_LESS_PERM_USER_PROFILE"]['crud'];
    }
    /* Fin Fraqmentar usuarios y perfiles*/


    if ($usua_perm_impresion == 1) {
        if ($perm_radi_salida_tp >= 1)
            $perm_radi_sal = 3; else $perm_radi_sal = 1;
    } else {
        if ($perm_radi_salida_tp >= 1)
            $perm_radi_sal = 1;
    }

    //Traemos el campo que indica si el usuario puede
    //utilizar el administrador de flujos o no
    if (array_key_exists("USUA_PERM_ADMINFLUJOS", $roles->permisosUsuario)) {
        $usua_perm_adminflujos = $roles->permisosUsuario["USUA_PERM_ADMINFLUJOS"]['crud'];
    }

    if (array_key_exists("CODI_NIVEL", $roles->permisosUsuario)) {
        $nivelus = $roles->permisosUsuario["CODI_NIVEL"]['crud'];
    }

    $isql =     "select
                      b.MUNI_NOMB from dependencia a,municipio b
        				where
                      a.muni_codi=b.muni_codi
        					and a.dpto_codi=b.dpto_codi
        					and a.muni_codi=b.muni_codi
        					and a.depe_codi=$dependencia";

    $rs = $db->conn->Execute($isql);
    $depe_municipio = $rs->fields["MUNI_NOMB"];

    /**
     *   Consulta que anade los nombres y codigos de carpetas del Usuario
     */
    $isql = "select CARP_CODI, CARP_DESC from carpeta";
    $rs = $db->conn->Execute($isql);
    $iC = 0;

    while (!$rs->EOF) {
        $iC = $rs->fields["CARP_CODI"];
        $descCarpetasGen[$iC] = $rs->fields["CARP_DESC"];
        $rs->MoveNext();
    }

    $isql = "select
                CODI_CARP,
                DESC_CARP
              from
                carpeta_per
              where
                    usua_codi = $codusuario
                and depe_codi = $dependencia";

    $rs = $db->conn->Execute($isql);
    $iC = 0;

    while (!$rs->EOF) {
        $iC = $rs->fields["CODI_CARP"];
        $descCarpetasPer[$iC] = $rs->fields["DESC_CARP"];
        $rs->MoveNext();
    }


    $ADODB_COUNTRECS = true;

    $isql = "SELECT
                      d.ID_CONT,
                			d.ID_PAIS,
                			d.DPTO_CODI,
                			d.MUNI_CODI,
                			m.MUNI_NOMB
                		FROM
                      dependencia d,
                			municipio m
                		WHERE
                            d.ID_CONT = m.ID_CONT AND
                			d.ID_PAIS = m.ID_PAIS AND
                			d.DPTO_CODI = m.DPTO_CODI AND
                			d.MUNI_CODI = m.MUNI_CODI AND
                			d.DEPE_CODI = $dependencia";

    $rs_cod_local = $db->conn->Execute("$isql");
    $ADODB_COUNTRECS = false;

    if ($rs_cod_local && !$rs_cod_local->EOF) {
        $cod_local = $rs_cod_local->fields['ID_CONT'] . "-" .
            str_pad($rs_cod_local->fields['ID_PAIS'], 3, 0, STR_PAD_LEFT) . "-" .
            str_pad($rs_cod_local->fields['DPTO_CODI'], 3, 0, STR_PAD_LEFT) . "-" .
            str_pad($rs_cod_local->fields['MUNI_CODI'], 3, 0, STR_PAD_LEFT);
        $depe_municipio = $rs_cod_local->fields["MUNI_NOMB"];
        $rs_cod_local->Close();

    } else {
        $cod_local = 0;
        $depe_municipio = "CONFIGURAR EN SESSION_ORFEO.PHP";
    }
    if (!isset($recOrfeo)) {
        $recOrfeo = "";
    }
    $nombSession = date("ymdhis") . "o" . str_replace(".", "", $_SERVER['REMOTE_ADDR']) . "$krd";

    session_id($nombSession);
    session_start();

    $fechah = date("Ymd") . "_" . time("hms");
    $carpeta = 0;

    $dirOrfeo = str_replace("index.php", "", $_SERVER["PHP_SELF"]);

    $_SESSION["entidad"]               = $entidad;
    $_SESSION["entidad_largo"]         = $entidad_largo;
    $_SESSION["apiFirmaDigital"]       = $apiFirmaDigital;
    $_SESSION["dirOrfeo"]              = $dirOrfeo;
    $_SESSION["drde"]                  = $contraxx;
    $_SESSION["usua_doc"]              = trim($usua_doc);
    $_SESSION["dependencia"]           = $dependencia;
    $_SESSION["codusuario"]            = $codusuario;
    $_SESSION["depe_nomb"]             = $depe_nomb;
    $_SESSION["cod_local"]             = $cod_local;
    $_SESSION["depe_municipio"]        = $depe_municipio;
    $_SESSION["usua_doc"]              = $usua_doc;
    $_SESSION["usua_email"]            = $usua_email;
    $_SESSION["usua_at"]               = $usua_at;
    $_SESSION["usua_ext"]              = $usua_ext;
    $_SESSION["usua_piso"]             = $usua_piso;
    $_SESSION["usua_nacim"]            = $usua_nacim;
    $_SESSION["usua_nomb"]             = $usua_nomb;
    $_SESSION["usua_nuevo"]            = $usua_nuevo;
    $_SESSION["usua_admin_archivo"]    = $usua_admin_archivo;
    $_SESSION["usua_masiva"]           = $usua_masiva;
    $_SESSION["usua_perm_dev"]         = $usua_perm_dev;
    $_SESSION["usua_perm_anu"]         = $usua_perm_anu;
    $_SESSION["usua_perm_numera_res"]  = $usua_perm_numera_res;
    $_SESSION["perm_radi_sal"]         = $perm_radi_sal;
    $_SESSION["depecodi"]              = $dependencia;
    $_SESSION["fechah"]                = $fechah;
    $_SESSION["crea_plantilla"]        = $crea_plantilla;
    $_SESSION["verrad"]                = 0;
    $_SESSION["menu_ver"]              = 3;
    $_SESSION["depe_codi_padre"]       = $depe_codi_padre;
    $_SESSION["depe_codi_territorial"] = $depe_codi_territorial;
    $_SESSION["nivelus"]               = $nivelus;
    $_SESSION["tpNumRad"]              = $tpNumRad;
    $_SESSION["tpDescRad"]             = $tpDescRad;
    $_SESSION["tpImgRad"]              = $tpImgRad;
    $_SESSION["tpDepeRad"]             = $tpDepeRad;
    $_SESSION["tpPerRad"]              = $tpPerRad;
    $_SESSION["usua_perm_envios"]      = $usua_perm_envios;
    $_SESSION["usua_perm_modifica"]    = $usua_perm_modifica;
    $_SESSION["usuario_reasignacion"]  = $usuario_reasignacion;
    $_SESSION["descCarpetasGen"]       = $descCarpetasGen;
    $_SESSION["descCarpetasPer"]       = $descCarpetasPer;
    $_SESSION["tip3Nombre"]            = $tip3Nombre;
    $_SESSION["tip3desc"]              = $tip3desc;
    $_SESSION["tip3img"]               = $tip3img;
    $_SESSION["usua_admin_sistema"]    = $usua_admin_sistema;
    $_SESSION["perm_radi"]             = $perm_radi;
    $_SESSION["usua_perm_sancionad"]   = $usua_perm_sancionad;
    $_SESSION["usua_perm_impresion"]   = $usua_perm_impresion;
    $_SESSION["usua_perm_intergapps"]  = $usua_perm_intergapps;
    $_SESSION["usua_perm_estadistica"] = $usua_perm_estadistica;
    $_SESSION["usua_perm_archi"]       = $usua_perm_archi;
    $_SESSION["usua_perm_trd"]         = $usua_perm_trd;
    $_SESSION["usua_perm_firma"]       = $usua_perm_firma;
    $_SESSION["usua_perm_prestamo"]    = $usua_perm_prestamo;
    $_SESSION["usua_perm_notifica"]    = $usua_perm_notifica;
    $_SESSION["usuaPermExpediente"]    = $usuaPermExpediente;
    $_SESSION["perm_tipif_anexo"]      = $perm_tipif_anexo;
    $_SESSION["perm_borrar_anexo"]     = $perm_borrar_anexo;
    $_SESSION["usua_auth_ldap"]        = $usuaAuthLdap;
    $_SESSION["usuaPermRadFax"]        = $usuaPermRadFax;
    $_SESSION["usuaPermRadEmail"]      = $usuaPermRadEmail;
    $_SESSION["varEstaenfisico"]       = $varEstaenfisico;

    $_SESSION["usua_perm_owncloud"]    = $usuaPermOwncloud;
    $_SESSION["usua_perm_respuesta"]   = $permRespuesta;
    $_SESSION['USUA_PERM_STICKER']     = $permStiker;
    //@busquedaFullOrfeo bandera para busqueda con opensearch
    $_SESSION['busquedaFullOrfeo']      = $busquedaFullOrfeo;

    $_SESSION['USUA_PERM_RAD_ESPECIAL'] = $permRadEspecial;
    $_SESSION['USUA_PERM_TRANS_RAD']    = $permTransRad;
    $_SESSION["USUA_PERM_RECOVER_RAD"]  = $usuapermrecoverrad;


    /* Fraqmentar usuarios y perfiles*/
    $_SESSION['USUA_PERM_ONLY_USER']         = $usuapermonlyuser;
    $_SESSION['USUA_LESS_PERM_USER']         = $usualesspermuser;
    $_SESSION["USUA_LESS_PERM_USER_PROFILE"] = $usualesspermuserprofile;
    /* Fin Fraqmentar usuarios y perfiles*/


    if (!isset($XAJAX_PATH)) {
        $XAJAX_PATH = "";
    }

    $_SESSION["XAJAX_PATH"]              = $XAJAX_PATH;
    $_SESSION["enviarMailMovimientos"]   = $enviarMailMovimientos;
    $_SESSION["depeRadicaFormularioWeb"] = $depeRadicaFormularioWeb; // Es radicado en la Dependencia 900
    $_SESSION["usuaRecibeWeb"]           = $usuaRecibeWeb; // Usuario que Recibe los Documentos Web
    $_SESSION["secRadicaFormularioWeb"]  = $secRadicaFormularioWeb;
    $_SESSION["ESTILOS_PATH"]            = $ESTILOS_PATH;
    $_SESSION["seriesVistaTodos"]        = $seriesVistaTodos;
    $_SESSION["USUA_PERM_RECOVER_RAD"]   = $usuapermrecoverrad;

    $_SESSION["digitosDependencia"]      = $digitosDependencia;
    if (!isset($indiTRD)) {
        $indiTRD = "";
    }
    $_SESSION["indiTRD"] = $indiTRD;
    //Variables para Correo IMAP
    $_SESSION["PEAR_PATH"] = $PEAR_PATH;
    $_SESSION["servidor_mail"] = $servidor_mail;
    $_SESSION["puerto_mail"] = $puerto_mail;
    $_SESSION["protocolo_mail"] = $protocolo_mail;
    $_SESSION["menuAdicional"] = $menuAdicional;
    $_SESSION["permArchi"] = $permArchi;
    $_SESSION["permVobo"] = $permVobo;
    $_SESSION["usua_perm_respuesta"] = $permRespuesta;

    if (isset($archivado_requiere_exp))
        $_SESSION["archivado_requiere_exp"] = true;

    if (isset($archivado_requiere_exp)) {
        $_SESSION["archivado_requiere_exp"] = $archivado_requiere_exp;
    }

    //Se pone el permiso de administracion de flujos en la sesion para su posterior consulta
    $_SESSION["usua_perm_adminflujos"] = $usua_perm_adminflujos;
    $_SESSION["krd"] = $krd;

    $nomcarpera = "ENTRADA";
    if (!$orno)
        $orno = 0;

    $query = "   UPDATE
                        usuario
                         SET
                        usua_sesion='" . session_id() .
        "',usua_fech_sesion=sysdate
                         WHERE
                        USUA_LOGIN ='$krd'  ";

    $recordSet["USUA_SESION"] = "'" . session_id() . "'";
    $recordSet["USUA_FECH_SESION"] = $db->conn->OffsetDate(0, $db->conn->sysTimeStamp);
    $recordWhere["USUA_LOGIN"] = "'$krd'";
    $db->update("USUARIO", $recordSet, $recordWhere);
    $validacionKrd = true;

}
?>
