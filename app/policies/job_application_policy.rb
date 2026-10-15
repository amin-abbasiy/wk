class JobApplicationPolicy < ApplicationPolicy
  def show?
    user.present? && (record.user == user || record.job.user == user)
  end

  def create?
    user.present? && record.job.user != user
  end

  def update?
    user.present? && (record.user == user || record.job.user == user)
  end

  def destroy?
    user.present? && (record.user == user || record.job.user == user)
  end
end