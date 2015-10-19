class ArticlePolicy 
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @article = model
  end

  def new?
   @current_user.admin? || @current_user.author?
  end

  def show?
   @current_user.member? || @current_user.admin?
  end

  def update?
    @current_user.admin?
  end

  def destroy?
   @current_user.admin? || @current_user.author?
  end

  def edit? 
   @current_user.admin? || @current_user.author?
  end

end