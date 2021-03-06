class MyTools

  def self.diff_date_in_days(time_from,time_to)
    (time_from.to_date-time_to.to_date).to_i
  end


  def self.get_discount(price,porcentage)
   (price*porcentage)
  end

  def self.bill_remember_days_interval
    [-2,-4,-6,-10,-15]
  end


  def self.bill_remember_days(diff)
    case diff
      when -2 then 1
      when -4 then 2
      when -6 then 3
      when -10 then 4
      when -15 then 5
      else 0
    end
  end

  def self.age_in_completed_years (bd, d)
      # Difference in years, less one if you have not had a birthday this year.
      a = d.year - bd.year
      a = a - 1 if (
           bd.month >  d.month or
          (bd.month >= d.month and bd.day > d.day)
      )
      a
  end

  
end


