<?php
session_start();

/*error_reporting(E_ALL);
ini_set('display_errors',1);*/

$ruta_raiz = ".";
if (!$_SESSION['dependencia']) header ("Location: $ruta_raiz/cerrar_session.php");
foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;

$subir_archivo  = (isset($subir_archivo))? $subir_archivo : false;
$nuevo_archivo  = (isset($nuevo_archivo))? $nuevo_archivo : false;

if($subir_archivo != true){
    $krd         = $_SESSION["krd"];
    $dependencia = $_SESSION["dependencia"];
    $usua_doc    = $_SESSION["usua_doc"];
    $codusuario  = $_SESSION["codusuario"];
    $tpNumRad    = $_SESSION["tpNumRad"];
    $tpPerRad    = $_SESSION["tpPerRad"];
    $tpDescRad   = $_SESSION["tpDescRad"];
    $tip3Nombre  = $_SESSION["tip3Nombre"];

    define('ADODB_ASSOC_CASE', 1);
    include_once "$ruta_raiz/class_control/AplIntegrada.php";
    include_once "$ruta_raiz/include/db/ConnectionHandler.php";
}

if(!$ent){
    $ent = substr(trim($numrad),strlen($numrad)-1,1);
}

$nombreTp3 = $tip3Nombre[3][$ent];

if(!$db){
  $db  = new ConnectionHandler($ruta_raiz);
}

$dbAux = new ConnectionHandler($ruta_raiz);

$conexion      = $db;
$rowar         = array();
$mensaje       = null;
$tipoDocumento = explode("-", $tipoLista);
$tipoDocumentoSeleccionado = $tipoDocumento[1];

$isql = "select USUA_LOGIN,USUA_PASW,CODI_NIVEL from usuario where (usua_login ='$krd') ";
$rs   = $db->conn->Execute($isql);

if ($rs->EOF){
    $mensaje="No tiene permisos para ver el documento";
}else{
    $nivel=$rs->fields["CODI_NIVEL"];
    ($tipo==0) ? $psql = " where  anex_tipo_codi<50 " : $psql=" ";
    $isql = "select ANEX_TIPO_CODI,
                    ANEX_TIPO_DESC,
                    ANEX_TIPO_EXT
              from anexos_tipo
                    $psql
              order by anex_tipo_desc desc";
    $rs=$db->conn->Execute($isql);
}

if ($resp1=="OK"){
    $mensaje = ($subir_archivo)? "<span class=info>Archivo anexado correctamente</span></br>" :
                                "Anexo Modificado Correctamente<br>No se anex&oacute; ning&uacute;n archivo</br>";
}else if ($resp1=="ERROR"){
    $mensaje="<span class=alarmas>Error al anexar archivos</span></br>";
}

include "$ruta_raiz/radicacion/crea_combos_universales.php";

if (!function_exists(return_bytes)){
    // Retorna la cantidad de bytes de una expresion como 7M, 4G u 8K.
    function return_bytes($val){
        $val = trim($val);
        $ultimo = strtolower($val{strlen($val)-1});
        switch($ultimo){
            // El modificador 'G' se encuentra disponible desde PHP 5.1.0
        case 'g': $val *= 1024;
        case 'm': $val *= 1024;
        case 'k': $val *= 1024;
        }
        return $val;
    }
}

$consultaESP  = "select r.EESP_CODI from radicado r where r.radi_nume_radi = $numrad";
$rsESP        = $db->conn->Execute($consultaESP);
$codigoESP    = $rsESP->fields["EESP_CODI"];
$consultaRUPS = "select FLAG_RUPS from bodega_empresas where ARE_ESP_SECUE = $codigoESP";

$rsESPRUPS = $db->conn->Execute( $consultaRUPS );
$espEnRUPS = $rsESPRUPS->fields[ "FLAG_RUPS" ];

$datos_envio  = "&otro_us11=$otro_us11&codigo=$codigo&dpto_nombre_us11=$dpto_nombre_us11&direccion_us11=".urlencode($direccion_us11)."&muni_nombre_us11=$muni_nombre_us11&nombret_us11=$nombret_us11";
$datos_envio .="&otro_us2=$otro_us2&dpto_nombre_us2=$dpto_nombre_us2&muni_nombre_us2=$muni_nombre_us2&direccion_us2=".urlencode($direccion_us2)."&nombret_us2=$nombret_us2";
$datos_envio .="&dpto_nombre_us3=$dpto_nombre_us3&muni_nombre_us3=$muni_nombre_us3&direccion_us3=".urlencode($direccion_us3)."&nombret_us3=$nombret_us3";
$variables    = "ent=$ent&".session_name()."=".trim(session_id())."&tipo=$tipo$datos_envio";
?>

<html>
<head>
<title>Informaci&oacute;n de Anexos</title>
	<meta charset="utf-8">
	<link rel="shortcut icon" href="<?=$ruta_raiz?>/img/favicon.png">
	<!-- Bootstrap core CSS -->
	<?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
  <SCRIPT Language="JavaScript" SRC="js/crea_combos_2.js"></SCRIPT>
<script language="javascript">
  var datasend = '<?=$variables?>'
  console.log(datasend);
  <?php
  // Convertimos los vectores de los paises, dptos y municipios creados en crea_combos_universales.php a vectores en JavaScript.
  echo arrayToJsArray($vpaisesv, 'vp');
  echo arrayToJsArray($vdptosv, 'vd');
  echo arrayToJsArray($vmcposv, 'vm');
  ?>

  function mostrar(nombreCapa){
    document.getElementById(nombreCapa).style.display="";
  }

  function continuar_grabar(){
    document.formulario.tpradic.disabled=false;
    document.formulario.action=document.formulario.action+"&cc=GrabarDestinatario&" + datasend;
    document.formulario.submit();
  }

  function mostrarNombre(nombreCapa){
    document.formulario.elements[nombreCapa].style.display="";
  }

  function ocultarNombre(nombreCapa){
    document.formulario.elements[nombreCapa].style.display="none";
  }

  function ocultar(nombreCapa){
    document.getElementById(nombreCapa).style.display="none";
  }

  function Start(URL, WIDTH, HEIGHT){
  windowprops = "top=0,left=0,location=no,status=no, menubar=no,scrollbars=yes, resizable=yes,width=1020,height=500";
  preview = window.open(URL , "preview", windowprops);
  }

  function doc_radicado(){
      if (document.formulario.radicado_salida.checked){
          document.formulario.tpradic.disabled=false;
      }else{
          document.formulario.tpradic.disabled=true;
      }
  }

  function f_close(){
    opener.regresar();
    window.close();
  }

  function regresar(){
    f_close();
  }

  function escogio_archivo(){
      var largo;
      var valor;
      var extension;
      archivo_up = document.getElementById('userfile').value;
      valor = 0;
      var mySplitResult = archivo_up.split(".");

      for(i = 0; i < (mySplitResult.length); i++){
          extension = mySplitResult[i];
      }
      extension = extension.toLowerCase();
      <? while (!$rs->EOF){
      echo "
          if (  extension=='".$rs->fields["ANEX_TIPO_EXT"]."'){
              valor=".$rs->fields["ANEX_TIPO_CODI"].";
          }\n";
        $rs->MoveNext();
      }

      $anexos_isql = $isql;
      ?>
      document.getElementById('tipo_clase').value = valor;
  }

  function validarGenerico(){

      var i     = 0;
      var marca = 0;

      if (document.formulario.radicado_salida.checked && document.formulario.tpradic.value=='null'){
          alert ("Debe seleccionar el tipo de radicacion");
          return false;
      }

      archivo=document.getElementById('userfile').value;

      if (archivo==""){
          <?php
            if($tipo==0 and !$codigo){echo "alert('Por favor escoja un archivo'); return false;";}
            else{echo "return true;";}
          ?>
      }

      copias = document.getElementById('i_copias').value;

      if(copias==0 && document.getElementById('radicado_salida').checked==true){
          document.getElementById('radicado_salida').checked=false;
      }

      return true;
  }

  function actualizar(){

      if (!validarGenerico()) return;

      var integracion = document.formulario.tpradic.value;

      document.formulario.radicado_salida.disabled=false;
      document.formulario.tpradic.disabled=false;
      document.formulario.submit();
  }

</script>
</head>
<body class="smart-form">
<div>
<form enctype="multipart/form-data" method="POST" name="formulario" id="formulario" action='upload2.php?<?=$variables?>' >

<input type="hidden" name="subir_archivo" value="<?=$subir_archivo?>"> 
<input type="hidden" name="nuevo_archivo" value="<?=$nuevo_archivo?>"> 
<?php
$i_copias = 0;

if ($codigo){

    $isql = "SELECT CODI_NIVEL
                  ,ANEX_SOLO_LECT
                  ,ANEX_CREADOR
                  ,ANEX_DESC
                  ,ANEX_TIPO_EXT
                  ,ANEX_NUMERO
                  ,ANEX_RADI_NUME
                  ,ANEX_NOMB_ARCHIVO AS nombre
                  ,ANEX_SALIDA
                  ,ANEX_ESTADO
                  ,SGD_DIR_TIPO
                  ,RADI_NUME_SALIDA
                  ,SGD_DIR_DIRECCION
                  ,ANEX_TIPO_ENVIO
              FROM
                  ANEXOS,
                  ANEXOS_TIPO,
                  RADICADO
              WHERE
                  ANEX_CODIGO='$codigo'
                  AND ANEX_RADI_NUME=RADI_NUME_RADI
                  AND ANEX_TIPO=ANEX_TIPO_CODI";

  $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
  $rs=$db->conn->Execute($isql);
  if (!$rs->EOF){
    $docunivel        = ($rs->fields["CODI_NIVEL"]);
    $sololect         = ($rs->fields["ANEX_SOLO_LECT"]=="S");
    $remitente        = $rs->fields["SGD_DIR_TIPO"].'remitenteee';
    $extension        = $rs->fields["ANEX_TIPO_EXT"].'PP';
    $radicado_salida  = $rs->fields["ANEX_SALIDA"];
    $anex_estado      = $rs->fields["ANEX_ESTADO"];
    $descr            = $rs->fields["ANEX_DESC"];
    $radsalida        = $rs->fields["RADI_NUME_SALIDA"];
    $direccionAlterna = $rs->fields["SGD_DIR_DIRECCION"];
    $direccionAlterna = $rs->fields["SGD_DIR_DIRECCION"];
    $medioRadicar     = $rs->fields["ANEX_TIPO_ENVIO"];
    // SGD_DIR_TIPO  = 7 es otro reminte

    if(!empty($remitente)){
        $radicado_rem = $remitente;
    }

  }

}
if(!$radicado_rem){
  $radicado_rem = 1;
}

?>
<div class="row">
	<div class="col-lg-12">
	<section id="widget-grid" class="">

<table class="table table-bordered">
<tr>
  <td>
<input type="hidden" name="anex_origen" value="<?=$tipo?>">
<input type="hidden" name="tipo" value="<?=$tipo?>"  id="tipo_clase">
<input type="hidden" name="numrad" value="<?=$numrad?>">
<input type="hidden" name="tipoLista" value="<?=$tipoLista?>">
<input type="hidden" name="tipoDocumentoSeleccionado" value="<?php echo $tipoDocumentoSeleccionado ?>">
<table width="100%" class="table table-bordered">
  <tr>
    <td >
      <input type="checkbox" class="select"  name="sololect" <?php  if($sololect){echo " checked ";}  ?> id="sololect">
      <small>Solo lectura</small>
    </td>
    <td colspan="3" >
    <table border=0 width=100% cellspacing="1" cellpadding="1">
    <tr>
    <td width=50% >
<?php
$us_1   = "";
$us_2   = "";
$us_3   = "";
$datoss = "";

if ($nombret_us11 and $direccion_us11 and $dpto_nombre_us11 and $muni_nombre_us11){
    $us_1 = "si"; $usuar=1;
    if($remitente==1) {$datoss1=" checked " ;  }
}else{
    $datoss1=" disabled ";
}

$datoss = "";
if ($nombret_us2 and $direccion_us2 and $dpto_nombre_us2 and $muni_nombre_us2  )
{ $us_2 = "si"; $predi=1;
  if($remitente==2) $datoss2=" checked  " ;
}
else
{ $datoss2=" disabled ";  }

$datoss = "";
if ($nombret_us3 and $direccion_us3 and $dpto_nombre_us3 and $muni_nombre_us3 )
{
  $us_3 = "si";
  $empre=1;
  if($remitente==3) $datoss3=" checked  " ;
}
else  {  $datoss3=" disabled " ;}

if ($remitente==7)  $datoss4=" checked  ";
else  $datoss4 = "";

if($us_1 or $us_2 or $us_3)
{
  if ($radicado_salida) $datoss=" checked ";
  else $datoss="";
?>
  <input type="checkbox" class="select" name="radicado_salida" value="radsalida"
<?php
  if (!$radicado_salida and $ent==1)  $radicado_salida=1;
  if($radicado_salida==1 or $datoss)
  { echo " checked "; }
?> onClick="doc_radicado();" id="radicado_salida"><small>  Este documento ser&aacute; radicado</small>
<?php
}else{
?>
  <small>Este documento no puede ser radicado ya que faltan datos.<br>
  (Para envio son obligatorios Nombre, Direccion, Departamento,
  Municipio)</small>
    <input type="checkbox" class="select" name="radicado_salida" value="radsalida"
		<?php
			if (!$radicado_salida and $ent==1)  $radicado_salida=1;
			if($radicado_salida==1 or $datoss)
			{ echo " checked "; }
		?> onClick="doc_radicado();" id="radicado_salida">  Este documento ser&aacute; radicado
<?php
}
?>
    </td>
    <td >
<?php
$comboRadOps="";
if ($ent!=1 ){
  $deshabb=" disabled=true ";
}

$comboRad       = "
      <label class='select'>
			<select name = 'tpradic' class = 'select' $deshab  $eventoIntegra >";
$comboRadSelecc = "<option selected value = 'null'>- Tipos de Radicacion -</option>";
$sel            = "";

if(!$tpradic) $tpradic=$ent;

foreach ($tpNumRad as $key => $valueTp){

    if(strcmp(trim($tpradic),trim($valueTp))==0){
        $sel="selected";
        $comboIntSwSel=1;
    }

    if($valueTp != 9 and $valueTp != 2){
        //Si se definio prioridad en algun tipo de radicacion
        $valueDesc = $tpDescRad[$key];
        $comboRadOps =$comboRadOps . "<option value='".$valueTp."' $sel>".$valueDesc."</option>";
        $sel="";
    }

}

$comboRad = $comboRad.$comboRadSelecc.$comboRadOps."</select></label>";

?>
   <small> Radicaci&oacute;n  <?=$comboRad?> </small><BR>
<?php

if ($ent==1){
  echo ("<script>doc_radicado();</script>");
}

if (strlen(trim($swDischekRad)) > 0){
  echo ("<script>document.formulario.tpradic.disabled=true;</script>");
}

?>
    </td>
    </tr>
    </table>
    </td>
  </tr>

  <tr>
    <td  ><small>Asunto </small></td>
    <td  valign="top" >
      <textarea name="descr" cols="60" rows="1" class="text" id="descr"><?=$descr?></textarea>
    </td>
  </tr>
  <tr>
        <td ><small>Expediente:</small></td>
      <td  valign="top"  >
      <table border="0"  class="borde_tab" align="center">
      <tr >
<?php

$q_exp  = "SELECT SGD_EXP_NUMERO as valor,
                  SGD_EXP_NUMERO as etiqueta,
                  SGD_EXP_FECH as fecha";
$q_exp .= " FROM SGD_EXP_EXPEDIENTE ";
$q_exp .= " WHERE RADI_NUME_RADI = " . $numrad;
$q_exp .= " AND SGD_EXP_ESTADO <> 2";
$q_exp .= " ORDER BY fecha desc";

$rs_exp = $db->conn->Execute( $q_exp );

if( $rs_exp->RecordCount() == 0 ){
  $mostrarAlerta  = "<td align=\"center\" >";
  $mostrarAlerta .= "<b><small>EL RADICADO PADRE NO ESTA INCLUIDO  EN UN EXPEDIENTE.</small></b>
          </td>";
  $sqlt = "select RADI_USUA_ACTU,RADI_DEPE_ACTU from RADICADO where RADI_NUME_RADI = '$numrad'";
  $rsE  = $db->conn->Execute($sqlt);
  $depe = $rsE->fields['RADI_DEPE_ACTU'];
  $usua = $rsE->fields['RADI_USUA_ACTU'];
  echo $mostrarAlerta;
}else{
?>
      <td align="center">

      <label class="select">
			  <?php print $rs_exp->GetMenu( 'expIncluidoAnexo', $expIncluidoAnexo, false, false, 0, "class='select'", false ); ?>
        </label>
      </td>
<?php
}
?>
    </tr>
    </table>
  </tr>

  <tr>
    <td  align="center"  colspan="2">
      <small>Destinatario</small>
    </td>
  </tr>

  <!-- Destinatario valor de seleccion -1- -->
  <tr valign="top">
    <td  valign="top" colspan="2"  ><small>
    <input type="radio"   name="radicado_rem" value=1  id="rusuario" <?=$datoss1?> '
    <?php
      if($radicado_rem==1){echo " checked ";}
    ?> '>
    <?=$tip3Nombre[1][$ent]?>
    <?=$otro_us11?>
    <?=$direccion_us11?>
    <?="$dpto_nombre_us11/$muni_nombre_us11" ?>
    </small></td>
  </tr>


<?php

    if($codigo){ ?>
        <tr><td height='3px' colspan="2"></td></tr>

      <!-- Listado de destinos buscados por usuario-->
      <!-- Destinatario valor de seleccion -codigo dir_direcciones- -->
        <?php
          if($borrar)
          {
              $isql = "delete from sgd_dir_drecciones
                     where sgd_anex_codigo='$codigo' and sgd_dir_tipo = $borrar ";
            $rs=$db->conn->Execute($isql);
          }
            //Si viene la variable cc(Boton de destino copia)
            //envia al modulo de grabacion de datos
          if($cc){
              if (($nombre_us1 or $prim_apel_us1 or $seg_apel_us2)
                  and  $direccion_us1
                  and $muni_us1 and $codep_us1){

                  $isql = "SELECT
                      SGD_DIR_TIPO NUM
                      FROM
                      SGD_DIR_DRECCIONES
                      WHERE
                      SGD_ANEX_CODIGO='$codigo'
                      ORDER BY SGD_DIR_TIPO";

                  $rs = $db->conn->Execute($isql);

                  if (!$rs->EOF)$num_anexos = substr($rs->fields["NUM"],1,2);
                  if(!$nurad){
                      $nurad = $numrad;
                  }
                  include "$ruta_raiz/radicacion/grb_direcciones.php";
                  $grabar = "<font size=1>Ha sido agregado el destinatario.</font>";
              }else{
                  $grabar = "<font size=1  class='titulosError2'>
                      faltan datos.(Los datos m&iacute;nimos de envio so Nombre,
                      direccion, departamento, municipio)";
              }
          }

          $i_copias = 0; //Cuantos copias se han añadido

          include_once "$ruta_raiz/include/query/queryNuevo_archivo.php";
          $isql = $query1;
          $rs=$db->conn->Execute($isql);

          $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
          $rs=$db->conn->Execute($isql);

          echo "
              <tr>
              <td colspan='2'>
              <table width='100%' class='table table-bordered'> ";

          while(!$rs->EOF && $rs ){
              $i_copias++;
              $sgd_ciu_codigo = "";
              $sgd_esp_codi   = ""; $sgd_oem_codi = "";
              $sgd_dir_codi   = $rs->fields["SGD_DIR_CODIGO"];
              $sgd_ciu_codi   = $rs->fields["SGD_CIU_CODIGO"];
              $sgd_esp_codi   = $rs->fields["SGD_ESP_CODI"];
              $sgd_oem_codi   = $rs->fields["SGD_OEM_CODIGO"];
              $sgd_dir_tipo   = $rs->fields["SGD_DIR_TIPO"];
              $sgd_doc_fun    = $rs->fields["SGD_DOC_FUN"];

              if($sgd_ciu_codi>0){
                  $isql = "SELECT
                      SGD_CIU_NOMBRE AS NOMBRE,
                      SGD_CIU_APELL1 AS APELL1,
                      SGD_CIU_APELL2 AS APELL2,
                      SGD_CIU_CEDULA AS IDENTIFICADOR,
                      SGD_CIU_EMAIL  AS MAIL,
                      SGD_CIU_DIRECCION  AS DIRECCION
                      FROM
                      SGD_CIU_CIUDADANO
                      WHERE
                      SGD_CIU_CODIGo=$sgd_ciu_codi";
              }

              if($sgd_esp_codi>0){
                  $isql = "SELECT
                      NOMBRE_DE_LA_EMPRESA AS NOMBRE,
                      IDENTIFICADOR_EMPRESA AS IDENTIFICADOR,
                      EMAIL AS MAIL,
                      DIRECCION AS DIRECCION
                      FROM
                      BODEGA_EMPRESAS
                      WHERE
                      IDENTIFICADOR_EMPRESA=$sgd_esp_codi";
              }

              if($sgd_oem_codi>0){
                  $isql = "SELECT
                      SGD_OEM_OEMPRESA AS NOMBRE,
                      SGD_OEM_DIRECCION AS DIRECCION,
                      SGD_OEM_CODIGO AS IDENTIFICADOR
                      FROM
                      SGD_OEM_OEMPRESAS
                      WHERE
                      SGD_OEM_CODIGO=$sgd_oem_codi";
              }

              if($sgd_doc_fun>0) {
                  $isql = "SELECT
                      USUA_NOMB AS NOMBRE,
                      D.DEPE_NOMB AS DIRECCION,
                      USUA_DOC AS IDENTIFICADOR,
                      USUA_EMAIL AS MAIL
                      FROM
                      USUARIO U ,
                      DEPENDENCIA D
                      WHERE
                      USUA_DOC='$sgd_doc_fun'
                      and  u.DEPE_CODI = d.DEPE_CODI ";
              }

              $rs2 = $db->conn->Execute($isql);
		      $nombre_otros = "";
              if($rs2 && !$rs2->EOF){
                  $nombre_otros =$rs2->fields["NOMBRE"]."".$rs2->fields["APELL1"]." ".$rs2->fields["APELL2"];
              }
              ?>

              <tr>
                    <input type="hidden"   name="radicado_rem" value=<?=$sgd_dir_tipo?>  id="rusuario"
                    '<?php  if($radicado_rem==$sgd_dir_tipo){echo " checked ";}?>'>
                <td width='100%' align="center"  colspan="2" >
                  <small>
                      <?=$nombre_otros?>
                      <?=$rs2->fields["DIRECCION"];?>
                  </small>
                </td>
                <td align="center"  colspan="1">
                  <small>
                      <a href='nuevo_archivo.php?<?=$variables?>&borrar=<?=$sgd_dir_tipo?>&tpradic=<?=$tpradic?>&numrad=<?=$numrad?>&aplinteg=<?=$aplinteg?>'>Borrar</a>
                  </small>

                </td>
              </tr>

              <?php
              $rs->MoveNext();
          }
          echo "    </table>
                  </td>
                </tr>";
        ?>
        <input name="usuar" type="hidden" id="usuar" value="<?php echo $usuar ?>">
        <input name="predi" type="hidden" id="predi" value="<?php echo $predi ?>">
        <input name="empre" type="hidden" id="empre" value="<?php echo $empre ?>">

        <?php
        if($tipo==999999){
                    echo " <div align='left'>
              <font size='1' color='#000000'><b>Ubicaci&oacute;n F&iacute;sica:</b></font>
              <input type='text' name='anex_ubic' value='$anex_ubic'>
              ";
        }
        ?>

    </tr>
    <tr>
      <td colspan="2">

      <table width="100%" class="table table-bordered">
      <tr align="center" >
        <td width="203"  ><small>Documento</small></td>
        <td   ><small>Nombre</small></td>
        <td  ><small>Dirigido a</small></td>
        <td  width="103" colspan='2'><small>Direccion</small></td>
        <td  width="68"><small>Email</small></td>
        <td  width="68" colspan="2"><small>Otros</small></td>
      </tr>
      <tr class='<?=$grilla ?>'>
        <TD align="center" >
          <input type=hidden name=telefono_us1 value='' class=tex_area  size=10>
          <input type=hidden name=tipo_emp_us1 class=tex_area size=3 value='<?=$tipo_emp_us1?>'>
          <input type=hidden name=documento_us1 class=tex_area size=3 value='<?=$documento_us1?>'>
          <input type=hidden name="idcont1" id="idcont1" value='<?=$idcont1 ?>' class=e_cajas size=4>
          <input type=hidden name="idpais1" id="idpais1" value='<?=$idpais1 ?>' class=e_cajas size=4>
          <input type=hidden name="codep_us1" id="codep_us1" value='<?=$codep_us1 ?>' class=e_cajas size=4 >
          <input type=hidden name="muni_us1" id="muni_us1"  value='<?=$muni_us1 ?>' class=e_cajas size=4 >
          <input type=text   name="cc_documento_us1" value='<?=$cc_documento_us1 ?>' class=e_cajas size=8 >
        </TD>
        <TD width="329" align="center">
          <input type="text" name="nombre_us1" value='' size="3" class="tex_area">
          <input type="text" name="prim_apel_us1" value='' size="3" class="tex_area">
          <input type="text" name="seg_apel_us1" value='' size="3" class="tex_area">
        </TD>
        <TD width="140" align="center"  colspan='2'>
          <input type=text name="otro_us7" value='' class=tex_area   size=20 maxlength="45">
        </TD>
        <TD align="center" >
          <input type=text name=direccion_us1 value='' class=tex_area  size=6>
        </TD>
        <TD width="68" align="center">
          <input type=text name=mail_us1 value='' class="tex_area" size="11">
        </TD>
        <TD width="68" align="center" colspan="2">
          <input type=text name="otro_us1" value='' class=tex_area" size="11">
        </TD>
      </tr>
      <tr>
        <td colspan="7"  align="center">
          <center>

      <font size="1" class="etextomenu">
      <small>Otro Destinatario <?  $busq_salida="true"; ?></small>
      </font>
        <input type="button" name="Button" value="BUSCAR" class="botones" onClick="Start('<?=$ruta_raiz?>/radicacion/buscar_usuario.php?ent=<?=$ent?>&busq_salida=<?=$busq_salida?>&nombreTp3=<?=$nombreTp3?>&krd=<?=$krd?>',1024,500);">
      <input type="button" name="cc" value="Grabar Destinatario" class="botones_mediano"  onClick="continuar_grabar()" ><small>
      <br/><?=$grabar?></small>
        </center>
        </td>
      </tr>
      </table>
    </font></td>
    </tr>
<?php
}
  $maximo_tamano = number_format((return_bytes(ini_get('upload_max_filesize')))/1000000,2);
  $tamano_archivo = return_bytes(ini_get('upload_max_filesize'));
?>
    <tr><td colspan="2"></td></tr>
    <tr align="center">
          <td align="center" colspan="2" >
          <input type="hidden" name="MAX_FILE_SIZE" value="<?php echo $tamano_archivo; ?>">
						   <input name="userfile1" type="file" onChange="escogio_archivo();" id="userfile" value="valor" class="btn btn-primary">
						<small>Archivo debe ser menor a <?php echo $maximo_tamano; ?>Mb.</small>
						<p><small class="btn btn-success"><?=$mensaje?></small></p>
						<p><small class="btn btn-success"><?=$mostrar_mensaje?></small></p>
          </td>
    </tr>

    <tr>
        <TD colspan="2" align="center">
        <footer>
            <input name="button" type="button" class="btn btn-success" onClick="actualizar()" value="ACTUALIZAR <?=$codigo?>">
            <?php
                echo "<input type='button' id='cerraranexar' class='btn btn-default' value='Cerrar'>";
            ?>
        <footer>
      </td>
    </tr>
	 </table>
	 <input type="hidden" name="i_copias" value='<?=$i_copias?>' id="i_copias" >
	 </td>
	 </tr>
	</table>
	</DIV>
	</DIV>
</form>
</div>
</body>

<script type="text/javascript">
  $(document).ready(function() {
      $('body').on("click", '#cerraranexar',function(){
          window.opener.$.fn.cargarPagina("./lista_anexos.php","tabs-c"); window.close();
      });
  });
</script>

</html>