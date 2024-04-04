class PlanExpiration 
    attr_accessor :time
    def initialize(time)
      @time = time
    end

    def get_date
        date = "#{@time.year + 1}-#{@time.month}-01"
        
        if is_february?
          return Time.parse(date)
        elsif month_end_with_thirty?
          return Time.parse(date)
        else
            date = "#{@time.year + 1}-#{@time.month}-#{@time.day}"
          return Time.parse(date)
        end
    end

    private 
      def is_february?
        (@time.month == 2) || (@time.day == 28) || (@time.day == 29)
      end

      def month_end_with_thirty?
        (@time.day == 30) || (@time.day == 31)
      end
end