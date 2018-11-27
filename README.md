# SupervisorPlayground

Some learning to to play on the iex.

## Start the "hand-made" Supervisor
```elixir
{:ok, pid} = SupervisorPlayground.Supervisor.start_link([{SupervisorPlayground.Server, :start_link, []}, {SupervisorPlayground.Server, :start_link, []}])
```

## Get a PID
```elixir
last_pid = SupervisorPlayground.Supervisor.list_processes(pid) |> Map.keys |> List.last
```

## Run a Client function

```elixir
SupervisorPlayground.Server.add(last_pid, 2,2)
```

## Let it crash

```elixir
SupervisorPlayground.Server.add(last_pid, 2,"2")
```

Watch a new process born. :)
