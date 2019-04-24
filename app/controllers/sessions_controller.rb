class SessionsController < ApplicationController
  
    def new

    # why nothing required for new action?
    end

    def create

      user = User.find_by(email: params[:session][:email].downcase)
      # 여기서 user에다가 모든 정보 매칭해서 담는다. 
      # 기본적으로 session은 모든 정보를 가지고 있다. Form으로 부터 정보 체취
      if user && user.authenticate(params[:session][:password])
        #파람으로 체크는 하지만, 기본적으로 이게 페스워드를 저장하는 것은 아니다. 
        #저장하고 싶다면 session에 따로 저장을 해야 한다. 
        session[:user_id] = user.id
        # session[:user_id] 는 여기서 비로소 정해진다. 
        # there is no validation beause it is not a model. 
        flash[:succes] = 'You have logged in'

        # after this, [:session][:password]를 nil로 하거나 destroy 하자. 
        # 만약 필요하면 내비두고. 
        redirect_to user_path(user)
      else  
        flash.now[:danger] ="Something wrong with your login info"
        render 'new'

      end


      
    end

    def destroy
      session[:user_id] =nil
      flash[:success] = "You have logged out"
      redirect_to root_path
    end
end