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
<?
$noRad = $_REQUEST['nurad'];
?>
<body topmargin="5" leftmargin="0">
    <table width="400px" cellpadding="0" cellspacing="0" onload="window.print()">
        <tr>
            <td  align=left width="300px">
	    	<table width="100%">
	    		<tr>
				<td width="80%"><center><?=$noRadBarras?></center></td>
				<td width="20%"><img src="<?=$dirLogo?>" alt="<?=$entidad_corto?>"  height="42" width="42"></td>
			</tr>
		</table>
                <p><span><b> No: <?=$nurad?> </b></span></p>
                <p><span><b>Fecha: <?=substr($radi_fech_radi,0,16). " "?> </b></span></p>
	        <p><span><b>No Folios: <?=$radi_nume_folio?> Paginas </b></span></p>
                <b>C&oacute;d veri: <?=$sgd_rad_codigoverificacion?> </b><br>
		<!--Falta incluir el destinatario-->
                <p><center><b><?=$entidad_largo?></b></br>
		<?=$entidad_dir?>, Tel: <?=$entidad_tel?>
		</center></p>
                <span  align="left"><b>
                </span>
            </td>
        </tr>
    </table>
</body>
</html>

