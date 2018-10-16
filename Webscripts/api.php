<?php
    include "settings.php";
    try {
        $pdo = new PDO('mysql:host='.$mysql_server.';dbname='.$mysql_dbname, $mysql_username, $mysql_password);
    } catch (PDOException $e) {
        reportError($e);
    }

    $a = $_GET['a'];

    if ($a == "get") { // for retrieving game data

        $type = $_GET['type'];

        if ($type == "mobs") {

            $stmt = $pdo->query("SELECT * FROM mobs");
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($data);

        } elseif ($type == "items") {

            $stmt = $pdo->query("SELECT * FROM items");
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($data);

        }

    } elseif ($a == "login") {

        $name = $_GET['username'];
        $pw = $_GET['pw'];

        $stmt = $pdo->query("SELECT token FROM users WHERE name='".$name."' AND password='".$pw."'");
        $stmt->execute();
        $pl = $stmt->fetch();

        if ($pl) {
            echo $pl['token'];
        } else {
            echo "Failed to login.";
        }
    }
?>