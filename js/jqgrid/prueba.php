<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<?php
  $ruta_raiz = "../..";
  include_once "../../htmlheader.inc.php";
  $table = "lote4686";
  $field = "chip";
  $fieldsView = "CHIP,FUENTE_DIRECCION,PROPIETARIOS_ACTUALES";
?>
<link rel="stylesheet" type="text/css" media="screen" href="resources/css/smoothness/jquery.ui.combogrid.css"/>
<script type="text/javascript" src="resources/plugin/jquery.ui.combogrid-1.6.3.js"></script>
<script>
jQuery(document).ready(function(){
		$( "#project" ).combogrid({
		url: 'server.php?table=<?=$table?>&field=<?=$field?>&fieldsView=<?=$fieldsView?>',
		debug:true,
    //replaceNull: true,
		colModel: [{'columnName':'CHIP','width':'25','label':'CHIP'}, {'columnName':'FUENTE_DIRECCION','width':'35','label':'DIRECCION'},{'columnName':'PROPIETARIOS_ACTUALES','width':'35','label':'PROPIETARIOS'}],
		select: function( event, ui ) {
			$( "#project" ).val( ui.item.CHIP );
			$( "#project-id" ).val( ui.item.FUENTE_DIRECCION );
			return false;
		}
	});
});
</script>
</head>
<body>
	<div>
		<div style="float:left"><input size="30" id="project-id"/><input size="30" id="project"/></div><br/>&nbsp;<br/>
		<div id="switcher" style="float:right"></div>
	</div>
</body>
</html>
