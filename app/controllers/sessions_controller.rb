class SessionsController < ApplicationController

    def new
        
    end

    def create
        user = User.find_by username: params[:username]

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user_path(user), notice: "Welcome back!"
        else
            redirect_to :back, notice: "Username and/or password mismatch"
        end
            
        # if user.nil?
        #     redirect_to :back, notice: "User #{params[:username]} does not exist!"
        # else
        #     session[:user_id] = user.id if not user.nil?
        #     redirect_to user
        # end
    end

    def destroy
        session[:user_id] = nil
        redirect_to = :root
    end
end
