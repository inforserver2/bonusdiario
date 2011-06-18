#encoding: UTF-8
module CommsHelper
  def trans_comm_status status
    case status
    when 0 then 'a enviar'
    when 1 then 'em envio'
    when 2 then 'pago'
    when 3 then 'cancelado'
    else

    end
  end

end

