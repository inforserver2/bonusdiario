<? 

//session_start();
//include_once "{$_SERVER['DOCUMENT_ROOT']}/inc/env.php";
$domain['url']=$sys['domain'];
dbopen();

//captura a url do dom�nio
$host = $_SERVER['HTTP_HOST'];
$uri = $_SERVER['REQUEST_URI'];



$firewall=strpos($host,$domain['url']);
if ($firewall===false) {
	echo "Invalid domain!";
	exit;	
}	


//diminui todos os caracteres
$exp = strtolower($host);
//var_dump($exp);

//extrai palavras por cada ponto paragrafo e grava resultados em arrays
$exp = explode(".",$host);
//var_dump($exp);

// extrai palavras por cada ponto paragrafo da url de dominio no arquivo de configuracao do sistema
$exp2 = explode(".",$domain['url']);
//var_dump($exp2);

// grava o indice 1x anterior ao da url de dominio configurada
$res=((array_search("$exp2[0]",$exp))-1);
//var_dump($exp[$res]);

// grava o indice 2x anterior ao da url de dominio configurada
$res2=((array_search("$exp2[0]",$exp))-2);
//var_dump($exp[$res2]);



$var1=$exp[$res];
$var2=$exp[$res2];

$user_enter=find_user2($var1,'name');

if (!$user_enter) {
	$user_random=random_user();

	//var_dump($user_random);
	if ($user_random) {
		($var1)? $exp[$res]=$user_random['name']:array_unshift($exp,$user_random['name']);
		//var_dump($exp[$res]);	
		//var_dump($exp[$res]);
		$rd = implode(".",$exp);

		header("Location: http://{$rd}{$uri}");
		exit;

	}
}

//var_dump($exp);
//var_dump($rd);	

	// INC VISIT
	// CAP PHOTO$photo=get_photo_user($user_enter['user_id'], 'user_id');	

//dbclose();
//	session_regenerate_id();

	$_SESSION['sponsor_id']=$user_enter['id'];
	$_SESSION['sponsor_name']=$user_enter['name']; 
	$_SESSION['sponsor_key']=$user_enter['token'];
	$_SESSION['sponsor_nick']=$user_enter['nick'];
	$_SESSION['sponsor_photo_type']=$photo['photo_type'];	
	$_SESSION['sponsor_photo_binary']=$photo['photo_binary'];		
	//var_dump($_SESSION);

?>
