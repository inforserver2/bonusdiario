class ContractMailer < ActionMailer::Base
  helper :contracts
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contract_mailer.activation.subject
  #
  def activation(contract)
    @contract = contract
    headers={:to => contract.user.email1,:subject => "#{CFG['domain']} - Seu contrato ##{contract.id} foi ativado com sucesso."}

    headers['bcc']= contract.user.email2 if contract.user.email2

    mail(headers)
  end
end
