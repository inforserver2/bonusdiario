#encoding : UTF-8
module ContractsHelper
  def contract_visible_interprets(status)
    case status
      when 0 then "pendente"
      when 1 then "ativo"
      when 2 then "bloqueado"
    end
  end


end

