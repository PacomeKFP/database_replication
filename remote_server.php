<?php
date_default_timezone_set('Africa/Douala');
$date_time = new DateTime("now");


if (isset($_FILES['db_file'])) {
    // where we will store the db file
    $target_dir = "uploads/" . $date_time->format('Y') . '/' . $date_time->format('Y-M') . '/';
    if (!is_dir($target_dir))
        mkdir($target_dir, 0755, true);

    $file_name = basename($_FILES["db_file"]["name"]);
    $target_file = $target_dir . $date_time->format('Y-m-d_H-i-s_') . $file_name;
    $file_extension = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));

    if (!in_array($file_extension, ['sql']))
        die(false);
    //uploading file
    $uploaded = False;
    if (move_uploaded_file($_FILES['db_file']['tmp_name'], $target_file)) {
        echo 'File uploaded with success\n';
        $uploaded = true;
    } else {
        echo 'An error occured when uploading the file';
    }

}

if ($uploaded) {
    include 'db_config.php';
    $db_name = $_POST['db_name'];
    $db = get_db_connexion($db_name);
    $file = file($target_file);
    $sql = "";
    foreach ($file as $line)
        $sql .= $line;

    $db->query($sql);
    
    echo 'All is good';
}