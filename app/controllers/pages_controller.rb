class PagesController < ApplicationController
    def main
        client = Client.new
        begin
            @tags = client.tag_uploaded_photo
        rescue => exception
            puts exception
            @tags = "error occurred"
        end
    end
end
