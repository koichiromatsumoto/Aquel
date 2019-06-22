class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    @replied_contacts = @contacts.where.not(reply: nil)
    @unreplied_contacts = @contacts.where(reply: nil)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(contact_params)
    redirect_to contact_path(@contact.id)
  end

  def new
    @contact = Contact.new
    @contacts = Contact.where(user_id: current_user.id).order(created_at: :desc).all
  end

  def create
  	@contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
  	@contact.save
    redirect_to new_contact_path
  end

  def destroy
  end

  private
  def contact_params
    params.require(:contact).permit(:user_id, :content, :reply)
  end
end
