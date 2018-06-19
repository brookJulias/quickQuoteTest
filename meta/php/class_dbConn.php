<?php

    $path = '..\dbSettings.ini';

    try {
        if(file_exists($path)){
            include_once($path);
        }else{
            throw new Exception('"'.$path .'" is not a valid path');
        }
    }
    catch(Exception $e){
        if(!isset($error)){
            $error;
        }
        array_push($error,$e->getMessage());
    }


class dbConn extends PDO{

    public function __construct( $file = 'dbSettings.ini' ){

        if(!isset($settings)){
            $settings = parse_ini_file($file, TRUE);
        }else{
            throw new exception('Unable to open '. $file . '.');
        }
        
        $dns = $settings['database']['driver']. ':host=' .$settings['database']['host'];
        
        if(!empty($settings['database']['port'])){
            $dns .= ';port='. $settings['database']['port'];
        }
        
        $dns .= ';dbname='.$settings['database']['scheme'];
        
        parent::__construct($dns,$settings['database']['username'],$settings['database']['password']);
    
    }

}

?>