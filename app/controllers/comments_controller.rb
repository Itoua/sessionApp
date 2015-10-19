class CommentsController < ApplicationController 
  after_action :verify_authorized, only: [ :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create
  	@article = Article.find(params[:article_id])
    @comment = @article.comments.build(allowed_params])
  	@comment.user_id = current_user.id
  	if @comment.save
  	 	redirect_to article_path(@article)
  	else
  	 	flash.now[:danger] = "Could not be saved"
  	 	render @comment
  	  end
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize @comment
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize @comment
    if @comment.update_attributes(allowed_params)
      flash.now[:notice] = 'Comment updated successfully'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = "Could mot be updated"
      render @comment
    end
  end

  def destroy
  	@article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to article_path(@article)
  end

private

  def allowed_params
    params.require(:comment).permit(:body)
    #params.require(:comment).permit(*policy(@comment || Comment).permitted_attributes)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    (request.referrer || root_path)
  end

   ##################################################

   # def new
   #    @comment = Comment.new
   # end

   # def create
   #    @article = Article.find(params[:article_id])
   #    @comment = @article.comments.build(params[:comment])
   #    @comment.user_id = current_user.id
   #    @comment.save
   #      flash[:success] = "Comment created!"
   #      redirect_to article_path(@comment.article)
   #  end

   # def edit
   #  @comment = Comment.find(params[:id])
   # end

   # def update
   #   @comment = Comment.find(params[:id])
   #   @article = @comment.article
   #   respond_to do |format|
   #    if @comment.update_attributes(params[:comment])
   #      redirect_to @article_path(@article)
   #    else
   #     render :action => "edit" 
   #    end
   # end

   # def destroy
   #   @comment = Comment.find(params[:id])
   #   @article = Article.find(params[:article_id])
   #   @comment.destroy
   #     redirect_to @article_path(@artilce) 
   # end
end
