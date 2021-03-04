class UsersController < ApplicationController
    
    def new
        render 'users/manage'
    end

    def index
        render 'users/manage'
    end
    
    def manage
        render 'users/manage'
    end
  end