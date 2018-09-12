<?php
  /*echo json_encode([
      "zobie" => [
        "health" => 1000000000000,
        "wack" => 2,
      ],
      "adam" => [
        "heath" => 7,
        "wack" => Math.pi,
      ],
      "NED" => [
        "health" => -4,
        "wack" => 1,
      ]
    ]);*/


    include "settings.php";
    $pin = $_GET['pin'];

    try {

          $pdo = new PDO('mysql:host='.$mysql_server.';dbname='.$mysql_dbname, $mysql_username, $mysql_password);

        } catch (PDOException $e) {
          reportError($e);
        }


    $stmt = $pdo->prepare("SELECT * FROM mobs");
    $result = array();
    if ($stmt->execute()) {
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
          //  $result[] = $row;
          echo "name=".$row['name']."=hp=".$row['hp']."=spd=".$row['spd']."=atk=".$row['atk']."=rng=".$row['rng']."=sp1=".$row['sp1']."=sp1t=".$row['sp1t']."=sp2=".$row['sp2']."=sp2t=".$row['sp2t']."=friend=".$row['friend']."=imgPath=".$row['imgPath']."\n";
        }
    }

  //  print json_encode($result);

    $pdo = null;

?>
