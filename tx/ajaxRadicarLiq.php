<?php
session_start();
 $_SESSION["dependencia"]=900;
 $_SESSION["codusuario"]=1;
 
  include '../config.php';
  include '../include/db/ConnectionHandler.php';
 $_SESSION['digitosDependencia']=$digitosDependencia ; 
  session_start();
  $tipoAnexo[1] = "Certificado de Tradición y Libertad."; 
  $tipoAnexo[2] = "Certificado Catastral vigente";
  $tipoAnexo[3] = "Certificado de Existencia y Representación ";
  $tipoAnexo[4] = "Cédula de Ciudadanía del Titular de la licencia";
  $tipoAnexo[5] = "Certificación de la Curaduría Urbana";
  $tipoAnexo[6] = "Poder";
  $ruta_raiz  = '..';
  include '../include/tx/Radicacion.php';
  include '../class_control/anexo.php';
  
  $codCarpeta = $_POST["codCarpeta"];
  $dato       = substr($codCarpeta,0,2);
  $rads       = $_POST["rads"];

  foreach ($_GET as $key => $valor)   ${$key} = $valor;
  foreach ($_POST as $key => $valor)   ${$key} = $valor;

  $db = new ConnectionHandler($ruta_raiz);
  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);

  
  $anexo = new Anexo ($db);
  $carpetaPersonal = ($dato == 11)? 1 : 0;
  
  $carpetaDestino = substr($codCarpeta,1,5);
  
  //  changeFolder( $radicados, $usuaLogin,$carpetaDestino,$carpetaTipo,$tomarNivel,$observa)
  $dependencia =900;
  $codusuario =1;

  $rad = new Radicacion($db);
   $rad->radiTipoDeri = 0;
   $rad->radiCuentai  = "";
   $rad->eespCodi     = 0;
   $rad->mrecCodi     = 1; // "dd/mm/aaaa"
   if(!$radicadopadre)  $radicadopadre = null;

   $rad->radiNumeDeri = trim($radicadopadre);
   $rad->radiPais     = 170;
   $rad->descAnex     = "";
   $rad->radiDepeActu = "900";
   $rad->radiDepeRadi = "900";
   $rad->usuaCodi     = 1;
   $rad->radiUsuaActu = 1;
   $rad->radiUsuaRadi = 1;
   $rad->trteCodi     = 0;
   $rad->tdocCodi     = 0;
   $rad->nofolios     = 1;
   $rad->noanexos     = 5;
   $rad->tdidCodi     = 0;
   $rad->carpCodi     = 9;
   $rad->carPer       = 1;
   $rad->trteCodi     = 0;
   $rad->raAsun       = "Liquidacion VIP/VIS";
   
   $pData = "";
   
   $numeroRadicado =  $rad->newRadicado("9","900");
   $codigoverificacion = $rad->codigoverificacion;
   $rand = rand(1000,9999);
   $pathRadicado = "/".date("Y")."/" . $dependencia . "/". $numeroRadicado ."_".$rand.".pdf"; 
   $rad->radiPath = $pathRadicado;
   $rad->updateRadicado($numeroRadicado);
   
   $rad->trdCodigo = 0;
   $rad->grbNombresUs =  $sFname;
   // $this->ccDocumento) $record['SGD_DIR_DOC']    = $this->ccDocumento;
   $rad->muniCodi = $sCodMuni;
   $rad->dpto_tmp1 = $sCodDpto;
   $rad->idgplis = 170;
   $rad->idCont = 1;
   $rad->funCodigo = 0;
   $rad->oemCodigo = 0;
   $rad->espCodigo = 0;
    //$record['SGD_SEC_CODIGO'] = 0;
   $rad->direccion = $sAddress;
   $rad->dirTelefono = $sPhone1 . " - " .$sPhone2;
   $rad->dirMail =$sEmail;
   $rad->dirTipo = $dirTipo;
   $rad->dirCodigo =  $dirCodigo;
   $rad->dirNombre = $sNombre;
   
  // TRD 
  $pathAnexos =  substr($numeroRadicado,0,4) . "/" . substr($numeroRadicado, 4,3). "/docs/" ; 
  //echo "<hr>$i)  $pathAnexos (".$tipoAnexo[$i].")<hr>";
  $countAnexos=1;
  
  for($i=1;$i<=6;$i++){
  $nFile = $_POST["f".$i];
  if($nFile) {
   $ext = end(explode('.',$nFile));
   $fileNew = $numeroRadicado . "_". str_pad($countAnexos , 5 , "0", STR_PAD_LEFT) .".".$ext;
   $pathNew = $pathAnexos . "" . $fileNew;
   $vSha1 = sha1_file("../bodega/tmp/$nFile");
   $files .= $countAnexos.") ".substr($nFile,6,40)." - <b>".$tipoAnexo[$i]."</b> ($vSha1)</br>";
   $anexo->anex_radi_nume = $numeroRadicado;
   
   $anexo->anex_creador= "'ADMON'";
   $anexo->anex_depe_creador= "999";
   $anexo->anex_nomb_archivo= $fileNew;
   $anexo->anex_solo_lectra = "S";
   $anexo->anex_desc = $tipoAnexo[$i]."<br> (".substr($nFile,7,40).")";
   $anexo->anexSha1 = $vSha1;
   
   $anexo->anexarFilaRadicado();
   //$comando ="cp ../bodega/tmp/$nFile  ../bodega/$pathNew <br>";
   $fileOld = "../bodega/tmp/$nFile";
   $fileNew1 = "../bodega/$pathNew";
   // Copia los archivos a lugar de anexos del radicado / bodega / Dependnecia / año / docs
   
   if (!copy($fileOld, $fileNew1)) {
    echo "Falla Anexando $fileOld...\n";
   }
   
   $countAnexos++;
  }
  }

   
   $rnd = rand(1000,9999);

   
  //  convert    p.ps -crop 210x600+2+735 +repage pp.png
   $pathFileBarras = 'bar'.$numeroRadicado.'.png';
   $pathFileQr = "qr".$numeroRadicado.".png";
   $pathImgBarras2 = "../bodega/tmp/bar".$numeroRadicado.".ps";
   $pathImgBarras = "../bodega/tmp/$pathFileBarras";
   $pathImgQr = "../bodega/tmp/$pathFileBarras";
   
   $datos = "http://200.69.119.84/mtvLiquidacion/ct=$numeroRadicado&codV=$codigoverificacion&chip=$chip&valO=$valorO";
   $comando = " qrencode $datos -o $pathFileQr";
   shell_exec($comando);
   
   $comando = '  barcode -b '.$numeroRadicado.' -e "39" -o ' . $pathImgBarras2;
   shell_exec($comando);
   
   $comando = "convert    $pathImgBarras2 -crop 300x70+2+690 +repage $pathImgBarras";
   shell_exec($comando);
   
   include $ruta_raiz."/mtvLiquidacion/radPrint.php";
   $tmpHtm = "$ruta_raiz/bodega/tmp/html".session_id().".html";
   $paginaHtml = str_replace("bodega/bodega","bodega",$paginaHtml);
   $fp = fopen($tmpHtm, 'w');
    fwrite($fp, $paginaHtml);
    fclose($fp);
    
    
   $comandoPdf = "wkhtmltopdf $tmpHtm ".$ruta_raiz."/bodega$pathRadicado ";
   
   shell_exec ($comandoPdf);
   
   $rad->insertDireccion($numeroRadicado, 1,$tipoAccion);
  
   $rad->grbNombresUs = "".$pConstructora . " Rep:". $pRep . " Proyecto:" . $pNombre;
   $rad->direccion = $pDir;
   
   $rad->insertDireccion($numeroRadicado, 2,$tipoAccion);

  //file_put_contents('../bodega/tmp/barcode.png',$barcodeobj->getBarcodePNG(2, 30, array(0,0,0)));
  // &$barcodeobj->
 
  $msg = '';
  $codBarras = "<table align=right><tr><td></td><td align=right><img src=\"../bodega/tmp/bar".$numeroRadicado.".png\" width=200  align=right><br> Radicado $numeroRadicado<br>Fecha ".date("Y/m/d H:i:s")."<br></td></tr></table>";
  
  
  if ($numeroRadicado) {
    $fechaHoy = date("ymdhmsi");
    echo "<script>
      $('#resultadoRad').html('$codBarras'); 
      pRepI = $('#pRep').val().toUpperCase();
      pNombreI = $('#pNombre').val().toUpperCase();
      pConstructoraI = $('#pConstructora').val().toUpperCase();
      $('#pRepI').text(pRepI);
      $('#pConstructoraI').text(pConstructoraI);
      $('#pNombreI').text(pNombreI);
    </script>";
    echo "<br><br><div class='alert alert-success fade in'>
            <button class='close' data-dismiss='alert'> × </button>
            <i class='fa-fw fa fa-check'></i>
            <strong>Solicitud Generada con N&uacute;mero de Radicado No. $numeroRadicado </strong>
            <small><a  onclick=\"funlinkArchivo('$numeroRadicado','$ruta_raiz');\" href='#' >Descargar Archivo</a></small>
            <span id=refresh class='btn btn-ribbon' data-reset-msg='Recargar Pagina' data-html='true' rel='tooltip' data-title='refresh' data-action='resetWidgets'></div>";
  } else {
    echo "<div class='alert alert-danger fade in'>
              <button class='close' data-dismiss='alert'> × </button>
              <i class='fa-fw fa fa-times'></i>
              <strong>Error la Generacion de la solicitud.</strong>
              Intente mas tarde</div>";
  }
?>
