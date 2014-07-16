<?php

/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
Copyright (C) 2013 Infometrika Ltda.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

session_start();

    $ruta_raiz = ".";
    if (!$_SESSION['dependencia'])
        header ("Location: $ruta_raiz/cerrar_session.php");

foreach ($_GET as $key => $valor)   ${$key} = $valor;
foreach ($_POST as $key => $valor)   ${$key} = $valor;


$krd         = $_SESSION["krd"];
$dependencia = $_SESSION["dependencia"];
$usua_doc    = $_SESSION["usua_doc"];
$codusuario  = $_SESSION["codusuario"];
$tip3Nombre  = $_SESSION["tip3Nombre"];
$tip3desc    = $_SESSION["tip3desc"];
$tip3img     = $_SESSION["tip3img"];

include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler($ruta_raiz);

$numeroa =
$numero  =
$numeros =
$numerot =
$numerop =
$numeroh =0;

$isql    = "select
                 a.*
                 ,b.depe_nomb
            from
                 usuario a
                 ,dependencia b
             where
                a.depe_codi=b.depe_codi
                and a.USUA_CODI = $codusuario
                and b.DEPE_CODI = $dependencia";

$rs     = $db->query($isql);

$dependencianomb = $rs->fields["DEPE_NOMB"];
$usua_login      = $rs->fields["USUA_LOGIN"];

?>
<html>
<head>
    <script language="JavaScript" type="text/JavaScript">

        function MM_findObj(n, d){
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
                    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n]; for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
                if(!x && d.getElementById) x=d.getElementById(n); return x;
        }

        function MM_validateForm(){
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
            if (val) { nm=val.name; if ((val=val.value)!="") {
                if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                } else if (test!='R') { num = parseFloat(val);
                if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                min=test.substring(8,p); max=test.substring(p+1);
                if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' es requerido.\n'; }
            } if (errors) alert('Asegurese de entrar el password Correcto, \N No puede ser Vacio:\n');
            document.MM_returnValue = (errors == '');
        }
    </script>
    <title>Cambio de Contrase&ntilde;as</title>
    <?php include_once "$ruta_raiz/htmlheader.inc.php"; ?>
</head>

<body>
    <form action='usuarionuevo.php' method="post" onSubmit="MM_validateForm('contradrd','','R','contraver','','R');return document.MM_returnValue">
	  <input type='hidden' name='<?=session_name()?>' value='<?=session_id()?>'>
    <div class="col-sm-12"> <!-- widget grid -->
      <h2></h2>
      <section id="widget-grid">
        <!-- row -->
        <div class="row">
          <!-- NEW WIDGET START -->
          <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">

              <header>
                <h2>
                  Cambio de contrase&ntilde;a<br>
                  <small><?=$tituloCrear ?></small>
                </h2>
              </header>
              <!-- widget div-->
              <div>
                <!-- widget content -->
                <div class="widget-body">
                  <div class="table-responsive smart-form">
                    <table class="table table-bordered table-striped ">
                      <tr>
                          <td class=listado2 colspan="2">
                            <center>Introduzca la nueva contrase&ntilde;a <b><?=$usua_login?></b>
                          </td>
                      </tr>
                      <tr>
                          <td class=listado2><center>Contrase&ntilde;a</td>
                          <td class=listado2><label class="input"><input type="password" name="contradrd"></label></td>
                      </tr>
                      <tr>
                          <td class=listado2><center>Re-escriba<br>la contrase&ntilde;a</td>
                          <td class=listado2><label class="input"><input type="password" name="contraver"></label></td>
                      </tr>
                      <tr>
                          <td class=listado2 colspan="2"><center><input class="btn btn-primary btn-sm" type="submit" value="Aceptar"></td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </article>
        </div>
      </section>
    </div>
	 </form>
</body>
</html>
