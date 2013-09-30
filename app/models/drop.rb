class Drop < ActiveRecord::Base
    
  def self.generate_uri
    loop do
      uri = (0...7).map{(65+rand(26)).chr}.join
      break if Drop.find_by_uri(uri).nil?
    end
  end
  
end
