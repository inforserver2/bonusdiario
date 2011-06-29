#encoding : UTF-8
module BillingsHelper
  
  def trans_bill_status status
    case status
    when 0 then 'pendente'
    when 1 then 'pago'
    when 2 then 'cancelado'
    else

    end
  end


end

