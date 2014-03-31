<?php

if (!isset($tipoMed)){
    $tipoMed = "";
}
if(!isset($buscar_por_cuentai)){
    $buscar_por_cuentai = "";
}
if(!isset($buscar_por_radicado)){
    $buscar_por_radicado = "";
}
if(!isset($buscar_por_exp)){
    $buscar_por_exp = "";
}
if(!isset($buscar_por_doc)){
    $buscar_por_doc = "";
}
if(!isset($buscar_por_nombres)){
    $buscar_por_nombres = "";
}
if(!isset($pnomb)){
    $pnomb = "";
}

?>
<script>
function solonumeros(){

 jh =  document.getElementById('buscar_por_radicado').value;
 if(jh){
    var1 =  parseInt(jh);
		if(var1 != jh)
		{
			alert("Atencion: El numero de Radicado debe ser de solo Numeros. ");
			return false;
		}else{
			document.getElementById('buscar_por_radicado').value = var1;
			numCaracteres = document.getElementById('buscar_por_radicado').value.length;
                        <?php
                       $ln=$_SESSION["digitosDependencia"];
                       $lnr=11+$ln;
                        ?>

			if(numCaracteres>=13 && numCaracteres<=<?php echo $lnr; ?>)
			{
				document.formulario.submit();
			}else
			{
				alert("Atencion: El numero de Caracteres del radicado es de <?php echo $lnr; ?>. (Digito :"+numCaracteres+")");
			}
			
		}
 }else{
 	document.formulario.submit();
 }
}
</script>
<link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="../js/spiffyCal/spiffyCal_v2_1.js"></script>
<script language="javascript">
<?php
  $ano_ini = date("Y");
  $mes_ini = substr("00".(date("m")-1),-2);
  if ($mes_ini=="00") {$ano_ini=$ano_ini-1; $mes_ini="12";}
  $dia_ini = date("d");
  if(!$fecha_ini) $fecha_ini = "$ano_ini/$mes_ini/$dia_ini";
    $fecha_busq = date("Y/m/d") ;
  if(!$fecha_fin) $fecha_fin = $fecha_busq;
?>
var dateAvailable  = new ctlSpiffyCalendarBox("dateAvailable", "formulario", "fecha_ini","btnDate1","<?=$fecha_ini?>",scBTNMODE_CUSTOMBLUE);
var dateAvailable2 = new ctlSpiffyCalendarBox("dateAvailable2", "formulario", "fecha_fin","btnDate2","<?=$fecha_fin?>",scBTNMODE_CUSTOMBLUE);
</script>

   <fieldset>
    <div class="row">
      <section class="col col-4">
        <label class="label">
          <? if(isset($and_cuentai)) $datoss=" checked ";  else $datoss= " "; ?>
          <input  type="checkbox" name=and_cuentai value=1 <?=$datoss?> disabled>
          REFERENCIA (Cuenta I, Oficio)
        </label>
        <label class="input"></i>
          <input name="buscar_por_cuentai" type="text" class="ecajasfecha" id="cuentai" size="35" value="<?=$buscar_por_cuentai ?>">
        </label>
      </section>
      <section class="col col-4">
        <label class="label">
          <? if(isset($and_radicado)) $datoss=" checked ";  else $datoss= " "; ?>
          <input  type="checkbox" name=and_radicado value=1 <?=$datoss?> disabled>
          No. Radicado
        </label>
        <label class="input"></i>
          <input name="buscar_por_radicado" type="text" class="ecajasfecha" id="buscar_por_radicado" size="35" value="<?=$buscar_por_radicado ?>">
        </label>
      </section>

      <section class="col col-4">
        <label class="label">
         <? if(isset($and_expediente)) $datoss=" checked ";  else $datoss= " "; ?>
         <input  type="checkbox" name=and_expediente value=1 <?=$datoss?> disabled>
         Expediente
        </label>
        <label class="input"></i>
          <input name="buscar_por_exp" type="text" class="ecajasfecha" id="buscar_por" size="35" value="<?=$buscar_por_exp ?>">
        </label>
      </section>
    </div>

    <div class="row">
      <section class="col col-4">
        <label class="label">
          <? if(isset($and_doc)) $datoss=" checked ";  else $datoss= " "; ?>
          <input  type="checkbox" name=and_doc value=1 <?=$datoss?> disabled>
          Identificacion (T.I.,C.C.,Nit) *
        </label>
        <label class="input"> </i>
          <input name="buscar_por_doc" type="text" class="ecajasfecha" id="cuentai" size="35" value="<?=$buscar_por_doc ?>">
        </label>
      </section>
      <? if($ent!=22) { ?>
      <section class="col col-4">
        <label class="label">
         <? if(isset($and_nombres)) $datoss=" checked ";  else $datoss= " "; ?>
         <input  type="checkbox" name=and_nombres value=1 <?=$datoss?> disabled>
         Nombres
        </label>
        <label class="input"></i>
          <input name="buscar_por_nombres" type="text" class="ecajasfecha" id="buscar_por_nombres" size="35" value="<?=$buscar_por_nombres ?>">
        </label>
      </section>
      <? } ?>
      <section class="col col-4">
        <label class="label">
          Rango de Fechas de Radicaci&oacute;n
        </label>
        <div class="row">
          <section class="col col-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
              <input type="text" name="fecha_ini" id="startdate" placeholder="Expected start date">
            </label>
          </section>

          <section class="col col-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
              <input type="text" name="fecha_fin" id="finishdate" placeholder="Expected finish date">
            </label>
          </section>
        </div>


      </section>
    </div>
    <?php if(isset($mostrar_dep) && $mostrar_dep=="ddd"){ ?>
    <div class="row">
      <section class="col col-4">
        <label class="label">
          <? if(isset($and_doc)) $datoss=" checked ";  else $datoss= " "; ?>
          <input  type="checkbox" name=and_doc value=1 <?=$datoss?> disabled>
            Dependencia de Radicacion
        </label>
        <label class="input"> </i>
          <input name="buscar_por_dep_rad" type="text" id="cuentai" size="35" value="<?=$buscar_por_dep_rad?>">
        </label>
      </section>
    </div>
   <?}?>
   </fieldset>
   <footer>
     <button type="submit" name="submit" onClick="solonumeros();" class="btn btn-primary">
      Buscar
     </button>
   </footer>
   <input type='hidden' name='pnom' value='<?=$pnomb ?>'>
