defmodule FindMyPersonalWeb.MemberControllerTest do
  @moduledoc """
  MemberControllerTest module
  """
  use FindMyPersonalWeb.ConnCase

  alias FindMyPersonal.Members

  @create_attrs %{
    birth_date: ~D[2010-04-17],
    blood: "some blood",
    email: "some email",
    height: 42,
    name: "some name",
    weight: 42
  }
  @update_attrs %{
    birth_date: ~D[2011-05-18],
    blood: "some updated blood",
    email: "some updated email",
    height: 43,
    name: "some updated name",
    weight: 43
  }
  @invalid_attrs %{birth_date: nil, blood: nil, email: nil, height: nil, name: nil, weight: nil}

  def fixture(:member) do
    {:ok, member} = Members.create_member(@create_attrs)
    member
  end

  describe "index" do
    test "lists all members", %{conn: conn} do
      conn = get(conn, Routes.member_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Members"
    end
  end

  describe "new member" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.member_path(conn, :new))
      assert html_response(conn, 200) =~ "New Member"
    end
  end

  describe "create member" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.member_path(conn, :create), member: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.member_path(conn, :show, id)

      conn = get(conn, Routes.member_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Member"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.member_path(conn, :create), member: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Member"
    end
  end

  describe "edit member" do
    setup [:create_member]

    test "renders form for editing chosen member", %{conn: conn, member: member} do
      conn = get(conn, Routes.member_path(conn, :edit, member))
      assert html_response(conn, 200) =~ "Edit Member"
    end
  end

  describe "update member" do
    setup [:create_member]

    test "redirects when data is valid", %{conn: conn, member: member} do
      conn = put(conn, Routes.member_path(conn, :update, member), member: @update_attrs)
      assert redirected_to(conn) == Routes.member_path(conn, :show, member)

      conn = get(conn, Routes.member_path(conn, :show, member))
      assert html_response(conn, 200) =~ "some updated blood"
    end

    test "renders errors when data is invalid", %{conn: conn, member: member} do
      conn = put(conn, Routes.member_path(conn, :update, member), member: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Member"
    end
  end

  describe "delete member" do
    setup [:create_member]

    test "deletes chosen member", %{conn: conn, member: member} do
      conn = delete(conn, Routes.member_path(conn, :delete, member))
      assert redirected_to(conn) == Routes.member_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.member_path(conn, :show, member))
      end
    end
  end

  defp create_member(_) do
    member = fixture(:member)
    %{member: member}
  end
end
