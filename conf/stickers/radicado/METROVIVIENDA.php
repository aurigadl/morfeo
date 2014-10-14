<?$ruta_raiz="../.."?>
<html>
<head>
<title>Sticker web</title>
<link rel="stylesheet" href="estilo_imprimir.css" TYPE="text/css" MEDIA="print">
<style type="text/css">

body {
    margin-bottom:0;
    margin-left:0;
    margin-right:0;
    margin-top:0;
    padding-bottom:0;
    padding-left:0;
    padding-right:0;
    padding-top:0
    font-family: Arial, Helvetica, sans-serif;
}

span{
    font-size:   15px;
    line-height: 15px;
    clear:       both;
}
h3,p{
    margin: 0px;
}
td{
    width:auto;
}

</style>
</head>
<body topmargin="5" leftmargin="0"  onload="window.print()">
    <table width="250px" cellpadding="0" cellspacing="0">
        <tr>
            <td  align=left width="300px">
              <?=$entidad_corto?>
               <!-- <center>
               <p><span><b><h3><?=$entidad_largo?></h3><b></span></p>
                </center> -->
                <!--<span><center><img src="barcode_img.php?num=<?php /*echo($nurad) */?>&type=Code39&imgtype=png" width="200px"><center><span>
                <p><span><b>Destino: <?/*=substr($dependenciaDestino,0,20)*/?><p><span><b> -->
                <p><span><b> Radicado: <?=$nurad?> </b></span></p>
                <p><span><b> Del: <?=substr($radi_fech_radi,0,16). " "?> </b></span></p>
                <p><span><b> Rem: <?=substr($remite,0,20); ?> </b></span></p>
                <p><span><b> <?=$process?> </b></span></p>
                <!--<p><span  align="left"><b>
                    Folios: <?=$radi_nume_folio?> &nbsp;&nbsp; Anexos: <?=$radi_nume_anexo?> &nbsp;&nbsp; Copias: <?=$copias?>   </b>
                </span></p>

                <span  align="left"><b>
                    <?=substr($radi_fech_radi,0,16). " "?>  &nbsp;&nbsp; C&oacute;d veri: <?=$sgd_rad_codigoverificacion?> </b>
                </span>
                <p><span><b>Consulte su tr&aacute;mite en http://www.correlibre.org</b></span></p>
                <p><span><b><?/*=$entidad_largo*/?></b></span></p>-->
            </td>
        </tr>
    </table>
</body>
</html>

