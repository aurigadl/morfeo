 <?php
/*
 * parse_message.php
 *
 * @(#) $Header: /home/mlemos/cvsroot/pop3/parse_message.php,v 1.4 2008/01/09 07:32:19 mlemos Exp $
 *
 */

?><html>
<head>
<title>Parsing a message with Manuel Lemos' PHP POP3 and MIME Parser classes</title>
</head>
<body>
<center><h1>Parsing a message with Manuel Lemos' PHP POP3 and MIME Parser classes</h1></center>
<hr />
<?php
  require('includes/mime_parser.php');
  require('includes/rfc822_addresses.php');
  require_once('pop3.php');

  stream_wrapper_register('pop3', 'pop3_stream');  /* Register the pop3 stream handler class */

  $user=UrlEncode("");
  $password=UrlEncode("");
  $realm=UrlEncode("");                         /* Authentication realm or domain            */
  $workstation=UrlEncode("");                   /* Workstation for NTLM authentication       */
  $apop=0;                                      /* Use APOP authentication                   */
  $authentication_mechanism=UrlEncode("USER");  /* SASL authentication mechanism             */
  $debug=1;                                     /* Output debug information                  */
  $html_debug=1;                                /* Debug information is in HTML              */
  $message=1;
  $message_file='pop3://jlosada:Jhlc11724@localhost/1?debug=0&html_debug=0&realm='.$realm.'&workstation='.$workstation.
      '&apop='.$apop.'&authentication_mechanism='.$authentication_mechanism;
  /*
   * Access Gmail POP account
   */
  /*
   $message_file='pop3://'.$user.':'.$password.'@pop.gmail.com:995/1?tls=1&debug=1&html_debug=1';
    */

  $mime=new mime_parser_class;

  /*
   * Set to 0 for not decoding the message bodies
   */
  $mime->decode_bodies = 1;

  $parameters=array(
      'File'=>$message_file,
      
      /* Read a message from a string instead of a file */
      /* 'Data'=>'My message data string',              */

      /* Save the message body parts to a directory     */
      /* 'SaveBody'=>'/tmp',                            */

      /* Do not retrieve or save message body parts     */
         'SkipBody'=>1,
  );
  $success=$mime->Decode($parameters, $decoded);


  if(!$success)
      echo '<h2>MIME message decoding error: '.HtmlSpecialChars($mime->error)."</h2>\n";
  else
  {
      echo '<h2>MIME message decoding successful</h2>'."\n";
      echo '<h2>Message structure</h2>'."\n";
      echo '<pre>';
      var_dump($decoded[0]);
      echo '</pre>';
      if($mime->Analyze($decoded[0], $results))
      {
          echo '<h2>Message analysis</h2>'."\n";
          echo '<pre>';
          var_dump($results);
          echo '</pre>';
      }
      else
          echo 'MIME message analyse error: '.$mime->error."\n";
  }
?>
<hr />
</body>
</html>