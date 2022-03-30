Ball=Class{}
function Ball:init(skin)

	self.dx=0
	self.dy=0

	self.width=8
	self.height=8
	self.skin=skin
  self.display=false
end
function Ball:update(dt)
   if self.display then
  self.x=self.x+self.dx*dt 
  self.y=self.y+self.dy*dt
   if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.x >= VIRTUAL_WIDTH - 8 then
        self.x = VIRTUAL_WIDTH - 8
        self.dx = -self.dx
        gSounds['wall-hit']:play()
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall-hit']:play()
    end
end
end
function Ball:reset()
	self.x=VIRTUAL_WIDTH/2-32

	self.y=VIRTUAL_HEIGHT-25
	self.dx=0
	self.dy=0
end

function Ball:collides(paddle)
  if self.display then
	if self.y+self.height>paddle.y and paddle.y+paddle.height>self.y then
		if self.x<paddle.x+paddle.width and paddle.x<self.x+self.width then
		return true 
	end
	end
end
end
function Ball:render()
     if self.display then
	love.graphics.draw(gTextures['main'],gFrames['ball'][self.skin],self.x,self.y)
end
end