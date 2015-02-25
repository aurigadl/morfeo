<?php

/**
 * Esta clase trae todos los metodos para generar formularios.
 * @autor Jairo Losada
 * @autor Este desarrollo se realiza con apoyo de la Fundacion Correlibre.org e Infometrika
 * @copyright GPL version 3+
 *
 * @param integer $codeForm Codigo del Formulario que se va a Usar.
 *
 */
class genForm {

    /** Metodo que permite iniciar la clase del formularios
     *
     * @param $db variable que carga el objeto que contiene la Base de Datos instanciada.
     * @param $dataSave arreglo de datos qeu se guardaran en el formulario.  Se pasaran en Json.
     *
     */
    var $db;
    var $codeForm;
    var $nameForm;
    var $descriptionForm;
    var $dataSave;


    function genForm($db) {
        // Constructor de la clase
        $this->db = $db;
        $this->db->conn->debug = false;
    }

    /** Metodo que permite iniciar la clase del formularios
     *
     * @param $codeForm variable que carga el codigo del formulario
     */
    function getForm($codeForm) {
        $this->codeForm = $codeForm;
        $sql = "SELECT * FROM FRM_FORMS WHERE FRM_CODE=" . $codeForm;
        $rs = $this->db->conn->query($sql);

        if (!$rs->EOF) {
            $this->nameForm = $rs->fields["FRM_NAME"];
            $this->descriptionForm = $rs->fields["FRM_DESCRIPTION"];
        }
    }

    /** Metodo que permite iniciar la clase del formularios
     * Este metodo requiere que la clase tenga cargada la
     *
     * @param $codeForm variable que carga el codigo del formulario
     *
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
                $nameField = $rs->fields["FRMF_NAME"];
                $pkField = $rs->fields["FRMF_PK"];
                $codeField = $rs->fields["FRMF_CODE"];
                $descField = $rs->fields["FRMF_DESCRIPTION"];
                $sqlField = $rs->fields["FRMF_SQL"];
                $nullField = $rs->fields["FRMF_NULL"];
                $colField = $rs->fields["FRMF_COLUMN"];
                $orderField = $rs->fields["FRMF_ORDER"];
                $colspanField = $rs->fields["FRMF_COLSPAN"];
                $typeField = $rs->fields["FRMT_TYPE"];
                $codeTypeField = $rs->fields["FRMT_CODE"];
                $classField = $rs->fields["FRMT_CLASS"];
                $jsField = $rs->fields["FRMT_JS"];
                $htmlField = $rs->fields["FRMT_HTML"];
                $helpField = $rs->fields["FRMF_HELP"];
                $labelField = $rs->fields["FRMF_LABEL"];
                $maskField = $rs->fields["FRMF_MASK"];
                $saveField = $rs->fields["FRMF_FIELD"];
                $fieldPkSearch1 = $rs->fields["FRMF_FIELDPK"];
                $fieldPkSearch = $rs->fields["FRMF_FIELDPKSEARCH"];
                $tablePkSearch = $rs->fields["FRMF_TABLEPKSEARCH"];
                $tableSave = $rs->fields["FRMF_TABLESAVE"];
                $tablePkSave = $rs->fields["FRMF_TABLEPKSAVE"];
                $rowspanField = $rs->fields["FRMF_ROWSPAN"];
                $defaultField = $rs->fields["FRMF_DEFAULT"];
                $paramsField = $rs->fields["FRMF_PARAMS"];
                $varsparamField = $rs->fields["FRMF_VARSPARAM"];
                $varsField = $rs->fields["FRMF_VARS"];

                $fields[$i]["FIELD_NAME"] = $nameField;
                $fields[$i]["FIELD_LABEL"] = $labelField;
                $fields[$i]["FIELD_PK"] = $pkField;
                $fields[$i]["FIELD_TYPE"] = $typeField;
                $fields[$i]["FIELD_TYPE_CODE"] = $codeTypeField;
                $fields[$i]["FIELD_DESC"] = $descField;
                $fields[$i]["FIELD_NULL"] = $nullField;
                $fields[$i]["FIELD_CLASS"] = $classField;
                $fields[$i]["FIELD_ORDER"] = $orderField;
                $fields[$i]["FIELD_COL"] = $colField;
                $fields[$i]["FIELD_COLSPAN"] = $colspanField;
                $fields[$i]["FIELD_SQL"] = $sqlField;
                $fields[$i]["FIELD_HTML"] = $sqlField;
                $fields[$i]["FIELD_HELP"] = $helpField;
                $fields[$i]["FIELD_MASK"] = $maskField;
                $fields[$i]["FIELD_SAVE"] = $saveField;
                $fields[$i]["FIELD_PKSAVE"] = $saveField;
                $fields[$i]["TABLE_SAVE"] = $tableSave;
                $fields[$i]["TABLE_PKSEARCH"] = $tablePkSearch;
                $fields[$i]["FIELD_PKSEARCH1"] = $fieldPkSearch1;
                $fields[$i]["FIELD_PKSEARCH"] = $fieldPkSearch;
                $fields[$i]["FIELD_ROWSPAN"] = $rowspanField;
                $fields[$i]["FIELD_DEFAULT"] = $defaultField;
                $fields[$i]["FIELD_PARAMS"] = $paramsField;
                $fields[$i]["FIELD_VARSPARAM"] = $varsparamField;
                $fields[$i]["FIELD_VARS"] = $varsField;
                $rs->MoveNext();
                $i++;
            }
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

        foreach ($data as $key => $campo) {
            $script     .= $campo["fieldSave"] . " varchar ,\n";
            $fieldName   = strtolower($campo["fieldSave"]);
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

        $insert = $db->conn->Replace($table, $record, $recordPk, $autoquote = true);


        if ($insert){
            echo '<div class="alert alert-block alert-success">
					<a class="close" href="#" data-dismiss="alert">×</a>
					<h4 class="alert-heading">
					<p> Se Grabaron los Datos Correctamente ! </p>
					</div>';
        } else {
            echo '<div class="alert alert-danger fade in">
					<button class="close" data-dismiss="alert"> × </button>
					<i class="fa-fw fa fa-times"></i>
					<strong>Error!</strong>
					Al realizar la transaccion.
					</div>';
        }
        //$db->conn->Execute($insertSQL);
    }

    function getCreateTable() {
        $data = $this->dataSave;
        $db = $this->db;
        //var_dump($data);

        foreach ($data as $key => $campo) {
            $script .= "" . $campo["fieldSave"] . " varchar ,\n";
            $table = $campo["tableSave"];
        }
        echo "create table $table( $script  )";
    }

}

?>