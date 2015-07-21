<?php
#echo "---"; exit;
class ConnectionHandler {

//Almacena un error, resultado de una transacci�
/**
  * ESTA CLASE INICIA LA CONEXION A LA BD SELECCIONADA
	* @$conn  objeto  Variable que almacena la conexion;
	* @$driver char  Variable que almacena la bd Utilizada.
	* @$rutaRaiz char Indica la ruta para encontrar la ubicacion de la raiz de la aplicacion.
	* @$dirOrfeo char Directorio del servidor web en el cual se encuentra instalado Orfeo.
	*
	*/

var $Error;
var $id_query;

var $driver;
var $rutaRaiz;
var $conn;
var $entidad;
var $entidad_largo;
var $entidad_tel;
var $entidad_dir;
var $querySql;
var $limitPsql;
var $limitOci8;
var $limitMsql;
/* Metodo constructor */
function ConnectionHandler($ruta_raiz){
	if (!defined('ADODB_ASSOC_CASE')) define('ADODB_ASSOC_CASE',1);
	//include ("$ruta_raiz/adodb/adodb-errorpear.inc.php");
	include ("$ruta_raiz/adodb/adodb.inc.php");
	include_once ("$ruta_raiz/adodb/adodb-paginacion.inc.php");
	include_once ("$ruta_raiz/adodb/tohtml.inc.php");
	include ("$ruta_raiz/config.php");
    $ADODB_COUNTRECS = false;
	$this->driver = $driver;
	$this->conn  = NewADOConnection("$driver");
	$this->conn->charSet = 'utf8';
	$this->rutaRaiz = $ruta_raiz;
	if ($this->conn->Connect($servidor,$usuario,$contrasena,$servicio) == false)
		die("Error de conexi&oacute;n a la B.D.");
	$this->entidad = $entidad;
	$this->entidad_largo = $entidad_largo;
	$this->entidad_tel = $entidad_tel;
	$this->entidad_dir = $entidad_dir;
}
function imagen()
{
	switch($this->entidad)
	{
		case "CRA":
			$imagen = "png/logoCRA.gif";
		break;
		case "DNP":
			$imagen = "png/logoDNP.gif";
		break;
		case "SSPD":
			$imagen = "png/escudoColombia.jpg";
		break;
		default:
			$imagen = "";
		break;
	}
	return($imagen);
}
//  Retorna False en caso de ocurrir error;
function query($sql)
{
$cursor = $this->conn->Execute($sql);

if (!$cursor){
//$error_object = ADODB_Pear_Error();
//$mensaje_error = $error_object->message;
$this ->log_error ("include/db/ConectionHandler - query linea: 69 ","No se pudo realizar la consulta \n $mensaje_error ",$sql,2);
}

  return $cursor;
}
//  Retorna la fecha actual segun la BD del driver;
function sysdate()
{
  if($this->driver == "postgres")  return "now()";
  if($this->driver == "oci8")  return "sysdate";
  if($this->driver == "mssql")  return "GETDATE()";
}

//  Retorna la fecha actual segun la BD del driver;
function limit($numRows)
{
  $this->limitOci8 = "";
  $this->limitMsql = "";
  $this->limitPsql = "";   
  if($this->driver == "postgres")  $this->limitPsql = "limit $numRows";
  if($this->driver == "oci8")  $this->limitOci8 = " and ROWNUM <= $numRows";
  if($this->driver == "mssql") $this->limitMsql = " top $numRows ";
}

function getDriver(){
if($this->driver == "postgres")  $this->Driver = "postgres";
if($this->driver == "oci8")  $this->Driver = "oci8";
if($this->driver == "mssql") $this->Driver = "mssql";
}

/* Devuelve un array correspondiente a la fila de una consulta */
/*	function fetch_row() {

	//return ifx_fetch_row($this->id_query);

	ora_fetch_into($this->idconnection,$row, ORA_FETCHINTO_NULLS|ORA_FETCHINTO_ASSOC);
	$this->id_query=$row;
	return ($row);

	}
*/

/* Devuelve el nmero de campos de una consulta */
/*
	function numfields() {

	return ifx_num_fields($this->id_query);

	}

 */

/* Devuelve el nmero de registros de una consulta */
/*
	function numrows(){

	return ifx_affected_rows($this->id_query);

	}
*/

/* Funcion miembro que carga dos arrays con los nombres de los campos y el tipo de dato respectivamente. */
/*
	function fieldsinfo() {

	$types = ifx_fieldtypes($this->id_query);

	for ($i = 0; $i < count($types); $i++) {

	$this->fieldsnames[$i] = key($types);

	$this->$fieldstypes[$i] = $types[$this->fieldsnames[$i]];

	next($types);

	}

	}

*/
/* Funcion miembro que realiza una consulta a la base de datos y devuelve un record set */

function getResult($sql) {
	if ($sql == "") {
	$this ->log_error ("ConectionHandler-getResult","No se ha especificado una consulta SQL",$sql,2);
		$this->Error = "No ha especificado una consulta SQL";
		print($this->Error);
		return 0;
	}
	return ($this->query($sql));
}


/* Funcion miembro que ejecuta una instruccion sql a la base de datos. */

/*Log de errores Cesar Buelvas (cejebuto@gmail.com)*/
	function log_error($numero,$texto,$data,$tipo){

	// tipo = 1 (array)
	//tipo = 2 (sql)

	if ($tipo == 1){
		$array = $data;
		foreach ($array as $k => $valor) {
			$data_show .= "[$k] => $valor \n";
		}
	}else{
		$data_show = "$data";
	}

	//Sedebe crear el archivo donde guardar el log. 
	//chown  www-data / apache error.log
	//chmod 777 error.log
   $ruta_absoluta = $_SESSION['RUTA_ABSOLUTA'];
   
	$ru_dt = "$ruta_absoluta/include/tx/error.log";

	if (file_exists($ru_dt)){
		$ddf = fopen($ru_dt,'a');
fwrite($ddf,"[".date("r")."] --> $numero: $texto \n --------------------------- \n $data_show
---------------------------------------------------------------------------------------------
		");
	fclose($ddf);
		}
	}	
/*Fin de la funcion de log de errores*/


/*
   Funcion miembro que recibe como parametros: nombre de la tabla, un array con los nombres de los campos,
   y un array con los valores respectivamente.
*/

	function insert($table,$record) {
  	$temp = array();
    $fieldsnames = array();
  	foreach($record as $fieldName=>$field )
  	{
      $fieldsnames[] = $fieldName;
    	$temp[] = $field;
    }
  	$sql = "insert into " . $table . "(" . join(",",$fieldsnames) . ") values (" . join(",",$temp) . ")";
		if ($this->conn->debug==true)
  	{
  	 echo "<hr>(".$this->driver.") $sql<hr>";
  	}
		$this->querySql = $sql;
		
		//$this->conn->BeginTrans();
    //
    
		$res = $this->conn->Execute($sql);
		
		if ($res==false){
 		$this ->log_error ("ConectionHandler-Insert","No se pudo insertar la consulta",$sql,2);
		$this->conn->RollbackTrans();
		}
		else
		{
//		 $this ->log_error ("ConectionHandler","Consulta ejecutada correctamente",$sql,2);
		 $this->conn->CommitTrans();
		}
		return( $res );
	}
/*
   Funcion miembro que recibe como parametros: nombre de la tabla,
   un array con los nombres de los campos
   ,un array con los valores, un array con los nombres de los campo id y
   un array con los valores de los campos id respectivamente.
*/



	function update($table, $record, $recordWhere) {

	$tmpSet = array();
	$tmpWhere = array();
	foreach($record as $fieldName=>$field )
	{
	  $tmpSet[] = $fieldName . "=" . $field;
	}

	foreach($recordWhere as $fieldName=>$field )
	{
	  $tmpWhere[] = " " . $fieldName . " = " . $field . " ";
	}
	$sql = "update " . $table ." set " . join(",",$tmpSet) . "    where " . join(" and ",$tmpWhere);
  if ($this->conn->debug==true)
  	{
  	 echo "<hr>(".$this->driver.") $sql<hr>";
  	}
  	$res = $this->conn->Execute( $sql );
	
  	if( !$res )
	{$this ->log_error ("ConectionHandler","No se pudo Actualizar la consulta",$sql,2);
		//$this->conn->RollbackTrans();
	}
	else
	{	
		//$this->conn->CommitTrans();
	}
	return( $res );
	//return ($this->conn->Execute($sql));

}


/*
   Funcion miembro que recibe como parametros: nombre de la tabla, un array con los
   nombres de los campos id, y un array con los valores de los id.
*/


	function delete($table, $record) {

	$temp = array();

	foreach($record as $fieldName=>$field )
	{
	$tmpWhere[] = "  " . $fieldName . "=" . $field;
	}
	$sql = "delete from " . $table . " where " . join(" and ",$tmpWhere);

	//print("*** $sql ****");
  if ($this->conn->debug==true)
  	{
  	 echo "<hr>(".$this->driver.") $sql<hr>";
  	}
	return ($this->query($sql));

	}

	function nextId($secName){
		if ($this->conn->hasGenID)
			return $this->conn->GenID($secName);
		else{
			$retorno=-1;

			if ($this->driver=="oracle"){
				$q= "select $secName.nextval as SEC from dual";
				$this->conn->SetFetchMode(ADODB_FETCH_ASSOC);
				$rs=$this->query($q);
				//$rs!=false &&
				if  ( !$rs->EOF){
					$retorno = $rs->fields['SEC'];
					//print ("Retorna en la funcion de secuencia($retorno)");
				}
			}
			return $retorno;
		}
	}
/*
* @param $string string cadena para convertir caracteres especiales a mayuscula para busquedas
*/
static function fullUpper($string){
  return strtr(strtoupper($string), array(
      "à" => "À",
      "è" => "È",
      "ì" => "Ì",
      "ò" => "Ò",
      "ù" => "Ù",
      "á" => "Á",
      "é" => "É",
      "í" => "Í",
      "ó" => "Ó",
      "ú" => "Ú",
      "â" => "Â",
      "ê" => "Ê",
      "î" => "Î",
      "ô" => "Ô",
      "û" => "Û",
      "ç" => "Ç",
      "ñ" => "Ñ",
    ));
}


 /*
 function datoActualizado($mensaje) {
	echo  "<script>";
	echo  ("alert ('$mensaje');");
	echo  "</script>";

}

*/
/*
   Funcion miembro que libera los recursos de la consulta realizada.
*/

/*
	function free(){

	ifx_free_result($this->id_query);

	}

*/

/*
   Funcion miembro que cierra la conexion abierta a la base de datos.
*/

/*
	function close(){

	ifx_close($this->idconnection);

	}*/
}

?>
