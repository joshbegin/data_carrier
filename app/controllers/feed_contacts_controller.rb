class FeedContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_feed_contact, only: [:edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  # def index
  #   @feeds = Feed.sort_by_company.all
  # end

  # GET /feeds/1
  # GET /feeds/1.json
  # def show
  #   @feed = Feed.find(params[:id])
  # end

  # GET /feeds/new
  # def new
  #   if current_user.admin?
  #     @feed = Feed.new(company_id: params[:company_id])
  #   else
  #     redirect_to feeds_path
  #   end
  # end

  # GET /feeds/1/edit
  # def edit
  # end

  # POST /feeds
  # POST /feeds.json
  # def create
  #   @feed = Feed.new(feed_params)

  #   respond_to do |format|
  #     if @feed.save
  #       format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
  #       # format.json { render action: 'show', status: :created, location: @feed }
  #     else
  #       format.html { render action: 'new' }
  #       # format.json { render json: @feed.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  # def update
  #   respond_to do |format|
  #     if @feed.update(feed_params)
  #       format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
  #       # format.json { render action: 'show', status: :ok, location: @feed }
  #     else
  #       format.html { render action: 'edit' }
  #       # format.json { render json: @feed.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    feed = @feed_contact.feed
    @feed_contact.destroy
    respond_to do |format|
      format.html { redirect_to(:back) }
      # format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_contact
      if current_user.admin?
        @feed_contact = FeedContact.find(params[:id])
      else
        redirect_to feeds_path, notice: "User not authorized"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_contact_params
      params.require(:feed_contact).permit(:id, :contact_id, :feed_id, :contact_type_id, :start_date, :end_date)
    end
end
