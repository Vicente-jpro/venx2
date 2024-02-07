class GenerateCode

    def self.generate
      (Time.new).to_s
                .gsub("-", "")
                .gsub(":", "")
                .gsub("+", "")
                .gsub(" ", "")
                .gsub("0100", "")
    end
end

      