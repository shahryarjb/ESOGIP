defmodule Person do
	defstruct token: ""
end

defmodule ApiTrangellWeb.PageController do
	use ApiTrangellWeb, :controller

	def sign_in(conn, %{"password" => password,}) do
		user = %{id: "1"}

		case password do
			2 ->
				{:ok, token, _claims} = ApiTrangell.Guardian.encode_and_sign(user)
				json conn, %Person{token: token}
				_ -> IO.puts "nabashe"  

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

	def show(conn, %{"token" => token}) do
		# user = ApiTrangell.Guardian.Plug.current_resource(conn)

		# send_resp(conn, 200, Poison.encode!(%{user: user}))

		{:ok, _claims} = ApiTrangell.Guardian.decode_and_verify(token)
		# IO.puts claims
		json conn, %Person{token: "token"}
	end

	def kab(conn, %{"token" => token}) do
		case ApiTrangell.Guardian.decode_and_verify(token) do
		  {:ok,_claims} -> 
		  	# IO.puts claims
		  	json conn, %Person{token: "verify"}

		  {:error, _any} -> conn
		  	|> put_status(403)
		  	|> json(%{ error: "unauthorized"})
		end
	end
end