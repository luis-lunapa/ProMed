<?php
    require_once('../include/header.php');
    

    /*
   *	Este web service recibe los datos de login de un usuario, los valida contra BDD, autoriza el acceso a un usuario, si es el caso, y crea una nueva sesión
   *
   *	Parámetros:
   *	- idUser 
   *    - nombre
   *    - email
   *    - telefono
   *    - fechaNac
   *    - genero
   *    - descripcion
   *    - nss
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

$idUser = "";
if(!isset($_GET['idUser']) || trim($_GET['idUser']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió idUser";
    echo json_encode($json);
    exit;

}
else {
    $idUser = $_GET['idUser'];
}

$nombre = "";
if(!isset($_GET['nombre']) || trim($_GET['nombre']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió nombre";
    echo json_encode($json);
    exit;

}
else {
    $nombre = $_GET['nombre'];
}


$email = "";
if(!isset($_GET['email']) || trim($_GET['email']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió email";
    echo json_encode($json);
    exit;

}
else {
    $email = $_GET['email'];
}

$telefono = "";
if(!isset($_GET['telefono']) || trim($_GET['telefono']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió telefono";
    echo json_encode($json);
    exit;

}
else {
    $telefono = $_GET['telefono'];
}

$fechaNac = "";
if(!isset($_GET['fechaNac']) || trim($_GET['fechaNac']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió fechaNac";
    echo json_encode($json);
    exit;

}
else {
    $fechaNac = $_GET['fechaNac'];
}


$genero = "";
if(!isset($_GET['genero']) || trim($_GET['genero']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió genero";
    echo json_encode($json);
    exit;

}
else {
    $genero = $_GET['genero'];
}

//;;;
$descripcion = "";
if(!isset($_GET['descripcion']) || trim($_GET['descripcion']) == "") {
    $descripcion = "";

}
else {
    $descripcion = $_GET['descripcion'];
}

//;;;


$nss = "";
if(!isset($_GET['nss']) || trim($_GET['nss']) == "") {
    $json['status'] 	= 601;
    $json['msg']		= "No se recibió nss";
    echo json_encode($json);
    exit;

}
else {
    $nss = $_GET['nss'];
}


$result = $db->querySelect(
    "Se verifica si existe $nombre  con $emmail",
    " SELECT
        *  
     FROM 
        Paciente
    WHERE
        nombre = '$nombre' AND
        email = '$email'

    "

);

if (!result) {
    $json['msg']            = 'Paciente ya existe';
    $json['status']         = 605;
    echo(json_encode($json));
    exit;



}



$idPaciente = $db->queryInsert(
"Inserta nuevo paciente",
array (
    "INSERT INTO Paciente (
        nombre,
        email,
        telefono,
        nacimiento,
        genero,
        descripcion,
        nss
       
        )
        VALUES (
           '$nombre',
           '$email',
           '$telefono',
           '$fechaNac',
           '$genero',
           '$descripcion',
           '$nss'
            
        )
    
    
    "
)
);



if (!$idPaciente) {
    $json['status'] = '600';
    $json['msg']    = 'No se pudo agregar paciente';
    echo(json_encode($json));
    exit;

}

$result = $db->queryInsert(
    "Asocia paciente a medico",
    array (
        "INSERT INTO Atendiendo (
            idPaciente,
            idUsuario
           
            )
            VALUES (
               $idPaciente,
               $idUser
            )
        
        
        "
    )
    );

    if (!$result) {
        $json['status'] = '600';
        $json['msg']    = 'No se pudo asociar paciente';
        echo(json_encode($json));
        exit;
    
    }

$json['status']                     = '200';
$json['msg']                        = 'Paciente  agregado';







echo(json_encode($json));
    
?>