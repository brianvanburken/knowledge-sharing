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
iex> :hello     # atom
iex> "elixir"   # string
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
# Compile-time functions

Write a program that, given a DNA strand, returns its RNA complement (per RNA transcription).

---

The four nucleotides found in DNA are adenine (A), cytosine (C), guanine (G) and thymine (T).

The four nucleotides found in RNA are adenine (A), cytosine (C), guanine (G) and uracil (U).

---

Given a DNA strand, its transcribed RNA strand is formed by replacing each nucleotide with its complement:

G -> C
C -> G
T -> A
A -> U

---

```elixir
# rna.ex
defmodule RNATranscription do
  def to_rna('G'), do: 'C'
  def to_rna('C'), do: 'G'
  def to_rna('T'), do: 'A'
  def to_rna('A'), do: 'U'
end

iex> load("rna.ex")
iex> RNATranscription.to_rna('T')
'A'
```

^ But what if we add new letters or the whole spec changes?

---
[.code-highlight: all]
[.code-highlight: 3,7]
[.code-highlight: 4,6]
[.code-highlight: 5]
[.code-highlight: all]

```elixir
# rna.ex
defmodule RNATranscription do
  for { dna, rna } <- %{ ?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U } do
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

- Erlang virtual machine (BEAM) processes
- lighter than OS processes
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
[.code-highlight: 1-8]
[.code-highlight: 9-13]

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

# Agents, tasks and OTP
---

# GenServer

GenServer are processes that encapsulate state, provide (a)sync calls and support code reload.

^ Example: connection-pool to the database
^ Example: polling external resource

---

# Example application

---

# Recommended material

- Book Programming Elixir 1.6 by Jose Valim
- Book Metaprogramming Elixir by Chris McCord & Jose Valim

^ Can recommend books based on path you want to take. Web or service.

---

# Challenges!

TODO: create repo with challenges

---

# Mix

New project: `mix new <name>`
Start project using iex: `iex -S mix`
