class ParentCompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_parent_company, only: [:edit, :update, :destroy]
  # after_action :verify_authorized

  # GET /parent_companies
  # GET /parent_companies.json
  def index
    @parent_companies = ParentCompany.sort_by_name.all
  end

  # GET /parent_companies/1
  # GET /parent_companies/1.json
  def show
    @parent_company = ParentCompany.find(params[:id])
    @companies = @parent_company.companies
  end

  # GET /parent_companies/new
  def new
    if current_user.admin?
      @parent_company = ParentCompany.new
    else
      redirect_to parent_companies_path
    end
  end

  # GET /parent_companies/1/edit
  def edit
  end

  # POST /parent_companies
  # POST /parent_companies.json
  def create
    @parent_company = ParentCompany.new(parent_company_params)

    respond_to do |format|
      if @parent_company.save
        format.html { redirect_to @parent_company, notice: 'Parent company was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parent_company }
      else
        format.html { render action: 'new' }
        format.json { render json: @parent_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parent_companies/1
  # PATCH/PUT /parent_companies/1.json
  def update
    respond_to do |format|
      if @parent_company.update(parent_company_params)
        format.html { redirect_to @parent_company, notice: 'Parent company was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @parent_company }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parent_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parent_companies/1
  # DELETE /parent_companies/1.json
  def destroy
    @parent_company.destroy
    respond_to do |format|
      format.html { redirect_to parent_companies_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent_company
      if current_user.admin?
        @parent_company = ParentCompany.find(params[:id])
      else
        redirect_to parent_companies_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_company_params
      params.require(:parent_company).permit(:name, :additional_name)
    end
end
