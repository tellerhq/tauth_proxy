defmodule TAuthProxy.ProxyServer do
  use Plug.Router
  import Plug.Conn

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  @www "https://teller.io"
  @api "https://api.teller.io"

  match "/api/*path" do
    dir = Application.app_dir(:tauth_proxy)

    {:ok, client} =
      :hackney.request(method(conn), uri(conn), conn.req_headers, :stream, [
        ssl_options: [
          certfile: :filename.absname("priv/certificate.pem", dir),
          keyfile:  :filename.absname("priv/private_key.pem", dir)
        ]
      ])

    conn
    |> write(client)
    |> read(client)
  end

  defp write(conn, client) do
    case read_body(conn, []) do
      {:ok, body, conn} ->
        :hackney.send_body(client, body)
        conn
      {:more, body, conn} ->
        :hackney.send_body(client, body)
        write(conn, client)
    end
  end

  defp read(conn, client) do
    {:ok, status, headers, client} = :hackney.start_response(client)
    {:ok, body} = :hackney.body(client)

    headers = List.keydelete(headers, "Transfer-Encoding", 0)

    send_resp(%{conn | resp_headers: headers}, status, body)
  end

  defp method(%{method: "GET"}),    do: :get
  defp method(%{method: "POST"}),   do: :post
  defp method(%{method: "PUT"}),    do: :put
  defp method(%{method: "PATCH"}),  do: :patch
  defp method(%{method: "DELETE"}), do: :delete

  defp uri(conn) do
    ["api" | path_info] = conn.path_info
    @api <> "/" <> Enum.join(path_info, "/")
  end
end

