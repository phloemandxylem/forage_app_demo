class UsersController < ApplicationController

      def index
            @user= User.all
      end 
      def new
           @user = User.new
      end

      def create
           @user = User.new
           @user.name = params[:user][:name]
           @user.email = params[:user][:email]
           @user.password = params[:user][:password]
           @user.password_confirmation = params[:user][:password_confirmation]

           if @user.save
                 flash[:notice] = "Welcome to Botanopedia #{@user.name}!"
                 create_session(@user)
                 redirect_to root_path
           else
                 flash.now[:alert] = "There was an error creating your account. Please try again."
                 render :new
           end
      end
            def show
                  @user = User.find(params[:id])
                  @wikis = @user.wikis.visible_to(current_user)
            end
      end
