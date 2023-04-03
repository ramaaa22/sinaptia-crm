class UsersController < ApplicationController
  before_action :set_company
  before_action :set_user, only: %i[edit update destroy restore]
  before_action :authorize_user, only: %i[edit update destroy restore]
  after_action :verify_authorized

  # GET /users
  def index
    @users = User.excluding(current_user).where(company: @company).page(params[:page])
    if params[:search].present?
      @users = @users.search(params[:search])
    end
    authorize(User)
  end

  def new
    @user = User.new
    authorize_user
  end

  def create
    @user = User.new(user_params.merge(company: @company))
    authorize_user
    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.discard
    redirect_to users_path, notice: "User was successfully deleted."
  end

  # RESTORE /users/1
  def restore
    @user.undiscard
    redirect_to users_path, notice: "User was successfully restored."
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :role, :first_name, :last_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize(@user)
  end
end
