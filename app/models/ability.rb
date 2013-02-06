class Ability
  include CanCan::Ability
  
  def initialize(user)
    return if user.blank?
    can :read, user, :id => user.id
    can :update, user, :id => user.id
  end
end
