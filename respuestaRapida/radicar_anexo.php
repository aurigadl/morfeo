<?php
  require_once($ruta_raiz."/config.php");
  require_once($ruta_raiz."/include/db/ConnectionHandler.php");
  include_once($ruta_raiz."/class_control/AplIntegrada.php");
  include_once($ruta_raiz."/class_control/anexo.php");
  include_once($ruta_raiz."/class_control/anex_tipo.php");
  include_once($ruta_raiz."/include/tx/Tx.php");
  include_once($ruta_raiz."/include/tx/Radicacion.php");
  include_once($ruta_raiz."/class_control/Municipio.php");
  include_once($ruta_raiz."/include/PHPMailer_v5.1/class.phpmailer.php");
  require_once($ruta_raiz."/tcpdf/config/lang/eng.php");
  require_once($ruta_raiz."/conf/configPHPMailer.php");
  require_once($ruta_raiz."/tcpdf/tcpdf.php");

  $db      = new ConnectionHandler($ruta_raiz);
  $hist    = new Historico($db);
  $Tx      = new Tx($db);
  
  $anexo   = $_POST['anexo'];
  
  $archivo_txt    = $anexo . '.txt';
  $archivo_grabar_txt = $directorio . $archivo_txt;
  $file_content   = fopen($archivo_grabar_txt, 'w');
  $write_result   = fwrite($file_content, $respuesta);
  $closing_result = fclose($file_content);
  
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
  $sqlFechaHoy      = $db->conn->OffsetDate(0, $db->conn->sysTimeStamp);
  $numRadicadoPadre = $_POST["radPadre"];

  $tamanoMax      = 7 * 1024 * 1024; // 7 megabytes
  $fechaGrab      = trim($date1);
  $numramdon      = rand (0,100000);
  $contador       = 0;
  $regFile        = array();
  $conCopiaA      = '';
  $enviadoA       = '';
  $cCopOcu        = '';

  $ddate          = date('d');
  $mdate          = date('m');
  $adate          = date('Y');
  $fechproc4      = substr($adate, 2, 4);
  $fecha1         = time();
  $fecha          = fechaFormateada($fecha1);
  $tdoc           = NO_DEFINIDO; 
  $tipo_radicado  = (isset($_POST['tipo_radicado']))? $_POST['tipo_radicado'] : null;
  $pais           = 170; //OK, codigo pais
  $cont           = 1; //id del continente
  $radicado_rem   = 7;
  $auxnumero      = str_pad($auxnumero, 5, "0", STR_PAD_LEFT);
  $tipo           = ARCHIVO_PDF;
  $tamano         = 1000;
  $auxsololect    = 'N';
  $radicado_rem   = 1;
  $descr          = 'Pdf respuesta';
  $fechrd         = $ddate.$mdate.$fechproc4;
  $coddepe        = $_SESSION["dependencia"] * 1 ;
  $usua_actu      = $_SESSION["codusuario"];
  $usua           = $_SESSION["krd"];
  $codigoCiu      = $_SESSION["usua_doc"];
  $ln             = $_SESSION["digitosDependencia"];

  $usMailSelect   = $_POST['usMailSelect']; //correo del emisor de la respuesta
  $destinat       = $_POST["destinatario"]; //correos de los destinanexnexnexnexnexnexnextarios
  $correocopia    = $_POST["concopia"]; //destinatarios con copia
  $conCopOcul     = $_POST["concopiaOculta"]; //con copia oculta
  $anexHtml       = $_POST["anexHtml"]; //con copia oculta
  $docAnex        = $_POST["docAnex"]; //con copia oculta
  $medioRadicar   = $_POST["medioRadicar"]; //con copia oculta

  $asu            = $_POST["respuesta"];

  $tpDepeRad      = $coddepe;
  $radUsuaDoc     = $codigoCiu;
  $usua_doc       = $_SESSION["usua_doc"];
  $usuario        = $_SESSION["usua_nomb"];
  $setAutor       = 'Sistema de Gestion Documental Orfeo';
  $SetTitle       = 'Respuesta a solicitud';
  $SetSubject     = 'Metrovivienda';
  $SetKeywords    = 'metrovivienda, respuesta, salida, generar';

  //DATOS EMPRESA
  $sigla          = 'null';
  $iden           = $db->conn->nextId("sec_ciu_ciudadano");//uniqe key

  //ENLACE DEL ANEXO
  $radano = substr($numRadicadoPadre,0,4);
  $ruta   = $anexo . '.pdf';

  $desti = "SELECT
              s.sgd_dir_nomremdes,
              s.sgd_dir_direccion,
              s.sgd_dir_tipo,
              s.sgd_dir_mail,
              s.sgd_dir_telefono,
              s.sgd_sec_codigo,
              r.depe_codi,
              r.radi_path
          FROM
              SGD_DIR_DRECCIONES s,
              RADICADO r
          WHERE
              r.RADI_NUME_RADI     = $numRadicadoPadre
              AND s.RADI_NUME_RADI = r.RADI_NUME_RADI";

  $rssPatth       = $db->conn->Execute($desti);
  
  $dir_nombre     = $rssPatth->fields["sgd_dir_nomremdes"];
  $dir_tipo       = $rssPatth->fields["sgd_dir_tipo"];
  $dir_mail       = $rssPatth->fields["sgd_dir_mail"];
  $dir_telefono   = $rssPatth->fields["sgd_dir_telefono"];
  $dir_direccion  = $rssPatth->fields["sgd_dir_direccion"];
  $pathPadre      = $rssPatth->fields["radi_path"];

  $digitosDependencia = ($digitosDependencia >= 4)? 3 : $digitosDependencia;
  $depCreadora    = substr($numRadicadoPadre, 4, $digitosDependencia);

  $ruta2  = "/bodega/$radano/$depCreadora/docs/".$ruta;
  $ruta3  = "/$radano/$depCreadora/docs/".$ruta;

// CREACION DEL RADICADO RESPUESTA
  //Para crear el numero de radicado se realiza el siguiente procedimiento
  $isql_consec = "SELECT
                      DEPE_RAD_TP$tipo_radicado as secuencia
                  FROM
                      DEPENDENCIA
                  WHERE
                      DEPE_CODI = $tpDepeRad";

  $creaNoRad   = $db->conn->Execute($isql_consec);
  $tpDepeRad   = $creaNoRad->fields["secuencia"];

  $rad = new Radicacion($db);
  $rad->radiTipoDeri  = 0;        // ok ????
  $rad->radiCuentai   = 'null';   // ok, Cuenta Interna, Oficio, Referencia
  $rad->eespCodi      = $iden;    //codigo emepresa de servicios publicos bodega
  $rad->mrecCodi      = 3;        // medio de correspondencia, 3 internet
  $rad->radiFechOfic  = "$ddate/$mdate/$adate"; // igual fecha radicado;
  $rad->radiNumeDeri  = $numRadicadoPadre; //ok, radicado padre
  $rad->radiPais      = $pais;    //OK, codigo pais
  $rad->descAnex      = '.';      //OK anexos
  $rad->raAsun        = "Respuesta al radicado " . $numRadicadoPadre; // ok asunto
  $rad->radiDepeActu  = $coddepe;   // ok dependencia actual responsable
  $rad->radiUsuaActu  = $usua_actu; // ok usuario actual responsable
  $rad->radiDepeRadi  = $coddepe;   //ok dependencia que radica
  $rad->usuaCodi      = $usua_actu; // ok usuario actual responsable
  $rad->dependencia   = $coddepe;   //ok dependencia que radica
  $rad->trteCodi      =  0;         //ok, tipo de codigo de remitente
  $rad->tdocCodi      = $tdoc;      //ok, tipo documental
  $rad->tdidCodi      = 0;          //ok, ????
  $rad->carpCodi      = 1;          //ok, carpeta entradas
  $rad->carPer        = 0;          //ok, carpeta personal
  $rad->ra_asun       = "Respuesta al radicado " . $numRadicadoPadre;
  $rad->radiPath      = 'null';
  $rad->sgd_apli_codi = '0';
  $rad->usuaDoc       = $radUsuaDoc;
  $codTx              = 62;

  $nurad = $rad->newRadicado($tipo_radicado, $tpDepeRad);

  if ($nurad=="-1"){
    header("Location: salidaRespuesta.php?$encabe&error=1");
      die;
  }

  //datos para guardar los anexos en la carpeta del nuevo radicado
  $primerno  = substr($nurad, 0, 4);
  $segundono = $_SESSION["dependencia"];
  $ruta1     = $primerno . "/" . $segundono . "/docs/";
  $adjuntos  = 'bodega/'.$ruta1;

  $nextval   = $db->nextId("sec_dir_direcciones");
  //se buscan los datos del radicado padre y se
  //insertaran en los del radicado hijo

  $isql = "insert into SGD_DIR_DRECCIONES(
                              SGD_TRD_CODIGO,
                              SGD_DIR_NOMREMDES,
                              SGD_DIR_DOC,
                              DPTO_CODI,
                              MUNI_CODI,
                              id_pais,
                              id_cont,
                              SGD_DOC_FUN,
                              SGD_OEM_CODIGO,
                              SGD_CIU_CODIGO,
                              SGD_ESP_CODI,
                              RADI_NUME_RADI,
                              SGD_SEC_CODIGO,
                              SGD_DIR_DIRECCION,
                              SGD_DIR_TELEFONO,
                              SGD_DIR_MAIL,
                              SGD_DIR_TIPO,
                              SGD_DIR_CODIGO,
                              SGD_DIR_NOMBRE)
                      values( 1,
                              '$dir_nombre',
                              NULL,
                              11,
                              1,
                              170,
                              1,
                              '$usua_doc',
                              NULL,
                              NULL,
                              NULL,
                              $nurad,
                              0,
                              '$dir_direccion',
                              '$dir_telefono',
                              '$dir_mail',
                              1,
                              $nextval,
                              '$dir_nombre')";

  $rsg               = $db->conn->Execute($isql);

  $mensajeHistorico  = "Se envia respuesta rapida";

  if(!empty($regFile)) {
    $mensajeHistorico .= ", con archivos adjuntos";
  }

  //inserta el evento del radicado padre.
  $radicadosSel[0] = $numRadicadoPadre;

  $hist->insertarHistorico($radicadosSel,
                            $coddepe,
                            $usua_actu,
                            $coddepe,
                            $usua_actu,
                            $mensajeHistorico,
                            $codTx);

  //Inserta el evento del radicado de respuesta nuevo.
  $radicadosSel[0] = $nurad;
  
  $hist->insertarHistorico($radicadosSel,
                            $coddepe,
                            $usua_actu,
                            $coddepe,
                            $usua_actu,
                            "",
                            2);

  //Agregar un nuevo evento en el historico para que
  //muestre como contestado y no genere alarmas.
  //A la respuesta se le agrega el siguiente evento
  $hist->insertarHistorico($radicadosSel,
                            $coddepe,
                            $usua_actu,
                            $coddepe,
                            $usua_actu,
                            "Imagen asociada desde respuesta rapida",
                            42);

// REMPLAZAR DATOS EN EL ASUNTO
  // Extend the TCPDF class to create custom Header and Footer
  class MYPDF extends TCPDF {

    //Page header
    public function Header() {
      // Logo
      $this->Image('../img/banerPDF.JPG',
                    30,
                    10,
                    167,
                    '',
                    'JPG',
                    '',
                    'T',
                    false,
                    300,
                    '',
                    false,
                    false,
                    0,
                    false,
                    false,
                    false);
    }

    // Page footer
    public function Footer() {
      // Position at 15 mm from bottom
      $this->SetY(-20);
      // Page number
      include '../config.php';

      $txt = "<div align='center'> $entidad_dir Contacto: $entidad_tel";
      $this->writeHTMLCell($w = 0,
                            $h = 3,
                            $x = '32',
                            $y='',
                            $txt,
                            $border = 0,
                            $ln = 1,
                            $fill = 0,
                            $reseth = true);
    }
  }

  // create new PDF document
  $pdf = new MYPDF('P', PDF_UNIT, 'LETTER', true, 'UTF-8', false);

  // set document information
  $pdf->SetCreator(PDF_CREATOR);
  $pdf->SetAuthor($setAutor);
  $pdf->SetTitle($SetTitle);
  $pdf->SetSubject($SetSubject);
  $pdf->SetKeywords($SetKeywords);

  // set default header data
  $pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);

  // set header and footer fonts
  $pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
  $pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));

  // set default monospaced font
  $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

  //set margins
  $pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
  $pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
  $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

  //set auto page breaks
  $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

  //set image scale factor
  $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

  //set some language-dependent strings
  $pdf->setLanguageArray($l);

  // set default font subsetting mode
  $pdf->setFontSubsetting(true);

  // Add a page
  // This method has several options, check the source code documentation for more information.
  $pdf->AddPage();

  // output the HTML content
  $pdf->writeHTML($asu, true, false, true, false, '');

  // Close and output PDF document
  // This method has several options, check the source code documentation for more information.
  $pdf->Output($ruta_raiz.$ruta2, 'F');

  $sqlE = "UPDATE
              RADICADO
           SET
              RADI_PATH = '$ruta3'
           WHERE
              RADI_NUME_RADI = $nurad";

  $db->conn->Execute($sqlE);

  $actualizar_anexo = "UPDATE ANEXOS
                          SET RADI_NUME_SALIDA = '$nurad'
                          WHERE ANEX_CODIGO = '$anexo'";

  $db->conn->Execute($actualizar_anexo);

  $isqlDepR = "SELECT RADI_DEPE_ACTU,
                      RADI_USUA_ACTU
                  FROM RADICADO
                  WHERE RADI_NUME_RADI = '$nurad'";

  $rsDepR = $db->conn->Execute($isqlDepR);

  $coddepe = $rsDepR->fields['RADI_DEPE_ACTU'];
  $codusua = $rsDepR->fields['RADI_USUA_ACTU'];
?>
