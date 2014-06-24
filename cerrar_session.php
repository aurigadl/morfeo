<?php
session_start();
    $ruta_raiz = ".";
    include_once "$ruta_raiz/config.php";
    include_once "$ruta_raiz/include/db/ConnectionHandler.php";

    $db     = new ConnectionHandler($ruta_raiz);
    $fecha  = "'FIN  ".date("Y:m:d H:mi:s")."'";

    $isql   = "UPDATE
                    usuario
               SET
                    USUA_SESION =".$fecha."
               WHERE
                    USUA_SESION like '%".session_id()."%'";

    if (!$db->conn->Execute($isql)) {
        echo "<p>No pude actualizar<p><br>";
    }

    session_destroy();
    echo "<script>
        if(window.self !== window.top){
            top.location.reload();
        };
    </script>";

    header('Location: ./index.php');
    exit;