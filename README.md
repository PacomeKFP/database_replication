# You anc use this for database replication:
if you have a local data base and want to replicate it on remote remote server
you can yse this script containing using the _`Master - Slave`_ Schemas

>- The shellScript for your local server _the master_ (database source): This is configurated for mysql database with laragon loading on a windows SE, but you can change it by updating variables values that are setted in the `./shell/MySqlbackup.bat` file

>- The remote server php handler (`./db_config.php` and `./remote_server.php` files), you have to place this files on the remote server that will be mounted as the `Slave`. You have to modify the variables setted the `./db_config.php` before using it.

When the batch file of the Master is launched, it the specified database is dumped and sent to the Slave. the Slave save the file and update his repliication of the database,  by executin the SQL script contained in the file that he saved.

You can change the directory of the sa