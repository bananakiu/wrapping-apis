class PagesController < ApplicationController
    before_action :get_api
    def main
        begin
            @tags_call = @client.tag_uploaded_photo
            @tags = @tags_call["result"]["tags"]
        rescue => exception
            puts exception
            @tags_call = exception
        end
    end

    def get_api
        @client = Client.new
    end 
end
# response = connection.public_send("get", "tags", image_url: "https://media.istockphoto.com/photos/red-apple-with-leaf-isolated-on-white-background-picture-id185262648"