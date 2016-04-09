<?php
session_start();

$num = $_GET["msgNo"];
$imap = imap_open("{miip:995/pop3/ssl/novalidate-cert}", "usuario", "contraseña");
if( $imap ) {
     if( $num >0 ) {
          echo imap_fetchbody($imap, $num,1,FT_UID);
     }
     imap_close($imap);
}
?>
