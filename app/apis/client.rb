class Client
    # Imagga API docs: https://docs.imagga.com/
    # possible reference: https://github.com/unsplash/imagga-auto-tag/blob/master/lib/imagga_auto_tag/client.rb
    BASE_URL = "https://api.imagga.com/v2".freeze

    def initialize
    end

    def tag_uploaded_photo(image_upload_id:)
        request(
            http_method: :get,
            endpoint: "tags",
            params: {
                # image_url: "https://media.istockphoto.com/photos/red-apple-with-leaf-isolated-on-white-background-picture-id185262648",
                image_upload_id: image_upload_id
            }
        )
    end
    
    def upload_file(image64)
        request(
            http_method: :post,
            endpoint: "uploads",
            params: {
                image_base64: image64
            }
        )
    end
    
    def upload_url(img_path)
        request(
            http_method: :post,
            endpoint: "uploads",
            params: {
                image_url: img_url
            }
        )
    end
    def delete_uploaded_file(upload_id:)
        request(
            http_method: :delete,
            endpoint: "uploads",
            params: {
                upload_id: upload_id
            }
        )
    end

    private
    def request(http_method:, endpoint:, params: {})
        @response = connection.public_send(http_method, endpoint, params)
        JSON.parse(@response.body)
    end

    def connection
        @connection ||= Faraday.new(
            url: BASE_URL,
            headers: {
                "Authorization" => Rails.application.credentials.imagga[:authorization]
            }
        )
    end
end