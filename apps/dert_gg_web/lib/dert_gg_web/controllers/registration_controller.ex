defmodule DertGGWeb.RegistrationController do
  use DertGGWeb, :controller

  alias DertGG.Accounts
  alias DertGGWeb.Authentication

  def new(conn, _) do
    if Authentication.get_current_account(conn) do
      redirect(conn, to: Routes.page_path(conn, :index))
    else
      render(conn, :new,
        changeset: Accounts.change_account(),
        action: Routes.registration_path(conn, :create)
      )
    end
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.register(account_params) do
      {:ok, account} ->
        conn
        |> Authentication.log_in(account)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end