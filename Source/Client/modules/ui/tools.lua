--[[
    This file contains some generic UI elements.

    FUNCTIONS:
        drawButton(text,x,y,width,height) - Draws a black button. Returns true if the button is presently being pressed.
]]

function drawButton(text,x,y,width,height)
    if isMouseOver(x,width,y,height) then
        love.graphics.setColor(100,100,100)
        if love.mouse.isDown(1) then return true end
    else
        love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill",x,y,width,height)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    love.graphics.printf(text,x,y,width,"center")
end

function getTextHeight(text,tFont,tLimit)
    return tFont:getWidth(text)/tLimit * tFont:getHeight()
end