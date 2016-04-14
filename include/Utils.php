<?php
ini_set("display_errors",0);
/***
metodos agrupados por Aquiles Canto
***/

class Utils {
	public static function getIp() {
		$ipCliente = false;
		$ipEncontrada = null;
		$ipEncontrada = null;
		$ipEncontrada = null;
		
		if (! empty ( $_SERVER ['HTTP_X_FORWARDED_FOR'] )) { // buscamos la ip en la vaiable server.
			$ipCliente = (! empty ( $_SERVER ['REMOTE_ADDR'] )) ? $_SERVER ['REMOTE_ADDR'] : ((! empty ( $_ENV ['REMOTE_ADDR'] )) ? $_ENV ['REMOTE_ADDR'] : "Sin Info");
			$ent = explode ( ", ", $_SERVER ['HTTP_X_FORWARDED_FOR'] );
			reset ( $ent );
			foreach ( $ent as $valor ) {
				$valor = trim ( $valor );
				if (preg_match ( "/^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/", $valor, $lista_ips )) {
					$ipsPrivadas = array (
							'/^0\./',
							'/^127\.0\.0\.1/',
							'/^192\.168\..*/',
							'/^172\.((1[6-9])|(2[0-9])|(3[0-1]))\..*/',
							'/^10\..*/' 
					);
					$ipEncontrada = preg_replace ( $ipPrivadas, $ipCliente, $lista_ips [1] );
					if ($ipCliente != $ipEncontrada) {
						$ipCliente = $ipEncontrada;
					}
				}
			}
		}
		if (! $ipCliente) {
			$headers = getallheaders ();
			if (! empty ( $headers ["X-Forwarded-For"] )) {
				$ipCliente = $headers ["X-Forwarded-For"];
				$ent = explode ( ", ", $headers ["X-Forwarded-For"] );
				reset ( $ent );
				$ipCliente = $ent [0];
			} else
				$ipCliente = (! empty ( $_SERVER ['REMOTE_ADDR'] )) ? $_SERVER ['REMOTE_ADDR'] : ((! empty ( $_ENV ['REMOTE_ADDR'] )) ? $_ENV ['REMOTE_ADDR'] : "Sin Informacion");
		}
		return $ipCliente;
	}
	public static function getIP2() {
		if (isSet ( $_SERVER )) {
			if (isSet ( $_SERVER ["HTTP_X_FORWARDED_FOR"] )) {
				$realip = $_SERVER ["HTTP_X_FORWARDED_FOR"];
			} elseif (isSet ( $_SERVER ["HTTP_CLIENT_IP"] )) {
				$realip = $_SERVER ["HTTP_CLIENT_IP"];
			} else {
				$realip = $_SERVER ["REMOTE_ADDR"];
			}
		} else {
			if (getenv ( "HTTP_X_FORWARDED_FOR" )) {
				$realip = getenv ( "HTTP_X_FORWARDED_FOR" );
			} elseif (getenv ( "HTTP_CLIENT_IP" )) {
				$realip = getenv ( "HTTP_CLIENT_IP" );
			} else {
				$realip = getenv ( "REMOTE_ADDR" );
			}
		}
		return $realip;
	}
	public static function return_bytes($val) {
		$val = trim ( $val );
		$ultimo = strtolower ( $val {strlen ( $val ) - 1} );
		switch ($ultimo) { // El modificador 'G' se encuentra disponible desde PHP 5.1.0
			case 'g' :
				$val *= 1024;
			case 'm' :
				$val *= 1024;
			case 'k' :
				$val *= 1024;
		}
		return $val;
	}
	public static function checkldapuser($username, $password, $userBind=1) {
		$path_raiz = realpath ( dirname ( __FILE__ ) . "/../../" );
		require ($path_raiz . '/config.php');
		$username = strtolower ( $username );
		$connect = ldap_connect ( $ldapServer );
		if ($connect != false) {
			ldap_set_option ( $connect, LDAP_OPT_PROTOCOL_VERSION, 3 );
			ldap_set_option ( $connect, LDAP_OPT_REFERRALS, 0 );
			// enlace a la conexión
			//echo "$username, $password, $userBind";
			if($userBind!=1){ $userLDAP = $username; $pwdLDAP=$password;}
			//$userLDAP = $username; $pwdLDAP=$password;
			$bind = ldap_bind ( $connect, $userLDAP."@".$dominioLdap, $pwdLDAP );
			if ($bind == false) {
				$mensajeError = "Falla la conexi&oacute;n con el servidor LDAP con el usuario	$userLDAP@$dominioLdap bind>$userBind";
				return $mensajeError;
			}else{
			    if($userBind!=1){
				  return  1;
				}
			}
			// busca el usuario
			$filtro = "($campoBusqLDAP=$username)";
			//$filtro = "(uid=$username)";
			$res_id = ldap_search ( $connect, $cadenaBusqLDAP, $filtro );
			$cant = ldap_count_entries ( $connect, $res_id );
			if ($res_id == false) {
				$mensajeError = "No encontrado el usuario en el A.D.";
				return $mensajeError;
			}
			
			$cant = ldap_count_entries ( $connect, $res_id );
			if ($cant == 0) {
				$mensajeError = "El usuario $username NO se encuentra en el A.D. $bind";
				return $mensajeError;
			}
			
			if ($cant > 1) {
				$mensajeError = "El usuario $username se encuentra $cant veces en el A.D.";
				return $mensajeError;
			}
			
			$entry_id = ldap_first_entry ( $connect, $res_id );
			if ($entry_id == false) {
				$mensajeError = "No se obtuvieron resultados";
				return $mensajeError;
			}
			
			if (($user_dn = ldap_get_dn ( $connect, $entry_id )) == false) {
				$mensajeError = "No se puede obtener el dn del usuario";
				return $mensajeError;
			}
			
			/* Autentica el usuario */

			if (($link_id = ldap_bind ( $connect, "$user_dn", $password )) == false) {
				error_reporting ( 0 );
				$mensajeError = "USUARIO O CONTRASE&Ntilde;A INCORRECTOS";
				return $mensajeError;
			}
			
			return '1';
			@ldap_close ( $connect );
		} else {
			$mensajeError = "no hay conexi&oacute;n a '$ldap_server'";
			return $mensajeError;
		}
		
		@ldap_close ( $connect );
		return (false);
	}
	
	/**
	 * funcion que ajusta los codigos de los anexos con el tama�o de la dependencia
	 */
	public static function carpetaDependencia($numRadicado, $noDigitosDependencia) {
		$dependencia = substr ( $numRadicado, 4, $noDigitosDependencia );
		return $dependencia + 0;
	}
	public static function fechaFormateada($FechaStamp) {
		$ano = date ( 'Y', $FechaStamp ); // <-- A�o
		$mes = date ( 'm', $FechaStamp ); // <-- n�mero de mes (01-31)
		$dia = date ( 'd', $FechaStamp ); // <-- D�a del mes (1-31)
		$dialetra = date ( 'w', $FechaStamp ); // D�a de la semana(0-7)
		switch ($dialetra) {
			case 0 :
				$dialetra = "domingo";
				break;
			case 1 :
				$dialetra = "lunes";
				break;
			case 2 :
				$dialetra = "martes";
				break;
			case 3 :
				$dialetra = "miércoles";
				break;
			case 4 :
				$dialetra = "jueves";
				break;
			case 5 :
				$dialetra = "viernes";
				break;
			case 6 :
				$dialetra = "sábado";
				break;
		}
		switch ($mes) {
			case '01' :
				$mesletra = "Enero";
				break;
			case '02' :
				$mesletra = "Febrero";
				break;
			case '03' :
				$mesletra = "Marzo";
				break;
			case '04' :
				$mesletra = "Abril";
				break;
			case '05' :
				$mesletra = "Mayo";
				break;
			case '06' :
				$mesletra = "Junio";
				break;
			case '07' :
				$mesletra = "Julio";
				break;
			case '08' :
				$mesletra = "Agosto";
				break;
			case '09' :
				$mesletra = "Septiembre";
				break;
			case '10' :
				$mesletra = "Octubre";
				break;
			case '11' :
				$mesletra = "Noviembre";
				break;
			case '12' :
				$mesletra = "Diciembre";
				break;
		}
		return "$dialetra $dia de $mesletra de $ano";
	}
}

?>

