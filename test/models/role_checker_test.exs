defmodule RoleCheckerTest do
  use Pxblog.ModelCase

  alias Pxblog.Factory
  alias Pxblog.RoleChecker

  test "is_admin? is true when user has an admin role" do
    role = Factory.create(:role, admin: true)
    user = Factory.create(:user, role: role)
    assert RoleChecker.is_admin?(user)
  end

  test "is_admin? is false when user has not an admin role" do
    role = Factory.create(:role, admin: false)
    user = Factory.create(:user, role: role)
    refute RoleChecker.is_admin?(user)
  end
end
