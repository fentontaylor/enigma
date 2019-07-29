# Enigma
Based on the concept of the encryption device used extensively by the Germans in
World War II, known as the Enigma machine, this code used key-based encryption to
encrypt plain text into ciphertext. As long as the keys used to generate the
encryption are known, decrypting the text back into human-readable text is fairly
straight-forward.

In the following code block, the arguments to the methods `encrypt` and `decrypt`
are the message, the key, and the date key. The last two arguments are used to
calculate the final shift values. 

```
encrypted = enigma.encrypt('hello world', '31415', '290719')
encrypted[:encryption]
=> "raeaywpdahx"

decrypted = enigma.decrypt('raeaywpdahx', '31415', '290719')
decrypted[:decryption]
=> 'hello world'
```
