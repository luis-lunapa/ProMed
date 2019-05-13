<?php
    require_once('../include/header.php');
    

    /*
   *	Este web service regresa los datos de login
   *
   *	Parámetros: 
   *    - idUsuario

   *
   *	Devuelve un JSON con {status, msg, data}
   *
   *	Lista de status:
   *	- 0         No execution
   *	- 200 	    Success
   *	- 600       Datos faltantes o incorrectos del usuario
   *    - 601       No se recibio idUsuario
   *    - 604       Token no recibido o válido
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



$idUsuario = "";
if(!isset($_GET['idUsuario']) || trim($_GET['idUsuario']) == "") {
    $json['status'] 	= 602;
    $json['msg']		= "No se recibió idUsuario ";
    echo json_encode($json);
    exit;

}
else {
    $idUsuario = $_GET['idUsuario'];
}





$result = $db->querySelect(
    "Se obtienen todos datos de pacientes",
    "SELECT
        p.idPaciente,
        p.nombre,
        p.email,
        p.telefono,
        p.nacimiento,
        p.genero,
        p.descripcion,
        p.nss

    FROM
       Paciente p INNER JOIN Atendiendo a
    WHERE
        a.idUsuario = $idUsuario


    "
);




if(!isset($result)) {
    $json['status'] = '605';
    $json['msg']    = 'No se obtuvieron pacientes :O';
    echo(json_encode($json));
    exit;

}

$pacientes = array();

while($row = $result->fetch_assoc()) {
array_push($pacientes, array(

'idPaciente'    => $row['idPaciente'],
'nombre'        => $row['nombre'],
'email'         => $row['email'],
'telefono'      => $row['telefono'],
'nacimiento'    => $row['nacimiento'],
'genero'        => $row['genero'],
'descripcion'   => $row['descripcion'],
'nss'           => $row['nss'],



)
);



}




$json['status']                 = '200';
$json['msg']                    = 'Datos obtenidos correctamente';
$json['data'] = $pacientes;

echo(json_encode($json));
    
?>