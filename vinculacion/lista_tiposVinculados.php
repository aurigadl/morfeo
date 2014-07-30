<?php
session_start();

$ruta_raiz = "..";
if (!$_SESSION['dependencia'])
    header ("Location: $ruta_raiz/cerrar_session.php");

    $isqlC = 'select
                radi_nume_deri        AS "DERIVADO"
                , radi_tipo_deri      AS "TIPO"
                from
                   RADICADO
                where radi_nume_radi    =  '. $verrad;
    ?>

    <table class="table table-bordered table-striped">
        <tr>
            <td>
                Documento vinculado al radicado No. <?=$verrad ?>
            </td>
        </tr>
    </table>

    <table class="table table-bordered table-striped">
  	<tr class="titulo4" align="center">
    	<td width="20%"  class="titulos4">TIPO</td>
		<td width="30%"  class="titulos4">RADICADO VINCULADO</td>
   	   	<td width="30%"  class="titulos4">ACCION</td>
  		</tr>
  	    <?php
	 	$rsC=$db->query($isqlC);
		$numRadiVin  =$rsC->fields["DERIVADO"];
   		 if($numRadiVin  != ''){
      			$tipVinculo  =$rsC->fields["TIPO"];
	  			$numRadiVin  =$rsC->fields["DERIVADO"];
				
		    ?>
            <td class="listado4"> <?=$tipVinculo?> </td>
            <td class="listado4"> <?=$numRadiVin?> </td>
            <td  <? if (!$rsC->fields["DERIVADO"]) echo " class='celdaGris ' "; else echo " class='e_tablas ' "; ?>  >
		    <?php
			    echo "<a href=javascript:borrarArchivo('$verrad','si')><span class='botones_largo'>Borrar Vinculo</a> ";
		    ?>
	        </td>
	    </tr>
	    <?} ?>
   </table>