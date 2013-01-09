class Ability
  include CanCan::Ability

  def initialize(user)
    can :update, user, :id => user.id
  end
end
