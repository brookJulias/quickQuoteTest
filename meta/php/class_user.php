<?php 
    $path = "constants.php";

    try{
        if(file_exists($path)){
            include_once($path);
        }
    }
    catch(Exception $e){
        if(!isset($error)){
            $error;
        }else{
            array_push($error, $e->getMessage());
        }
    }
include_once('');

class user{

    public function __construct(){
        
    }

}

?>