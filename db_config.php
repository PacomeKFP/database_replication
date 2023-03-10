<?php

function get_db_connexion(string $db_name)
{
	$dbhost = 'localhost';
	$dbname = $db_name;
	$dbuser = 'root';
	$dbpswd = '';


	try {
	$db = new PDO('mysql:host=' . $dbhost . ';dbname=' . $dbname, $dbuser, $dbpswd, array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8 ', PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
	} catch (PDOException $e) {
		die("Une erreur est survenue lors de la connexion à la base de donnees");
	}
	return $db;
}