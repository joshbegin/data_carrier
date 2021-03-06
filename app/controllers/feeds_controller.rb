class FeedsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_feed, only: [:edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.sort_by_company.all
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
  end

  # GET /feeds/new
  def new
    if current_user.admin?
      @feed = Feed.new(company_id: params[:company_id])
    else
      redirect_to feeds_path
    end
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @feed }
      else
        format.html { render action: 'new' }
        # format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        # format.json { render action: 'show', status: :ok, location: @feed }
      else
        format.html { render action: 'edit' }
        # format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url }
      # format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      if current_user.admin?
        @feed = Feed.find(params[:id])
      else
        redirect_to feeds_path, notice: "User not authorized"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:name, :notes, :stage_feed_url, :production_feed_url,
        :production_start_date, :production_end_date, :company_id, :feed_status_id,
        :feed_frequency_id, :feed_type_id, :transaction_type, :sent_to_data_rail,
        :enhanced_carrier_status, :data_rail_api_key, :data_rail_password, :data_rail_queue_priority,
        :data_view_username, :data_view_password, :partner, :split_by_data_rail,
        :source_system_type_id, :destination_system_type_id, :source_transmission_type_id,
        :destination_transmission_type_id, :parent_feed_id)
    end
end
