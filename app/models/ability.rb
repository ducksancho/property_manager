class Ability
  include CanCan::Ability
  
  def initialize(user)
    return if user.blank?
    can :update, user, :id => user.id
  end
end
