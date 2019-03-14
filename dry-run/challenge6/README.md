# Challenge 6

Everything is comming together. Our informant added his secret emoji language and
now requires you to send the key to his server encoded in his secret language. Now
you need to get his final message from the server. To do this you first need to
fetch the key with a length of `7` and send a specialized message to the server.

The final message need to be a tuple with its first value the cookie used, then
the key of a length of 7, and your process ID.

You can find his slow server at `challenge6@10.31.161` and the function `Challenge6.secret`.
