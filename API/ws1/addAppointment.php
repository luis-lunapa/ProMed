<?php
    require_once('../include/header.php');
    

    /*
   *	Este web service recibe los datos de login de un usuario, los valida contra BDD, autoriza el acceso a un usuario, si es el caso, y crea una nueva sesión
   *
   *	Parámetros:
   *	- idPatient 
   *    - idUser
   *    - date
   *    - description

   *
   *	Devuelve un JSON con {status, msg, data}
   *
   *	Lista de status:
   *	- 0         No execution
   *	- 200 	    Success
   *	- 600       Datos faltantes o incorrectos del usuario
   *    - 601       Usuaio no registrado
   *    - 604       Contraseña incorrecta
   */

header('Content-Type: application/json');
$json = array (
    'status'    => '0',
    'msg'       => 'Sin Ejecución',
    'data'      => array()
);

if(isset($_GET['debug'])){
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
}

$idPatient = "";
if(!isset($_GET['idPatient']) || trim($_GET['idPatient']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió idPatient";
    echo json_encode($json);
    exit;

}
else {
    $idPatient = $_GET['idPatient'];
}

$idUser = "";
if(!isset($_GET['idUser']) || trim($_GET['idUser']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió v";
    echo json_encode($json);
    exit;

}
else {
    $idUser = $_GET['idUser'];
}

$date = "";
if(!isset($_GET['date']) || trim($_GET['date']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió date";
    echo json_encode($json);
    exit;

}
else {
    $date = $_GET['date'];
}

$description = "";
if(!isset($_GET['description'])) {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió description";
    echo json_encode($json);
    exit;

}
else {
    $description = $_GET['description'];
}

$result = $db->querySelect(
    "Se verifica si existe $idPatient  con $idUser y date en bd",
    " SELECT
        *  
     FROM 
        Appointment
    WHERE
        idPaciente = '$idPatient' AND
        idUsuario = '$idUser' AND
        date = '$date'

    "

);

if (!result) {
    $json['msg']            = 'Ya hay una cita con estos parametros';
    $json['status']         = 605;
    echo(json_encode($json));
    exit;



}



$result = $db->queryInsert(
"Inserta nuevo appointmment",
array (
    "INSERT INTO Appointment (
        idPaciente,
        idUsuario,
        date,
        description
        )
        VALUES (
            $idPatient,
            $idUser,
            '$date',
            '$description'
        )
    
    
    "
)


);

$db->printQuery();

if (!$result) {
    $json['status'] = '600';
    $json['msg']    = 'No se pudo agregar appointment';
    echo(json_encode($json));
    exit;

}


$json['status']                     = '200';
$json['msg']                        = 'Appointment agregado';







echo(json_encode($json));
    
?>