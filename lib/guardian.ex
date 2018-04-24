defmodule Blog.Guardian do
  @moduledoc false
  use Guardian, otp_app: :blog

  alias Blog.Accounts

#  def subject_for_token(user, _claims) do
#    sub = to_string(user.id)
#    {:ok, sub}
#  end

#  def subject_for_token(_, _) do
#    {:error, :reason_for_error}
#  end

#  def resource_from_claims(claims) do
#    id = claims["sub"]
#    resource = MyApi.Accounts.get_user!(id)
#    {:ok,  resource}
#  end

#  def resource_from_claims(_claims) do
#    {:error, :reason_for_error}
#  end

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = Accounts.get_user!(id)
    {:ok, user}
  end
end