<div class="col-sm-12">
  <section id="widget-grid">
      <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="jarviswidget jarviswidget-color-darken" id="wid-id-1" data-widget-editbutton="false">
            <div class="widget-body">
            <?php
            foreach ($_GET as $key => $valor)   ${$key} = $valor;
              require_once($ruta_raiz."/include/myPaginadorPDF.inc.php");

              $paginador=new myPaginador($db,($queryE),$orden);

              //$_SESSION["tipoEstadistica"] = $tipoEstadistica;
              $paginador->moreLinks = "&tipoEstadistica=".$_GET['tipoEstadistica']."&";
              $paginador->setFuncionFilas("pintarEstadisticaDetalle");
              $paginador->setImagenASC($ruta_raiz."iconos/flechaasc.gif");
              $paginador->setImagenDESC($ruta_raiz."iconos/flechadesc.gif");
              //$paginador->setPie($pie);
	      $tabla_generada =  $paginador->generarPagina($titulos,"titulos3"); 
            ?>
          </div>
        </div>
      </article>
  </section>
</div>
</body>
</html>

