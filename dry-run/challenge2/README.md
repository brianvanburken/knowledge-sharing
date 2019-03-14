# Challenge 2

We got a binary file containing the key broken up by our secret informant. He
provided us with the specification to extract the key. The key is put at random
so we also have to place in the correct order. Build a function that reads the
file, extracts the pieces of the key, and places it in the correct order. The
binary files is placed in a password protected zip which can only be opened with
the key we decoded from our secret emoji language.

## Secret specification

### Legenda
R = key for random data
S = key for our secret data

<key>[<length of bytes>](<name>)

### Specification

```
R[54]S[1](a)R[2]S[1](b)R[2]S[1](c)R[30]S[3](d)R[30]S[2](e)R[1]S[1](f)R[10]S[2](g)R[102]
```

### Order

```elixir
e <> f <> g <> "-"  <> a <> c <> b <> d
```
