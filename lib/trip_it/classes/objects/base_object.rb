module TripIt
  class BaseObject < Base    
    attr_reader :id, :relative_url, :is_client_traveler
    integer_param :trip_id 
    string_param :display_name
    array_param :image
    
    def populate(info)
      return if info.nil? # Make sure we don't raise an error if info is nil
      @id                     = info["id"]
      @relative_url           = info["relative_url"]
      @trip_id                = info["trip_id"]
      @is_client_traveler     = Boolean(info["is_client_traveler"])
      @display_name           = info["display_name"]
      @image                  = []
      chkAndPopulate(@image, TripIt::Image, info["Image"])
    end
    
    def save
      if @obj_id.nil?
        @client.create(self.to_xml)
      else
        @client.replace("/#{self.class.name.split("::").last.gsub("Object","").downcase}/id/#{@obj_id}", self.to_xml)
      end
    end
    
    def sequence
      ["@trip_id","@display_name", "@image"]
    end
  end
end