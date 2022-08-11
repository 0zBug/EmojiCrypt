
local EmojiCrypt = {}

local Encode = {}
local Decode = {}

local Emojis = {     
    0x600, 0x603, 0x604, 0x601, 0x606, 0x605, 0x923, 0x602, 
    0x642, 0x643, 0x609, 0x60A, 0x607, 0x970, 0x60D, 0x929, 
    0x618, 0x617, 0x510, 0x61A, 0x619, 0x60B, 0x61B, 0x61C, 
    0x92A, 0x61D, 0x911, 0x917, 0x92D, 0x92B, 0x914, 0x910, 
    0x928, 0x610, 0x611, 0x636, 0x60F, 0x612, 0x644, 0x62C, 
    0x62E, 0x925, 0x60C, 0x614, 0x62A, 0x924, 0x634, 0x637, 
    0x912, 0x915, 0x922, 0x92E, 0x927, 0x975, 0x976, 0x974, 
    0x635, 0x92F, 0x920, 0x973, 0x60E, 0x913, 0x9D0, 0x615, 
    0x61F, 0x641, 0x41B, 0x62E, 0x62F, 0x632, 0x633, 0x97A, 
    0x626, 0x627, 0x628, 0x630, 0x625, 0x622, 0x62D, 0x631, 
    0x616, 0x623, 0x61E, 0x613, 0x629, 0x62B, 0x971, 0x624, 
    0x621, 0x620, 0x92C, 0x608, 0x47F, 0x480, 0x44F, 0x4A9, 
    0x921, 0x479, 0x47A, 0x47B, 0x47D, 0x47E, 0x916, 0x63A, 
    0x638, 0x639, 0x63B, 0x63C, 0x63D, 0x640, 0x63F, 0x63E, 
    0x44B, 0x91A, 0x590, 0x513, 0x596, 0x44C, 0x44D, 0x44E, 
    0x64F, 0x440, 0x5E3, 0x431, 0x68E, 0x525, 0x5DD, 0x511
}

for Byte = 0, 255 do
    local Emoji = utf8.char(Emojis[Byte % 128 + 1] + 0x1F000) .. (Byte > 127 and utf8.char(0x512) or "")

    Decode[Emoji] = Byte
    Encode[Byte] = Emoji
end

function EmojiCrypt.Encrypt(Normal, Key)
    local Encrypted = {}

    local Normal = {string.byte(Normal, 1, -1)}
    local Key = {string.byte(Key, 1, -1)}

    for Index = 1, #Normal do
        table.insert(Encrypted, Encode[bit32.bxor(Normal[Index], Key[Index % #Key + 1])])
    end

    return table.concat(Encrypted)
end

function EmojiCrypt.Decrypt(Encrypted, Key)
    local Decoded = {}
    local Decrypted = {}

    for i = 1, #Encrypted, 4 do
        local Current = string.sub(Encrypted, i, i + 3)
        local Next = string.sub(Encrypted, i + 4, i + 7)

        if Current ~= utf8.char(0x1F512) then
            table.insert(Decoded, Decode[Current] + (Next == utf8.char(0x1F512) and 128 or 0))
        end
    end

    local Key = {string.byte(Key, 1, -1)}
    
    for Index = 1, #Decoded do
        table.insert(Decrypted, string.char(bit32.bxor(Decoded[Index], Key[Index % #Key + 1])))
    end

    return table.concat(Decrypted)
end

return EmojiCrypt
