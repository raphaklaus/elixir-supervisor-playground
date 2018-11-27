defmodule SupervisorPlayground do
  use Application
  alias SupervisorPlayground.Supervisor
  alias SupervisorPlayground.Server

  def start(_type, _args) do
    # IO.puts('wow')
    # IO.puts(type)
    # IO.puts(args)
    Supervisor.start_link([
      {Server, :start_link, name: MyServerOne},
      {Server, :start_link, name: MyServerTwo}
    ])
  end
end
