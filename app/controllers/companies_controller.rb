class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_company, only: [:edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.sort_by_name.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    @partner_connection_feeds = Feed.partner_connections(@company)
    @feeds = @company.feeds - @partner_connection_feeds
  end

  # GET /companies/new
  def new
    if current_user.admin?
      @company = Company.new(parent_company_id: params[:parent_company_id])
    else
      redirect_to companies_path
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @company }
      else
        format.html { render action: 'new' }
        # format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        # format.json { render action: 'show', status: :ok, location: @company }
      else
        format.html { render action: 'edit' }
        # format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      # format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      if current_user.admin?
        @company = Company.find(params[:id])
      else
        redirect_to companies_path, notice: "User not authorized"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:parent_company_id, :company_type_id, :state_id, :name, :additional_name, :address_line_1, :address_line_2, :address_line_3, :city, :zip, :url, :naic_code, :ai_carrier_code, :notes, parent_company_attributes: [:id, :name, :additional_name])
    end
end
