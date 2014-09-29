class TestPolicy < ApplicationPolicy

  def rails_admin?(action)
    case action
      when :destroy, :new
        false
      else
        super
    end
  end
end