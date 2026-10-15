class UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    @results = current_user.search(params[:query])

    render 'users/search'
  end

  def show
    @user = current_user
  end

  def enable_2fa 
    if current_user.otp_required_for_login?
      redirect_to root_path, alert: 'Two-factor authentication is already enabled.'
    else
      @qr_svg = RQRCode::QRCode.new(current_user.otp_qr_code).as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 3,
        standalone: true,
        use_path: true,
      )

      render "users/enable_2fa" 
    end  
  end

  def disable_2fa
    current_user.update!(otp_required_for_login: false)
    redirect_to root_path, notice: 'Two-factor authentication disabled successfully.'
  end

  def update
    if current_user.validate_and_consume_otp!(params[:otp_attempt])
        current_user.update!(otp_required_for_login: true)
        redirect_to root_path, notice: 'Two-factor authentication enabled successfully.'
    else
        redirect_to root_path, alert: 'Invalid OTP code.'
    end
  end
end