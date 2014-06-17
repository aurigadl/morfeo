<?php
  require '../tcpdf/config/lang/eng.php';
  require '../tcpdf/tcpdf.php';
  require '../config.php';
  
  define ('AUTOR_PDF', 'Sistema de Gesti&oacute;n Documental Caliope');
  define ('TITULO_PDF', 'Respuesta a solicitud');
  define ('ASUNTO_PDF', 'Metrovivienda');
  define ('KEYWORDS_PDF', 'metrovivienda, respuesta, salida, generar');
  define ('IMAGEN_PDF', '../img/banerPDF.JPG');
  define ('ENTIDAD_DIR', $entidad_dir);
  define ('ENTIDAD_TEL', $entidad_tel);


  // Extend the TCPDF class to create custom Header and Footer
  class MYPDF extends TCPDF {
    //Page header
    public function Header() {
      // Logo
      $this->Image(LOGO_METROVIVIENDA,
                    100,
                    10,
                    25,
                    0,
                    'png',
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
      
      $this->Image(PIE_METROVIVIENDA,
                    25,
                    250,
                    167,
                    '',
                    'png',
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
    }
  }

  // create new PDF document
  $pdf = new MYPDF('P', PDF_UNIT, 'LETTER', true, 'UTF-8', false);

  // set document information
  $pdf->SetCreator(PDF_CREATOR);
  $pdf->SetAuthor(AUTOR_PDF);
  $pdf->SetTitle(TITULO_PDF);
  $pdf->SetSubject(ASUNTO_PDF);
  $pdf->SetKeywords(KEYWORDS_PDF);

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
  $pdf->writeHTML($respuesta, true, false, true, false, '');

  // Close and output PDF document
  // This method has several options, check the source code documentation for more information.
  $pdf_result = $pdf->Output($archivo_grabar, 'F');
?>
