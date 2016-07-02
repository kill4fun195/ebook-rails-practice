class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      end

      if user.has_role? :member
        can :read, :all
        can :create, Article
        can :edit, Article
        can :update, Article
        can :destroy, Article
        can :create, Comment
        can :edit, Comment
        can :update, Comment
        can :destroy, Comment
        cannot :read, Category
        cannot :read, User
      end

      if user.has_role? :comment_manager
        can :read, :all
        can :update, Comment
        cannot :edit, Comment
        cannot :read, Article
        cannot :read, Category
        cannot :read, User
      end

      if user.has_role? :editor
        can :read , :all
        can :edit, Article
        can :update, Article
        cannot :destroy, Article
        cannot :read, Comment
        cannot :read, Category
        cannot :read, User
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
