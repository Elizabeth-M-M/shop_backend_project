class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    users= User.all
    render json: users
  end

  def show
    user = find_user
    if user
    render json: user
    else
      render json: {error: "User not found"}, status: :not_found
    end
  end

  def create
    user = User.create(user_params)
    if user.valid?
      render json: user, status: :created
    else
      render json: {error: user.errors.full_messages}, status: :unprocessable_entity
    end

  end

  def update
    user = find_user
    if user
      user.update(user_params)
      render json: user, status: :accepted
    else
      render json: {error: "User not found"}, status: :not_found
    end

  end

  def destroy
    user = find_user
    if user
       user.destroy
       head :no_content
    else
      render json: {error: "User not found"}, status: :not_found
    end
  end

  private

  def user_params
    params.permit(:name, :email, :phone_number, :password)
  end

  def find_user
    User.find_by(id:params[:id])
  end

end
