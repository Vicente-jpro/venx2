class Testando 

    def self.test 
        @p = PlansSelected.new
        @p.day_used = 30
        @p.duration = "semiannual"
        @p.plan_id =  1
        @p.company_id = 1
        @p.save
    end
end