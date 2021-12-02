class Client
    # Imagga API docs: https://docs.imagga.com/
    # possible reference: https://github.com/unsplash/imagga-auto-tag/blob/master/lib/imagga_auto_tag/client.rb
    BASE_URL = "https://api.imagga.com/v2".freeze

    def initialize
    end

    # def tag_uploaded_photo(image_upload_id:)
    def tag_uploaded_photo(image_url)
        request(
            http_method: :get,
            endpoint: "tags",
            params: {
                image_url: image_url
            }
        )
    end

    def get_categorizers
        request(
            http_method: :get,
            endpoint: "categorizers"
        )
    end

    def categorize(category_id, image_url)
        request(
            http_method: :get,
            endpoint: "categorizers/#{category_id}",
            params: {
                image_url: image_url
            }
        )
    end

    def detect_face(image_url)
        request(
            http_method: :get,
            endpoint: "faces/detections",
            params: {
                image_url: image_url
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