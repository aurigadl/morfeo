<?php
session_start();
$krd = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;
if (!$ruta_raiz) $ruta_raiz = "..";
?>
<html>
<head>

  <title>Sistema de informaci&oacute;n <?=$entidad_largo?></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap core CSS -->
  <?php include_once "../htmlheader.inc.php"; ?>
<?

//include "$ruta_raiz/rec_session.php";
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
include_once "$ruta_raiz/include/tx/Historico.php";
include_once "$ruta_raiz/include/tx/Expediente.php";
$db = new ConnectionHandler( "$ruta_raiz" );
$db->debug = true;
$encabezadol = "$PHP_SELF?".session_name()."=".session_id()."&dependencia=$dependencia";
?>
<script>
function RegresarV(){
 window.location.assign("adminEdificio.php?<?=$encabezado1?>&fechah=$fechah&$orno&adodb_next_page");
}
<?
/**
  * Grabar los datos del edificio.
  */
if( isset( $_POST['btnGrabar'] ) && $_POST['btnGrabar'] != "" )
{
    //$db->conn->BeginTrans();
    
    /**
      * Crea el registro con los datos del edificio.
      */
    $q_insertE  = "INSERT INTO SGD_EIT_ITEMS( SGD_EIT_CODIGO, SGD_EIT_COD_PADRE,";
    $q_insertE .= " SGD_EIT_NOMBRE, SGD_EIT_SIGLA, CODI_DPTO, CODI_MUNI )";
    $sec=$db->conn->nextId( 'SEC_EDIFICIO' );
    $q_insertE .= " VALUES( '$sec', 0,";
    $q_insertE .= " UPPER( '".$_POST['hidNombreEdificio']."' ),";
    $q_insertE .= " UPPER( '".$_POST['hidSiglaEdificio']."' ),";
    $q_insertE .= " ".$_POST['hidDepartamento'].", ".$_POST['hidMunicipio']." )";
echo $muni_us;
  //  $q_insertE;
     $listo = $db->query( $q_insertE );
    
    /**
      * Datos de las unidades de almacenamiento del edificio.
      */
    foreach( $_POST as $clavePOST => $valorPOST )
    {
        if( strncmp( $clavePOST, 'nombre_', 7 ) == 0 )
        {
            $nombreUA = $valorPOST;
        }
        if( strncmp( $clavePOST, 'sigla_', 6 ) == 0 )
        {
            $siglaUA = $valorPOST;
        }
        
        if( $nombreUA != "" && $siglaUA != "" )
        {
            /*
             * Crea el registro correspondiente a la unidad de almacenamiento.
             */
            $q_insertUA  = "INSERT INTO SGD_EIT_ITEMS( SGD_EIT_CODIGO,SGD_EIT_COD_PADRE, SGD_EIT_NOMBRE,";
            $q_insertUA .= " SGD_EIT_SIGLA )";
            $q_insertUA .= " VALUES( ".$db->conn->nextId( 'SEC_EDIFICIO' ).", $sec,";
            $q_insertUA .= " UPPER( '".$nombreUA."' ), UPPER( '".$siglaUA."' ) )";
            if( $listo )
            {
                $listo = $db->query( $q_insertUA );
            }
            $nombreUA = "";
            $siglaUA = "";
        }
    }
    
    if( $listo )
    {
        //$db->conn->CommitTrans();
	?>
	window.open('<?=$ruta_raiz?>/archivo/relacionTiposAlmac.php?dependencia=<?=$dependencia?>&tipo=<?=$tipo?>&idEdificio=<?=$idEdificio?>&codp=<?=$sec?>',"Relacion Tipos Almacenamiento","height=250,width=550,scrollbars=yes");
	<?	
    }
    else
    {
        //$db->conn->RollbackTrans(); 
    }

   // header( "Location: relacionTiposAlmac.php?".$encabezadol."&idEdificio=".$idEdificio);
}
?>
function mostrarCampos()
{
    var departamento = document.getElementById( 'codep_us' ).selectedIndex;
    var municipio2 = document.getElementById( 'muni_us' ).selectedIndex;
    var nombreEdificio = document.getElementById( 'nombre' ).value;
    var siglaEdificio = document.getElementById( 'sigla' ).value;
    
    if( document.getElementById( 'numero' ).value == "" || isNaN( document.getElementById( 'numero' ).value ) )
    {
        alert( 'Debe ingresar Numero de Tipos de Almacenamiento.' );
        document.getElementById( 'numero' ).focus();
        return false;
    }
    else
    {
		var i;
		var j = parseInt( document.getElementById( 'numero' ).value );
		document.open();
		document.write( "<html>" +
										"<head>" +
										"<title>.:: INGRESAR EDIFICIO ::.</title>" );
		document.write('<link href="../estilos/bootstrap.min.css" rel="stylesheet">');
		document.write( '</head><body class="smart-form">' +
										'<form name="frmCampos" Action="<?=$encabezado1?>" method="POST" CLASS="smart-form">'+
										"<input type='hidden' name='hidDepartamento' value='<?=$codep_us?>'>"+
										"<input type='hidden' name='hidMunicipio' value='<?=$muni_us?>'>"+
										"<input type='hidden' name='hidNombreEdificio' value='"+nombreEdificio+"'>"+
										"<input type='hidden' name='hidSiglaEdificio' value='"+siglaEdificio+"'>"+
										"<table class='table table-bordered'>"+
										"<tr>" +
										"<th height='35' colspan='2' class='titulos2'>" +
										"<center>INGRESAR EDIFICIO</center>" +
										"</th>" +
										"</tr>" +
										"<tr>" +
										"<td height='30' class='titulos2'>" +
										"<div align='center'>" +
										"NOMBRE" +
										"</div>" +
										"</td>" +
										"<td height='30' class='titulos2'>" +
										"<div align='center'>" +
										"SIGLA" +
										"</div>" +
										"</td>" +
										"</tr>"
									);
        for ( i = 0; i < j; i++ )
        {
        document.write( "<tr>" +
                        "<td >" +
                        "<div align='center'>" +
                        "<input type='text' name='nombre_" + i + "' size='40' maxlength='40'>" +
                        "</div>" +
                        "</td>" +
                        "<td >" +
                        "<div align='center'>" +
                        "<input type='text' name='sigla_" + i + "' size='4' maxlength='4'>" +
                        "</div>" +
                        "</td>" +
                        "</tr>"
                      );
        }
        document.write( "<tr>" +
                        "<td align='center' colspan='3' >" +
                        "<footer><input type='submit' class='btn btn-success' value='Grabar' name='btnGrabar'>" +
                        "<input type='button' class='btn btn-default' value='Cancelar' name='Cancelar' onClick='javascript:history.back()'>" +
                        "</footer></td>" +
                        "</tr>" +
                        "</table>" +
                        "</form>" +
                        "</body>" +
                        "</html>"
                      );
        document.close();
    }
}
</script>
</head>
<body>
<form name="inEdificio" action="<?=$encabezadol?>" method="post" class="smart-form" >
<table class="table table-bordered" width=200>
<tr>
  <th  colspan="2" class="titulos2">
  <center>INGRESO DE EDIFICIOS</center>
  </th>
</tr>
<tr>
 <td width="50">
    <div align="left">
      Departamento
      <label class=select>
      <select name="codep_us" id="codep_us" onChange="document.inEdificio.submit();" class="select">
        <option value="" selected>
          <font color="">-----</font>
        </option>
        <?php
        $isql = "SELECT DPTO_CODI, DPTO_NOMB
                  FROM DEPARTAMENTO
                  where
                  ID_PAIS=170
                  ORDER BY DPTO_NOMB
                ";
        $db->debug = true;
        $rs = $db->query( $isql );
		while( $rs && !$rs->EOF )
        {
            $deptocodi = trim( $rs->fields[0] );
            $deptonomb = trim( $rs->fields[1] );
            if( strlen( trim( $codep_us ) ) !=0 )
            {
                if( $deptocodi == $codep_us )
                {
                    $datos =" selected ";
                }
                else
                {
                    $datos = "";
                }
            }
            print "<option value='$deptocodi' $datos><font color=''>$deptonomb</font></option>";
            $rs->MoveNext();
        }
?>
      </select>
      </label>
    </div>
  </td>
  
  <td width="170">
    <div align="left">
      Municipio
      <label class=select>
      <select name="muni_us" id="muni_us" onChange="document.inEdificio.submit();" class="select">
        <?php
        if( $codep_us )
		{
			$depto = $codep_us;
		}
		if ( strlen( trim( $codep_us ) ) !=0 )
		{
			$depto = $codep_us;
		}
		if( !$depto )
        {
            $depto = '0';
        }
		$isql = "SELECT MUNI_CODI,MUNI_NOMB FROM MUNICIPIO where DPTO_CODI = $depto AND ID_PAIS=170 order by muni_nomb";
		$rs = $db->query( $isql );
		echo "<option value='' $datos>---</font></option>";
	
        while( $rs && !$rs->EOF )
		{
			$municodi = trim( $rs->fields[0] );
			$muninomb = trim( $rs->fields[1] );
			if( strlen( trim( $muni_us ) ) !=0 )
			{
				if( $municodi == $muni_us )
                {
                    $datos = " selected ";
                }
                else
                {
                    $datos = "";
                }
			}
			print "<option value='$municodi' $datos>$muninomb</font></option>";
			$rs->MoveNext();
		}
        $municodi="";$muninomb="";$depto="";
        ?>
      </select>
		 </label>
    </div>
  </td>
</tr>
<tr>
  <td height="23">
    <div align="left">
      Nombre
      <label class="input">
      <input type="text" name="nombre" id="nombre" value="<?php print $_POST['nombre']; ?>" size="40" maxlength="40" align="right">
      </label>
    </div>
  </td>
  <td>
    <div align="left">
      Sigla
      <label class="input">
      <input type="text" name="sigla" id="sigla" value="<?php print $_POST['sigla']; ?>" size="4" maxlength="4" align="right">
      </label>
    </div>
  </td>
</tr>
<tr>
  <td height="26">
    <div align="left">
      Ingrese N&uacute;mero de Tipos de Almacenamiento
      
    </div>
  </td>
  
  <td>
  <label class="input">
  <input type="text" name="numero" id="numero" value="<?php print $_POST['numero']; ?>" size="2" maxlength="2" align="right">  
  </label>
  </td>
</tr>
<tr><td colspan=2>
<footer><input name='SALIR' type="button" class="btn btn-default" id="envia22" onClick="opener.regresar();window.close();" value="SALIR" align="middle" >
<input type="button" name="btnMostrarCampos" class="btn btn-success" value="Definir &gt;&gt;" onClick="mostrarCampos();"></footer>
</td></tr>
</table>
</form>
</body>
</html>
