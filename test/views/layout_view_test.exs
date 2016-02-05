defmodule Pxblog.LayoutViewTest do
  use Pxblog.ConnCase

  alias Pxblog.LayoutView
  alias Pxblog.User
  alias Pxblog.Factory

  setup do
    role = Factory.create(:role)
    user = Factory.create(:user, role: role)
    conn = conn()
    {:ok, conn: conn, user: user}
  end

  test "current user returns the user in the session", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create), user: %{username: user.username, password: user.password}

    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn, user: user} do
    conn = delete conn, session_path(conn, :delete, user)

    refute LayoutView.current_user(conn)
  end

  test "deletes the user session", %{conn: conn, user: user} do
    user = Repo.get_by(User, %{username: user.username})
    conn = delete conn, session_path(conn, :delete, user)

    refute get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Signed out successfully!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
