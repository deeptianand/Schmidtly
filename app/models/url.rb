require 'uuid'

class Url < ActiveRecord::Base
  validates_format_of :full_url, :with => /^(https?):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  before_create :short_urlify
  
  def short_urlify
    uuid = UUID.new.generate #23412354573567456874536632lkjshdagf
    @code = ""
    10.times do 
        @code += uuid[rand(uuid.length)]
    end
    if Url.where("short_url = '#{@code}'") == []
      self.short_url = @code
    else
      short_urlify
    end
    self.short_url = @code
    self.counter = 0
    #we need to validate that code is unique, if not, generate another from encoded_byte_values
    #if it is, then we complete our database entry
  end

end
