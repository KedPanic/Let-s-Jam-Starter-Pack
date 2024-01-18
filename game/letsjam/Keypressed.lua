
local keypressedMultiDelegate = {}
function bindKeypressed(obj)
    table.insert(keypressedMultiDelegate, obj)
end

function unbindKeypressed(obj)
    for i,delegate in pairs(keypressedMultiDelegate) do
        if keypressedMultiDelegate[i] == obj then
            keypressedMultiDelegate[i] = keypressedMultiDelegate[#keypressedMultiDelegate]
            keypressedMultiDelegate[#keypressedMultiDelegate] = nil
        end
    end
end

function keypressed(key)
    for i=1, #keypressedMultiDelegate do
        keypressedMultiDelegate[i]:keypressed(key)
    end
end

function keyreleased(key)
    for i=1, #keypressedMultiDelegate do
        keypressedMultiDelegate[i]:keyreleased(key)
    end
end