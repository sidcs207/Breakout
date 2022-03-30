Key=Class{}
aletteColors = {
   [5] = {
        ['r'] = 251/255,
        ['g'] = 242/255,
        ['b'] = 54/255
    }
}
function Key:init(x,y,z)
	self.width=32
	self.height=16
	self.x=x
	self.y=y
	self.z=z
	self.inplay=true
self.col=5
	self.psystem=love.graphics.newParticleSystem(gTextures['particle'],96)

	self.psystem:setParticleLifetime(0.5,1)
	self.psystem:setLinearAcceleration(-15,0,15,80)
	self.psystem:setAreaSpread('normal',10,10)
end
function Key:hit()
	 gSounds['brick-hit-2']:play()

    self.psystem:setColors(
    	paletteColors[self.col].r,
        paletteColors[self.col].g,
        paletteColors[self.col].b,
        55 * 2,
        paletteColors[self.col].r,
        paletteColors[self.col].g,
        paletteColors[self.col].b,
        0
    )

    self.psystem:emit(64)
	self.inplay=false

end
function Key:update(dt)
    self.psystem:update(dt)
end
function Key:render()
	if self.inplay then
	love.graphics.draw(gTextures['main'],gFrames['key'],self.x,self.y)
end
end
function Key:renderParticles()
	love.graphics.draw(self.psystem,self.x+16,self.y+8)
end
