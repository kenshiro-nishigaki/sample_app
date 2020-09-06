class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      #[remember me]チェックボックスの送信結果を処理する
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #フレンドリーフォワーディングを備えたcreateアクション
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end