slidenumbers: true
theme: Sketchnote,1

---
# TODO

- What is Elixir
- Syntax
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
- Hot code reloading
- Testing
  - Doctests
  - Fuzzy testing
- Challenge! Morse

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
iex> :atom      # atom / symbol
iex> "elixir"   # string
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

iex> load(...)
iex> Greeting.hello/0
iex> Greeting.hello/1
```

---
