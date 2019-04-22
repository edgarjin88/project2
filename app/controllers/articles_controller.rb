class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  # 여기서 set_article은 왜 :가 붙는가? 
  # 아래의 article_params와 비교된다. 이것은 콜백의 개념인가?

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created"
      redirect_to article_path(@article)

    else
      render 'new'
    end
  end
  
  def show

  end 

  def destroy

    @article.destroy
    flash[:notice] = "Article was deleted"

    redirect_to articles_path
    
  end

  def edit

  end

  def update

    if @article.update(article_params)
      flash[:notice] = "Article was updated"
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

  
end