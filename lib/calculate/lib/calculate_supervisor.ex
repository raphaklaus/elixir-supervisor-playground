defmodule SupervisorPlayground.Supervisor do
  use GenServer

  def start_link(children) do
    GenServer.start_link(__MODULE__, children, name: __MODULE__)
  end

  def init(children) do
    Process.flag(:trap_exit, true)
    state = children
    |> Enum.map(&start_child/1)
    |> Enum.into(%{})

    {:ok, state}
  end

  def list_processes(pid) do
    GenServer.call(pid, :list)
  end

  #Server

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:EXIT, dead_pid, _reason}, state) do
    IO.inspect('Reviving dead process...')

    # Start new process
    {new_pid, child_spec} = state
    |> Map.get(dead_pid)
    |> start_child()

    # Remove dead_pid and insert new_pid with its spec
    new_state = state
    |> Map.delete(dead_pid)
    |> Map.put(new_pid, child_spec)

    {:noreply, new_state}
  end

  # Helper Functions

  @spec start_child({atom() | tuple(), atom(), [any()]}) ::
          {any(), {atom() | tuple(), atom(), [any()]}}
  def start_child({module, function, args} = child) do
    {:ok, pid} = apply(module, function, args)
    Process.link(pid)
    {pid, child}
  end
end
