class DateConvert 
    attr_writer :time

    def initialize(time)
      @time = time
    end

    def get_date_in_string
       date = "#{@time.year}-#{@time.month}-#{@time.day}"
       date 
    end
end