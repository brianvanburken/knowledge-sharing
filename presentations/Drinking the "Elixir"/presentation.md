slidenumbers: true
theme: Sketchnote,1


# Drinking the Elixir

---

# Outline

- What is Elixir
- Syntax
- Sigils
- Functions
- Pipes!
- Pattern matching
  - same head
  - byte level
  - guards
- Meta-programming
    - Macros
    - Compile-time function definition
        - Quote/Unquote
    - DSL's
- OTP
    - Let it crash
    - Actor-model
    - Hot code reloading?
- Erlang interop

---

# What is Elixir?

- Language build on top of Erlang
- Compiles down to BEAM code
- Heavily inspired by Ruby
- Designed by Jose Valim
- Financed by Plataformatec

---

# Syntax

```elixir
iex> 1          # integer
iex> 0x1F       # integer
iex> 1.0        # float
iex> true       # boolean
iex> :atom      # atom | symbol
iex> "elixir"   # binary | string
iex> [1, 2, 3]  # list
iex> {1, 2, 3}  # tuple
```

---

# Syntax

```elixir
iex> "Hello " <> "there!"
"Hello World!"
iex> is_binary("hellö")
true
iex> String.length("hellö")
5
iex> String.upcase("hellö")
"HELLÖ"
```

---

# Pipes!

```elixir
iex> "2" |> String.to_integer() |> Kernel.*(2)
4
```

---

# Functions

```elixir
iex> greet = fn x -> "Hello " <> x <> "!" end
iex> greet.("there")
"Hello there!"
```

---
[.code-highlight: 1-7]
[.code-highlight: 8-12]

# Arity

```elixir
# greeting.ex
defmodule Greeting do
  def hello(), do: hello("World")
  def hello(thing) do
    "Hello " <> thing <> "!"
  end
end

iex> load("greeting.ex")
iex> Greeting.hello()
"Hello World!"
iex> Greeting.hello("there")
"Hello there!"
```

---


```elixir
defmodule Fibonacci do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-2) + fib(n-1)  
end
```

---
[.code-highlight: 4]

# Guards

```elixir
defmodule Fibonacci do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when n > 0, do: fib(n-2) + fib(n-1)  
end
```

---

# Pattern matching

```elixir
iex> [1, a] = [1, 2]
iex> a
2
iex> {:ok, [hello: a]} = {:ok, [hello: "world"]}
iex> a
"world"
```

---
[.code-highlight: 1,4]
[.code-highlight: 2]
[.code-highlight: 3]

# Pattern matching

```elixir
iex> case File.read("path/to/file") do
iex>   {:ok, contents} -> IO.puts("found file: #{contents}")
iex>   {:error, reason} -> IO.puts("missing file: #{reason}")
iex> end
```

---
[.code-highlight: 1-2,19-20]
[.code-highlight: 3-4,15-18]
[.code-highlight: 5]
[.code-highlight: 6]
[.code-highlight: 7-14]
[.code-highlight: all]

```elixir
defmodule ID3Parser do
  def parse(file_name) do
    case File.read(file_name) do
      {:ok, binary} ->
        mp3_byte_size = (byte_size(binary) - 128)
        << _ :: binary-size(mp3_byte_size), id3_tag :: binary >> = binary

        << "TAG",
            title   :: binary-size(30), 
            artist  :: binary-size(30), 
            album   :: binary-size(30), 
            year    :: binary-size(4), 
            comment :: binary-size(30), 
            _rest   :: binary >> = id3_tag

      _ -> 
        IO.puts "Couldn't open #{file_name}"
    end
  end
end
```

---

# OTP

- Agent (simple wrapper around state)
- GenServer (processes that encapsulate state, provide (a)sync calls and support code reload)
- Task (async units of computation)

---

# Processes

```elixir
iex> for num <- 1..1000, do: spawn fn -> IO.puts("#{num * 2}") end
```

---
[.code-highlight: 1-2]
[.code-highlight: 3-4]
[.code-highlight: 5-6]
[.code-highlight: 7-8]

# Agents

```elixir
iex> {:ok, agent} = Agent.start_link fn -> [] end
{:ok, #PID<0.57.0>}
iex> Agent.update(agent, fn list -> ["eggs" | list] end)
:ok
iex> Agent.get(agent, fn list -> list end)
["eggs"]
iex> Agent.stop(agent)
:ok
```

---

# ETS

ETS is an in-memory table which is very fast and allows to store any ELixir term.

```elixir
iex> table = :ets.new(:buckets_registry, [:set, :protected])
#Reference<0.1885502827.460455937.234656>
iex> :ets.insert(table, {"foo", self()})
true
iex> :ets.lookup(table, "foo")
[{"foo", #PID<0.41.0>}]
```

---

# Named ETS

ETS table can also be named

```elixir
iex> :ets.new(:buckets_registry, [:named_table])
:buckets_registry
iex> :ets.insert(:buckets_registry, {"foo", self()})
```

---

# Tasks

```elixir
iex> task = Task.async fn -> perform_complex_action() end
iex> other_time_consuming_action()
iex> Task.await task
```
---

# GenServer
(http://blog.plataformatec.com.br/2018/04/elixir-processes-and-this-thing-called-otp/)

---


# Noteworthy

- Erlang interop. Can use Erlang packages!
- Hot-code reloading on deploy
