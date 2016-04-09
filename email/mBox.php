<?php
     $imap = imap_open("{miip:995/pop3/ssl/novalidate-cert}INBOX", "usuario", "contraseña");
     $n_msgs = imap_num_msg($imap);
     error_reporting(7);
     echo "$n_msgs";
     $s = microtime(true);
     for ($i=0; $i<$n_msgs; $i++) {
          $header = imap_header($imap, $i);
     }
     $e = microtime(true);
     echo ($e - $s);
     imap_close($imap);

?> 
