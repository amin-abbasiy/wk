class MyOffersController < ApplicationController
  before_action :set_my_offer, only: %i[ show edit update destroy ]

  # GET /my_offers or /my_offers.json
  def index
    @my_offers = MyOffer.all
  end

  # GET /my_offers/1 or /my_offers/1.json
  def show
  end

  # GET /my_offers/new
  def new
    @my_offer = MyOffer.new
  end

  # GET /my_offers/1/edit
  def edit
  end

  # POST /my_offers or /my_offers.json
  def create
    @my_offer = MyOffer.new(my_offer_params)

    respond_to do |format|
      if @my_offer.save
        format.html { redirect_to my_offer_url(@my_offer), notice: "My offer was successfully created." }
        format.json { render :show, status: :created, location: @my_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @my_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my_offers/1 or /my_offers/1.json
  def update
    respond_to do |format|
      if @my_offer.update(my_offer_params)
        format.html { redirect_to my_offer_url(@my_offer), notice: "My offer was successfully updated." }
        format.json { render :show, status: :ok, location: @my_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @my_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_offers/1 or /my_offers/1.json
  def destroy
    @my_offer.destroy!

    respond_to do |format|
      format.html { redirect_to my_offers_url, notice: "My offer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_offer
      @my_offer = MyOffer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_offer_params
      params.require(:my_offer).permit(:title, :story, :present)
    end
end
