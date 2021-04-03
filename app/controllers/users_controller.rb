class UsersController < ApplicationController

    # make sure you cannot delete yourself

    before_action -> { require_role(:root, :admin) }
    
    def new
        @users = User.all
        render 'users/manage'
    end

    def index
        @users = User.all
        render 'users/manage'
    end
    
    def manage
        @users = User.all
        render 'users/manage'
    end

    def set_user
        @user = User.find(params[:id])
    end


    def edit
        @user = User.find(params[:id])
        @user.email_setting = @user.build_email_setting.save! if @user.email_setting.nil?
    end

    def show
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        respond_to do |format|
            if @user.update(email: user_params["email"], admin: user_params["admin"], donor: user_params["donor"], donee: user_params["donee"], volunteer: user_params["volunteer"])
                format.html { redirect_to @user, notice: "User was successfully updated." }
                format.json { render :show, status: :ok, location: @user }
            else
            render 'edit'
            end
        end
    end
   

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_manage_url
     end

     private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :admin, :volunteer, :donee, :donor, :current_password, :password_confirmation => [], email_setting_attributes: [:preference])
    end
  end