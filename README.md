# EmojiCrypt
**A simple module to encrypt text with emojis.**
# Documentation
### Encrypt
**Encrypts the message into emojis**
```html
<string> EmojiCrypt.Encrypt(<string> Message, <string> Key)
```
### Decrypt
**Decrypts encrypted emoji messages**
```html
<string> EmojiCrypt.Decrypt(<string> Message, <string> Key)
```
# Example
```lua
local Key = "secret"

local Hello = "Hello, World!"
local Encrypted =  EmojiCrypt.Encrypt(Hello, Key)
local Decrypted = EmojiCrypt.Decrypt(Encrypted, Key)

print("Original:", Hello) --> Hello, World!
print("Key:", Key) --> secret
print("Encrypted:", Encrypted) --> 🤤🤣🤔🙃🤗💩😲🤧🤫😜🤪😜😯
print("Decrypted:", Decrypted) --> Hello, World!
print("Decrypted with 'password' as key:", EmojiCrypt.Decrypt(Encrypted, "password")) --> Lum~t-!D|dk`+
```
