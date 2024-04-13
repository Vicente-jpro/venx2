class FileFormat
    
    def initialize(file)
      @file = file
    end

    def get_content_type
       last_caracter_position =  @file.original_filename.size-1
       first_caracter_position =  @file.original_filename.size-3

       content_type = @file.original_filename[first_caracter_position, last_caracter_position]
       content_type
    end
end