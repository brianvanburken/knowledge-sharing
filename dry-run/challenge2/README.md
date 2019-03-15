# Challenge 2

We got a binary file containing the key broken up by our secret informant. He
provided us with the specification to extract the key. The key is scrabbled so
we to put it back together in the correct order.

Build a function that reads the bin file, extracts the pieces of the key, and
places it in the correct order. The binary file is found in the zip file which
can only be opened with the key we decoded from our previous challenge.

## Secret specification

### Legenda

- `R` = key for random data
- `S` = key for our secret data

Parts of the binary sequence is brokend down like this: `<key>[<length of bytes>](<order>)`

### Specification

```
R[054]()
S[001](3)
R[002]()
S[001](4)
R[002]()
S[001](5)
R[030]()
S[003](6)
R[030]()
S[002](0)
R[001]()
S[001](1)
R[010]()
S[003](2)
R[102]()
```
