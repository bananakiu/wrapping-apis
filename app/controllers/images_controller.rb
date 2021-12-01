class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  before_action :get_api, only: %i[ new ]

  # GET /images or /images.json
  def index
    @images = Image.all
  end

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
    image_path = ""
    begin
        @upload_response = @client.upload_file(image_path)
    rescue => exception
        puts exception
    end
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    # # upload to Imagga
    # begin
    #   @upload_response = @client.upload_file(@image.image_on_disk)
    #   @image.upload_id = @upload_response["result"]["upload_id"]
    # rescue => error
    #   flash[:alert] = error.message
    #   # redirect_to images_path
    # end

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
