# Challenge 3

Our secret informant changed his mind about security by obscurity. So he/she
wanted to try something else. The informant sent us a binary file and hid our
secret key inside. The key is broken up in parts and scrambled the order. We
need to extract the pieces and put them back together in the correct order. The
informant was able to send us the specification which we already decoded. Below
you can read the specification.

The binary file is stored in a ZIP file which is password protected. We can open
it using the secret key we got from the previous correspondence.

## Secret specification

### Legenda

- `R` = key for random data
- `S` = key for our secret data

Parts of the binary sequence is brokend down like this: `<key>[<length of bytes>](<order in secret key>)`

### Specification

```
R[054]()S[007](3)R[002]()S[004](4)R[002]()S[004](6)R[030]()S[002](5)R[030]()S[005](0)R[001]()S[001](1)R[010]()S[003](2)R[102]()
```
