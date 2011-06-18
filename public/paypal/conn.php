<?

$bill_id=trim(strip_tags($_REQUEST['bill_id']));	
$bill_key=trim(strip_tags($_REQUEST['bill_key']));

include_once "{$_SERVER['DOCUMENT_ROOT']}/inc/env.php";
dbopen ();

$bill=get_bill($bill_id,$bill_key);

if (!$bill) {
	header("Location: /office");
	exit;
}

if ($bill['status']!=0 || $sys['payments']['paypal']['actived']==false) {
	header("Location: /cli/billings/{$bill[id]}?token={$bill[token]}");
	exit;
}

$contact=get_contact($bill['user_id']);
	
	/* (Euro Value to Dollar Value)
	$bill['price']=($bill['price']/$sys['paypal']['factor']);
	$discount=($sys['paypal']['porcentage']/100);
	$bill['price']+=($bill['price']*$discount);
	$bill['price']=number_format($bill['price'],2,'.',',');
	*/
	
	// inc porcentage value and divide per dollar factor (Brazil Value to Dollar Value)
	
	$bill['price']=(($bill['price']/$sys['payments']['paypal']['factor']));
	$porcentage=($sys['payments']['paypal']['porcentage']);
	$bill['price']+=($bill['price']*$porcentage);	
	$bill['price']=number_format($bill['price'],2,'.',',');
	
	$fatura_pag='
	<html>
	<head>
	<title>Paypal Redirection</title>
	</head>
	<body>
	<form action="/paypal/process.php" method="post" name="paypal">
	<input name="firstname" type="hidden" id="firstname" value="'.$contact['complete_name'].'" size="40">
	<input name="email" type="hidden" id="email" value="'.$bill['contact_email1'].'" size="40">
	<input name="item_name" type="hidden" id="item_name" value="'.listaimagemRemoveAcentos($bill['description'], $enc = "iso-8859-1").'" size="40"> 
	<input name="item_number" type="hidden" id="item_number" value="'.$bill['id'].'" size="40">
	<input name="amount" type="hidden" id="amount" value="'.$bill['price'].'" size="40">
	<script language="JavaScript">document.paypal.submit();</script>
	</body>
	</html>
	';
	
	die("$fatura_pag");	


?>