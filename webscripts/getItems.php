<?php
    include "settings.php";

    try {

          $pdo = new PDO('mysql:host='.$mysql_server.';dbname='.$mysql_dbname, $mysql_username, $mysql_password);

        } catch (PDOException $e) {
          reportError($e);
        }


    $stmt = $pdo->prepare("SELECT * FROM items");
    $result = array();
    if ($stmt->execute()) {
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
          //  $result[] = $row;
          echo "name=".$row['name']."=type=".$row['type']."=val=".$row['val']."=lvl=".$row['lvl']."=price=".$row['price']."=imgPath=".$row['imgPath']."=description=".$row['description']."=recipe=".$row['recipe']."=requirement=".$row['requirement']."\n";
        }
    }

  //  print json_encode($result);

    $pdo = null;

?>
