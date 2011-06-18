#encoding: UTF-8
module PayoutsHelper
  def trans_payout_status status
    case status
    when 0 then 'a enviar'
    when 1 then 'enviado'
    when 2 then 'pendente'
    else

    end
  end

end

