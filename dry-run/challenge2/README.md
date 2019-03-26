# Challenge 2

Our secret informant was not satisfied with the secret emoji language. He wanted
to try something else. He sent us a binary file in which our secret key is hidden.
He broken the key in parts and scrambled the order. We need to extract the pieces
and put it back together in the correct order. He was able to sent us the specification
which we already decoded. Below you can read the specification. The binary file
is sent to us in a ZIP file which is password protected. We can open it using the
secret key we got from the previous correspondence.

## Secret specification

### Legenda

- `R` = key for random data
- `S` = key for our secret data

Parts of the binary sequence is brokend down like this: `<key>[<length of bytes>](<order>)`

### Specification

```
R[054]()S[001](3)R[002]()S[001](4)R[002]()S[001](5)R[030]()S[003](6)R[030]()S[002](0)R[001]()S[001](1)R[010]()S[003](2)R[102]()
```
