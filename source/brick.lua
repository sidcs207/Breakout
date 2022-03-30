Brick=Class{}
paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99/255,
        ['g'] = 155/255,
        ['b'] = 255/255
    },
    -- green
    [2] = {
        ['r'] = 106/255,
        ['g'] = 190/255,
        ['b'] = 47/255
    },
    -- red
    [3] = {
        ['r'] = 217/255,
        ['g'] = 87/255,
        ['b'] = 99/255
    },
    -- purple
    [4] = {
        ['r'] = 215/255,
        ['g'] = 123/255,
        ['b'] = 186/255
    },
    -- gold
    [5] = {
        ['r'] = 251/255,
        ['g'] = 242/255,
        ['b'] = 54/255
    }
}

function Brick:init(x,y)
	self.x=x
	self.y=y
	self.width=32
	self.height=16
	self.inplay=true
	self.color=1
	self.tier=0
	self.psystem=love.graphics.newParticleSystem(gTextures['particle'],64)

	self.psystem:setParticleLifetime(0,1)
	self.psystem:setLinearAcceleration(-15,0,15,80)
	self.psystem:setAreaSpread('normal',10,10)

end
function Brick:hit()
 
    gSounds['brick-hit-2']:play()

    self.psystem:setColors(
    	paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        55 * (self.tier + 1),
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        1
    )

    self.psystem:emit(32)

if self.tier>0 then
  if self.color==1 then
  	self.tier=self.tier-1
  	self.color=5
  else
  	self.color=self.color-1
  end
else
	if self.color==1 then
		self.inplay=false
	else
		self.color=self.color-1
	end
end


	if not self.inplay then
      
        gSounds['brick-hit-1']:play()
    end
end
function Brick:update(dt)
    self.psystem:update(dt)
end
function Brick:render()
	if self.inplay then
		love.graphics.draw(gTextures['main'],gFrames['bricks'][1+((self.color - 1) * 4)+self.tier],self.x,self.y)
	end
end
function Brick:renderParticles()
	love.graphics.draw(self.psystem,self.x+16,self.y+8)
end
