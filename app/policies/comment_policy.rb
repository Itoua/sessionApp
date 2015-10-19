class CommentPolicy 

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @comment = model
  end

  def update?
    policy_check?
  end

  def destroy?
    policy_check?
  end

  def edit?
    policy_check?
  end

  private 

    def policy_check?
       if @current_user.admin? || @current_user.id == @comment.user_id
         return true
       else
         return false
       end
    end
end