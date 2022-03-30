Paddle=Class()
paddlespeed=6 

function Paddle:init(skin)
	self.x=VIRTUAL_WIDTH/2-32

	self.y=VIRTUAL_HEIGHT-40

	self.dx=0
	self.skin=skin

	self.size=2

	
	self.height=16




end
function Paddle:update(dt)
	self.width=32*self.size
	self.height=16
	if love.keyboard.isDown('left') then
		self.dx=-paddlespeed
	elseif love.keyboard.isDown('right') then
		self.dx=paddlespeed
	else 
		self.dx=0
	end


    if self.dx<0 then
    	self.x=math.max(0,self.x+self.dx+dt) 
    elseif self.dx>0 then
    	self.x=math.min(VIRTUAL_WIDTH-self.width,self.x+self.dx+dt)
    end

end	

function Paddle:render()
	love.graphics.draw(gTextures['main'],gFrames['paddles'][self.size + 4 * (self.skin - 1)],self.x,self.y)
end