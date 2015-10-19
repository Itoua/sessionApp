class ArticlesController < ApplicationController
  
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :create, :destroy]

  def new
    @article = Article.new
    authorize @article
  end

  def edit   
    @article = Article.find(params[:id])
    authorize @article
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
  end

  def index
    @article = Article.all.order('created_at DESC')
    #@article = Article.includes(:comment).all
  end

  def create
    @article = Article.new(allowed_params)   
    @article.user_id = current_user.id
    if@article.save
      flash.now[:notice] = "Article #{@article.title} created succesfully"
      redirect_to articles_path
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    authorize @article
    if @article.update_attributes(allowed_params)
      flash.now[:notice] = "Article #{@article.title} updated successfully"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article
    @article.destroy
    redirect_to articles_path
  end

  private

    def allowed_params
      params.require(:article).permit(:title, :content)
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to articles_path
    end      
end
