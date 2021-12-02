class Client
    # Imagga API docs: https://docs.imagga.com/
    include HttpStatusCodes
    include ApiExceptions

    BASE_URL = "https://api.imagga.com/v2"

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
            endpoint: "categories/#{category_id}",
            params: {
                image_url: image_url
            }
        )
    end

    def detect_text(image_url)
        request(
            http_method: :get,
            endpoint: "text",
            params: {
                image_url: image_url
            }
        )
    end

    private
    def request(http_method:, endpoint:, params: {})
        @response = connection.public_send(http_method, endpoint, params)
        puts @response.status
        return JSON.parse(@response.body) if @response.status == HTTP_OK_CODE
        raise error_class
    end

    def connection
        @connection ||= Faraday.new(
            url: BASE_URL,
            headers: {
                "Authorization" => Rails.application.credentials.imagga[:authorization]
            }
        )
    end

    def error_class
        case @response.status
        when HTTP_NOT_FOUND_CODE
            NotFoundError
        when HTTP_UNAUTHORIZED_CODE
            UnauthorizedError
        else
            ApiError
        end
    end
end