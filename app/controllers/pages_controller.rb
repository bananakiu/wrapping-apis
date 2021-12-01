class PagesController < ApplicationController
    before_action :get_api
    def main
        begin
            @tags_response = @client.tag_uploaded_photo
            @tags = @tags_response["result"]["tags"]
        rescue => exception
            puts exception
        end
    end

    def upload
        image_path = ""
        begin
            @upload_response = @client.upload_file(image_path)
        rescue => exception
            puts exception
        end
    end

    def get_api
        @client = Client.new
    end 
end
# response = connection.public_send("get", "tags", image_url: "https://media.istockphoto.com/photos/red-apple-with-leaf-isolated-on-white-background-picture-id185262648"