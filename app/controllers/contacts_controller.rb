class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_contact, only: [:edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])
  end

  # GET /contacts/new
  def new
    if current_user.admin?
      @contact = Contact.new
    else
      redirect_to contacts_path
    end
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        # format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        # format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        # format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        # format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      # format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      if current_user.admin?
        @contact = Contact.find(params[:id])
      else
        redirect_to contacts_path, notice: "User not authorized"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :phone, :address_line_1, :address_line_2, :address_line_3, :email, :gender_id, :title, :notes, :state_id, :city, :zip, 
        feed_contacts_attributes: [:id, :contact_id, :feed_id, :contact_type_id, :start_date, :end_date, :_destroy])
    end
end
