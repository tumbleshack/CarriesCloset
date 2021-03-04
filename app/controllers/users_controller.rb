class UsersController < ApplicationController
    
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
  end