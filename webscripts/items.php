<?php
    include "settings.php";

    try {

          $pdo = new PDO('mysql:host='.$mysql_server.';dbname='.$mysql_dbname, $mysql_username, $mysql_password);

        } catch (PDOException $e) {
          reportError($e);
        }
    
    $itemType = $_GET['type'];

    echo "<center><img src='img/logo.png' alt='BrawlQuest'><br /><h2>Items List</h2><hr /><a href='?view=wep'>Weapons</a> - <a href='?view=head armour'>Head Armour</a> - <a href='?view=chest armour'>Chest Armour</a> - <a href='?view=Leg Armour'>Leg Armour</a> - <a href='?view=spell'>Spells</a> - <a href='?view=pot'>Potions</a> - <a href='?view=Reagent'>Reagents</a> - <a href='?view=buddy'>Buddies</a><table><tr><th>IMG</th><th>Name</th><th>Type</th><th>Value</th><th>iLVL</th><th>Worth</th><th>Description</th><th>Recipe</th><th>Requirement</th></tr>";
    
    if ($itemType != "") {
        $stmt = $pdo->prepare("SELECT * FROM items WHERE `type`=".$itemType);
    } else {
        $stmt = $pdo->prepare("SELECT * FROM items");
    }
    
    $result = array();
    if ($stmt->execute()) {
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
          //  $result[] = $row;
            echo "<tr><td><img src='".$row['imgPath']."'></td><td>".$row['name']."</td><td>".$row['type']."</td><td>".$row['val']."</td><td>".$row['lvl']."</td><td>".$row['price']." Gold</td><td>".$row['description']."</td><td>".$row['recipe']."</td><td>".$row['requirement']."</td></tr>";
        }
    }
    echo "</table>";
  //  print json_encode($result);

    $pdo = null;

?>
