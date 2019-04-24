class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  # delete via :update action

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
    # 위의 코드 자체가 이미 유저들을 페이지네이트 해서 정리한 코드이다. 
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ="Welcome to Slozzie #{@user.username}"
      redirect_to articles_path
    else

      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      flash[:success] ="Your account was updated successfully"
      redirect_to articles_path

    else
      render 'edit'
    end
  end 

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    # to paginate only the articles writted by the user. 
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
    
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path

    end
    
  end

  def set_user
    @user= User.find(params[:id])
    # is that all ? 
  end
  
end