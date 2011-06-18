<?

function sample_autoloader($class) {
    require str_replace('_', '/', $class) . '.php';
}
spl_autoload_register('sample_autoloader');

function get_config_path($root){
	$root = explode("/",$root);
	array_pop($root);
	array_push($root,"config");
	$path = implode("/",$root);
	return $path;
}

function get_file_config($folder,$subfolder,$filename){
	$folder= explode("/",$folder);
	array_pop($folder);
	array_push($folder,$subfolder,$filename);
	$path = implode("/",$folder);
	return $path;
}

//open database access
function dbopen () {
	global $db;
	global $sys;	
	mysql_connect($sys['db']['address'], $db[$sys['env']]['username'], $db[$sys['env']]['password']) 
	or die ('Error connecting to mysql');
	mysql_select_db($db[$sys['env']]['database']);
}

// close database access
function dbclose () {
	mysql_close();
}

function get_bill($bill_id,$bill_key) {

	$q1=mysql_query("SELECT a.id,a.value as price,a.status,a.description,a.token,b.user_id FROM bills a ,contracts b  WHERE (a.id = $bill_id and a.token='$bill_key') and a.contract_id=b.id");
	if ( mysql_num_rows( $q1 ) == 1) {
		$result=mysql_fetch_assoc($q1);
		return $result;
	}
	return false;
}

function get_contact($user_id) {
	$q1=mysql_query("select a.id, a.name, a.email1, a.email2, a.fullname as complete_name from users a where a.id=$user_id");
	if ( mysql_num_rows( $q1 ) == 1) {
		$result=mysql_fetch_assoc($q1);
		return $result;
	}
	return false;
}

function formating_number($num) {
	return number_format($num,2,',','.'); 
}

function listaimagemRemoveAcentos($str, $enc = "UTF-8"){
$acentos = array(
'A' => '/&Agrave;|&Aacute;|&Acirc;|&Atilde;|&Auml;|&Aring;/',
'a' => '/&agrave;|&aacute;|&acirc;|&atilde;|&auml;|&aring;/',
'C' => '/&Ccedil;/',
'c' => '/&ccedil;/',
'E' => '/&Egrave;|&Eacute;|&Ecirc;|&Euml;/',
'e' => '/&egrave;|&eacute;|&ecirc;|&euml;/',
'I' => '/&Igrave;|&Iacute;|&Icirc;|&Iuml;/',
'i' => '/&igrave;|&iacute;|&icirc;|&iuml;/',
'N' => '/&Ntilde;/',
'n' => '/&ntilde;/',
'O' => '/&Ograve;|&Oacute;|&Ocirc;|&Otilde;|&Ouml;/',
'o' => '/&ograve;|&oacute;|&ocirc;|&otilde;|&ouml;/',
'U' => '/&Ugrave;|&Uacute;|&Ucirc;|&Uuml;/',
'u' => '/&ugrave;|&uacute;|&ucirc;|&uuml;/',
'Y' => '/&Yacute;/',
'y' => '/&yacute;|&yuml;/',
'a.' => '/&ordf;/',
'o.' => '/&ordm;/');

   return preg_replace($acentos,
                       array_keys($acentos),
                       htmlentities($str,ENT_NOQUOTES, $enc));
}


function check_session(){
	global $sys;
	if (!$_SESSION['sponsor_id']) {
		include_once "{$_SERVER['DOCUMENT_ROOT']}/inc/url_handler.php";
	}
}

// find user by login with nick
function find_user2($user,$type) {

	$q1=mysql_query("SELECT a.id, a.name, a.nick, a.email1, a.email2, a.token ,a.fullname as complete_name  FROM users a where a.{$type}='{$user}' and a.status=1");

	if ( mysql_num_rows( $q1 ) == 1) {
		$result=mysql_fetch_assoc($q1);
		return $result;
	}
	return false;
}

function random_user() {
	//$q1=mysql_query("SELECT a.user_id,a.user_login,b.profile_nick FROM users a, profiles b where a.user_status='a' and a.user_id=b.user_id order by rand() limit 1");
	$q1=mysql_query("SELECT a.id,a.name FROM users a where a.id=1");	
	if ( mysql_num_rows( $q1 ) == 1) {
		$result=mysql_fetch_assoc($q1);
		return $result;
	}
	return false;
}

function get_user_url($login){
	global $sys;
	return "http://{$login}.{$sys['domain']}";
}

?>
