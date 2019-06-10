class ContactsController < ApplicationController
  def index
  end

  def show
  	@contact = Contact.find(params[:id])
  end

  def create
  	@contact = Contact.new
  	contact.save
  end

  def destroy
  end
end
