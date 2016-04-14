<?php
//ini_set("display_errors", 1);
session_start();

foreach ($_GET as $key => $valor) ${$key} = $valor;
foreach ($_POST as $key => $valor) ${$key} = $valor;

define('ADODB_ASSOC_CASE', 1);

$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$dependencia_nombre = $_SESSION["depe_nomb"];
$usua_doc = $_SESSION["usua_doc"];
$usua_nomb = $_SESSION["usua_nomb"];
$codusuario = $_SESSION["codusuario"];
$nivelus = $_SESSION["nivelus"];
$tip3Nombre = $_SESSION["tip3Nombre"];
$tip3desc = $_SESSION["tip3desc"];
$tip3img = $_SESSION["tip3img"];

if (!$ruta_raiz) $ruta_raiz = ".";
include("$ruta_raiz/config.php");
if (isset($db)) unset($db);
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
$db = new ConnectionHandler("$ruta_raiz");
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

require_once("$ruta_raiz/class_control/anexo.php");
require_once("$ruta_raiz/class_control/CombinaError.php");
require_once("$ruta_raiz/class_control/Sancionados.php");
require_once("$ruta_raiz/class_control/Dependencia.php");
require_once("$ruta_raiz/class_control/Esp.php");
require_once("$ruta_raiz/class_control/TipoDocumento.php");
require_once("$ruta_raiz/class_control/Radicado.php");
require_once("$ruta_raiz/include/tx/Radicacion.php");
require_once("$ruta_raiz/include/tx/Historico.php");
require_once("$ruta_raiz/class_control/ControlAplIntegrada.php");
require_once("$ruta_raiz/include/tx/Expediente.php");
require_once("$ruta_raiz/include/tx/Historico.php");


$hist = new Historico($db);

header('Content-Type: application/json');


$dep = new Dependencia($db);
$espObjeto = new Esp($db);
$radObjeto = new Radicado($db);
$radObjeto->radicado_codigo($numrad);

//objeto que maneja el tipo de documento del anexos
$tdoc = new TipoDocumento($db);

//objeto que maneja el tipo de documento del radicado
$tdoc2 = new TipoDocumento($db);
$tdoc2->TipoDocumento_codigo($radObjeto->getTdocCodi());

$fecha_dia_hoy = Date("Y-m-d");
//$sqlFechaHoy = $db->conn->OffsetDate(0,$db->conn->sysTimeStamp);
$sqlFechaHoy = $db->conn->sysTimeStamp;
if ($db->driver == "postgres") $sqlFechaHoy = "now()";
//OBJETO CONTROL DE APLICACIONES INTEGRADAS.
$objCtrlAplInt = new ControlAplIntegrada($db);
//OBJETO EXPEDIENTE
$objExpediente = new Expediente($db);
$expRadi = $objExpediente->consulta_exp($numrad);

$dep->Dependencia_codigo($dependencia);
$dep_sigla = $dep->getDepeSigla();
$nurad = trim($nurad);
$numrad = trim($numrad);
$hora = date("H") . "_" . date("i") . "_" . date("s");
// var que almacena el dia de la fecha
$ddate = date('d');
// var que almacena el mes de la fecha
$mdate = date('m');
// var que almacena el a�o de la fecha
$adate = date('Y');
// var que almacena  la fecha formateada
$fechaArchivo = $adate . "_" . $mdate . "_" . $ddate;
//var que almacena el nombre que tendr� la pantilla
$archInsumo = "tmp_" . $usua_doc . "_" . $fechaArchivo . "_" . $hora . ".txt";
//Var que almacena el nombre de la ciudad de la territorial
$terr_ciu_nomb = $dep->getTerrCiuNomb();
//Var que almacena el nombre corto de la territorial
$terr_sigla = $dep->getTerrSigla();
//Var que almacena la direccion de la territorial
$terr_direccion = $dep->getTerrDireccion();
//Var que almacena el nombre largo de la territorial
$terr_nombre = $dep->getTerrNombre();
//Var que almacena el nombre del recurso
$nom_recurso = $tdoc2->get_sgd_tpr_descrip(); //

if (!$numrad) {
    $numrad = $verrad;
}
if (strlen(trim($radicar_a)) == 13 or strlen(trim($radicar_a)) == 18) {
    $no_digitos = 5;
} else {
    $no_digitos = 6;
}
$linkArchSimple = strtolower($linkarchivo);
$linkArchivoTmpSimple = strtolower($linkarchivotmp);

$linkarchivo = "$ruta_raiz/" . strtolower($linkarchivo);
$linkarchivotmp = "$ruta_raiz/" . strtolower($linkarchivotmp);
$fechah = date("Ymd") . "_" . time("hms");
$trozosPath = explode("/", $linkarchivo);
$nombreArchivo = $trozosPath[count($trozosPath) - 1];

// ABRE EL ARCHIVO
$a = new Anexo($db);
$a->anexoRadicado($numrad, $anexo);
$apliCodiaux = $a->get_sgd_apli_codi();
$anex = $a;
$secuenciaDocto = $a->get_doc_secuencia_formato($dependencia);
$fechaDocumento = $a->get_sgd_fech_doc();
$tipoDocumento = $a->get_sgd_tpr_codigo();
$tdoc->TipoDocumento_codigo($tipoDocumento);

$tipoDocumentoDesc = $tdoc->get_sgd_tpr_descrip();


/** @var $answer Respuesta Ajax variable de notificacion a la solicitud  */
$answer = array();
function saveMessage($type, $message){
    if(!empty($type) and !empty($message)){
        global $answer;
        $answer[$type][] = $message;
        return true;
    }else{
        return false;
    }
}


if ($radicar_documento) {
    //GENERACION DE LA SECUENCIA PARA DOCUMENTOS ESPECIALES  *******************************
    //Generar el Numero de Radicacion
    if (($ent != 2) and $nurad and $vpppp == "ddd") {
        $sec = $nurad;
        $anoSec = substr($nurad, 0, 4);
        // @tipoRad define el tipo de radicado el -X
        $tipoRad = substr($radicar_documento, -1);
    } else {
        if ($vp == "n" and $radicar_a == "si") {
            if ($generar_numero == "no") {
                $sec = substr($nurad, 7, $no_digitos);
                $anoSec = substr($nurad, 0, 4);
                $tipoRad = substr($radicar_documento, -1);
            } else {
                $isql = "select * from ANEXOS where ANEX_CODIGO='$anexo' AND ANEX_RADI_NUME=$numrad";
                $rs = $db->query($isql);
                if (!$rs->EOF) {
                    $radicado_salida = $rs->fields['RADI_NUME_SALIDA'];
                    $expAnexoActual = $rs->fields['SGD_EXP_NUMERO'];
                    if ($expAnexoActual != '') {
                        $expRadi = $expAnexoActual;
                    }
                } else {
                    saveMessage('error',"No se ha podido obtener la informacion del radicado.");
                    die(json_encode($answer));
                }

                if (!$radicado_salida) {
                    $no_digitos = 6;
                    $tipoRad = "1";
                } else {
                    $sec = substr($radicado_salida, 7, $no_digitos);
                    $tipoRad = substr($radicar_documento, -1);
                    $anoSec = substr($radicado_salida, 0, 4);
                    saveMessage('error', 'Ya estaba radicado');
                    die(json_encode($answer));
                }
            }
        } else {
            if ($vp == "s") {
                $sec = "XXX";
            } else {
                // EN ESTA PARTE ES EN LA CUAL SE ENTRA A ASIGNAR EL NUMERO DE RADICADO
                $sec = substr($radicar_a, 7, $no_digitos);
                $anoSec = substr($radicar_a, 0, 4);
                $tipoRad = substr($radicar_a, 13, 1);
            }
        }
        // GENERACION DE NUMERO DE RADICADO DE SALIDA
        $sec = str_pad($sec, $no_digitos, "0", STR_PAD_LEFT);
        $plg_comentarios = "";
        $plt_codi = $plt_codi;
        if (!$anoSec) {
            $anoSec = date("Y");
        }
        if (!$tipoRad) {
            $tipoRad = "1";
        }

        //Adicion para que no reemplace el numero de radicado de un anexo al ser reasignado a otra dependencia
        if ($generar_numero == "no") {
            $rad_salida = $numrad;
        } else {
            //Es un anexo radicado en otra dependencia y no queremos que le genere un nuevo numero
            if ($radicar_a != null && $radicar_a != 'si') {
                $rad_salida = $radicar_a;
            } else {
                $rad_salida = $anoSec . $dependencia . $sec . $tipoRad;
            }
        }


        if ($numerar == 1) {
            $numResol = $a->get_doc_secuencia_formato();
            $rad_salida = date("Y") . $dependencia . str_pad($a->sgd_doc_secuencia(), 6, "0", STR_PAD_left) . $a->get_sgd_tpr_codigo();
        }
    }
    //**********************************************************************************************************************************
    // * FIN GENERACION DE NUMERO DE RADICADO DE SALIDA
    $ext = substr(trim($linkarchivo), -3);
    $extx = explode('.', $linkarchivo);
    $ext = $extx[count($extx) - 1];

    $extVal = strtoupper($ext);
    if ($extVal == "XLS" or $extVal == "PPT" or $extVal == "PDF") {
        saveMessage('error', 'Sobre formato ($ext) no se puede realizar combinaci&oacute;n de correspondencia');
        die(json_encode($answer));
    } else {
        require "$ruta_raiz/jh_class/funciones_sgd.php";
        $verrad = $numrad;
        $radicado_p = $verrad;
        $no_tipo = "true";
        require "$ruta_raiz/ver_datosrad.php";
        include "$ruta_raiz/radicacion/busca_direcciones.php";
        $a = new LOCALIZACION($codep_us1, $muni_us1, $db);
        $dpto_nombre_us1 = $a->departamento;
        $muni_nombre_us1 = $a->municipio;
        $a = new LOCALIZACION($codep_us2, $muni_us2, $db);
        $dpto_nombre_us2 = $a->departamento;
        $muni_nombre_us2 = $a->municipio;
        $a = new LOCALIZACION($codep_us3, $muni_us3, $db);
        $dpto_nombre_us3 = $a->departamento;
        $muni_nombre_us3 = $a->municipio;
        $espObjeto->Esp_nit($cc_documento_us3);
        $nuir_e = $espObjeto->getNuir();

        // Inicializacion de la fecha que va a pasar al reemplazable *F_RAD_S*
        $fecha_hoy_corto = "";
        include "$ruta_raiz/class_control/class_gen.php";

        $b = new CLASS_GEN();
        $date = date("m/d/Y");
        $fecha_hoy = $b->traducefecha($date);
        $fecha_e = $b->traducefecha($radi_fech_radi);
        $fechaDocumento2 = $b->traducefecha_sinDia($fechaDocumento);
        $fechaDocumento = $b->traducefechaDocto($fechaDocumento);

        if ($vp == "n") $archivoFinal = $linkArchSimple;
        else $archivoFinal = $linkArchivoTmpSimple;

        //almacena la extension del archivo a procedar
        $extension = (strrchr($archivoFinal, "."));
        $archSinExt = substr($archivoFinal, 0, strpos($archivoFinal, $extension));
        //Almacena el path completo hacia el archivo a producirse luego de la combinacion

        if (substr($archSinExt, -1) == "d") {
            $caracterDefinitivo = "";
        } else {
            $caracterDefinitivo = "d";
        }

        if ($ext == 'xml' || $ext == 'XML' || $ext == 'odt' || $ext == 'ODT' || $ext == 'DOCX' || $ext == 'docx') {
            $archivoFinal = $archSinExt . "." . $ext;
        } else {
            $archivoFinal = $archSinExt . $caracterDefinitivo . "." . $ext;
        }

        //Almacena el nombre de archivo a producirse luego de la combinacion y que ha de actualizarce en la tabla de anexos
        $archUpdate = substr($archivoFinal,
            strpos($archivoFinal, strrchr($archivoFinal, "/")) + 1,
            strlen($archivoFinal) - strpos($archivoFinal,
                strrchr($archivoFinal, "/")) + 1);
        //Almacena el path de archivo a producirse luego de la combinacion y que ha de actualizarce en la tabla de radicados
        $archUpdateRad = substr_replace($archivoFinal, "", 0, strpos($archivoFinal, "bodega") + strlen("bodega"));
    }
    //****************************************************************************************************

    $tipo_docto = $anex->get_sgd_tpr_codigo();
    if (!$tipo_docto) $tipo_docto = 0;

//ESTE INCLUDE PERMITE PASAR HERENCIA A UN ANEXO
 include 'datos_rad_padre.php';

    if ($sec and $vp == "n") {
        if ($generar_numero != "no" and $radicar_a == "si") {
            if (!$tpradic) {
                $tpradic = 'null';
            }
            $rad = new Radicacion($db);
            $rad->radiTipoDeri = 0;
            $rad->radiCuentai = "''";
            $rad->eespCodi = $espcodi;
            $rad->mrecCodi = 1;
            $rad->radiFechOfic = $sqlFechaHoy;
            $rad->radiNumeDeri = trim($verrad);
            $rad->descAnex = $asunto;
            $rad->radiPais = "$pais";
            $rad->raAsun = $asunto;

            if ($tpradic == 1) {
                if ($entidad_depsal != 0) {
                    $rad->radiDepeActu = $entidad_depsal;
                    $rad->radiUsuaActu = 1;
                } else {
                    $rad->radiDepeActu = $dependencia;
                    $rad->radiUsuaActu = $codusuario;
                }
            } else {
                $rad->radiDepeActu = $dependencia;
                $rad->radiUsuaActu = $codusuario;
            }

            $rad->radiDepeRadi = $dependencia;
            $rad->trteCodi = "null";
            $rad->tdocCodi = $tipo_docto;
            $rad->tdidCodi = "null";
            $rad->carpCodi = $tpradic; //por revisar como recoger el valor
            $rad->carPer = 0;
            $rad->trteCodi = "null";
            $rad->ra_asun = "'$asunto'";
            $rad->radiPath = "$archUpdateRad";

            if (strlen(trim($apliCodiaux)) > 0 && $apliCodiaux > 0)
                $aplinteg = $apliCodiaux;
            else $aplinteg = "0";

            $rad->sgd_apli_codi = $aplinteg;
            $codTx = 2;
            $flag = 1;

            // Se genera el numero de radicado del anexo
            $noRad = $rad->newRadicado($tpradic, $tpDepeRad[$tpradic]);

	    //Personalizo el codigo de transaccion y el comentario
	    $TX_CODIGO = 96;
	    $TX_COMENTARIO = "Radicación Anexo No .$anexo";
	    
	    /*CONTROL DE VERSIONES - TRAZABILIDAD  */
	    /*Insertar en el historico cuando se inserta un anexo como nuevo*/
	    $_numrad[0]=$numrad;
	    $hist->insertarHistorico( $_numrad, $dependencia , $codusuario, $dependencia, $codusuario,$TX_COMENTARIO,$TX_CODIGO);

  		//le incluyo a la tabla sgd_dir_drecciones el radicado con sus dignatarios
		include 'dignatario_radicado_anexo.php';

            if(substr($noRad,0,1)==0) saveMessage('error', 'No se genero el radicado. '.$noRad.'');

            // Se instancia un objeto para el radicado generado y obtener la fecha real de radicacion
            $radGenerado = new Radicado($db);
            $radGenerado->radicado_codigo($noRad);

            // Asgina la fecha de radicacion

            $fecha_hoy_corto = $radGenerado->getRadi_fech_radi("d-m-Y");

            //BUSCA QUERYS ADICIONALES RESPECTO DE APLICATIVOS INTEGRADOS
            $campos["P_RAD_E"] = $noRad;
            $campos["P_USUA_CODI"] = $codusuario;
            $campos["P_DEPENDENCIA"] = $dependencia;
            $campos["P_USUA_DOC"] = $usua_doc;
            $campos["P_COD_REF"] = $anexo;

            //El nuevo radicado hereda la informacion del expediente del radicado padre
            if (isset($expRadi) && $expRadi != 0) {
                $resultadoExp = $objExpediente->insertar_expediente($expRadi, $noRad, $dependencia, $codusuario, $usua_doc);
                $radicados = "";
                if ($resultadoExp == 1) {
                    $observa = "Se ingresa al expediente del radicado padre ($numrad)";
                    include_once "$ruta_raiz/include/tx/Historico.php";
                    $radicados[] = $noRad;
                    $tipoTx = 53;
                    $Historico = new Historico($db);
                    $Historico->insertarHistoricoExp($expRadi,
                        $radicados,
                        $dependencia,
                        $codusuario,
                        $observa,
                        $tipoTx, 0, 0);
                } else {
                    saveMessage('error', 'No se anexo este radicado al expediente. Verifique que el numero del expediente exista e intente de nuevo.');
                    die(json_encode($answer));
                }
            }

            $estQueryAdd = $objCtrlAplInt->queryAdds($noRad, $campos, $MODULO_RADICACION_DOCS_ANEXOS);
            if ($estQueryAdd == "0") {
                saveMessage('error', 'Error al realizar proceso con anexos');
                die(json_encode($answer));
            }


            $radicadosSel[0] = $noRad;
            $hist->insertarHistorico($radicadosSel, $dependencia, $codusuario, $dependencia, $codusuario, " ", $codTx);

            if ($noRad == "-1") {
                saveMessage('error', 'Error no genero un Numero de Secuencia o inserto el radicado.');
                die(json_encode($answer));
            }
            $rad_salida = $noRad;
        } else {
            $linkarchivo_grabar = str_replace("bodega", "", $linkarchivo);
            $linkarchivo_grabar = str_replace("./", "", $linkarchivo_grabar);
            $extdoctmp = explode('.', $linkarchivo_grabar);
            $extdoc = $extdoctmp[count($extdoctmp) - 1];
            if ($extdoc == 'doc') {
                $posExt = strpos($linkarchivo_grabar, 'd.doc');
                if ($posExt === false) {

                    $temp = $linkarchivo_grabar;
                    $ruta = str_replace('.doc', 'd.doc', $temp);
                    $linkarchivo_grabar = $ruta;
                }
            }

            $isql = "update RADICADO
				   set RADI_PATH='$linkarchivo_grabar'
				  where RADI_NUME_RADI = $rad_salida";

            $radGenerado = new Radicado($db);
            $radGenerado->radicado_codigo($rad_salida);
            // Asgina la fecha de radicacion
            $fecha_hoy_corto = $radGenerado->getRadi_fech_radi("d-m-Y");
            $rs = $db->query($isql);
            if (!$rs) {
                saveMessage('error', 'No se ha podido Actualizar el Radicado.');
                die(json_encode($answer));
            } else {
		    $archUpdate = $linkarchivo_grabar;

	    //Personalizo el codigo de transaccion y el comentario
	    $TX_CODIGO = 97;
	    $TX_COMENTARIO = "Anexo Combinado No .$anexo";
	    
	    /*CONTROL DE VERSIONES - TRAZABILIDAD  */
	    /*Insertar en el historico cuando se inserta un anexo como nuevo*/

	    $_numrad[0]=$numrad;
	    $hist->insertarHistorico( $_numrad, $dependencia , $codusuario, $dependencia, $codusuario,$TX_COMENTARIO,$TX_CODIGO);

            }
        }


        if ($ent == 1) $rad_salida = $nurad;
        // Update Anexos
	$archUpdateFinal = basename($archUpdate);
	
	$isql = "update ANEXOS set RADI_NUME_SALIDA=$rad_salida,
			      ANEX_SOLO_LECT = 'S',
			      ANEX_RADI_FECH = $sqlFechaHoy,
			      ANEX_ESTADO = 2,
			      ANEX_NOMB_ARCHIVO = '$archUpdateFinal',
			      ANEX_TIPO='$numextdoc',
			      SGD_DEVE_CODIGO = null
		           where ANEX_CODIGO='$anexo' AND ANEX_RADI_NUME=$numrad";

        $rs = $db->query($isql);
        if (!$rs) {
            saveMessage('error', 'No se ha podido actualizar la informacion de anexos.');
            die(json_encode($answer));
        }


        $isql = "select * from ANEXOS where ANEX_CODIGO='$anexo' AND ANEX_RADI_NUME=$numrad";
        $rs = $db->query($isql);

        if ($rs == false) {
            saveMessage('error','No se ha podido obtener la informacion de anexo');
            die(json_encode($answer));
        }

        $sgd_dir_tipo = $rs->fields["SGD_DIR_TIPO"];
        $anex_desc = $rs->fields["ANEX_DESC"];
        $anex_numero = $rs->fields["ANEX_NUMERO"];
        $direccionAlterna = $rs->fields["SGD_DIR_DIRECCION"];
        $pasar_direcciones = true;
        $dep_radicado = substr($rad_salida, 4, $digitosDependencia);
        $carp_codi = 1;

        if (!$tipo_docto) $tipo_docto = 0;

        $linkarchivo_grabar = str_replace("bodega", "", $linkarchivo);
        $linkarchivo_grabar = str_replace("./", "", $linkarchivo_grabar);

        if ($sgd_dir_tipo == 1) {
            $grbNombresUs1 = $nombret_us1_u;
        }

        //Adiciones para DIR_E SSPD, no quieren que se reemplace DIR_R con DIR_E
        $campos = array();
        $datos = array();
        $anex->obtenerArgumentos($campos, $datos);
        $vieneDeSancionados = 0;


        //Trae la informacion de Sancionados y genera los campos de combinacion
        $camposSanc = array();
        $datosSanc = array();

        if ($sgd_dir_tipo == 2 ) {
            $dir_tipo_us1 = $dir_tipo_us2;
            $tipo_emp_us1 = $tipo_emp_us2;
            $nombre_us1 = $nombre_us2;
            $grbNombresUs1 = $nombre_us2;
            $documento_us1 = $documento_us2;
            $cc_documento_us1 = $cc_documento_us2;
            $prim_apel_us1 = $prim_apel_us2;
            $seg_apel_us1 = $seg_apel_us2;
            $telefono_us1 = $telefono_us2;
            $direccion_us1 = $direccion_us2;
            $mail_us1 = $mail_us2;
            $muni_us1 = $muni_us2;
            $codep_us1 = $codep_us2;
            $tipo_us1 = $tipo_us2;
            $otro_us1 = $otro_us2;
        }
        if ($sgd_dir_tipo == 3 ) {
            $dir_tipo_us1 = $dir_tipo_us3;
            $tipo_emp_us1 = $tipo_emp_us3;
            $nombre_us1 = $nombre_us3;
            $grbNombresUs1 = $nombre_us3;
            $documento_us1 = $documento_us3;
            $cc_documento_us1 = $cc_documento_us3;
            $prim_apel_us1 = $prim_apel_us3;
            $seg_apel_us1 = $seg_apel_us3;
            $telefono_us1 = $telefono_us3;
            $direccion_us1 = $direccion_us3;
            $mail_us1 = $mail_us3;
            $muni_us1 = $muni_us3;
            $codep_us1 = $codep_us3;
            $tipo_us1 = $tipo_us3;
            $otro_us1 = $otro_us3;
        }
        if ($direccionAlterna and $sgd_dir_tipo == 3) {
            $direccion_us3 = $direccionAlterna;
            $muni_us3 = $muniCodiAlterno;
            $codep_us3 = $dptoCodiAlterno;
        }

        $nurad = $rad_salida;
        $documento_us2 = "";
        $documento_us3 = "";
        $conexion = $db;

        if ($numerar != 1) include "$ruta_raiz/radicacion/grb_direcciones.php";

        $actualizados = 4;
        $sgd_dir_tipo = 1;

        // Borro todo lo generando anteriormete .....  para el caso de regenerar
        $isql = "delete from ANEXOS where RADI_NUME_SALIDA=$nurad
			   and CAST( sgd_dir_tipo AS VARCHAR(4) ) like '7%' and sgd_dir_tipo !=7 ";
        $rs = $db->query($isql);
        if (!$rs) {
            saveMessage('error','No se ha borrar los datos previos del radicado');
            die(json_encode($answer));
        }

        $isql = "select ANEX_NUMERO from ANEXOS where ANEX_RADI_NUME = $nurad Order by ANEX_NUMERO desc ";
        $rs = $db->query($isql);
        if (!$rs->EOF)
            $i = $rs->fields['ANEX_NUMERO'];

        include_once "./include/query/queryGenarchivo.php";
        $isql = $query1;
        $rs = $db->query($isql);
        $k = 0;

        while (!$rs->EOF) {
            $anexo_new = $rad_salida . substr("00000" . ($i + 1), -5);
            $sgd_dir_codigo = $rs->fields['SGD_DIR_CODIGO'];
            $radi_nume_radi = $rs->fields['RADI_NUME_RADI'];
            $sgd_dir_tipo = $rs->fields['SGD_DIR_TIPO'];
            $anex_tipo = "20";
            $anex_creador = $krd;
            $anex_borrado = "N";
            $anex_nomb_archivo = " ";
            $anexo_num = $i + 1;

            $isql = "insert into ANEXOS (ANEX_RADI_NUME,RADI_NUME_SALIDA,ANEX_SOLO_LECT,ANEX_RADI_FECH,ANEX_ESTADO,ANEX_CODIGO  ,anex_tipo   ,ANEX_CREADOR  ,ANEX_NUMERO    ,ANEX_NOMB_ARCHIVO   ,ANEX_BORRADO   ,sgd_dir_tipo)
		VALUES ($verrad       ,$rad_salida     ,'S'           ,$sqlFechaHoy       ,2          ,'$anexo_new','$anex_tipo','$anex_creador','$anexo_num','$anex_nomb_archivo','$anex_borrado','$sgd_dir_tipo')";
            $rs2 = $db->query($isql);
            if (!$rs2) {
                saveMessage('error','No se pudo insertar en la tabla de anexos');
                die(json_encode($answer));
            }
            $isql = "UPDATE sgd_dir_drecciones
		         set RADI_NUME_RADI=$rad_salida
 				     where sgd_dir_codigo=$sgd_dir_codigo ";
            $rs2 = $db->query($isql);
            if (!$rs2) {
                saveMessage('error','No se pudo actualizar las direcciones');
                die(json_encode($answer));
            }
            $sgd_dir_tipo++;
            $i++;
            $k++;
            $rs->MoveNext();
        }
        saveMessage('success',"$k copias ");

        if ($actualizados > 0) {
            if ($ent != 1) {
                if ($numerar != 1) {
                    $numerar = $numerar;
                    saveMessage('success'," actualizado $rad_salida ");
                }
            }
        } else {
            saveMessage('error',"No se ha podido radicar el Documento con el N&uacute;mero");
            die(json_encode($answer));
        }
    }
}

$ra_asun = ereg_replace("\n", "-", $ra_asun);
$ra_asun = ereg_replace("\r", " ", $ra_asun);
$archInsumo = "tmp_" . $usua_doc . "_" . $fechaArchivo . "_" . $hora . ".txt";

$fp = fopen("$ruta_raiz/bodega/masiva/$archInsumo", 'w+');

if (!$fp) {
    $db->conn->RollbackTrans();
    saveMessage('error',"No se pudo abrir el archivo $ruta_raiz/bodega/masiva/$archInsumo");
    die(json_encode($answer));
}


$linkArchivoTxt = $linkArchSimple . ".txt";
$linkArchivoTxtactuales = $linkArchSimple . ".rads.txt";
$linkArchivoTxt = str_replace("1d.docx", "1.docx", $linkArchivoTxt);
$linkArchivoTxtactuales = str_replace("1d.docx", "1.docx", $linkArchivoTxtactuales);

if (is_file($linkArchivoTxt)) {
    $documentosFaltantes = file_get_contents($linkArchivoTxt);
    $documentosActuales = file_get_contents($linkArchivoTxtactuales);
    saveMessage('success',$documentosActuales);
}

fputs($fp, "archivoInicial=$linkArchSimple" . "\n");
fputs($fp, "archivoFinal=$archivoFinal" . "\n");
fputs($fp, "<Radicado>=$rad_salida\n");

$arr = explode("\n", $documentosFaltantes);
$arrActuales = explode("\n", $documentosActuales);

if (is_file($linkArchivoTxt)) {
    foreach ($arr as $value) {
        $docsF .= "$value<br>";
    }
    foreach ($arrActuales as $value) {
        $documentosA .= "$value<br>";
    }
}

fputs($fp, "<USUARIO>=$nombret_us1_u\n");
fputs($fp, "<SGD_CIU_DIRECCION>=$direccion_us1\n");
fputs($fp, "<DPTO_NOMB>=$dpto_nombre_us1\n");
fputs($fp, "<MUNI_NOMB>=$muni_nombre_us1\n");
fputs($fp, "<NOMBRE_DE_LA_EMPRESA>=$nombret_us3_u\n");
fputs($fp, "*RAD_LIQUIDACIONES_VOLUNTARIAS*=$documentosA\n");
fputs($fp, "*DOC_FALTA*=$docsF\n");
fputs($fp, "*RAD_E_PADRE*=$radicado_p\n");
fputs($fp, "*CTA_INT*=$cuentai\n");
fputs($fp, "*ASUNTO*=$ra_asun\n");
fputs($fp, "*F_RAD_E*=$fecha_e\n");
fputs($fp, "*SAN_FECHA_RADICADO*=$fecha_e\n");
fputs($fp, "*RA_ASUN=$ra_asun\n");
fputs($fp, "*NOM_R*=$nombret_us1_u\n");
fputs($fp, "*DIR_R*=$direccion_us1\n");
fputs($fp, "*DIR_E*=$direccion_us3\n");
fputs($fp, "*DEPTO_R*=$dpto_nombre_us1\n");
fputs($fp, "*MPIO_R*=$muni_nombre_us1\n");
fputs($fp, "*TEL_R*=$telefono_us1\n");
fputs($fp, "*MAIL_R*=$mail_us1\n");
fputs($fp, "*DOC_R*=$cc_documentous1\n");
fputs($fp, "*NOM_P*=$nombret_us2_u\n");
fputs($fp, "*DIR_P*=$direccion_us2\n");
fputs($fp, "*DEPTO_P*=$dpto_nombre_us2\n");
fputs($fp, "*MPIO_P*=$muni_nombre_us2\n");
fputs($fp, "*TEL_P*=$telefono_us1\n");
fputs($fp, "*MAIL_P*=$mail_us2\n");
fputs($fp, "*DOC_P*=$cc_documento_us2\n");
fputs($fp, "*NOM_E*=$nombret_us3_u\n");
fputs($fp, "*DIR_E*=$direccion_us3\n");
fputs($fp, "*MPIO_E*=$muni_nombre_us3\n");
fputs($fp, "*DEPTO_E*=$dpto_nombre_us3\n");
fputs($fp, "*TEL_E*=$telefono_us3\n");
fputs($fp, "*MAIL_E*=$mail_us3\n");
fputs($fp, "*NIT_E*=$cc_documento_us3\n");
fputs($fp, "*NUIR_E*=$nuir_e\n");
fputs($fp, "*F_RAD_S*=$fecha_hoy_corto\n");
fputs($fp, "*RAD_E*=$radicado_p\n");
fputs($fp, "*SAN_RADICACION*=$radicado_p\n");
fputs($fp, "*SECTOR*=$sector_nombre\n");
fputs($fp, "*NRO_PAGS*=$radi_nume_hoja\n");
fputs($fp, "*DESC_ANEXOS*=$radi_desc_anex\n");
fputs($fp, "*F_HOY_CORTO*=$fecha_hoy_corto\n");
fputs($fp, "*F_HOY*=$fecha_hoy\n");
fputs($fp, "*NUM_DOCTO*=$secuenciaDocto\n");
fputs($fp, "*F_DOCTO*=$fechaDocumento\n");
fputs($fp, "*F_DOCTO1*=$fechaDocumento2\n");
fputs($fp, "*FUNCIONARIO*=$usua_nomb\n");
fputs($fp, "*LOGIN*=$krd\n");
fputs($fp, "*DEP_NOMB*=$dependencianomb\n");
fputs($fp, "*CIU_TER*=$terr_ciu_nomb\n");
fputs($fp, "*DEP_SIGLA*=$dep_sigla\n");
fputs($fp, "*DIR_TER*=$terr_direccion\n");
fputs($fp, "*TER_L*=$terr_nombre\n");
fputs($fp, "*NOM_REC*=$nom_recurso\n");
fputs($fp, "*EXPEDIENTE*=$expRadi\n");
fputs($fp, "*NUM_EXPEDIENTE*=$expRadi\n");
fputs($fp, "*DIGNATARIO*=$otro_us1\n");
fputs($fp, "*DEPE_CODI*=$dependencia\n");
fputs($fp, "*DEPENDENCIA*=$dependencia\n");
fputs($fp, "*DEPENDENCIA_NOMBRE*=$dependencia_nombre\n");
fputs($fp, "*NOM_R*=$nombret_us1_u\n");
fputs($fp, "*F_RAD*=$fecha_hoy_corto\n");
fputs($fp, "*RAD_S*=$rad_salida\n");
fputs($fp, "*DEPTO_R*=$dpto_nombre_us1\n");
fputs($fp, "*MPIO_R*=$muni_nombre_us1\n");
fputs($fp, "*RAD_ASUNTO*=$ra_asun\n");
fputs($fp, "*LOGINORFEO*=$krd\n");
fputs($fp, "*DIR_R*=$direccion_us1\n");
fputs($fp, "*DEPENDENCIAORFEO*=$dependencia\n");
fputs($fp, "*DEPE_CODI*=$dependencia\n");
fputs($fp, "RAD_S=$rad_salida\n");
fputs($fp, "F_RAD=$fecha_hoy_corto\n");
fputs($fp, "F_RAD_S=$fecha_hoy_corto\n");
fputs($fp, "RAD_LIQUIDACIONES_VOLUNTARIAS=$documentosA\n");
fputs($fp, "DOC_FALTA=$docsF\n");
fputs($fp, "RAD_E_PADRE=$radicado_p\n");
fputs($fp, "CTA_INT=$cuentai\n");
fputs($fp, "ASUNTO=$ra_asun\n");
fputs($fp, "F_RAD_E=$fecha_e\n");
fputs($fp, "SAN_FECHA_RADICADO=$fecha_e\n");
fputs($fp, "RA_ASUN=$ra_asun\n");
fputs($fp, "NOM_R=$nombret_us1_u\n");
fputs($fp, "DIR_R=$direccion_us1\n");
fputs($fp, "DIR_E=$direccion_us3\n");
fputs($fp, "DEPTO_R=$dpto_nombre_us1\n");
fputs($fp, "MPIO_R=$muni_nombre_us1\n");
fputs($fp, "TEL_R=$telefono_us1\n");
fputs($fp, "MAIL_R=$mail_us1\n");
fputs($fp, "DOC_R=$cc_documentous1\n");
fputs($fp, "NOM_P=$nombret_us2_u\n");
fputs($fp, "DIR_P=$direccion_us2\n");
fputs($fp, "DEPTO_P=$dpto_nombre_us2\n");
fputs($fp, "MPIO_P=$muni_nombre_us2\n");
fputs($fp, "TEL_P=$telefono_us1\n");
fputs($fp, "MAIL_P=$mail_us2\n");
fputs($fp, "DOC_P=$cc_documento_us2\n");
fputs($fp, "NOM_E=$nombret_us3_u\n");
fputs($fp, "DIR_E=$direccion_us3\n");
fputs($fp, "MPIO_E=$muni_nombre_us3\n");
fputs($fp, "DEPTO_E=$dpto_nombre_us3\n");
fputs($fp, "TEL_E=$telefono_us3\n");
fputs($fp, "MAIL_E=$mail_us3\n");
fputs($fp, "NIT_E=$cc_documento_us3\n");
fputs($fp, "NUIR_E=$nuir_e\n");
fputs($fp, "F_RAD_S=$fecha_hoy_corto\n");
fputs($fp, "RAD_E=$radicado_p\n");
fputs($fp, "SAN_RADICACION=$radicado_p\n");
fputs($fp, "SECTOR=$sector_nombre\n");
fputs($fp, "NRO_PAGS=$radi_nume_hoja\n");
fputs($fp, "DESC_ANEXOS=$radi_desc_anex\n");
fputs($fp, "F_HOY_CORTO=$fecha_hoy_corto\n");
fputs($fp, "F_HOY=$fecha_hoy\n");
fputs($fp, "NUM_DOCTO=$secuenciaDocto\n");
fputs($fp, "F_DOCTO=$fechaDocumento\n");
fputs($fp, "F_DOCTO1=$fechaDocumento2\n");
fputs($fp, "FUNCIONARIO=$usua_nomb\n");
fputs($fp, "LOGIN=$krd\n");
fputs($fp, "DEP_NOMB=$dependencianomb\n");
fputs($fp, "CIU_TER=$terr_ciu_nomb\n");
fputs($fp, "DEP_SIGLA=$dep_sigla\n");
fputs($fp, "DIR_TER=$terr_direccion\n");
fputs($fp, "TER_L=$terr_nombre\n");
fputs($fp, "NOM_REC=$nom_recurso\n");
fputs($fp, "NUM_EXPEDIENTE=$expRadi\n");
fputs($fp, "DEPE_CODI=$dependencia\n");
fputs($fp, "DEPENDENCIA=$dependencia\n");
fputs($fp, "DEPENDENCIA_NOMBRE=$dependencia_nombre\n");
fputs($fp, "NOM_R=$nombret_us1_u\n");
fputs($fp, "F_RAD=$fecha_hoy_corto\n");
fputs($fp, "RAD_S=$rad_salida\n");
fputs($fp, "DEPTO_R=$dpto_nombre_us1\n");
fputs($fp, "MPIO_R=$muni_nombre_us1\n");
fputs($fp, "RAD_ASUNTO=$ra_asun\n");
fputs($fp, "LOGINORFEO=$krd\n");

for ($i_count = 0; $i_count < count($camposSanc); $i_count++) {
    fputs($fp, trim($camposSanc[$i_count]) . "=" . trim($datosSanc[$i_count]) . "\n");
}

for ($i_count = 0; $i_count < count($campos); $i_count++) {
    fputs($fp, trim($campos[$i_count]) . "=" . trim($datos[$i_count]) . "\n");
}

fclose($fp);
$estadoTransaccion = -1;


if ($ext == "ODT" || $ext == "odt") {
    //Se incluye la clase que maneja la combinacion masiva
    include("$ruta_raiz/radsalida/masiva/OpenDocText.class.php");
    define ('WORKDIR', './bodega/tmp/workDir/');
    define ('CACHE', WORKDIR . 'cacheODT/');
    //Se abre archivo de insumo para lectura de los datos
    if (file_exists("$ruta_raiz/bodega/masiva/$archInsumo")) {
        $contenidoCSV = file("$ruta_raiz/bodega/masiva/$archInsumo");
    } else {
        saveMessage('error',"No hay acceso para crear el archivo $archInsumo");
        die(json_encode($answer));
    }

    $accion = false;
    $odt    = new OpenDocText();
    //$odt->debug = true;

    //Se carga el archivo odt Original
    $archivoACargar = str_replace('../', '', $linkarchivo);
    $odt->cargarOdt("$archivoACargar", $nombreArchivo);
    $odt->setWorkDir(WORKDIR);
    $accion = $odt->abrirOdt();

    if (!$accion) {
        saveMessage('error',"Problemas en el servidor abriendo archivo ODT para combinaci&oacute;n.");
        die(json_encode($answer));
    }

    $odt->cargarContenido();

    //Se recorre el archivo de insumo
    foreach ($contenidoCSV as $line_num => $line) {
        if ($line_num > 1) {
            $cadaLinea = explode("=", $line);
            $cadaVariable[$line_num - 2] = $cadaLinea[0];
            $cadaValor[$line_num - 2] = $cadaLinea[1];
        }
    }

    $tipoUnitario = '1';

    if ($vp == "s") {
        $linkarchivo_grabar = str_replace("bodega/", "", $linkarchivotmp);
        $linkarchivo_grabar = str_replace("./", "", $linkarchivo_grabar);
        $odt->setVariable($cadaVariable, $cadaValor);
        $archivoDefinitivo = $odt->salvarCambios(null, $linkarchivo_grabar, '1');
    } else {
        $linkarchivo_grabar = str_replace("..", "", $linkarchivo_grabar);
        $odt->setVariable($cadaVariable, $cadaValor);
        $archivoDefinitivo = $odt->salvarCambios(null, $linkarchivo_grabar, '1');
    }

    $db->conn->CommitTrans();
    saveMessage('success', "<script> function abrirArchivo(url){nombreventana='Documento'; window.open(url, nombreventana,  'status, width=900,height=500,screenX=100,screenY=75,left=50,top=75');return; }</script>
    combinaci&oacute;n de correspondencia realizada <a class='vinculos' href=javascript:abrirArchivo('./bodega/" . $linkarchivo_grabar . "')> Ver Archivo </a>");
    $odt->borrar();
} elseif ($ext == "DOCX" || $ext == "docx") {
    //Se incluye la clase que maneja la combinacion masiva
    include("$ruta_raiz/radsalida/masiva/ooxml.class.php");
    define ('WORKDIR', './bodega/tmp/workDir/');
    define ('CACHE', WORKDIR . 'cacheODT/');
    //Se abre archivo de insumo para lectura de los datos
    $fp = fopen("$ruta_raiz/bodega/masiva/$archInsumo", 'r');

    if ($fp) {
        $contenidoCSV = file("$ruta_raiz/bodega/masiva/$archInsumo");
        fclose($fp);
    } else {
        saveMessage('error',"No hay acceso para crear el archivo $archInsumo ");
        die(json_encode($answer));
    }

    $accion = false;
    $docx = new OoXml();

    //Se carga el archivo odt Original
    $archivoACargar = str_replace('../', '', $linkarchivo);
    $docx->cargarOdt("$archivoACargar", $nombreArchivo);
    $docx->setWorkDir(WORKDIR);
    $accion = $docx->abrirOdt();
    if (!$accion) {
        saveMessage('error',"Problemas en el servidor abriendo archivo DOCX para combinaci&oacute;n.");
    }
    $docx->cargarContenido();

    //Se recorre el archivo de insumo
    foreach ($contenidoCSV as $line_num => $line) {
        if ($line_num > 1) { //Desde la linea 2 hasta el final del archivo de insumo estan los datos de reemplazo
            $cadaLinea = explode("=", $line);
            $cadaVariable[$line_num - 2] = $cadaLinea[0];
            $cadaValor[$line_num - 2] = $cadaLinea[1];
        }
    }
    $tipoUnitario = '1';
    if ($vp == "s") {
        $linkarchivo_grabar = str_replace("bodega/", "", $linkarchivotmp);
        $linkarchivo_grabar = str_replace("./", "", $linkarchivo_grabar);
        $docx->setVariable($cadaVariable, $cadaValor);
        $archivoDefinitivo = $odt->salvarCambios(null, $linkarchivo_grabar, '1');
    } else {
        $docx->setVariable($cadaVariable, $cadaValor);
        $linkarchivo_grabar = str_replace("..", "", $linkarchivo_grabar);
        $docx->salvarCambios(null, $linkarchivo_grabar, '1');
    }
    $db->conn->CommitTrans();
    saveMessage('success',"<script> function abrirArchivo(url){nombreventana='Documento'; window.open(url, nombreventana,  'status, width=900,height=500,screenX=100,screenY=75,left=50,top=75');return; }<//script>
        Combinacion de Correspondencia Realizada <a class='vinculos' href=javascript:abrirArchivo('./bodega/" . $linkarchivo_grabar . "?time=" . time() . "')> Ver Archivo </a> ");

    $docx->borrar();
} elseif ($ext == "XML" || $ext == "xml") {
    //Se incluye la clase que maneja la combinacion masiva
    include("$ruta_raiz/include/AdminArchivosXML.class.php");
    define ('WORKDIR', './bodega/tmp/workDir/');
    define ('CACHE', WORKDIR . 'cacheODT/');

    //Se abre archivo de insumo para lectura de los datos
    $fp = fopen("$ruta_raiz/bodega/masiva/$archInsumo", 'r');
    if ($fp) {
        $contenidoCSV = file("$ruta_raiz/bodega/masiva/$archInsumo");
        fclose($fp);
    } else {
        saveMessage('error',"No hay acceso para crear el archivo $archInsumo ");
        die(json_encode($answer));
    }
    $accion = false;
    $xml    = new AdminArchivosXML();
    //Se carga el archivo odt Original
    $archivoACargar = str_replace('../', '', $linkarchivo);
    $xml->cargarXML("$archivoACargar", $nombreArchivo);
    $xml->setWorkDir(WORKDIR);
    $accion = $xml->abrirXML();
    $xml->cargarContenido();

    //Se recorre el archivo de insumo
    foreach ($contenidoCSV as $line_num => $line) {
        if ($line_num > 1) { //Desde la linea 2 hasta el final del archivo de insumo estan los datos de reemplazo
            $cadaLinea = explode("=", $line);
            //$cadaLinea[1] = str_replace("<", "'", $cadaLinea[1]);
            //$cadaLinea[1] = str_replace(">", "'", $cadaLinea[1]);
            $cadaVariable[$line_num - 2] = $cadaLinea[0];
            $cadaValor[$line_num - 2] = $cadaLinea[1];
        }
    }
    if ($vp == "s") {
        $linkarchivo_grabar = str_replace("bodega", "", $linkarchivotmp);
        $linkarchivo_grabar = str_replace("./", "", $linkarchivo_grabar);
    }

    $xml->setVariable($cadaVariable, $cadaValor);
    $xml->salvarCambios(null, $linkarchivo_grabar);
    $db->conn->CommitTrans();

    saveMessage('error',"<script> function abrirArchivo(url){nombreventana='Documento'; window.open(url, nombreventana,  'status, width=900,height=500,screenX=100,screenY=75,left=50,top=75');return; }</script>
        Combinacion de Correspondencia Realizada <a class='vinculos' href=javascript:abrirArchivo('./bodega" . $linkarchivo_grabar . "')> Ver Archivo </a> ");
}

/** Este Procedimiento Asegura si se realizo la combinacion
 * Primero verifica que el archivo Generado Exista
 * Luego si no existe deja la Plantilla Original.
 **/


$link         = $ABSOL_PATH . "/bodega/" . $linkarchivo_grabar;
$tam          = filesize($link);
$linkFuente   = str_replace("d.", ".", $linkarchivo_grabar);
$linkF        = $ABSOL_PATH . "/bodega/" . $linkFuente;
$tamFuente    = filesize($linkF);

saveMessage('success', " ".($tam) / 1000 . " kb");

if ($tam >= 100) {
    saveMessage('success'," archivo Final Ok.");
} else {
    $isql = "update RADICADO
				   set RADI_PATH='$linkFuente'
				  where RADI_NUME_RADI = $rad_salida";

    $db->conn->query($isql);
    if ($linkarchivo_grabar) {
        $filaGrabar = filedata($archUpdateFuente);
        $isql = "update anexos
		  set ANEX_NOMB_ARCHIVO='" . basename($linkFuente) . "'
		where ANEX_NOMB_ARCHIVO like '%" . basename($link) . "%'";
        $db->conn->query($isql);
    }
    saveMessage('error',"No se realizo Combinacion. Retornado Archivo Original.");
    die(json_encode($answer));
}

function filedata($path){
    // Vaciamos la caché de lectura de disco
    clearstatcache();
    // Comprobamos si el fichero existe
    $data["exists"] = is_file($path);
    // Comprobamos si el fichero es escribible
    $data["writable"] = is_writable($path);
    // Leemos los permisos del fichero
    $data["chmod"] = ($data["exists"] ? substr(sprintf("%o", fileperms($path)), -4) : FALSE);
    // Extraemos la extensión, un sólo paso
    $data["ext"] = substr(strrchr($path, "."), 1);
    // Primer paso de lectura de ruta
    $data["path"] = array_shift(explode("." . $data["ext"], $path));
    // Primer paso de lectura de nombre
    $data["name"] = array_pop(explode("/", $data["path"]));
    // Ajustamos nombre a FALSE si está vacio
    $data["name"] = ($data["name"] ? $data["name"] : FALSE);
    // Ajustamos la ruta a FALSE si está vacia
    $data["path"] = ($data["exists"] ? ($data["name"] ? realpath(array_shift(explode($data["name"], $data["path"]))) : realpath(array_shift(explode($data["ext"], $data["path"])))) : ($data["name"] ? array_shift(explode($data["name"], $data["path"])) : ($data["ext"] ? array_shift(explode($data["ext"], $data["path"])) : rtrim($data["path"], "/"))));
    // Ajustamos el nombre a FALSE si está vacio o a su valor en caso contrario
    $data["filename"] = (($data["name"] OR $data["ext"]) ? $data["name"] . ($data["ext"] ? "." : "") . $data["ext"] : FALSE);
    // Devolvemos los resultados
    return $data;
}
echo json_encode($answer);
