class ContactsController < ApplicationController
before_action :authenticate_user!

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
    if @contact.update(contact_params)
      flash[:success] = "回答を送信しました"
      redirect_to contact_path(@contact.id)
    else
      flash[:danger] = "回答は1〜200文字で入力してください"
      redirect_to contact_path(@contact.id)
    end
  end

  def new
    @contact = Contact.new
    @contacts = Contact.where(user_id: current_user.id).order(created_at: :desc).all
  end

  def create
  	@contact = Contact.new(contact_params)
    @contacts = Contact.where(user_id: current_user.id).order(created_at: :desc).all
    @contact.user_id = current_user.id
  	if @contact.save
      flash[:success] = "送信しました"
      redirect_to new_contact_path
    else
      flash[:danger] = "1〜200文字で送信してください"
      render :new
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact.destroy
      flash[:success] = "問い合わせを削除しました"
      redirect_to contacts_path
    else
      flash[:danger] = "問い合わせの削除に失敗しました"
      redirect_to contact_path(@contact.id)
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:user_id, :content, :reply)
  end
end
