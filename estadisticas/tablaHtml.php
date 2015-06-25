<div class="col-sm-12">
  <section id="widget-grid">
      <article>
        <div>
            <div>
            <?php
            foreach ($_GET as $key => $valor)   ${$key} = $valor;
              require_once($ruta_raiz."/include/myPaginador.inc.php");

              $paginador=new myPaginador($db,($queryE),$orden);

              //$_SESSION["tipoEstadistica"] = $tipoEstadistica;
              $paginador->moreLinks = "&tipoEstadistica=".$_GET['tipoEstadistica']."&";

              if(!isset($_GET['genDetalle'])){
                $orden=isset($orden)?$orden:"";
                $paginador->setFuncionFilas("pintarEstadistica");
              } else {
                $paginador->setFuncionFilas("pintarEstadisticaDetalle");
              }
              $paginador->setImagenASC($ruta_raiz."iconos/flechaasc.gif");
              $paginador->setImagenDESC($ruta_raiz."iconos/flechadesc.gif");
              //$paginador->setPie($pie);
              echo $paginador->generarPagina($titulos,"titulos3");

            if(!isset($_GET['genDetalle'])&& $paginador->getTotal() > 0){
              $total=$paginador->getId()."_total";
              if(!isset($_REQUEST[$total])) {
              $res = $db->conn->query($queryE);
              $datos=0;

              while(!$res->EOF){
                $data1y[]=$res->fields[1];
                $nombUs[]=$res->fields[0];
                $res->MoveNext();
              }

              $nombYAxis=substr($titulos[1],strpos($titulos[1],"#")+1);
              $nombXAxis=substr($titulos[2],strpos($titulos[2],"#")+1);
                $nume_ale = rand(1,100);
              $nombreGraficaTmp = $ruta_raiz."bodega/tmp/E_$nume_ale.png";
              $rutaImagen = $nombreGraficaTmp;
              if(file_exists($rutaImagen)){
                unlink($rutaImagen);
              }
              $notaSubtitulo = $subtituloE[$tipoEstadistica]."\n";
              $tituloGraph = $tituloE[$tipoEstadistica];
              //include "genBarras1.php";
            }
  	  ?>

          <? if ($block_details !=1 )  {
             if ($tipoEstadistica!=1000 )  {
                if ($genTodosDetalle != 1 or $genDetalle != 1) {
                echo "<center><a href=\"genEstadistica.php?$datosEnvioDetalle&genTodosDetalle=1&$datosaenviar\" Target=\"VerDetalle".date("dmYHis")."\" class=\"btn btn-sm btn-primary\"> Ver todos los detalles</a></center><br/>";
                }
              }
	     }
	    }
            ?>
          </div>
        </div>
      </article>
  </section>
</div>
</body>
</html>

