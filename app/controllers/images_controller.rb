class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy upload ]
  before_action do
    ActiveStorage::Current.host = request.base_url
  end
  after_action :upload, only: %i[ create ]

  # GET /images or /images.json
  def index
    @images = Image.all
  end

  # GET /images/1 or /images/1.json
  def show
    key = @image.image_to_analyze.blob.key
    @blob_path = "storage/#{key[0..1]}/#{key[2..3]}/#{key}"
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload
    get_api

    # file path
    # key = @image.image_to_analyze.blob.key
    # @blob_path = "storage/#{key[0..1]}/#{key[2..3]}/#{key}"

    # upload to Imagga
    begin
      # i0709705005abef67333ebc461uClsmm
      puts "entered upload api call block"
      # upload_response = @client.upload_file(image_path: request.base_url + @image.attachment_url)
      # upload_response = @client.upload_file(image_path: @image.image_to_analyze.service_url)
      # upload_response = @client.upload_file(image_path: @image.attachment_url)
      # upload_response = @client.upload_file(image_path: @blob_path)
      upload_response = @client.upload_file(image64: Base64.encode64(@image.image_to_analyze.download))
      # upload_response = @client.upload_file(image64: Base64.encode64(@image.image_to_analyze))

      puts upload_response
      
      @image.upload_id = upload_response["result"]["upload_id"]
      @image.save!
    rescue => error
      puts "error in upload api call block"
      puts error
      flash[:alert] = error
      return
      # redirect_to images_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      # :authenticity_token, :image, :commit
      # params.permit(:id, :url, :tags, :image_to_analyze, :image)
      params.require(:image).permit(:id, :url, :tags, :image_to_analyze, :updated_at)
      # params.require(:image).permit(:id, :url, :tags, :image_to_analyze) # <- weird error. cannot find ":mage"
    end

    def get_api
      @client = Client.new
  end 
end
