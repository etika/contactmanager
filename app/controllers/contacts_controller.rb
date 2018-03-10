class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_contact, only: [:edit, :update, :destroy,:show]

  def index
    respond_to do |format|

      @contacts = params[:search].present? ? search_contact(params[:search]) : Contact.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 30)
      format.csv { render csv: @contacts }
      format.html
    end
  end

  def show
  end

  # # GET /contacts/1/edit
  def edit
  end

  # # PATCH/PUT /contacts/1
  # # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /contacts/1
  # # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :email, :phone_number=>[])
  end

  def search_contact(search_params)
    @search = Contact.search do
      fulltext search_params
    end
    @contacts = @search.results
  end
end
