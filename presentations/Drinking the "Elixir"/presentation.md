slidenumbers: true
theme: Sketchnote,1


# Drinking the Elixir

---

# TODO

- What is Elixir
- Syntax
- Sigils
- Functions
- HOF/Currying
- Pipes!
- Protocols
- Enumerables and Streams
- Pattern matching
  - byte level
  - same head
  - with
  - pin operator
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
- Testing
  - Doctests
  - Fuzzy testing
- Erlang interop


NOTES:
- In `iex` a list of digits can be presented as characters: [87, 97, 116, 63, 33] => 'Wat?!'
  You could see its raw value using `i` in front


---

# What is Elixir?

- Language build on top of Erlang
- Compiles down to BEAM code
- Designed by Jose Valim (when wanting to make Ruby more concurrent)
- Heavily inspired by Ruby

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

# Sigils

```elixir
iex> ~s(this is a string with "double" quotes, not 'single' ones)
"this is a string with \"double\" quotes, not 'single' ones"
iex> ~w(foo bar bat)
["foo", "bar", "bat"]
iex> ~w(foo bar bat)a
[:foo, :bar, :bat]
````

---

# Sigil delimiters

```elixir
~r/hello/
~r|hello|
~r"hello"
~r'hello'
~r(hello)
~r[hello]
~r{hello}
~r<hello>
```

---

# Functions

```elixir
iex> def greet(thing), do: "Hello " <> thing <> "!"
iex> greet("there")
"Hello there!"
iex> greet = fn x -> "Hello " <> x <> "!" end
iex> greet("there")
"Hello there!"
```
---

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
iex> Greeting.hello/0
iex> Greeting.hello/1
```

---

# Pipes!

```elixir
something()
|> otherthing()
```

---

# Pattern matching

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

        IO.puts title
        IO.puts artist 
        IO.puts album 
        IO.puts year 
        IO.puts comment 

      _ -> 
        IO.puts "Couldn't open #{file_name}"
    end
  end

end

ID3Parser.parse("sample.mp3")
```

---

# OTP

- Agent (simple wrapper around state)
- GenServer (processes that encapsulate state, provide (a)sync calls and support code reload)
- Task (async units of computation)

---

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

# GenServer
(http://blog.plataformatec.com.br/2018/04/elixir-processes-and-this-thing-called-otp/)

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

# Testing

- test processes
- test documentation

---

# Erlang interop

- note: binary should be a charlist
- can call erlang packages
