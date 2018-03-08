defmodule Person do
	defstruct token: ""
end

defmodule ApiTrangellWeb.PageController do
	use ApiTrangellWeb, :controller

	def sign_in(conn, %{"password" => password,}) do
		user = %{id: "1", user: "shahryar"}

		case password do
			"2" ->
				perms = %{default: [:public_profile], user_actions: [:books]}
				# {:ok, token, _claims} = ApiTrangell.Guardian.encode_and_sign(user, %{some: "claim", userid: 2, admin: 2, pem: %{default: [:public_profile], user_actions: [:books]}}, token_type: "access",ttl: {99, :weeks})
				conn = ApiTrangell.Guardian.Plug.sign_in(conn, user, %{some: "claim", admin: 12}, permissions: perms)
				# json conn, %Person{token: token}
				json conn, %Person{token: ApiTrangell.Guardian.Plug.current_token(conn)}
			_ -> 
				conn |> send_resp(204, "sss")
				json conn, %{error: "you have an error"} 

		end 
	end

	def sign_in(conn, _params) do
		send_resp(conn, 401, Poison.encode!(%{error: "Incorrect password"}))
	end

	def sign_out(conn, _params) do
		conn
		|> ApiTrangell.Guardian.Plug.sign_out()
		|> send_resp(204, "")
	end

	def verify_token(conn, %{"token" => token}) do
		case  ApiTrangell.Guardian.decode_and_verify(token) do
			{:ok, claims} ->
				json conn, %Person{token: Map.get(claims, "exp")}
			{:error, _} ->
				conn
				|> put_status(403)
				|> json(%{ error: "khata"})
		end
	end

	def refresh_token(conn, %{"token" => token}) do
		case ApiTrangell.Guardian.refresh(token) do
			{:ok, {old_token, old_claims}, {new_token, new_claims}} ->
			  json conn,  %{
					old_token: old_token, 
					old_claims: old_claims,
					new_token: new_token, 
					new_claims: new_claims
				}

			{:error, %CaseClauseError{term: {:error, {:badmatch, false}}}} ->	
				conn		  
				|> put_status(404)
				|> json(%{ error: "errorrrrrr"})
		end
	end

	def current_user(conn) do
    	Guardian.Plug.current_resource(conn)
  	end
  	
end