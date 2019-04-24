class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user
  # let's make user required for every action
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # 여기서 set_article은 왜 :가 붙는가? 
  # 아래의 article_params와 비교된다. 이것은 콜백의 개념인가?
  # 위에서 말하는 것은 실제 코드가 아니라, 그냥 레퍼런스다. 코드를 여기서 실행하면 안되기 때문이다. 

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    # create  할 때 이렇게 확실히 연결시켜 줘야 정보를 안다.
    # 그럼 그렇지. 그러니 서로 연결을 하지. 
    if @article.save
      flash[:success] = "Article was created"
      redirect_to article_path(@article)

    else
      render 'new'
    end
  end
  
  def show
    # no ?
    # set_article function would take this part. 
  end 

  def destroy

    @article.destroy
    flash[:danger] = "Article was deleted"

    redirect_to articles_path
    
  end

  def edit

  end

  def update

    if @article.update(article_params)
      flash[:success] = "Article was updated"
      redirect_to article_path(@article)
    else
      render 'edit'

    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
    
  end
  def article_params
    params.require(:article).permit(:title, :description)
    # 이거 params에 관한 이야기가 아니다. database에 관한 이야기다. 
    # 아마도.. 
  end

  def require_same_user
    if current_user != @article.user
      # create 한 시점에서 의 current_user와는 다를 수가 있으니. 
      # @article.user = current_user
      flash[:danger] = "You can only edit or delete your own post"
      redirect_to root_path
    
    end
  end

  
end