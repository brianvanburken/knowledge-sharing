# Challenge 2

Our secret informant was not satisfied with the secret emoji language. So he
decided to throw off the government hackers and create a corrupt ZIP file.
Security by obscurity! Nice!

But, we still need the data.. Luckily for us, the informant sends the specification
to repair with the ZIP file. The parts are in the correct order and only some
random data inserted in the file. So we need to clean the garbage out. After
cleaning we should open the ZIP file with the key we got from our previous challenge.

## Repair specification

### Legenda
- `R` = random data
- `Z` = our zip data

The file is broken down like this: `<key>[<length of bytes>]`

### Specification

```
Z[4]R[5]Z[36]R[56]Z[5]R[16]Z[4]R[1]Z[20]R[43]Z[40]R[3]Z[34]R[13]Z[50]R[105]
```
