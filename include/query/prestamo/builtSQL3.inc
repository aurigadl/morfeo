<?PHP
	if(!$ps_numeroExpediente) $sWhere_non_exp    =$sWhere." and R.RADI_NUME_RADI =P.RADI_NUME_RADI "; 
	else { $sWhere_exp =$sWhere." and E.SGD_EXP_NUMERO =P.sgd_exp_numero ";  }//radicados con expediente
             // Build SQL statement 

            $sSQL_non_exp=$sSelect_non_exp.$sFrom_non_exp.$sWhere_non_exp;  		 
            $sSQL_exp    =$sSelect_exp.$sFrom_exp.$sWhere_exp;  
         if(!$ps_numeroExpediente){
            if ($sFileName=="formEnvio.php") {
               $sSQL=$sSQL_exp.$sSQLsele." union all ".$sSQL_non_exp.$sSQLsele;  		             
            }
            else {
               $sSQL=$sSQL_exp." union all ".$sSQL_non_exp;  		 
            } 
            $sSQL=$sSQL_non_exp . " ";
            if ($sFileName=="formEnvio.php") {
               $sSQL=$sSQL_non_exp. " ".$sSQLsele;                  
            }
        }else{
          $sSQL=$sSQL_exp . " ";
          if ($sFileName=="formEnvio.php") {
               $sSQL=$sSQL_exp. " ".$sSQLsele;                  
            }
        }
?>		 
