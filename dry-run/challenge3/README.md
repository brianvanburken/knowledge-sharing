# Challenge 3

Our secret informant didn't trusted the binary format so he decided to throw off
the goverment hackers and create a corrupt zipfile that needs to be fixed in order
to be unpacked. He send the instructions to us using our emoji language which we
decoded and placed below. He told us the parts are in the correct order. The zip is password protected with the key we got from our binary
extraction in the previous challenge.

## To repair

### Legenda
R = random data
Z = our zip data

<key>[<length of bytes>]

### Specification

```
Z[4]R[5]Z[36]R[56]Z[5]R[16]Z[4]R[1]Z[20]R[43]Z[40]R[3]Z[34]R[13]Z[70]R[105]
```
