class WikiPolicy < ApplicationPolicy

  def show?
    user.present?
  end

  def update?
    user.present?
  end

  def edit?

    case record.private
      when false
       true if user.present?
      when true
        true if user.present? && (user.admin? || record.user == user)
      else
        false
    end
  end
end
