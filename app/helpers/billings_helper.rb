#encoding : UTF-8
module BillingsHelper

  def bill_visible_interprets(status)
    case status
      when 0 then "pendente"
      when 1 then "pago"
      when 2 then "cancelado"
    end
  end

  def bill_show_link_interprets(status)
    case status
      when 0 then "Pagar"
      when 1 then "Mostrar"
      when 2 then "--"
    end
  end

end

