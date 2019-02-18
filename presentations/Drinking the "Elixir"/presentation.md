slidenumbers: true
theme: Sketchnote,1


# Welcome!

If you haven't installed Elixir, follow the instructions on:

https://elixir-lang.org/install.html

---

![original 100%](elixir-logo.png)

# Drinking the Elixir

---

# Agenda

- 15:30 Presentation
- ??:?? Challenges
- ??:?? Food
- ??:?? Announcing winner(s)

---

# Elixir?

- Language build on top of Erlang
- Compiles down to BEAM code
- Heavily inspired by Ruby
- Designed by Jose Valim
- Financed by Plataformatec

^ Elixir is build because Jose was unable to make Ruby concurrent

---

# Syntax

^ Tell that all code in the slides can be executed using the REPL called IEx (interactive elixir)

---

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

^ Make extra note of atoms and binary string
^ Warning: atoms are not garbage collected (DDOS if created from user input)

---

```elixir
iex> 1 + 2
3
iex> Kernel.+(1, 2)
3
iex> "Hello " <> "there!"
"Hello World!"
iex> is_binary("hellö")
true
iex> String.length("hellö")
5
iex> String.upcase("hellö")
"HELLÖ"
```

^ Make note of <> being a Kernel function

---

# Pipes!

```elixir
iex> "2" |> String.to_integer() |> Kernel.*(2)
4
```

^ Value is put as first parameter (not last like other FP languages)

---

# Functions

```elixir
iex> greet = fn x -> "Hello #{x}!" end
#Function<6.128620087/1 in :erl_eval.expr/5>
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

^ Same-name functions are defined by their arity hello/0 and hello/1

---

```elixir
iex> nested = [ [0], [1], [2] ]
iex> Enum.map(nested, &Kernel.hd/1)
[0, 1, 2]
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

^ Only Kernel functions allowed because of possible bugs when mutable code is used

---

# Pattern matching

---

# Destructuring

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

# Responses

```elixir
iex> case File.read("path/to/file") do
iex>   {:ok, contents} -> IO.puts("found file: #{contents}")
iex>   {:error, reason} -> IO.puts("missing file: #{reason}")
iex> end
```

^ Contents is a binary string

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

^ This is ID3v1

---

# Meta-programming

---

Most of Elixir is written in Elixir!

![inline](elixir-github.png)

^ Most of the language consists of macro's
^ Easier for people to read source-code to see what function does and to contribute

---
[.code-highlight: 1-3]
[.code-highlight: 4-10]

```elixir
if true do
  true
else
  false
end

# becomes:

case(true) do
  x when x in [false, nil] ->
    false
  _ ->
    true
end
```

^ "if" is an macro
^ Warning: don't use a lot of macro's. Code can become unreadable
^ here you can see that any value expect false and nil is true

---

# Quoted Expressions

```elixir
ast_of_expression = quote do
  1 + 2
end

IO.inspect(ast_of_expression)
# {:+, [context: Elixir, import: Kernel], [1, 2]}
```

^ Expressions are converted into Abstract Syntax Trees (AST) for evaluation.
^ Elixir allows you to see the structure of code using quote

---

```elixir
{:+, [context: Elixir, import: Kernel], [1, 2]}
```

name function, metadata, arguments

---

# Unquoted Expressions

```elixir
number = 2
ast_of_expression = quote do
  1 + unquote(number)
end

IO.inspect(ast_of_expression)
# {:+, [context: Elixir, import: Kernel], [1, 2]}
```

^ here the runtime number is taken and put in place of the unquote

---
[.code-highlight: 1-2,8]
[.code-highlight: 3,7]
[.code-highlight: 4,6]
[.code-highlight: 5]

[.code-highlight: 8-15]


# Compile-time functions

```elixir
# my_module.ex
defmodule MyModule do
  Enum.each [foo: 1, bar: 2, baz: 3], fn { k, v } ->
    def unquote(k)(arg) do
      unquote(v) + arg
    end
  end
end

iex> MyModule.foo(1)
2
iex> MyModule.bar(1)
3
iex> MyModule.baz(2)
4
```

^ here are three functions defined on runtime
^ there is a lot more like walking and modifing the AST

---

# OTP

Open Telecom Platform
- 

---

# OTP/Processes

- Erlang virtual machine (BEAM) processes
- lighter than OS processes
- follows the actor model

---

```elixir
iex> self
#PID<0.103.0>
iex> for num <- 1..1000, do: spawn fn -> IO.puts("#{num * 2}") end
2
4
6
8
10
12
...
```

^ Order is not guarenteed
^ Each porcess has it's own mailbox
^ Imagine each process like a mobile phone sending SMSs to eachother
^ Fault tolerance, more about that later

---

```elixir
defmodule MyProcess do
  def start, do: accepting_messages(0)

  def accepting_messages(state) do
    receive do
      {:counter} ->
        new_state = state + 1
        IO.puts "New state is #{new_state}"
        accepting_messages(new_state)
      _ ->
        accepting_messages(state)
    end
  end
end
```

^ With start we set a default state
^ Default state is usefull for resetting when crashing

---

```elixir
iex> pid = spawn fn -> MyProcess.start end
#PID<0.87.0>
iex> send pid, {:counter}
New state is 1
iex> send pid, {:counter}
New state is 2
```

---
[.code-highlight: 1-2]
[.code-highlight: 3-4]
[.code-highlight: 5-6]
[.code-highlight: 7-8]

# Agents

Agent is simple wrapper around state.

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

^ Make note of PID

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

Task are async units of computation.

```elixir
iex> task = Task.async fn -> perform_complex_action() end
iex> other_time_consuming_action()
iex> Task.await task
```
---

# GenServer

GenServer are processes that encapsulate state, provide (a)sync calls and support code reload.
(http://blog.plataformatec.com.br/2018/04/elixir-processes-and-this-thing-called-otp/)

^ Example of supervisor with process pool: Connections to the database

---


# Noteworthy

- Erlang interop. Can use Erlang packages!
- Hot-code reloading on deploy

---

# Recommended material

- Book Programming Elixir 1.6 by Jose Valim
- Book Metaprogramming Elixir by Chris McCord & Jose Valim

^ Can recommend books based on path you want to take. Web or service.
