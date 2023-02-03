local keypressedMultiDelegate = {}
function bindKeypressed(obj)
    table.insert(keypressedMultiDelegate, obj)
end

function unbindKeypressed(obj)
    table.remove(keypressedMultiDelegate, obj)
end

function keypressed(key)
    for i=1, #keypressedMultiDelegate do
        keypressedMultiDelegate[i]:keypressed(key)
    end
end