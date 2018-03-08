defmodule ApiTrangellWeb.PageControllerTest do
  use ApiTrangellWeb.ConnCase
  import ApiTrangell.Guardian

	test "Test true Post metude for giving token" do
	  	jsons = Poison.encode!(%{"password" => "2"}) 
	  	a =  HTTPoison.post!(
	  		"http://localhost:4001/api/users/sign-out",
	  		jsons, 
	  		[
	  			{"Content-Type", "application/json"},
	  			{"authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbiI6MiwiYXVkIjoiYXBpX3RyYW5nZWxsIiwiZXhwIjoxNTgwMTIzMjEwLCJpYXQiOjE1MjAyNDgwMTAsImlzcyI6ImFwaV90cmFuZ2VsbCIsImp0aSI6ImVhMzQ2ZTUzLTk4NzMtNDZjNy05ZmJlLTJmNmJiZjNlMTU3MSIsIm5iZiI6MTUyMDI0ODAwOSwicGVtIjp7ImRlZmF1bHQiOlsicHVibGljX3Byb2ZpbGUiXSwidXNlcl9hY3Rpb25zIjpbImJvb2tzIl19LCJzb21lIjoiY2xhaW0iLCJzdWIiOiIxIiwidHlwIjoiYWNjZXNzIiwidXNlcmlkIjoyfQ.3ORzK7mTqhEs9knE9N0fE-bwiZSTsH2mErYo_hnf19w"}
	  		])
	  	# .body |> Poison.decode
	    assert a.status_code == 204
	end


	test "To test to get token" do
		conn = post build_conn(), "/api/users/sign-in", [password: "2"]
		assert conn.status == 200
	end

	test "header router" do
		conn = build_conn()
			|> put_req_header("accept", "application/json")
			|> post("/api/users/sign-in", [password: "2"])
		assert conn.status == 200
	end

	test "header of router of log out" do
		biuld_token = build_conn()
			|> put_req_header("accept", "application/json")
			|> post("/api/users/sign-in", [password: "2"])
		jsons = Poison.decode!(biuld_token.resp_body) 
		
		tests = build_conn()
			|> put_req_header("accept", "application/json")
      		|> put_req_header("authorization","Bearer " <> jsons["token"])
      		|> post("/api/users/sign-out")
      		# IO.inspect tests
		assert tests.status == 204
	end 

	test "eroor" do
		response = assert_error_sent :not_found, fn ->
  			get build_conn(), "/api/users/sign-out"
		end
		assert {404, [_h | _t], "Page not found"} = response
	end
end
