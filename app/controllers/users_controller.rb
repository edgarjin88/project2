class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  # delete via :update action
  # why destroy later?

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
    # 위의 코드 자체가 이미 유저들을 페이지네이트 해서 정리한 코드이다. 
    
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      @user.image = req["public_id"]

      # cludinary
    end


    if @user.save
      session[:user_id] = @user.id
      flash[:success] ="Welcome to Slozzie #{@user.username}"
      redirect_to user_path(@user)
    else

      render 'new'
    end
  end

  def edit
    
  end

  def update
    @user = User.find(params[:id])
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])

      @user.image = req["public_id"]
      @user.update_attributes(user_params)
      # Above cloudinary
    end
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] ="User and all articles created by user have been deleted"
    redirect_to users_path
    
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
    
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path

    end
    
  end

  def require_admin

    if logged_in? and !current_user.admin?
      flash[:danger] ="Only admin users can perform that action"
      redirect_to root_path

    end

  end

  def set_user
    @user= User.find(params[:id])
    # is that all ? 
  end
  
end