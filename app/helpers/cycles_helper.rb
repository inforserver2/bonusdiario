#encoding: UTF-8
module CyclesHelper
  def trans_cycle_status status
    case status
    when 0 then 'aberto'
    when 1 then 'fechado'
    else
      
    end
  end
end

