<?php

$bill_id=trim(strip_tags($_REQUEST['bill_id']));	
$bill_key=trim(strip_tags($_REQUEST['bill_key']));

include_once "{$_SERVER['DOCUMENT_ROOT']}/inc/env.php";
dbopen ();

$bill=get_bill($bill_id,$bill_key);

if (!$bill) {
	header("Location: /office");
	exit;
}

if ($bill['status']!=0 || $sys['payments']['boleto']['bb']['actived']==false) {
	header("Location: /cli/billings/{$bill[id]}?token={$bill[token]}");
	exit;
}

$contact=get_contact($bill['user_id']);


// +----------------------------------------------------------------------+
// | BoletoPhp - Versão Beta                                              |
// +----------------------------------------------------------------------+
// | Este arquivo está disponível sob a Licença GPL disponível pela Web   |
// | em http://pt.wikipedia.org/wiki/GNU_General_Public_License           |
// | Você deve ter recebido uma cópia da GNU Public License junto com     |
// | esse pacote; se não, escreva para:                                   |
// |                                                                      |
// | Free Software Foundation, Inc.                                       |
// | 59 Temple Place - Suite 330                                          |
// | Boston, MA 02111-1307, USA.                                          |
// +----------------------------------------------------------------------+

// +----------------------------------------------------------------------+
// | Originado do Projeto BBBoletoFree que tiveram colaborações de Daniel |
// | William Schultz e Leandro Maniezo que por sua vez foi derivado do	  |
// | PHPBoleto de João Prado Maia e Pablo Martins F. Costa				        |
// | 														                                   			  |
// | Se vc quer colaborar, nos ajude a desenvolver p/ os demais bancos :-)|
// | Acesse o site do Projeto BoletoPhp: www.boletophp.com.br             |
// +----------------------------------------------------------------------+

// +--------------------------------------------------------------------------------------------------------+
// | Equipe Coordenação Projeto BoletoPhp: <boletophp@boletophp.com.br>              		             				|
// | Desenvolvimento Boleto Banco do Brasil: Daniel William Schultz / Leandro Maniezo / Rogério Dias Pereira|
// +--------------------------------------------------------------------------------------------------------+


// ------------------------- DADOS DINÂMICOS DO SEU CLIENTE PARA A GERAÇÃO DO BOLETO (FIXO OU VIA GET) -------------------- //
// Os valores abaixo podem ser colocados manualmente ou ajustados p/ formulário c/ POST, GET ou de BD (MySql,Postgre,etc)	//

// DADOS DO BOLETO PARA O SEU CLIENTE
$dias_de_prazo_para_pagamento = $sys['payments']['boleto']['expire_in_days'];
$taxa_boleto = $sys['payments']['boleto']['bb']['tax'];
$data_venc = date("d/m/Y", time() + ($dias_de_prazo_para_pagamento * 86400));  // Prazo de X dias OU informe data: "13/04/2006"; 
$valor_cobrado = ($bill['price']); // Valor - REGRA: Sem pontos na milhar e tanto faz com "." ou "," ou com 1 ou 2 ou sem casa decimal
$valor_cobrado = str_replace(",", ".",$valor_cobrado);
$valor_boleto=number_format($valor_cobrado+$taxa_boleto, 2, ',', '');


$dadosboleto["nosso_numero"] = $bill['id']; // tamanho 9!

$dadosboleto["numero_documento"] = $bill['id'];	// Num do pedido ou do documento
$dadosboleto["data_vencimento"] = $data_venc; // Data de Vencimento do Boleto - REGRA: Formato DD/MM/AAAA
$dadosboleto["data_documento"] = date("d/m/Y"); // Data de emissão do Boleto
$dadosboleto["data_processamento"] = date("d/m/Y"); // Data de processamento do boleto (opcional)
$dadosboleto["valor_boleto"] = $valor_boleto; 	// Valor do Boleto - REGRA: Com vírgula e sempre com duas casas depois da virgula

// DADOS DO SEU CLIENTE
$dadosboleto["sacado"] = $contact['complete_name'];
$dadosboleto["endereco1"] = "E-mails: {$contact['email1']} {$contact['email2']}";
//$dadosboleto["endereco2"] = "Cidade - Estado -  CEP: 00000-000";

// INFORMACOES PARA O CLIENTE
$dadosboleto["demonstrativo1"] = "Cobrança pela aquisição dos serviços oferecidos pelo site {$sys['domain']}";
//$dadosboleto["demonstrativo2"] = "Mensalidade referente a nonon nonooon nononon<br>Taxa bancária - R$ ".number_format($taxa_boleto, 2, ',', '');
$dadosboleto["demonstrativo2"] = "- Referente ao {$bill['description']}";
$dadosboleto["demonstrativo3"] = "- Login do titular: {$contact['name']}";

// INSTRUÇÕES PARA O CAIXA
$dadosboleto["instrucoes1"] = "- Pagavel somente até o vencimento.";
$dadosboleto["instrucoes2"] = "- Sua conta será ativada após o banco compensar o pagamento deste boleto, isso pode ocorrer dentro de 24 a 72 horas.";
$dadosboleto["instrucoes3"] = "- Em caso de dúvidas entre em contato conosco: {$sys['email']}";
//$dadosboleto["instrucoes4"] = "&nbsp; Emitido pelo sistema Projeto BoletoPhp - www.boletophp.com.br";

// DADOS OPCIONAIS DE ACORDO COM O BANCO OU CLIENTE
$dadosboleto["quantidade"] = "1";
$dadosboleto["valor_unitario"] = "10";
$dadosboleto["aceite"] = "N";		
$dadosboleto["especie"] = "R$";
$dadosboleto["especie_doc"] = "DM";


// ---------------------- DADOS FIXOS DE CONFIGURAÇÃO DO SEU BOLETO --------------- //


// DADOS DA SUA CONTA - BANCO DO BRASIL
$dadosboleto["agencia"] = $sys['payments']['boleto']['bb']['agency']; // Num da agencia, sem digito
$dadosboleto["conta"] = $sys['payments']['boleto']['bb']['account']; 	// Num da conta, sem digito

// DADOS PERSONALIZADOS - BANCO DO BRASIL
$dadosboleto["convenio"] = $sys['payments']['boleto']['bb']['convenio'];  // Num do convênio - REGRA: 6 ou 7 ou 8 dígitos
$dadosboleto["contrato"] = $sys['payments']['boleto']['bb']['contrato']; // Num do seu contrato
$dadosboleto["carteira"] = "18";
$dadosboleto["variacao_carteira"] = "-019";  // Variação da Carteira, com traço (opcional)

// TIPO DO BOLETO
$dadosboleto["formatacao_convenio"] = "7"; // REGRA: 8 p/ Convênio c/ 8 dígitos, 7 p/ Convênio c/ 7 dígitos, ou 6 se Convênio c/ 6 dígitos
$dadosboleto["formatacao_nosso_numero"] = "2"; // REGRA: Usado apenas p/ Convênio c/ 6 dígitos: informe 1 se for NossoNúmero de até 5 dígitos ou 2 para opção de até 17 dígitos

/*
#################################################
DESENVOLVIDO PARA CARTEIRA 18

- Carteira 18 com Convenio de 8 digitos
  Nosso número: pode ser até 9 dígitos

- Carteira 18 com Convenio de 7 digitos
  Nosso número: pode ser até 10 dígitos

- Carteira 18 com Convenio de 6 digitos
  Nosso número:
  de 1 a 99999 para opção de até 5 dígitos
  de 1 a 99999999999999999 para opção de até 17 dígitos

#################################################
*/


// SEUS DADOS
$dadosboleto["identificacao"] = "Boleto prestação serviços {$sys['company']}";
$dadosboleto["cpf_cnpj"] = $sys['register'];
//$dadosboleto["endereco"] = "Coloque o endereço da sua empresa aqui";
//$dadosboleto["cidade_uf"] = "Cidade / Estado";
$dadosboleto["cedente"] = $sys['company'];

// NÃO ALTERAR!
include("funcoes_bb.php"); 
include("layout_bb.php");
?>
