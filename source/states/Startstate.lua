Startstate=Class{__includes=BaseState}
local highlight=1
function Startstate:enter(params)
    self.highScores = params.highScores
end

function Startstate:update(dt)
if love.keyboard.wasPressed('up')or love.keyboard.wasPressed('down') then
	highlight=highlight==1 and 2 or 1
	 gSounds['paddle-hit']:play()
end
if love.keyboard.wasPressed('escape') then
	love.event.quit()
end

   if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
   	gSounds['confirm']:play()
         if highlight==1 then
  gStateMachine:change('paddle-select', {
                highScores = self.highScores,
                 brick = LevelMaker.createMap(100)
            })
	else
            gStateMachine:change('high-scores', {
                highScores = self.highScores
            })
   end
end

end
function Startstate:render()
	  love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')


		love.graphics.setFont(gFonts['medium'])
		 if highlight==1 then
		 	love.graphics.setColor(0.2, 0.8, 0.2)
		 end
		love.graphics.printf('Start',0,VIRTUAL_HEIGHT/2+70,VIRTUAL_WIDTH,'center')

	 love.graphics.setColor(255, 255, 255, 255)

        if highlight==2 then
        	 love.graphics.setColor(0.2, 0.8, 0.2)
        	end
		love.graphics.printf('Highscore',0,VIRTUAL_HEIGHT/2+90,VIRTUAL_WIDTH,'center')


		 love.graphics.setColor(255, 255, 255, 255)


end