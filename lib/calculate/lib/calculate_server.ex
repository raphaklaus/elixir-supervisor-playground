defmodule SupervisorPlayground.Server do
  alias SupervisorPlayground.Calculate
  use GenServer

  # Client

  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(arg) do
    test = arg |> elem(1)
    GenServer.start_link(__MODULE__, [], name: test)
  end

  def add(pid, a, b) do
    GenServer.call(pid, {:add, a, b})
  end

  def hello() do
    GenServer.call(__MODULE__, :hello)
  end

  # Server

  def handle_call({:add, a, b} ,_from, state) do
    calculation = Calculate.sum(a, b)
    {:reply, calculation, state}
  end

  def handle_call(:hello, _from, state) do
    {:reply, "Hello!", state}
  end
end
