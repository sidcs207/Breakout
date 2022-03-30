Powerup=Class{}
paletteColor = {
    -- blue
    [1] = {
        ['r'] = 99/255,
        ['g'] = 155/255,
        ['b'] = 255/255
    }
}
function Powerup:init(x,y,type,strength)
	self.x=x
	self.y=y
self.type=type
	self.dy=80
	self.colo=1
	self.inplay=true
	self.hit=false
self.height=16
self.width=16
self.strength=strength
	self.psystem=love.graphics.newParticleSystem(gTextures['particle'],32)

	self.psystem:setParticleLifetime(0.5,1)
	self.psystem:setLinearAcceleration(-15,0,15,80)
	self.psystem:setAreaSpread('normal',10,10)
end
function Powerup:hits()
	gSounds['brick-hit-2']:play()

    self.psystem:setColors(
    	paletteColor[self.colo].r,
        paletteColor[self.colo].g,
        paletteColor[self.colo].b,
        55 *2,
        paletteColor[self.colo].r,
        paletteColor[self.colo].g,
        paletteColor[self.colo].b,
        0
    )

    self.psystem:emit(12)
    self.inplay=false
end
function Powerup:collide(paddle)
	if self.y+self.height>paddle.y and paddle.y+paddle.height>self.y then
		if self.x<paddle.x+paddle.width and paddle.x<self.x+self.width then
		return true 
	end
	end
end
function Powerup:update(dt)
	if self.hit and self.strength==0 then
	
        self.y=self.y+self.dy*dt
      end
      self.psystem:update(dt)
end

function Powerup:render()
     if self.inplay  then
     love.graphics.draw(gTextures['main'],gFrames['Powerup'][self.type],self.x,self.y)
     end
     end	

function Powerup:renderParticles()
	love.graphics.draw(self.psystem,self.x+16,self.y+8)
end



