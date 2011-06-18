module UsersHelper

  def trans_user_status status
    case status
    when 0 then 'pendente'
    when 1 then 'ativo'
    when 2 then 'suspenso'
    else
      nil
    end
  end

end
