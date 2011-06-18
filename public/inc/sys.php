<?
$folder = get_config_path($_SERVER["DOCUMENT_ROOT"]);
$sys_config_path = get_file_config($folder,"config","sys.yml");
$sys = Horde_Yaml::loadfile($sys_config_path);
?>
