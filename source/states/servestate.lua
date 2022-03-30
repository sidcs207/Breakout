Servestate=Class{__includes=BaseState}

function Servestate:enter(params)
 self.paddle = params.paddle
  self.brick = params.brick
   self.health = params.health
   self.score = params.score
   self.level = params.level
    self.ball = Ball()
    self.ball.skin = math.random(7)
   self.ball.display=true
      self.highScores = params.highScores
        self.compareScore=params.maxScore
        self.comparepaddle=params.Maxpaddle
    self.canhit=params.canhit
     self.powerup=params.powerup

end
function Servestate:update(dt)
		 self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		
		gStateMachine:change('play',{
			paddle=self.paddle,
			ball=self.ball,
			brick=self.brick,
			health=self.health,
			score=self.score,
			level = self.level,
			 highScores = self.highScores,
			  maxScore=self.compareScore,
			   Maxpaddle=self.comparepaddle,
			  powerup=self.powerup,
			  canhit=self.canhit

		})
	end
end
function Servestate:render()
	self.paddle:render()
		self.ball:render()
		for k,power in pairs(self.powerup) do
        power:render()
      end
		for k,brick in pairs(self.brick) do
			brick:render()
		end
		
		renderscore(self.score)
		  renderHealth(self.health)
		love.graphics.printf('Press enter to Serve',0,VIRTUAL_HEIGHT/2,VIRTUAL_WIDTH,'center')
	end