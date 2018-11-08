<?php

    /*
        BRAWLQUEST BACKEND API
        Beta v1

        PUBLIC COMMANDS:
            ?a=get - Takes 'type' parameter and returns either 'mobs' or 'items' in json format
            ?a=login - Takes 'username' and 'pw' parameters and returns either "Failed to login." or the current token for the associated account TODO: make an account lock after 5 unsuccesful login attempts to prevent this from being bruteforced
        PRIVATE COMMANDS: (require 'key' parameter)    
            ?a=token - Generates a new token for all accounts that have verified ownership on steam. Requires key parameter
            ?a=char - Outputs legacy server character file format for loading
            ?a=put - Inputs legacy server character file format line and puts it on the server. Requires 'name' parameter for the user in question
    */
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

        $stmt = $pdo->prepare("SELECT * FROM users WHERE name='".$name."'");

        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if (password_verify($_GET['password'], $row['password'])) {
            echo $row['token'];
        } else {
            echo "Failed to login.";
        }

    } elseif ($a == "token" && $_GET['key'] == "s1eu") { // resetting tokens

        $result = $pdo->query("SELECT * FROM users WHERE steamkey > ''");

        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            $token = rand(100000,999999);
            $stmt = $pdo->query("UPDATE users SET `token`=".$token." WHERE id=".$row['id']);
        }
    } elseif ($a == "char" && $_GET['key'] == "s1eu") {
       
        $result = $pdo->query("SELECT * FROM users WHERE steamkey > ''");
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            echo $row['name']."|hp|".$row['hp']."|s1|".$row['s1']."|s2|".$row['s2']."|gold|".$row['gold']."|x|".$row['x']."|y|".$row['y']."|t|".$row['t']."|dt|".$row['dt']."|dtz|".$row['dtz']."|wep|".$row['wep']."|arm_head|".$row['arm_head']."|arm_chest|".$row['arm_chest']."|arm_legs|".$row['arm_legs']."|inv|".$row['inv']."|pot|".$row['pot']."|lvl|".$row['lvl']."|xp|".$row['xp']."|bud|".$row['bud']."|playtime|".$row['playtime']."|kills|".$row['kills']."|deaths|".$row['deaths']."|distance|".$row['distance']."|lastEquip|".$row['lastEquip']."|str|".$row['str']."|int|".$row['intel']."|agl|".$row['agl']."|sta|".$row['sta']."|cp|".$row['cp']."|lastLogin|".$row['lastLogin']."|owed|".$row['owed']."|blueprints|".$row['blueprints']."|zone|".$row['zone']."|party|".$row['party']."|authcode|".$row['token']."|name|".$row['name']."\n";
        }
        //$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        //echo json_encode($data);
    } elseif ($a == "put" && $_GET['key'] == "s1eu") {

        $charStr = $_GET['str'];
        $word = explode("|",$charStr); 
        $stmt = $pdo->prepare("UPDATE users SET hp=".$word[0].", s1='".$word[1]."', s2='".$word[2]."', gold=".$word[3].", t=".$word[4].", dt=".$word[5].", dtz='".$word[6]."', wep='".$word[7]."', arm_head='".$word[8]."', arm_chest='".$word[9]."', arm_legs='".$word[10]."', inv='".$word[11]."', pot='".$word[12]."', lvl=".$word[13].", xp=".$word[14].", bud='".$word[15]."', playtime=".$word[16].", kills=".$word[17].", deaths=".$word[18].", distance=".$word[19].", lastEquip='".$word[20]."', str=".$word[21].", intel=".$word[22].", agl=".$word[23].", sta=".$word[24].", cp=".$word[25].", lastLogin=".$word[26].", owed='".$word[27]."', blueprints='".$word[28]."', zone='".$word[29]."', party=".$word[30]." WHERE name='".$_GET['name']."';");
        $stmt->execute();
        echo "UPDATE users SET hp=".$word[0].", s1='".$word[1]."', s2='".$word[2]."', gold=".$word[3].", t=".$word[4].", dt=".$word[5].", dtz='".$word[6]."', wep='".$word[7]."', arm_head='".$word[8]."', arm_chest='".$word[9]."', arm_legs='".$word[10]."', inv='".$word[11]."', pot='".$word[12]."', lvl=".$word[13].", xp=".$word[14].", bud='".$word[15]."', playtime=".$word[16].", kills=".$word[17].", deaths=".$word[18].", distance=".$word[19].", lastEquip='".$word[20]."', str=".$word[21].", intel=".$word[22].", agl=".$word[23].", sta=".$word[24].", cp=".$word[25].", lastLogin=".$word[26].", owed='".$word[27]."', blueprints='".$word[28]."', zone='".$word[29]."', party=".$word[30]." WHERE name='".$_GET['name']."';";
       // echo $stmt;

    }
?>