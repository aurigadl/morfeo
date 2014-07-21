<?php

function checkMailuser($username,$password,$ruta_raiz){
  require($ruta_raiz."/email/pop3.php");
  //$username = "jlosada";
  $apop                           = 0;              // Use APOP authentication  */
  $pop3                           = new pop3_class();
  $pop3->hostname                 = "pop.gmail.com";
  $pop3->port                     = "995";
  $pop3->tls                      = 1;     /* Establish secure connections using TLS      */
  $pop3->realm                    = "";    /* Authentication realm or domain              */
  $pop3->workstation              = "";    /* Workstation for NTLM authentication         */
  $pop3->authentication_mechanism = "USER";/* SASL authentication mechanism               */
  $pop3->debug                    = 0;     /* Output debug information                    */
  $pop3->html_debug               = 1;     /* Debug information is in HTML                */
  $pop3->join_continuation_header_lines=1; /* Concatenate headers split in multiple lines */
  $pop3->Open();
//echo "$username,$password,$apop";
  $connect = $pop3->Login($username,$password,$apop);
  
  if (!$connect) 
  {
      return 0;
  }else{
  
     return $connect;
  }
}
?>


