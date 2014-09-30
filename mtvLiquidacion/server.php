<?php

    session_start();
    if (!$ruta_raiz) $ruta_raiz = "..";
    include "$ruta_raiz/conn.php";

    $page         = $_GET['page']; // get the requested page
    $limit        = $_GET['rows']; // get how many rows we want to have into the grid
    $sidx         = $_GET['sidx']; // get index row - i.e. user click to sort
    $sord         = $_GET['sord']; // get the direction
    $dat          = $_GET['dat']; // get the direction
    $tx           = $_GET['tx'];
    $tableSearch  = $_GET['tableSearch'];
    $fieldSearch  = $_GET['fieldSearch'];
    $fieldsView   = $_GET['fieldsView'];
    $searchTerm   = $_GET['searchTerm'];

    switch ($tx) {

        case 1:

            break;

        case 2:

            $year       = date("Y");
            $output_dir = "../bodega/tmp/";

            if(isset($_FILES["fileFormDinamic"])){
                $ret = array();
                $error =$_FILES["fileFormDinamic"]["error"];
                //You need to handle  both cases
                //If Any browser does not support serializing of multiple files using FormData()
                if(!is_array($_FILES["fileFormDinamic"]["name"])) //single file
                {
                    $namefile = rand(99999, 99999);
                    $fileName = $namefile.'_'.$_FILES["fileFormDinamic"]["name"];
                    move_uploaded_file($_FILES["fileFormDinamic"]["tmp_name"],$output_dir.$fileName);
                    $ret[]= $fileName;

                } else  //Multiple files, file[]
                {
                    $fileCount = count($_FILES["fileFormDinamic"]["name"]);
                    for($i=0; $i < $fileCount; $i++){
                        $namefile = rand(9999, 99999);
                        $fileName = $namefile.'_'.$_FILES["fileFormDinamic"]["name"][$i];
                        move_uploaded_file($_FILES["fileFormDinamic"]["tmp_name"][$i],$output_dir.$fileName);
                        $ret[]= $fileName;
                    }
                }
                echo json_encode($ret);
                die();
            }
            break;

    }

  echo json_encode($response);
