class BimbyRaisesController < ApplicationController
  before_action :set_bimby_raise, only: [:show, :edit, :update, :destroy]
  before_action :validate_password, except: :home
  before_action :validate_admin_password, only: [:edit, :destroy, :index, :update]

  VALID_PASSWORD = '$giftmartaraise$'
  ADMIN_PASSWORD = '#admin#manage1A$'
  VALID_PASSWORDS = [VALID_PASSWORD, ADMIN_PASSWORD]

  helper_method :admin?

  def index
    @bimby_raises = BimbyRaise.all
  end

  def new
    @bimby_raise = BimbyRaise.new
  end

  def edit
  end

  def update
    if @bimby_raise.update(bimby_raise_params)
      redirect_to bimby_raises_path
    else
      render :edit
    end
  end

  def destroy
    @bimby_raise.destroy

    redirect_to bimby_raises_path
  end

  def create
    @bimby_raise = BimbyRaise.new(bimby_raise_params)

    respond_to do |format|
      if @bimby_raise.save
        format.html { redirect_to @bimby_raise, notice: 'Bimby raise was successfully created.' }
        format.json { render :show, status: :created, location: @bimby_raise }
      else
        format.html { render :new }
        format.json { render json: @bimby_raise.errors, status: :unprocessable_entity }
      end
    end
  end

  def home
    password = params.dig(:password, :text)

    if password
      session[:password] = password if valid_password?(password)

      if admin?
        redirect_to bimby_raises_path
      else
        redirect_to new_bimby_raise_path
      end
    end
  end

  private

  def validate_password
    redirect_to root_path unless valid_password?(session[:password])
  end

  def validate_admin_password
    redirect_to root_path unless session[:password] == ADMIN_PASSWORD
  end

  def admin?
    session[:password] == ADMIN_PASSWORD
  end

  def valid_password?(pass)
    VALID_PASSWORDS.include?(pass)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_bimby_raise
    @bimby_raise = BimbyRaise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bimby_raise_params
    params.require(:bimby_raise).permit(:first_name, :last_name, :amount)
  end
end
