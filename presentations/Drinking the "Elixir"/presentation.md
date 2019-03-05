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

- 15:00 - 15:30 Presentation
- 15:30 - 17:30 Challenges
- 17:30 - 18:30 Food!
- 18:30 - 19:00 Announcing winners

---

# Elixir?

- build on top of Erlang
- inspired by Ruby
- immutable
- functional
- dynamically typed

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
iex> :hello     # atom
iex> "elixir"   # string
iex> ?A         # char
iex> <<0, 255>> # binary 
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

# Modules

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

# Pin operator

```elixir
iex> n = 1
iex> [1, ^n] = [1, 2]
** (MatchError) no match of right hand side value: [1, 2]
iex> [1, ^n] = [1, 1]
[1, 1]
```

---
[.code-highlight: 1,4]
[.code-highlight: 2]
[.code-highlight: 3]

# Responses

```elixir
iex> case File.read("path/to/file") do
iex>   {:ok, binary_contents} -> IO.puts(contents)
iex>   {:error, reason} -> IO.puts("Error: " <> reason)
iex> end
```

^ Contents is a binary string

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

```elixir
defmodule Fibonacci do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when n > 0, do: fib(n-2) + fib(n-1)  
end
```

^ Only Kernel functions allowed because of possible bugs when mutable code is used

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
      {:ok, contents} ->
        mp3_byte_size = (byte_size(contents) - 128)
        << _ :: binary-size(mp3_byte_size), id3_tag :: binary >> = contents

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
[.code-highlight: 1-5]
[.code-highlight: 5-15]

```elixir
if working?() do
  do_something()
else
  do_something_else()
end

# becomes:

case(working?()) do
  x when x in [false, nil] ->
    do_something_else()
  _ ->
    do_something()
end
```

^ "if" is an macro
^ Warning: don't use a lot of macro's. Code can become unreadable
^ here you can see that any value expect false and nil is true

---

# Quoted Expressions

```elixir
iex> quote do: 1 + 2
{:+, [context: Elixir, import: Kernel], [1, 2]}
```

^ Expressions are converted into Abstract Syntax Trees (AST) for evaluation.
^ Elixir allows you to see the structure of code using quote

---

```elixir
iex> quote do: sum(1, 2 + 3, 4)
{:sum, [], [1, {:+, [context: Elixir, import: Kernel], [2, 3]}, 4]}
```

---

# Unquoted Expressions

```elixir
iex> number = 2
iex> quote do: 1 + unquote(number)
{:+, [context: Elixir, import: Kernel], [1, 2]}
```

^ here the runtime number is taken and put in place of the unquote

---

```elixir
iex> number = 2
iex> ast = quote do: 1 + unquote(number)
iex> Macro.to_string(ast)
"1 + 2"
```

---

# Compile-time functions

"Convert a given DNA strand to its RNA complement."

![inline](rna_transcription.png)

---

| DNA | RNA |
| --- | --- |
| G | C |
| C | G |
| T | A |
| A | U |

---

```elixir
# rna.ex
defmodule RNATranscription do
  def to_rna(?G), do: ?C
  def to_rna(?C), do: ?G
  def to_rna(?T), do: ?A
  def to_rna(?A), do: ?U
end

iex> load("rna.ex")
iex> RNATranscription.to_rna(?T)
?A
```

^ But what if we add new letters or the whole spec changes?

---
[.code-highlight: all]
[.code-highlight: 3]
[.code-highlight: 4,6]
[.code-highlight: 5]
[.code-highlight: all]

```elixir
# rna.ex
defmodule RNATranscription do
  mapping = %{ ?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U }
  for { dna, rna } <- mapping do
    def to_rna(unquote(dna)), do: unquote(rna)
  end
end

iex> load("rna.ex")
iex> RNATranscription.to_rna(?T)
?A
```

^ functions are defined on compile-time
^ Note: difficult to read and to search codebase on

---

# Processes

^ Erlang Mantra: Let it crash!

---

# OTP/Processes

- Erlang virtual machine processes
- follows the actor model

---

```elixir
iex> self
#PID<0.103.0>
iex> for num <- 1..1000 do
...>   spawn(fn -> IO.puts("#{num * 2}") end)
...> end
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
iex> send(self(), "Hello!")
"Hello!"
iex> flush()
"Hello!"
:ok
```

---
[.code-highlight: 1-8]
[.code-highlight: 9-15]

```elixir
iex> pid = spawn(fn ->
...>  IO.puts "Waiting for messages"
...>  receive do
...>    msg -> IO.puts "Received: " <> msg
...>  end
...>end)
Waiting for messages
#PID<0.1134.0>

iex> send(pid, "Hello world!")
Received "Hello world!"
iex> send(pid, "Hello world!")
iex>
```

^ With start we set a default state
^ Default state is usefull for resetting when crashing
^ A process exits when it no longer has any code to execute

---
[.code-highlight: all]
[.code-highlight: 5-10]
[.code-highlight: 14]
[.code-highlight: all]

```elixir
# my_process.ex
defmodule MyProcess do
  def start, do: loop()

  def loop do
    receive do
      msg -> IO.puts "Received #{inspect msg}"
    end
    loop()
  end
end

iex> load("my_process.ex")
iex> pid = spawn(MyProcess, :start, [])
iex> send(pid, "Hello world!")
Received "Hello world!"
iex> send(pid, "Hello there!")
Received "Hello there!"
```

---

# Remote nodes

---

```bash
$ iex --name bar@10.1.0.1 --cookie secret  
```

```bash
$ iex --name foo@10.1.0.2 --cookie secret  
```

---

```elixir
iex(bar@10.1.0.1)> Node.list  
[]
iex(bar@10.1.0.1)> Node.connect :"foo@10.1.0.2"  
true
iex(bar@10.1.0.1)> Node.list  
[:"foo@10.1.0.2"]
```

---

```bash
$ iex --name bar
```

```elixir
iex(bar@10.1.0.1)> greetings = fn -> IO.puts "Hello from #{Node.self}" end  
iex(bar@10.1.0.1)> Node.spawn :"foo@10.1.0.2", greetings
#PID<9071.68.0>
Hello from foo@10.1.0.2
```

^ spawned a process on remote node, linked it, and returned the PID

---

```elixir
iex(bar@10.1.0.1)> pid = Node.spawn(:"foo@10.1.0.2", fn ->
...>   receive do
...>     {:ping, client} -> send client, :pong
...>   end
...> end)
#PID<9014.59.0>

iex(bar@10.1.0.1)> send pid, {:ping, self}
{:ping, #PID<0.73.0>}
iex(bar@10.1.0.1)> flush
:pong
:ok
```

---

# Challenges!

---

`git clone https://github.com/avisi/techday_elixir`
