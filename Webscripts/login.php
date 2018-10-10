<?php
    include "settings.php";
    
    try {
        $pdo = new PDO('mysql:host='.$mysql_server.';dbname='.$mysql_dbname, $mysql_username, $mysql_password);

      } catch (PDOException $e) {
        echo "Oopsy we mad a woopsy.";
      }

      $stmt = $pdo->query("SELECT * FROM users WHERE name='".$_GET['name']."'");
      $pl = $stmt->fetch();

      if ($pl) {
        if ($pl['password'] == $_GET['pw']) {
            echo $pl['token'];
        } else {
            echo "Incorrect password.";
        }
    } else {
        echo "User doesn't exist.";
    }
    ?>