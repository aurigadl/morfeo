<?php
/**
* @author Jairo Losada   <jlosada@gmail.com>
* @author Cesar Gonzalez <aurigadl@gmail.com>
* @license  GNU AFFERO GENERAL PUBLIC LICENSE
* @copyright

SIIM2 Models are the data definition of SIIM2 Information System
Copyright (C) 2013 Infometrika Ltda.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

 *
 * @param integer $codeForm Codigo del Formulario que se va a Usar.
 *
 */

class genForm {

    /** Metodo que permite iniciar la clase del formularios
     * @param $db variable que carga el objeto que contiene la Base de Datos instanciada.
     * @param $dataSave arreglo de datos qeu se guardaran en el formulario.  Se pasaran en Json.
    */
    var $db;
    var $codeForm;
    var $nameForm;
    var $descriptionForm;
    var $dataSave;
    var $dataDelete;
    var $tablepksearch;
    var $fieldpksearch;
    var $varsparam;
    var $js_data_array = Array();

    function genForm($db) {
        // Constructor de la clase
        $this->db = $db;
        $this->db->conn->debug = false;
    }

    /** Metodo que permite iniciar la clase del formularios
     * @param $codeForm variable que carga el codigo del formulario
    */

    function getForm($codeForm) {

        $this->codeForm = $codeForm;
        $sql = "SELECT * FROM FRM_FORMS WHERE FRM_CODE=" . $codeForm;
        $rs  = $this->db->conn->query($sql);

        if (!$rs->EOF) {
            $this->nameForm        = $rs->fields["FRM_NAME"];
            $this->descriptionForm = $rs->fields["FRM_DESCRIPTION"];
            $this->tablepksearch   = $rs->fields["FRM_TABLEPKSEARCH"];
            $this->fieldpksearch   = $rs->fields["FRM_FIELDPKSEARCH"];
            $this->varsparam       = $rs->fields["FRM_VARSPARAM"];
            $this->fromAccion      = explode("|", $rs->fields["FRM_ACCION"]);
        }
    }

    /** Metodo que permite cargar el formulario
     * Con el contenido de una tabla.
     * Los parametros de la tabla son enviados por Get o Post y son
     * transferidos al where de la busqueda configurada desde la base de
     * datos del formulario
     * @return arreglo con los datos del formulario para ser pasados al usuario.
     */

    function loadDataForm($varContSearch) {

      $tablesearch = explode("||", $this->tablepksearch);
      $fieldpksearch = $this->fieldpksearch;
      $param_value   = $varContSearch;
      $db            = $this->db;
      $dataarray     = array();

      if(  empty($tablesearch)
        || empty($fieldpksearch)
        || empty($param_value)){
          return [];
      }

      foreach ($tablesearch as $tablepksearch){

        $sqlForm = "SELECT * FROM $tablepksearch WHERE $fieldpksearch = '$param_value'";
        $rs = $db->conn->query($sqlForm);

        while (!$rs->EOF) {
          foreach ($rs->fields as $nameField => $valueField){
            $dataarray[$nameField] = $valueField;
          }
          $rs->MoveNext();
        }
        if(!empty($dataarray)){
          return $dataarray;
        }
      }

    }

    /** Metodo que permite iniciar la clase del formularios
     * Este metodo requiere que la clase tenga cargada la
     * @param $codeForm variable que carga el codigo del formulario
     * @return Retorna confirmación del formualrio eliminado.
     */

    function deleteFormRegister() {

      $dataDelete = $this->dataDelete;
      $db         = $this->db;
      $deleted    = 0;

      foreach ($dataDelete as $key => $campo) {
        if($campo['fieldSave'] === 'frm_code'){
          $code = $campo['fieldValue'];
          $deleted++;
        }
        if($campo['fieldSave'] === 'frmf_name' && empty($campo['fieldValue'])){
          $deleted++;
        }
      }

      //TODO:Preguntar si las tablas que usa son unicas para este formulario
      //de ser de esa manera se eliminaran tambien.

      //TODO:Se deben borrar los  campos de la tabla formulario
      //la tabla donde se guarda el formulario  y el formulario
      //debe presentarcele  la opcion al usuairo si quiere eliminar las tablas
      //encontradas o solo el formato.

      if($deleted>1){
        //Borrar el formulario de la tabla pincipal
        $sql1 = "DELETE FROM
                  FRM_FORMS
                WHERE
                  FRM_CODE = $code";

        $rs = $this->db->conn->query($sql1);

        //Borrar los campos del formulario
        $sql2 = "DELETE FROM
                    FRMF_FRMFIELDS
                WHERE FRMT_CODE = $code";

        $rs = $this->db->conn->query($sql2);
      }

      if ($rs){
        echo '<div class="alert alert-block alert-success">
          <a class="close" href="#" data-dismiss="alert">×</a>
          <h4 class="alert-heading">
          <p> Se Borraron los Datos Correctamente ! </p>
        </div>';
      } else {
        echo '<div class="alert alert-danger fade in">
          <button class="close" data-dismiss="alert"> × </button>
          <i class="fa-fw fa fa-times"></i>
          <strong>Error!</strong>
          Al realizar la transaccion.
        </div>';
      }

    }

    /** Metodo que permite iniciar la clase del formularios
     * Este metodo requiere que la clase tenga cargada la
     * @param $codeForm variable que carga el codigo del formulario
     * @return Retorna un arreglo con los campos del Formulario.
    */
    function getFormFields() {
        $codeForm = $this->codeForm;
        $sql = "
        SELECT f.FRMF_NAME,
            f.FRMF_NAME,
            f.FRMF_DESCRIPTION,
            f.FRMF_SQL,
            f.FRMF_NULL,
            f.FRMF_LABEL,
            f.FRMF_MASK ,
            f.FRMF_COLUMN,
            f.FRMF_ORDER,
            f.FRMF_COLSPAN,
            f.FRMF_VARSPARAM,
            f.FRMF_VARS,
            f.FRMF_FIELDPK,
            f.FRMF_FIELD,
            f.FRMF_TABLESAVE,
            f.FRMF_TABLEPKSAVE,
            f.FRMF_TABLEPKSEARCH,
            f.FRMF_FIELDPKSEARCH,
            f.FRMF_PK,
            ft.FRMT_NAME,
            ft.FRMT_CLASS,
            ft.FRMT_HTML,
            ft.FRMT_Js,
            ft.FRMT_TYPE,
            f.FRMf_HELP,
            ft.FRMT_CODE,
            f.FRMF_ROWSPAN,
            f.FRMF_DEFAULT,
            f.FRMF_PARAMS
        FROM
            FRMF_FRMFIELDS f,
            FRMT_FIELDTYPE  ft
        WHERE
            f.FRM_CODE=" . $codeForm
            . " AND f.frmt_code=ft.frmt_code
            ORDER BY f.FRMF_ORDER,f.FRMF_COLUMN ";
        $rs = $this->db->conn->query($sql);

        $fields = array();
        $i = 0;
        if ($rs) {
          while (!$rs->EOF) {
            $nameField      = $rs->fields["FRMF_NAME"];
            $pkField        = $rs->fields["FRMF_PK"];
            $codeField      = $rs->fields["FRMF_CODE"];
            $descField      = $rs->fields["FRMF_DESCRIPTION"];
            $sqlField       = $rs->fields["FRMF_SQL"];
            $nullField      = $rs->fields["FRMF_NULL"];
            $colField       = $rs->fields["FRMF_COLUMN"];
            $orderField     = $rs->fields["FRMF_ORDER"];
            $colspanField   = $rs->fields["FRMF_COLSPAN"];
            $typeField      = $rs->fields["FRMT_TYPE"];
            $codeTypeField  = $rs->fields["FRMT_CODE"];
            $classField     = $rs->fields["FRMT_CLASS"];
            $jsField        = $rs->fields["FRMT_JS"];
            $htmlField      = $rs->fields["FRMT_HTML"];
            $helpField      = $rs->fields["FRMF_HELP"];
            $labelField     = $rs->fields["FRMF_LABEL"];
            $maskField      = $rs->fields["FRMF_MASK"];
            $saveField      = $rs->fields["FRMF_FIELD"];
            $fieldPkSearch1 = $rs->fields["FRMF_FIELDPK"];
            $fieldPkSearch  = $rs->fields["FRMF_FIELDPKSEARCH"];
            $tablePkSearch  = $rs->fields["FRMF_TABLEPKSEARCH"];
            $tableSave      = $rs->fields["FRMF_TABLESAVE"];
            $tablePkSave    = $rs->fields["FRMF_TABLEPKSAVE"];
            $rowspanField   = $rs->fields["FRMF_ROWSPAN"];
            $defaultField   = $rs->fields["FRMF_DEFAULT"];
            $paramsField    = $rs->fields["FRMF_PARAMS"];
            $varsparamField = $rs->fields["FRMF_VARSPARAM"];
            $varsField      = $rs->fields["FRMF_VARS"];

            $fields[$i]["FIELD_NAME"]      = $nameField;
            $fields[$i]["FIELD_LABEL"]     = $labelField;
            $fields[$i]["FIELD_PK"]        = $pkField;
            $fields[$i]["FIELD_TYPE"]      = $typeField;
            $fields[$i]["FIELD_TYPE_CODE"] = $codeTypeField;
            $fields[$i]["FIELD_DESC"]      = $descField;
            $fields[$i]["FIELD_NULL"]      = $nullField;
            $fields[$i]["FIELD_CLASS"]     = $classField;
            $fields[$i]["FIELD_ORDER"]     = $orderField;
            $fields[$i]["FIELD_COL"]       = $colField;
            $fields[$i]["FIELD_COLSPAN"]   = $colspanField;
            $fields[$i]["FIELD_SQL"]       = $sqlField;
            $fields[$i]["FIELD_HTML"]      = $sqlField;
            $fields[$i]["FIELD_HELP"]      = $helpField;
            $fields[$i]["FIELD_MASK"]      = $maskField;
            $fields[$i]["FIELD_SAVE"]      = $saveField;
            $fields[$i]["FIELD_PKSAVE"]    = $saveField;
            $fields[$i]["TABLE_SAVE"]      = $tableSave;
            $fields[$i]["TABLE_PKSEARCH"]  = $tablePkSearch;
            $fields[$i]["FIELD_PKSEARCH1"] = $fieldPkSearch1;
            $fields[$i]["FIELD_PKSEARCH"]  = $fieldPkSearch;
            $fields[$i]["FIELD_ROWSPAN"]   = $rowspanField;
            $fields[$i]["FIELD_DEFAULT"]   = $defaultField;
            $fields[$i]["FIELD_PARAMS"]    = $paramsField;
            $fields[$i]["FIELD_VARSPARAM"] = $varsparamField;
            $fields[$i]["FIELD_VARS"]      = $varsField;

            //Datos para la realización
            $datatojs[strtolower($labelField)] = $nameField;

            $rs->MoveNext();
            $i++;
          }
          $this->js_data_array = json_encode($datatojs, JSON_UNESCAPED_UNICODE);
        } else {
            return -1;
        }
        return $fields;

    }

    /** Metodo que permite Añadir/Guardar los datos de un formulario Especifico
     * Este metodo requiere que la clase tenga cargada la
     *
     * @param $codeForm variable que carga el codigo del formulario
     *
     * @return Retorna un arreglo con los campos del Formulario.
     */

    function putFormRegister() {
        $data = $this->dataSave;
        $db   = $this->db;
        $this->db->conn->debug = false;

          foreach ($data as $key => $campo) {
            $name_field = $campo["fieldSave"];
            if(!empty($name_field)){
              $script     .= $name_field  . " varchar ,\n";
              $fieldName   = strtolower($name_field );
              $fieldValue  = "'".$campo["fieldValue"]."'";
              $fieldPk     = $campo["fieldPk"];
              $table       = $campo["tableSave"];
              $record[$fieldName] = $fieldValue;

              if ($fieldName == 'id'){
                  $recordPk[] = $fieldName;
              }elseif($fieldPk == 1){
                  $recordPk[] = $fieldName;
              }
            }
          }

        $insert  = $db->conn->Replace($table, $record, $recordPk, $autoquote = true);
        $showerr = $db->conn->ErrorMsg();

        if ($insert) {
          echo '<div class="alert alert-block alert-success">
          <a class="close" href="#" data-dismiss="alert">×</a>
          <h4 class="alert-heading">
          <p> Se Grabaron los Datos Correctamente ! </p>
          </div>';
        } else {
          echo "<div class=\"alert alert-danger fade in\">
          <button class=\"close\" data-dismiss=\"alert\"> × </button>
          <i class=\"fa-fw fa fa-times\"></i>
          <strong>Error!</strong>
          Al realizar la transaccion.<br/>
          $showerr
          </div>";
        }
    }

    function getCreateTable() {
        $data = $this->dataSave;
        $db = $this->db;

        foreach ($data as $key => $campo) {
            $script .= "" . $campo["fieldSave"] . " varchar ,\n";
            $table = $campo["tableSave"];
        }
        echo "create table $table( $script  )";
    }
}

?>
