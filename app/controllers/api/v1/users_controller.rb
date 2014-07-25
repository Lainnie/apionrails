module Api::V1
  class UsersController < ApplicationController
    respond_to :json
    before_action :set_user, only: [:update, :show, :destroy]

    def index
      render json: User.all, status: 200
    end
    def show
      respond_with @user
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: 201, location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
    end

    def update
      if @user.update user_params
        render json: @user, status: 200, location: [:api, @user]
      else
        render json: { errors: @user.errors }, status: 422
      end
    end

    def destroy
      @user.destroy
      render nothing: true, status: 204
    end

    private
    def set_user
      render nothing: true, status: 404 unless @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
