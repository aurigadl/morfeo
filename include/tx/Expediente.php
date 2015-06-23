<?

/**
 * CLASE EXPEDIENTE
 *
 * @author Jairo Losada   <jlosada@gmail.com>
 * @author Cesar Gonzalez <aurigadl@gmail.com>
 * @license  GNU AFFERO GENERAL PUBLIC LICENSE
 * @copyleft

Models are the data definition of SIIM2 Information System
 * Copyright (C) 2013 Infometrika Ltda.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
class Expediente {
    var $num_expediente; // Almacena el nume del expediente
    var $estado_expediente; // Almacena el estado 0 para organizacion y 1 para indicar ke ya esta clasificado fisicamente en archivo
    var $descSerie;
    var $descSubSerie;
    var $descTipoExp;
    var $descFldExp;
    var $codigoFldExp;
    var $exp_titulo;
    var $exp_isla;
    var $exp_caja;
    var $exp_estante;
    var $exp_carpeta;
    var $exp_unicon;
    var $exp_archivo;
    var $exp_fechaIni;
    var $exp_fechaFin;
    var $exp_num_carpetas;
    var $expUsuaDoc;
    var $codiSRD;
    var $codiSBRD;
    var $db;
    var $codigoTipoDoc;


    /** Variable que ALmacena los dias Habiles de un Proceso
     *
     * @param $codigoTipoExp int Codigo del tipo de expediente o Tipo de Proceso.
     */

    var $codigoTipoExp;

    /** Variable que ALmacena los dias Habiles de un Proceso
     *
     * @param $expTerminos int Contiene los dias Habiles de Un Proceso.
     */
    var $expTerminos;

    /** Variable que ALmacena los dias Habiles de una Etapa Perteneciente a Un proceso
     *
     * @param $expTerminosP int Contiene los terminos en dias Habiles de la Etapa Actual del Proceso del expediente.
     */
    var $expTerminosP;

    /** Variable
     *
     * @param $expFechaCrea int Almacena Fecha de Creacion del expediente
     */
    // var $expTerminos;
    var $expFechaCrea;

    /** Variable
     *
     * @param $numSubexpediente int Almacena el numero de subexpediente;
     */
    var $numSubexpediente;
    /** Variable
     *
     * @param $pAutomatico int Dice si el expediente se puede manejar de forma manual (Los cambios de estado);
     */

    var $pAutomatico;

    /** CONSTRUTOR
     * Inicializa la Clase.
     *
     * @param $db variable contenedora del Cursor. Esta tiene que ser  enviada en el construtor
     */

    var $expedientes = array();

    /** $expedientes
     * array que guarda los expedientes pertenecientes a un aradicado.
     *
     * @param $db variable contenedora del Cursor. Esta tiene que ser  enviada en el construtor
     */

    function Expediente($db) {
        $this->db = $db;
        $this->db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
    }

    /** FUNCION CONSULTA EXPEDIENTE
     * Inicializa la Clase.
     *
     * @param $radicado int Contiene el numero de radicado a Buscar
     *
     * @return Numero de Expediente que posee el radicado
     */
    function consulta_exp($radicado) {
        switch ($this->db->driver) {
            case 'mssql':
                $radi_nume_radi = "convert(varchar(14), e.radi_nume_radi)";
                break;
            default:
                $radi_nume_radi = "e.radi_nume_radi";
                break;
        }
        // Modificado 15-Agosto-2006 Supersolidaria
        // No tiene en cuenta los expedientes de los que ha sido excluido el radicado (SGD_EXP_ESTADO = 2).
        $query = "select e.SGD_EXP_NUMERO,e.SGD_EXP_ESTADO,$radi_nume_radi AS RADI_NUME_RADI
				from SGD_EXP_EXPEDIENTE e
				where e.RADI_NUME_RADI = $radicado
				AND SGD_EXP_ESTADO <> 2";
	//$this->db->conn->debug = true;
	$rs = $this->db->conn->query($query);
	if ($rs) {
		$iE = 1;
            while (!$rs->EOF) {
                if ($iE == 1) {
                    $this->num_expediente = $rs->fields['SGD_EXP_NUMERO'];
                    //	echo  $rs->fields['SGD_EXP_NUMERO']."<hr>";
                    $this->estado_expediente = $rs->fields['SGD_EXP_ESTADO'];
                }
                $this->expedientes[$iE] = $rs->fields['SGD_EXP_NUMERO'];
                $iE++;
                $rs->MoveNext();
            }
	}else{
		$this->num_expediente = 0;
	}
        //$this->num_expediente = $num_expediente;   RP
        return $this->num_expediente;
    }

    function consultaExp($radicado) {
        $this->db->conn->debug = false;
        switch ($this->db->driver){
            case 'mssql':
                $radi_nume_radi = "convert(varchar(14), e.radi_nume_radi)";
                break;
            default:
                $radi_nume_radi = "e.radi_nume_radi";
                break;
        }


        $query = "SELECT
                    e.SGD_EXP_NUMERO,
                    e.SGD_EXP_ESTADO,
                    sexp.SGD_SEXP_PRESTAMO,
                    $radi_nume_radi AS RADI_NUME_RADI
                  FROM
                    SGD_EXP_EXPEDIENTE e,
                    SGD_SEXP_SECEXPEDIENTES sexp
                  WHERE
                    e.RADI_NUME_RADI = $radicado AND
                    e.sgd_exp_numero=sexp.sgd_exp_numero AND
                    SGD_EXP_ESTADO <> 2";

        $rs = $this->db->conn->query($query);
        if ($rs)
            $this->num_expediente = $rs->fields['SGD_EXP_NUMERO'];
        if ($rs->EOF) {
            $this->num_expediente = 0;
        } else {
            $iE = 1;
            $expArr = array();

            while (!$rs->EOF) {


                if ($iE == 1) {
                    $this->num_expediente    = $rs->fields['SGD_EXP_NUMERO'];
                    $this->estado_expediente = $rs->fields['SGD_EXP_ESTADO'];
                }

                $numExpediente = $rs->fields['SGD_EXP_NUMERO'];

                $expArr[$numExpediente]["PRESTAMO"] = $rs->fields['SGD_SEXP_PRESTAMO'];

                $query = "select
                              exp.RADI_NUME_RADI,
                              r.RA_ASUN,
                              to_char(r.RADI_FECH_RADI, 'YYYY-MM-DD hh:mi:SS') RADI_FECH_RADI,
                              t.SGD_TPR_DESCRIP,
                              r.RADI_PATH
                          from
                              sgd_exp_expediente exp,
                              radicado r,
                              SGD_TPR_TPDCUMENTO t
                          where
                                  exp.sgd_exp_numero='" . $numExpediente . "'
                              and exp.radi_nume_radi = r.radi_nume_radi
                              and r.tdoc_codi=t.sgd_tpr_codigo  AND exp.sgd_exp_estado <>2 ";

                $rsRad = $this->db->conn->query($query);

                $iRr = 0;
                if (!$rsRas->EOF) {
                    while (!$rsRad->EOF) {
                        $numRadicado    = $rsRad->fields['RADI_NUME_RADI'];
                        $fechaRadicado  = $rsRad->fields['RADI_FECH_RADI'];
                        $tipoDRadicado  = $rsRad->fields['SGD_TPR_DESCRIP'];
                        $asuntoRadicado = $rsRad->fields['RA_ASUN'];
                        $pathRadicado   = $rsRad->fields['RADI_PATH'];
                        $prestamosexp   = $rsRad->fields['SGD_EXP_NUMERO'];

                        $expArr[$numExpediente][$iRr]["NUM_RADICADO"]    = $numRadicado;
                        $expArr[$numExpediente][$iRr]["FECHA_RADICADO"]  = $fechaRadicado;
                        $expArr[$numExpediente][$iRr]["TIPO_DRADICADO"]  = $tipoDRadicado;
                        $expArr[$numExpediente][$iRr]["ASUNTO_RADICADO"] = $asuntoRadicado;
                        $expArr[$numExpediente][$iRr]["PATH_RADICADO"]   = $pathRadicado;


                        $query = "select a.ANEX_RADI_NUME,a.ANEX_DESC, a.radi_nume_salida, a.anex_numero, t.SGD_TPR_DESCRIP
					 ,a.ANEX_NOMB_ARCHIVO
				    from anexos a LEFT JOIN  SGD_TPR_TPDCUMENTO t
                                       on ( a.sgd_tpr_codigo=t.sgd_tpr_codigo   )
				where a.anex_radi_nume='" . $numRadicado . "'
				ORDER BY a.anex_fech_anex";
                        $rsAnex = $this->db->conn->query($query);

                        $arrAnexos = array();
                        $iA = 0;

                        while (!$rsAnex->EOF) {
                            $arrAnexos[$iA]["NUMERO"] = $rsAnex->fields['ANEX_RADI_NUME'];
                            $arrAnexos[$iA]["DESCRIPCION"] = $rsAnex->fields['ANEX_DESC'];
                            $arrAnexos[$iA]["RADI_SALIDA"] = $rsAnex->fields['RADI_NUME_SALIDA'];
                            $arrAnexos[$iA]["ANEX_NUMERO"] = $rsAnex->fields['ANEX_NUMERO'];
                            $arrAnexos[$iA]["ANEX_PATH"] = $rsAnex->fields['ANEX_NOMB_ARCHIVO'];
                            $expArr[$numExpediente][$iRr]["ANEXOS"] = $arrAnexos;
			    $rsAnex->MoveNext();
			    $iA++;
                        }

                        $querySE = "select exp.SGD_EXP_NUMERO, sexp.sgd_sexp_PAREXP1, sexp.sgd_sexp_PAREXP2
                                          , sexp.sgd_sexp_PAREXP3,  sexp.sgd_sexp_PAREXP4, sexp.sgd_sexp_PAREXP5
                                          , sexp.sgd_sexp_PAREXP6,  sexp.sgd_sexp_PAREXP7, sexp.sgd_sexp_PAREXP8
                                          , sexp.sgd_sexp_PAREXP9,  sexp.sgd_sexp_PAREXP10
									from
									      SGD_EXP_EXPEDIENTE exp, sgd_sexp_secexpedientes sexp
									where
									      exp.radi_nUme_radi='$numRadicado' and exp.sgd_exp_numero = '$numExpediente'
											  and exp.sgd_exp_numero=sexp.sgd_exp_numero AND exp.sgd_exp_estado <>2";

                        $rsSE = $this->db->conn->query($querySE);
                        $iE = 0;

                        while (!$rsSE->EOF and !empty($rsSE)) {
                            $arrSE[$iE]["NUMERO"] = $rsSE->fields['SGD_EXP_NUMERO'];
                            $arrSE[$iE]["PARAM1"] = $rsSE->fields['SGD_SEXP_PAREXP1'];
                            $arrSE[$iE]["PARAM2"] = $rsSE->fields['SGD_SEXP_PAREXP2'];
                            $arrSE[$iE]["PARAM3"] = $rsSE->fields['SGD_SEXP_PAREXP3'];
                            $arrSE[$iE]["PARAM4"] = $rsSE->fields['SGD_SEXP_PAREXP4'];
                            $arrSE[$iE]["PARAM5"] = $rsSE->fields['SGD_SEXP_PAREXP5'];
                            $arrSE[$iE]["PARAM6"] = $rsSE->fields['SGD_SEXP_PAREXP6'];
                            $arrSE[$iE]["PARAM7"] = $rsSE->fields['SGD_SEXP_PAREXP7'];
                            $arrSE[$iE]["PARAM8"] = $rsSE->fields['SGD_SEXP_PAREXP8'];
                            $arrSE[$iE]["PARAM9"] = $rsSE->fields['SGD_SEXP_PAREXP9'];
                            $arrSE[$iE]["PARAM10"] = $rsSE->fields['SGD_SEXP_PAREXP10'];
                            $rsSE->MoveNext();
                            $iE++;
                            $expArr[$numExpediente][$iRr]["SEXPEDIENTES"] = $arrSE;
                        }
                        $iRr++;
                        $rsRad->MoveNext();
                    }
                    $iE++;
                    $rs->MoveNext();
                }
                $this->expedientes = $expArr;
            }
        }
        return $this->num_expediente;
    }


    /**
     * Inserta un Numero de radicado en un Expediete
     * Inicializa la Clase.
     *
     * @param $radicado int Contiene el numero de radicado a Buscar
     * @param  $usua_doc String Documento de identificacion de Usuario que realiza la insercion-
     * @param  $usua_codi String Codigo en Orfeo del Usuario que realiza la insercion-
     * @param  $depe_codi String Codigo en Orfeo de la dependencia del  Usuario que realiza la insercion.
     * @param  $radicado Numeric Numero de Radicado a Relacionar con el Expediente.
     * @param  $radicado String Numero de Expediente a Relacionar con el Radicado.
     * @param    $expManual String que Contien 1 o 0. "0 es genera secuencia y 1 deja el consecutivo que el usuario ha colocado.
     *
     * @return Numero de Expediente que posee el radicado
     *
     */
    function insertar_expediente($num_expediente, $radicado, $depe_codi, $usua_codi, $usua_doc) {
        $estado_expediente = 0;
        $creadoOld = 0;
        $query = "select *
			from SGD_SEXP_SECEXPEDIENTES e
			WHERE
			e.SGD_EXP_NUMERO='$num_expediente'
			";
        $rs = $this->db->conn->query($query);
        if (!$rs->fields["SGD_EXP_NUMERO"]) {
            $this->db->conn->query($query);
            $query = "select
			e.SGD_EXP_NUMERO,
			e.SGD_EXP_FECH
			from SGD_EXP_EXPEDIENTE e
			WHERE
			e.SGD_EXP_NUMERO='$num_expediente'
			order by e.SGD_EXP_FECH DESC";
            $rs2 = $this->db->conn->query($query);
            if (!$rs2->fields["SGD_EXP_NUMERO"]) {
                echo "<hr>No hay Documentos en el expediente $num_expediente<hr>";
                return 0;
            } else {
                $codiSRD = 0;
                $codiSBRD = 0;
                $fechaExp = $rs2->fields["SGD_EXP_FECH"];
                $this->crearExpediente($num_expediente, $radicado, $depe_codi, $usua_codi, $usua_doc, $usua_doc, $codiSRD, $codiSBRD, "true", $fechaExp);
                if ($rs2 != -1)
                    $creadoOld = 1;
            }

        }

        if (!$rs->EOF or $creadoOld == 1) {
            //echo "<br>Expediente Grabado Correctamente<br>";
            $fecha_hoy = Date("Y-m-d");
            $sqlFechaHoy = $this->db->conn->DBDate($fecha_hoy);
            $query = "insert into SGD_EXP_EXPEDIENTE(SGD_EXP_NUMERO   , RADI_NUME_RADI,SGD_EXP_FECH,DEPE_CODI   ,USUA_CODI   ,USUA_DOC      ,SGD_EXP_ESTADO )
	VALUES ('$num_expediente','$radicado'    ," . $sqlFechaHoy . ",'$depe_codi' ,'$usua_codi' ,'$usua_doc','$estado_expediente')";
            if (!$this->db->conn->query($query)) {
                //echo '<br>Lo siento no pudo agregar el expediente<br>';

                // Modificado 17-Agosto-2006 Supersolidaria
                // Si el radicado ha sido excluido del expediente (SGD_EXP_ESTADO = 2) y se desea
                // incluir de nuevo actualiza a 0 el campo SGD_EXP_ESTADO (SGD_EXP_ESTADO = 0).
                $q_excluido = "SELECT SGD_EXP_ESTADO";
                $q_excluido .= " FROM SGD_EXP_EXPEDIENTE";
                $q_excluido .= " WHERE SGD_EXP_NUMERO = '" . $num_expediente . "'";
                $q_excluido .= " AND RADI_NUME_RADI = '" . $radicado . "'";
                // print $q_excluido;
                $rs_excluido = $this->db->conn->query($q_excluido);
                if ($rs_excluido->fields["SGD_EXP_ESTADO"] == 2) {
                    $q_update = "UPDATE SGD_EXP_EXPEDIENTE";
                    $q_update .= " SET SGD_EXP_ESTADO = 0";
                    $q_update .= " WHERE SGD_EXP_NUMERO = '" . $num_expediente . "'";
                    $q_update .= " AND RADI_NUME_RADI = '" . $radicado . "'";
                    $q_update .= " AND SGD_EXP_ESTADO = 2";
                    // print $q_update;

                    if (!$rs_update = $this->db->conn->query($q_update)) {
                        return 0;
                    } else {
                        return 1;
                    }
                } else {
                    return 0;
                }

            } else {
                return 1;
            }

        } else {
            return 0;
        }
    }

    /**
     * Crea un Numero de radicado en un Expediete
     * Crea un expediente y anade un numero de radicado a este. Ademas inserta en el historico
     * La transcacion realizada, para esto verifica que el digito de Chequeo.
     *
     * @param $radicado int Contiene el numero de radicado a Buscar
     * @param  $usua_doc String Documento de identificacion de Usuario que realiza la insercion-
     * @param  $usua_codi String Codigo en Orfeo del Usuario que realiza la insercion-
     * @param  $depe_codi String Codigo en Orfeo de la dependencia del  Usuario que realiza la insercion.
     * @param  $radicado Numeric Numero de Radicado a Relacionar con el Expediente.
     * @param  $expOld   String Si esta en False Indica eque es un expediente Normal, True es del numeracin Antigua.
     * @param  $radicado String Numero de Expediente a Relacionar con el Radicado.
     *
     * @return Numero de Expediente que posee el radicado
     *
     * Modificacion: 09-Junio-2006 Supersoldiaria
     *
     * @param  $codiPROC Numeric Codigo del proceso asociado al expediente
     * @param  $arrParametro Array Arreglo que contiene los parametros asociados al expediente
     *         indexado con el orden.
     */
    function crearExpediente($numExpediente, $radicado, $depe_codi, $usua_codi, $usua_doc, $usuaDocExp, $codiSRD, $codiSBRD, $expOld = null, $fechaExp = null, $codiPROC = null, $arrParametro = null) {

        $p = 1;
        // Valida que $arrParametro contenga un arreglo
        if (is_array($arrParametro)) {
            foreach ($arrParametro as $orden => $datoParametro) {
                $coma = ", ";
                if ($p == count($arrParametro)) {
                    $coma = "";
                }
                $campoParametro .= "SGD_SEXP_PAREXP" . $orden . $coma;
                $valorParametro .= "'" . $datoParametro . "'" . $coma;
                $p++;
            }
        }

        $estado_expediente = 0;
        $query = "select SGD_EXP_NUMERO
			from SGD_SEXP_SECEXPEDIENTES
			WHERE
			SGD_EXP_NUMERO='$numExpediente'
			";

    $dependencia = $depe_codi;
        if ($expOld == "false") {
           #echo "--><pre>$query</pre>";
            $rs = $this->db->conn->Execute($query);
             $trdExp = substr("00" . $codiSRD, -2) . substr("00" . $codiSBRD, -2);
            $anoExp = substr($numExpediente, 0, 4);
            if ($expManual == 1) {
                 $secExp = $this->secExpediente($dependencia, $codiSRD, $codiSBRD, $anoExp);
            } else {
                 #echo "thishere"; exit;
                 $secExp = substr("00000" . $secExp, -5);
            }
            $consecutivoExp = substr("00000" . $secExp, -5);
            $numeroExpediente = $anoExp . $dependencia . $trdExp . $consecutivoExp;
          /*  echo "-->".$anoExp."<br>";
            echo "-->".$dependencia."<br>";
            echo "-->".$trdExp."<br>";
            echo "-->".$consecutivoExp."<br>";
            echo "--".$numeroExpediente."<br>";

            echo "--".$rs->fields["SGD_EXP_NUMERO"]; exit;*/
        } else {
             $secExp = "0";
            $consecutivoExp = "00000";
            $anoExp = substr($numExpediente, 0, 4);
        }
        if ($rs->fields["SGD_EXP_NUMERO"] == $numExpediente) {
           # echo "1"; exit;
            return 0;
        } else {
           # echo "2"; exit;
            $fecha_hoy = Date("Y-m-d");
            if (!$fechaExp)
                $fechaExp = $fecha_hoy;
            $sqlFechaHoy = $this->db->conn->OffsetDate(0, $this->db->conn->sysTimeStamp);
            if (!$codiPROC)
                $codiPROC = "0";
            if (!$secExp)
                $secExp = 1;
#echo "<pre>$query</pre>"; exit;
            $query = "insert into SGD_SEXP_SECEXPEDIENTES(SGD_EXP_NUMERO   ,SGD_SEXP_FECH      ,DEPE_CODI   ,USUA_DOC   ,SGD_FEXP_CODIGO,SGD_SRD_CODIGO,SGD_SBRD_CODIGO,SGD_SEXP_SECUENCIA, SGD_SEXP_ANO, USUA_DOC_RESPONSABLE, SGD_PEXP_CODIGO";
            if ($campoParametro != "") {
                $query .= ", $campoParametro";
            }
            $query .= " )";
            $query .= " VALUES ('$numExpediente'," . $sqlFechaHoy . " ,'$depe_codi','$usua_doc',0              ,$codiSRD     ,$codiSBRD        ,'$secExp' ,$anoExp, $usuaDocExp, $codiPROC";
            if ($valorParametro != "") {
                $query .= " , $valorParametro";
            }
            $query .= " )";
#echo $campoParametro; exit; 2014900029900002E
#echo "<pre>$query</pre>"; exit;
            if (!$rs = $this->db->conn->Execute($query)) {
                //echo '<br>Lo siento no pudo agregar el expediente<br>';
                echo "No se ha podido insertar el Expediente";
                return 0;
            } else {
                //echo "<br>Expediente Grabado Correctamente<br>";
                return $numExpediente;
            }

        }
    }

    /**  FUNCION QUE CALCULA SECUENCIA SEGUN PARAMETROS DEPENDENCIA, SERIE, SUBSERIE
     * Esta funcion Devuelve la secuencia manual cogiendo el valor mayor en le campo SGD_SEXP_SECUENCIA
     * y le incrementa 1.
     *
     * @param $dependencia int Codigo de la Dependencia.
     * @param $codiSrd int Codigo de la Serie documental que es enviada por el Usuario.
     * @param $codiSBRD int Codigo de la subserie documental enviada por el Usuario.
     * @param $query String Cadena de uso temporal para guardar consultas SQL.
     *
     * @return  Esta funcion Rerna el valor incrementado en Uno del la secuencia correspondiente.
     */
    function secExpediente($dependencia, $codiSRD, $codiSBRD, $anoExp) {
        $query = "select se.SGD_EXP_NUMERO
				, se.SGD_FEXP_CODIGO
				, se.SGD_SEXP_SECUENCIA
			from SGD_SEXP_SECEXPEDIENTES se
			WHERE
				SGD_SRD_CODIGO=$codiSRD
				AND SGD_SBRD_CODIGO=$codiSBRD
				AND SGD_SEXP_ANO=$anoExp
				-- AND DEPE_CODI = $dependencia
				AND SGD_SEXP_SECUENCIA IS NOT NULL
			ORDER BY
				substr(sgd_exp_NUMERO,length(sgd_exp_numero)-5,5) desc, sgd_sexp_secuencia DESC
			";
        // AND SGD_SEXP_SECUENCIA > 0
        $rs = $this->db->conn->Execute($query);
        $numExpediente = $rs->fields["SGD_EXP_NUMERO"];
        $secExp = $rs->fields["SGD_SEXP_SECUENCIA"];
        $secExp = substr($numExpediente, -6, -1);
        $secExp = intval($secExp);
        if (!$secExp) {
            $secExp = 1;
        } else {
            $secExp = $secExp + 1;
        }
        return $secExp;
    }

    /**
     * MODIFICA EL TRD DE UN EXPEDIENTE
     *
     * @param unknown_type $radicado
     * @param unknown_type $num_expediente
     * @param unknown_type $exp_titulo
     * @param unknown_type $exp_asunto
     * @param unknown_type $exp_ufisica
     * @param unknown_type $exp_isla
     * @param unknown_type $exp_caja
     * @param unknown_type $exp_estante
     * @param unknown_type $exp_carpeta
     */

    function modificarTRDExpediente($radicado, $numExpediente, $codiSrd = null, $codiSbrd = null, $codiProceso = null, $arrParametro = null, $usuaDoc = null) {
        if ($codiProceso == 0)
            $codiProceso = "";

        if (is_array($arrParametro)) {
            foreach ($arrParametro as $orden => $datoParametro) {
                $campoParametro = "SGD_SEXP_PAREXP" . $orden ;
                $valorParametro = "'" . $datoParametro . "'";
                $p++;
                $fecha_hoy = Date("Y-m-d");
                $sqlFechaHoy = $this->db->conn->OffsetDate(0, $this->db->conn->sysTimeStamp);
                $query = "update sgd_sexp_secexpedientes set
				SGD_SRD_CODIGO='$codiSrd'
				,SGD_SBRD_CODIGO='$codiSbrd',
				SGD_PEXP_CODIGO='$codiProceso',
				USUA_DOC_RESPONSABLE='$usuaDoc'";
                if ($valorParametro != "''") {
                    if ($campoParametro != "") {
                        $query .= ", $campoParametro";
                        $query .= " = $valorParametro";
                    }
                }
                $query .= " WHERE SGD_EXP_NUMERO = '$numExpediente'";
                $rs = $this->db->conn->query($query);
            }
        } else {
            $fecha_hoy = Date("Y-m-d");
            $sqlFechaHoy = $this->db->conn->DBDate($fecha_hoy);
            $query = "update sgd_sexp_secexpedientes set
				SGD_SRD_CODIGO='$codiSrd'
				,SGD_SBRD_CODIGO='$codiSbrd',
				SGD_PEXP_CODIGO='$codiProceso',
				USUA_DOC_RESPONSABLE='$usuaDoc'
				WHERE SGD_EXP_NUMERO = '$numExpediente'";
            $rs = $this->db->conn->query($query);
        }
        if (!$rs) {
            //
            echo '<br>Lo siento no pudo Actualizar los datos del expediente<br>';
            return $numExpediente;
        } else {
            //echo "<br>Datos de expediente Grabados Correctamente<br>";
            return 0;
        }

    }


    /**
     * PRESTA O REVERSA EL PRESTAMO DE UN EXPEDIENTE
     *
     * @param string  $num_expediente
     * @param array   $radicado //Radicados a prestar que pertenecen al expediente
     * @param string  $usuario  //Login del usuario que hace la acción
     * @param boolean $estado   //Prestado true
     */
    function cancPrestarExpediente($numExpediente,$radicados,$login) {
      $fldPRES_FECH = $this->db->conn->OffsetDate(0, $this->db->conn->sysTimeStamp);
      $setFecha     = "PRES_FECH_CANC=".$fldPRES_FECH.", USUA_LOGIN_CANC='".$login."'";
      $radijoin     = implode(",",$radicados);

      $sSQL     = "UPDATE
                    PRESTAMO    SET  ".$setFecha.",
                    PRES_ESTADO = 4
                  WHERE RADI_NUME_RADI IN ($radijoin)";

      $rs = $this->db->conn->query($sSQL);

      $sSqlChan = " UPDATE
                      SGD_SEXP_SECEXPEDIENTES
                      SET SGD_SEXP_PRESTAMO = FALSE
                    WHERE
                      SGD_EXP_NUMERO LIKE '$expediente'";

      $rs = $this->db->conn->query($sSqlChan);
    }


    /**
     * Modifica un Numero de radicado en un Expediete
     * Modifica un expediente y aÃ±ade un numero de radicado a este. Ademas inserta en el historico
     * La transcacion realizada, para esto verifica que el digito de Chequeo.
     *
     * @param $radicado int Contiene el numero de radicado a Buscar
     * @param  $usua_doc String Documento de identificacion de Usuario que realiza la insercion-
     * @param  $usua_codi String Codigo en Orfeo del Usuario que realiza la insercion-
     * @param  $depe_codi String Codigo en Orfeo de la dependencia del  Usuario que realiza la insercion.
     * @param  $radicado Numeric Numero de Radicado a Relacionar con el Expediente.
     * @param  $radicado String Numero de Expediente a Relacionar con el Radicado.
     *
     * @return Numero de Expediente que posee el radicado
     */
    function modificar_expediente($radicado, $num_expediente, $exp_titulo, $exp_asunto, $exp_ufisica, $exp_isla, $exp_caja, $exp_estante, $exp_carpeta, $exp_archivo, $exp_unicon, $exp_fechaIni, $exp_fechaFin) {

        $fecha_hoy = Date("Y-m-d");
        $sqlFechaHoy = $db->conn->DBDate($fecha_hoy);
        $query = "update sgd_exp_expediente set SGD_EXP_NUMERO='$num_expediente'
				,SGD_EXP_TITULO='$exp_titulo'
				,SGD_EXP_ASUNTO='$exp_asunto'
				,SGD_EXP_UFISICA='$exp_ufisica'
				,SGD_EXP_ISLA='$exp_isla'
				,SGD_EXP_CAJA='$exp_caja'
				,SGD_EXP_ESTANTE='$exp_estante'
				,SGD_EXP_CARPETA='$exp_carpeta'
				,SGD_EXP_ESTADO='1'
				,SGD_EXP_ARCHIVO='$exp_archivo'
				,SGD_EXP_UNICON='$exp_unicon'
				,SGD_EXP_FECH_ARCH=" . $sqlFechaHoy . "
				,SGD_EXP_FECH=" . $exp_fechaIni . "
				,SGD_EXP_FECHFIN=" . $exp_fechaFin . "
				WHERE RADI_NUME_RADI = $radicado
				";
        print $query;
        if (!$rs = $this->db->conn->query($query)) {
            echo '<br>Lo siento no pudo Actualizar los datos del expediente<br>';
        } else {

            echo "<br>Datos de expediente Grabados Correctamente<br>";
        }

    }

    function datos_expediente($radicado, $num_expediente) {
        $query = "select max(SGD_EXP_CARPETA) tt
				from sgd_exp_expediente
				WHERE
				SGD_EXP_NUMERO='$num_expediente'
				group by SGD_EXP_NUMERO ";
        $rs = $this->db->conn->query($query);
        if (!$rs) {
            echo 'No tiene un Numero de expediente<br>';
        } else {
            if ($rs)
                $this->exp_num_carpetas = $this->rs->fields['tt'];
        }
        $query = "select
				SGD_EXP_TITULO
				,SGD_EXP_ASUNTO
				,SGD_EXP_UFISICA
				,SGD_EXP_ISLA
				,SGD_EXP_CAJA
				,SGD_EXP_ESTANTE
				,SGD_EXP_CARPETA
				,SGD_EXP_ARCHIVO
				,SGD_EXP_UNICON
				,SGD_EXP_FECH
				,SGD_EXP_FECHFIN
				from sgd_exp_expediente
				WHERE
				SGD_EXP_NUMERO='$num_expediente'
				and SGD_EXP_ESTADO='1'
				";
        $rs = $this->db->conn->query($query);
        if ($rs) {

            $this->exp_titulo = "'" . $this->rs->fields['sgd_exp_titulo'] . "'";
            $this->exp_asunto = "'" . $this->rs->fields['sgd_exp_asunto'] . "'";
            $this->exp_ufisica = "'" . $this->rs->fields['sgd_exp_ufisica'] . "'";
            $this->exp_isla = $this->rs->fields['sgd_exp_isla'];
            $this->exp_caja = $this->rs->fields['sgd_exp_caja'];
            $this->exp_estante = $this->rs->fields['sgd_exp_estante'];
            $this->exp_carpeta = $this->rs->fields['sgd_exp_carpeta'];
            $this->exp_archivo = $this->rs->fields['sgd_exp_archivo'];
            $this->exp_unicon = $this->rs->fields['sgd_exp_unicon'];
            $this->exp_fechaIni = $this->rs->fields['SGD_EXP_FECH'];
            $this->exp_fechaFin = $this->rs->fields['SGD_EXP_FECHFIN'];


            return 1;
        } else {
            echo "<br>No se encontraron datos del expediente<br>";
            return 0;
        }
    }

    function consultaTipoExpediente($numExpediente) {
        $query = "select se.SGD_EXP_NUMERO
				, sb.SGD_SRD_CODIGO
				, sr.SGD_SRD_DESCRIP
				, sb.SGD_SBRD_CODIGO
				, sb.SGD_SBRD_DESCRIP
				, se.SGD_FEXP_CODIGO
				, se.SGD_SEXP_FECH
                , se.USUA_DOC_RESPONSABLE
                , se.SGD_PEXP_CODIGO
			from SGD_SEXP_SECEXPEDIENTES se
 				, SGD_SBRD_SUBSERIERD sb
				, SGD_SRD_SERIESRD sr
			WHERE
				SGD_EXP_NUMERO='$numExpediente'
				AND se.SGD_SRD_CODIGO=sr.SGD_SRD_CODIGO
				AND se.SGD_SRD_CODIGO=sb.SGD_SRD_CODIGO
				AND se.SGD_SBRD_CODIGO=sb.SGD_SBRD_CODIGO
			order by se.SGD_SEXP_FECH DESC
			";
        //		$cuentaEtapas=-1;
        $rs = $this->db->conn->query($query);
        $numExpediente = $rs->fields["SGD_EXP_NUMERO"];
        if ($numExpediente) {

            $this->db->conn->query($query);
            $this->descSerie = $rs->fields["SGD_SRD_DESCRIP"];
            $this->descSubSerie = $rs->fields["SGD_SBRD_DESCRIP"];
            $this->codiSRD = $rs->fields["SGD_SRD_CODIGO"];
            $this->codiSBRD = $rs->fields["SGD_SBRD_CODIGO"];
            $this->codigoFldExp = $rs->fields["SGD_FEXP_CODIGO"];
            $this->expFechaCrea = $rs->fields["SGD_SEXP_FECH"];
            $this->expUsuaDoc = $rs->fields["USUA_DOC_RESPONSABLE"];
            $this->codigoTipoExp = $rs->fields["SGD_PEXP_CODIGO"];

            /** EN ESTA CONSULTA TRAEMOS EL TIPO DE PROCESO
             */
            $query = "SELECT SGD_PEXP_DESCRIP
									,SGD_PEXP_CODIGO
									,SGD_PEXP_TERMINOS
									,SGD_PEXP_AUTOMATICO
									FROM SGD_PEXP_PROCEXPEDIENTES
									WHERE SGD_SRD_CODIGO= " . $this->codiSRD . "
									AND SGD_SBRD_CODIGO=" . $this->codiSBRD;
            if ($this->codigoTipoExp) {
                $query .= " and SGD_PEXP_CODIGO=" . $this->codigoTipoExp;
            }
            $rs = $this->db->conn->query($query);
            //$this->codigoTipoExp=$rs->fields["SGD_PEXP_CODIGO"];
            $this->descTipoExp = $rs->fields["SGD_PEXP_DESCRIP"];
            $this->expTerminos = $rs->fields["SGD_PEXP_TERMINOS"];
            $this->pAutomatico = $rs->fields['SGD_PEXP_AUTOMATICO'];
            /** EN ESTA CONSULTA TRAEMOS EL ESTADO DEL PROCESO
             */
            IF ($this->codigoFldExp != 0) {
                $query = "SELECT SGD_FEXP_DESCRIP
									, SGD_FEXP_CODIGO
									, SGD_FEXP_TERMINOS
									FROM SGD_FEXP_FLUJOEXPEDIENTES
									WHERE SGD_FEXP_CODIGO= " . $this->codigoFldExp . "";

                $rs = $this->db->conn->query($query);
                $cuentaEtapas = -1;
                $cuentaEtapas = $rs->FieldCount();
                //			die("Cuenta 1: $cuentaEtapas");
                //			die("Cuenta 1: " . $rs->FieldCount()  );
                if ($cuentaEtapas > 0) {
                    $this->codigoFldExp = $rs->fields["SGD_FEXP_CODIGO"];
                    $this->descFldExp = $rs->fields["SGD_FEXP_DESCRIP"];
                    $this->expTerminosP = $rs->fields["SGD_FEXP_TERMINOS"];
                } else {
                    $this->descFldExp = "El proceso a&uacute;n no tiene etapas.";
                }
            } else {
                $query = "SELECT SGD_FEXP_DESCRIP
                                                                        , SGD_FEXP_CODIGO
                                                                        , SGD_FEXP_TERMINOS
                                                                        FROM SGD_FEXP_FLUJOEXPEDIENTES
                                                                        WHERE SGD_PEXP_CODIGO= " . $this->codigoTipoExp . "
					ORDER BY SGD_FEXP_ORDEN ";

                $rs = $this->db->conn->query($query);
                $cuentaEtapas = -1;

                $cuentaEtapas = $rs->FieldCount();
                //            	die("Cuenta 2: " . $rs->FieldCount()  );

                if ($cuentaEtapas > 0) {
                    $this->codigoFldExp = $rs->fields["SGD_FEXP_CODIGO"];
                    $this->descFldExp = $rs->fields["SGD_FEXP_DESCRIP"];
                    $this->expTerminosP = $rs->fields["SGD_FEXP_TERMINOS"];
                } else {
                    $this->descFldExp = "El proceso a&uacute;n no tiene etapas.";
                }

            }
            return $numExpediente;;
        } else {
            return 0;
        }
    }

    /** Descripcion: FUNCION QUE CONSULTA EL TRD DEL EXPEDIENTE SEGUN PARAMETROS SERIE, SUBSERIE, PROCESO Y EXPEDIENTE
     *              Esta funcion devuelve los datos de serie, subserie y proceso asociados al expediente.
     * Parametros:
     *
     * @param $numExp String Numero del expediente.
     * @param $codiSrd int Codigo de la serie documental.
     * @param $codiSbrd int Codigo de la subserie documental.
     * @param $codiProc int Codigo del proceso.
     * Retorna:
     *
     * @return $arrTRDExp Arreglo con los datos de serie, subserie y proceso asociados al expediente.
     * Fecha de creacion: 13-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificaciï¿½n:
     * Modificador:
     */
    function getTRDExp($numExp, $codiSrd = '', $codiSbrd = '', $codiProc = '') {
        $q_TRDExp = "SELECT SRD.SGD_SRD_CODIGO, SRD.SGD_SRD_DESCRIP,";
        $q_TRDExp .= " SBRD.SGD_SBRD_CODIGO, SBRD.SGD_SBRD_DESCRIP,";
        $q_TRDExp .= " PEXP.SGD_PEXP_DESCRIP,";
        $q_TRDExp .= " PEXP.SGD_PEXP_TERMINOS,";
        $q_TRDExp .= " SEXP.SGD_SEXP_FECH,";
        $q_TRDExp .= " FEXP.SGD_FEXP_CODIGO, FEXP.SGD_FEXP_DESCRIP";
        $q_TRDExp .= " FROM SGD_SRD_SERIESRD SRD, SGD_SBRD_SUBSERIERD SBRD,";
        $q_TRDExp .= " SGD_PEXP_PROCEXPEDIENTES PEXP";
        $q_TRDExp .= " RIGHT JOIN SGD_SEXP_SECEXPEDIENTES SEXP";
        $q_TRDExp .= " ON SEXP.SGD_PEXP_CODIGO = PEXP.SGD_PEXP_CODIGO";
        $q_TRDExp .= " LEFT JOIN SGD_FEXP_FLUJOEXPEDIENTES FEXP";
        $q_TRDExp .= " ON SEXP.SGD_FEXP_CODIGO = FEXP.SGD_FEXP_CODIGO";
        $q_TRDExp .= " WHERE SEXP.SGD_SRD_CODIGO = SRD.SGD_SRD_CODIGO";
        $q_TRDExp .= " AND SEXP.SGD_SBRD_CODIGO = SBRD.SGD_SBRD_CODIGO";

        // $q_TRDExp .= " AND PEXP.SGD_SRD_CODIGO = SRD.SGD_SRD_CODIGO";
        // $q_TRDExp .= " AND PEXP.SGD_SBRD_CODIGO = SBRD.SGD_SBRD_CODIGO";

        $q_TRDExp .= " AND SRD.SGD_SRD_CODIGO = SBRD.SGD_SRD_CODIGO";
        if ($codiSrd != "") {
            $q_TRDExp .= " AND SRD.SGD_SRD_CODIGO = " . $codiSrd;
        }
        if ($codiSbrd != "") {
            $q_TRDExp .= " AND SBRD.SGD_SBRD_CODIGO = " . $codiSbrd;
        }
        if ($codiProc != "" && $codiProc != 0) {
            $q_TRDExp .= " AND PEXP.SGD_PEXP_CODIGO = " . $codiProc;
        }
        if ($numExp != "") {
            $q_TRDExp .= " AND SEXP.SGD_EXP_NUMERO = '" . $numExp . "'";
        }
        $q_TRDExp .= " ORDER BY SEXP.SGD_SEXP_FECH desc";
        $rs_TRDExp = $this->db->conn->query($q_TRDExp);
        $arrTRDExp['serie'] = $rs_TRDExp->fields['SGD_SRD_CODIGO'] . "-" . $rs_TRDExp->fields['SGD_SRD_DESCRIP'];
        $arrTRDExp['subserie'] = $rs_TRDExp->fields['SGD_SBRD_CODIGO'] . "-" . $rs_TRDExp->fields['SGD_SBRD_DESCRIP'];
        $arrTRDExp['proceso'] = $rs_TRDExp->fields['SGD_PEXP_DESCRIP'];
        $arrTRDExp['terminoProceso'] = $rs_TRDExp->fields['SGD_PEXP_TERMINOS'] . " Dias Calendario de Termino Total";
        $arrTRDExp['fecha'] = $rs_TRDExp->fields['SGD_SEXP_FECH'];
        $arrTRDExp['estado'] = $rs_TRDExp->fields['SGD_FEXP_DESCRIP'];

        return $arrTRDExp;
    }

    /** Descripcion: FUNCION QUE MODIFICA LAS ETIQUETAS DE UN EXPEDIENTE
     * Esta funcion devuelve la confirmacion o negacion de la accion.
     * Parametros:
     *
     * @param $numExp String Numero del expediente.
     * Retorna:
     * @return boolean confirma o niega la accion realizada.
     */
    function editDatosParamExp($numExp, $params) {

        $q_datosParametro = "UPDATE sgd_sexp_secexpedientes SET ";

        foreach ($params as $clave => $valor){
           $campo = $clave + 1;
           if(empty($descrip)){
               $descrip .= "sgd_sexp_parexp".$campo. " = '$valor'";
           }else{
               $descrip .= ", sgd_sexp_parexp".$campo . " = '$valor'" ;
           }
        }

        if(!empty($descrip)){
            $q_datosParametro .= $descrip . " WHERE sgd_exp_numero = '$numExp'";
        };

        if ($this->db->conn->query($q_datosParametro) === false) {
            return false;
        }
        return true;
    }



    /** Descripcion: FUNCION QUE CONSULTA LOS PARAMETROS ASIGANDOS A UN EXPEDIENTE
     * Esta funcion devuelve las etiquetas y los valores asociados a un expediente.
     * Parametros:
     *
     * @param $numExp String Numero del expediente.
     * @param $depeCodi int Codigo de la dependencia.
     * Retorna:
     *
     * @return $arrDatosParam Arreglo con la etiqueta y los datos de los parï¿½metros.
     * Fecha de creaciï¿½n: 13-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function getDatosParamExp($numExp, $depeCodi){

         $this->db->limit(5);
         $limitMsql = $this->db->limitMsql;
         $limitOci8 = $this->db->limitOci8;
         $limitPsql = $this->db->limitPsql;

        $depeExp = substr($numExp, 4, 3);
        $q_datosParametro = "SELECT  $limitMsql CASE WHEN PAREXP.SGD_PAREXP_ORDEN = 1 THEN SEXP.SGD_SEXP_PAREXP1
         WHEN PAREXP.SGD_PAREXP_ORDEN = 2 THEN SEXP.SGD_SEXP_PAREXP2
         WHEN PAREXP.SGD_PAREXP_ORDEN = 3 THEN SEXP.SGD_SEXP_PAREXP3
         WHEN PAREXP.SGD_PAREXP_ORDEN = 4 THEN SEXP.SGD_SEXP_PAREXP4
         WHEN PAREXP.SGD_PAREXP_ORDEN = 5 THEN SEXP.SGD_SEXP_PAREXP5
         WHEN PAREXP.SGD_PAREXP_ORDEN = 6 THEN SEXP.SGD_SEXP_PAREXP6
         WHEN PAREXP.SGD_PAREXP_ORDEN = 7 THEN SEXP.SGD_SEXP_PAREXP7
         WHEN PAREXP.SGD_PAREXP_ORDEN = 8 THEN SEXP.SGD_SEXP_PAREXP8
         WHEN PAREXP.SGD_PAREXP_ORDEN = 9 THEN SEXP.SGD_SEXP_PAREXP9
         WHEN PAREXP.SGD_PAREXP_ORDEN = 0 THEN SEXP.SGD_SEXP_PAREXP10
         END AS PARAMETRO,
         PAREXP.SGD_PAREXP_ETIQUETA
         FROM SGD_SEXP_SECEXPEDIENTES SEXP,
         SGD_PAREXP_PARAMEXPEDIENTE PAREXP
         WHERE SEXP.SGD_EXP_NUMERO = '$numExp'
         AND parexp.DEPE_CODI = '$depeExp' $limitOci8
         ORDER BY SEXP.SGD_SEXP_FECH desc $limitPsql";
         #$db->conn->debug=true;
         #echo "<pre>$q_datosParametro</pre>"; exit;
         $rs_datosParametro = $this->db->conn->query($q_datosParametro);

        $p = 0;
        while (!$rs_datosParametro->EOF) {
            $arrDatosPar[$p]['etiqueta'] = $rs_datosParametro->fields['SGD_PAREXP_ETIQUETA'];
            $arrDatosPar[$p]['parametro'] = $rs_datosParametro->fields['PARAMETRO'];
            $p++;
            $rs_datosParametro->MoveNext();
        }

        return $arrDatosPar;
    }

    /** FUNCION EXISTE EXPEDIENTE
     * Determina si existe o no el expediente al cual se le va a incluir el radicado.
     *
     * @param $numExpediente String Numero de Expediente a buscar.
     *
     * @return 0 si no existe el Expediente y el nï¿½mero del Expediente en caso contrario.
     * Fecha de creacion: 21-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function existeExpediente($numExpediente) {
        $query = "SELECT SGD_EXP_NUMERO";
        $query .= " FROM SGD_SEXP_SECEXPEDIENTES";
        $query .= " WHERE SGD_EXP_NUMERO = '" . $numExpediente . "'";

        $rs = $this->db->conn->query($query);
        if ($rs->EOF) {
            $q_exp_expediente = "SELECT SGD_EXP_NUMERO";
            $q_exp_expediente .= " FROM SGD_EXP_EXPEDIENTE";
            $q_exp_expediente .= " WHERE SGD_EXP_NUMERO = '" . $numExpediente . "'";

            $rs_exp_expediente = $this->db->conn->query($q_exp_expediente);
            if ($rs_exp_expediente->EOF) {
                $this->num_expediente = 0;
            } else {
                $this->num_expediente = $rs_exp_expediente->fields['SGD_EXP_NUMERO'];
            }
        } else {
            $this->num_expediente = $rs->fields['SGD_EXP_NUMERO'];
        }
        return $this->num_expediente;
    }

    /** FUNCION EXPEDIENTES RADICADO
     * Busca los expedientes a los que pertenece un radicado.
     *
     * @param $radicado int Contiene el numero de radicado a Buscar
     *
     * @return Arreglo con los Nombres de Expediente a los que pertenece el radicado
     * Fecha de creaciï¿½n: 21-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function expedientesRadicado($radicado) {
        $query = " SELECT SGD_EXP_NUMERO";
        $query .= " FROM SGD_EXP_EXPEDIENTE";
        $query .= "	WHERE RADI_NUME_RADI = " . $radicado;
        $query .= " AND SGD_EXP_ESTADO <> 2";
        $rs = $this->db->conn->query($query);
        $arrExpedientes = array();
        while ($rs && !$rs->EOF) {
            $arrExpedientes[] = $rs->fields['SGD_EXP_NUMERO'];
            $rs->MoveNext();
        }

        return $arrExpedientes;
    }

    /** FUNCION EXPEDIENTE ARCHIVADO
     * Busca los datos de archivo de un radicado.
     *
     * @param $radicado int Numero del radicado incluido en el expediente a buscar.
     * @param $numExpediente int Numero del expediente a buscar.
     *
     * @return Arreglo con los datos de archivo del Expediente.
     * Fecha de creacion: 21-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function expedienteArchivado($radicado, $numExpediente) {
        $query = "SELECT SGD_EXP_ESTADO, SGD_EXP_TITULO, SGD_EXP_ASUNTO,";
        $query .= " SGD_EXP_CARPETA, SGD_EXP_UFISICA, SGD_EXP_ISLA,";
        $query .= " SGD_EXP_ESTANTE, SGD_EXP_CAJA, SGD_EXP_FECH_ARCH";
        $query .= " FROM SGD_EXP_EXPEDIENTE";
        $query .= "	WHERE RADI_NUME_RADI = '" . $radicado . "'";
        $query .= " AND SGD_EXP_NUMERO = '" . $numExpediente . "'";

        $rs = $this->db->conn->query($query);
        if (!$rs->EOF) {
            $arrExpArchivo['estado'] = $rs->fields['SGD_EXP_ESTADO'];
            $arrExpArchivo['titulo'] = $rs->fields['SGD_EXP_TITULO'];
            $arrExpArchivo['asunto'] = $rs->fields['SGD_EXP_ASUNTO'];
            $arrExpArchivo['carpeta'] = $rs->fields['SGD_EXP_CARPETA'];
            $arrExpArchivo['uFisica'] = $rs->fields['SGD_EXP_UFISICA'];
            $arrExpArchivo['isla'] = $rs->fields['SGD_EXP_ISLA'];
            $arrExpArchivo['estante'] = $rs->fields['SGD_EXP_ESTANTE'];
            $arrExpArchivo['caja'] = $rs->fields['SGD_EXP_CAJA'];
            $arrExpArchivo['fArchivo'] = $rs->fields['SGD_EXP_FECH_ARCH'];

            $this->estado_expediente = $arrExpArchivo['estado'];
        }

        return $arrExpArchivo;
    }

    /**
     * FUNCION EXCLUIR EXPEDIENTE
     * Excluye un Numero de radicado de un Expediete
     *
     * @param  $radicado int Contiene el numero de radicado a Buscar
     * @param  $numExpediente String Numero del Expediente del que se desea excluir el radicado.
     *
     * @return 1 si el radicado fue excluido del expediente y 0 en caso contrario.
     * Fecha de creacion: 23-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function excluirExpediente($radicado, $numExpediente) {
        $query = "UPDATE SGD_EXP_EXPEDIENTE";
        $query .= " SET SGD_EXP_ESTADO = 2";
        $query .= " WHERE SGD_EXP_NUMERO = '" . $numExpediente . "'";
        $query .= " AND RADI_NUME_RADI = '" . $radicado . "'";
        // print $query;

        if ($this->db->conn->query($query)) {
            $excluido = 1;
        } else {
            $excluido = 0;
        }

        return $excluido;
    }

    /**
     * FUNCION RADICADO PADRE, ANEXOS y ASOCIADOS
     * Consulta el radicado padre, los anexos y los asociados de un radicado
     *
     * @param  $radicado int Contiene el numero de radicado a Buscar
     *
     * @return arrAnexoAsociado Arreglo con el radicado padre, los anexos y los asociados del radicado.
     * Fecha de creacion: 27-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function expedienteAnexoAsociado($radicado) {

        $query = 'SELECT RAD.RADI_NUME_DERI AS "RADPADRE", RAD.SGD_SPUB_CODIGO AS "PRIVADO",';
        $query .= ' CASE WHEN RAD.RADI_TIPO_DERI = 0 THEN RAD.RADI_NUME_RADI';
        $query .= ' END AS "ANEXO",';
        $query .= ' CASE WHEN RAD.RADI_TIPO_DERI = 2 THEN RAD.RADI_NUME_RADI';
        $query .= ' END AS "ASOCIADO",';
        $query .= ' RAD.RADI_FECH_RADI, RAD.RADI_PATH, TPR.SGD_TPR_DESCRIP, RAD.RA_ASUN';
        $query .= ' FROM RADICADO RAD';
        $query .= ' LEFT JOIN SGD_TPR_TPDCUMENTO TPR ON TPR.SGD_TPR_CODIGO = RAD.TDOC_CODI';
        $query .= ' WHERE 1 = 1';
        $query .= ' AND ( RAD.RADI_NUME_DERI = ' . $radicado;
        $query .= ' OR ( RAD.RADI_NUME_RADI = ' . $radicado;
        $query .= ' AND RAD.RADI_NUME_DERI IS NOT NULL';
        $query .= ' AND RAD.RADI_TIPO_DERI = 0 )';
        $query .= ' )';
        $query .= ' AND RADI_TIPO_DERI <> 1';
        $query .= ' AND RAD.RADI_NUME_RADI NOT IN (';
        $query .= '   SELECT EXP.RADI_NUME_RADI FROM SGD_EXP_EXPEDIENTE EXP WHERE EXP.RADI_NUME_RADI <> ' . $radicado;
        $query .= ' )';
        $query .= ' AND RAD.RADI_NUME_DERI NOT IN (';
        $query .= '   SELECT EXP.RADI_NUME_RADI FROM SGD_EXP_EXPEDIENTE EXP WHERE EXP.RADI_NUME_RADI <> ' . $radicado;
        $query .= ' )';
        $query .= ' AND RAD.RADI_NUME_RADI NOT IN (';
        $query .= '   SELECT RADI_NUME_SALIDA FROM ANEXOS';
        $query .= '   WHERE ANEX_RADI_NUME = ' . $radicado;
        $query .= '   AND RADI_NUME_SALIDA <> ' . $radicado;
        $query .= ' )';
        // print $query;

        $rs = $this->db->conn->query($query);
        $a = 0;
        while (!$rs->EOF) {
            $arrAnexoAsociado[$a]['radPadre'] = $rs->fields['RADPADRE'];
            $arrAnexoAsociado[$a]['anexo'] = $rs->fields['ANEXO'];
            $arrAnexoAsociado[$a]['asociado'] = $rs->fields['ASOCIADO'];
            $arrAnexoAsociado[$a]['fechaRadicacion'] = $rs->fields['RADI_FECH_RADI'];
            $arrAnexoAsociado[$a]['ruta'] = $rs->fields['RADI_PATH'];
            $arrAnexoAsociado[$a]['tipoDocumento'] = $rs->fields['SGD_TPR_DESCRIP'];
            $arrAnexoAsociado[$a]['asunto'] = $rs->fields['RA_ASUN'];
            $arrAnexoAsociado[$a]['privado'] = $rs->fields['PRIVADO'];
            $a++;
            $rs->MoveNext();
        }

        return $arrAnexoAsociado;
    }

    /**
     * FUNCION GRABAR SUBEXPEDIENTE
     * Almacena el numero del subexpediente asociado a un expediente y a un radicado.
     *
     * @param  $radicado int Contiene el numero de radicado
     * @param  $numExpediente int Contiene el nï¿½mero del expediente
     * @param  $numSubexpediente int Contiene el nï¿½mero del Subexpediente
     *
     * @return 1 si se grabo correctamente el subexpediente y 0 en caso contrario.
     * Fecha de creacion: 29-Junio-2006
     * Creador: Supersolidaria
     * Fecha de modificacion:
     * Modificador:
     */
    function grabarSubexpediente($radicado, $numExpediente, $Subexpediente) {
        $query = "UPDATE SGD_EXP_EXPEDIENTE";
        $query .= " SET SGD_EXP_SUBEXPEDIENTE = " . $Subexpediente;
        $query .= " WHERE SGD_EXP_NUMERO = '" . $numExpediente . "'";
        $query .= " AND RADI_NUME_RADI = '" . $radicado . "'";
        // print $query;

        if ($this->db->conn->query($query)) {
            $grabado = 1;
        } else {
            $grabado = 0;
        }

        return $grabado;
    }
}

?>
