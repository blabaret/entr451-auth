class SessionsController < ApplicationController
def new
end

    def create
        #check if user exists
        @user = User.find_by({"email" => params["email"]})
    
            if @user
                #if they do, check the password is correct
                #if params["password"] == @user["password"]
                if BCrypt::Password.new(@user["password"]) == params["password"]
                    cookies["monster"] = "me like cookies"
                    session["user_id"] = @user["id"]
                    flash["notice"] = "Welcome!"
                    redirect_to "/companies"
                else
                    redirect_to "/sessions/new"
                end
            else
                #if it is, log them in
                redirect_to "/sessions/new"
            end
    end

    def destroy
        session["user_id"] = nil
        redirect_to "/sessions/new"
    end

end
