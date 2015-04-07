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
   <fieldset>
    <div class="row">
      <section class="col col-4">
        <label class="label">
          REFERENCIA (Cuenta I, Oficio)
        </label>
        <label class="input"></i>
          <input name="buscar_por_cuentai" type="text" class="ecajasfecha" id="cuentai" size="35" value="<?=$buscar_por_cuentai ?>">
        </label>
      </section>
      <section class="col col-4">
        <label class="label">
          No. Radicado
        </label>
        <label class="input"></i>
          <input name="buscar_por_radicado" type="text" class="ecajasfecha" id="buscar_por_radicado" size="35" value="<?=$buscar_por_radicado ?>">
        </label>
      </section>

      <section class="col col-4">
        <label class="label">
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
          Identificaci&oacute;n (T.I.,C.C.,Nit) *
        </label>
        <label class="input"> </i>
          <input name="buscar_por_doc" type="text" class="ecajasfecha" id="cuentai" size="35" value="<?=$buscar_por_doc ?>">
        </label>
      </section>
      <? if($ent!=22) { ?>
      <section class="col col-4">
        <label class="label">
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
            <input type="text" name="fecha_ini" id="startdate" placeholder="Expected start date" value="<?=$fecha_ini?>">
            </label>
          </section>

          <section class="col col-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
              <input type="text" name="fecha_fin" id="finishdate" placeholder="Expected finish date" value="<?=$fecha_fin?>">
            </label>
          </section>

        </div>
      </section>

    </div>
    <?php if(isset($mostrar_dep) && $mostrar_dep=="ddd"){ ?>
    <div class="row">
      <section class="col col-4">
        <label class="label">
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
       <input type="submit" name="Submit" onClick="solonumeros();" title="Digite un dato para realizar una búsqueda previa" value="Buscar" onSelect="solonumeros();" class="btn btn-primary">
       <a class="btn btn-success" title="Seleccione Nuevo si su comunicación no se relaciona con otra comunicación existente" href='./NEW.php?<?=session_name()."=".trim(session_id())?>&dependencia=<?=$dependencia?>&ent=<?=$ent?>'>Nuevo</a>
   </footer>
   <input type='hidden' name='pnom' value='<?=$pnomb ?>'>
