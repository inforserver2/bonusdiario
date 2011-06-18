<?
$folder = get_config_path($_SERVER["DOCUMENT_ROOT"]);
$database_config_path = get_file_config($folder,"config","database.yml");
$db = Horde_Yaml::loadfile($database_config_path);

?>
