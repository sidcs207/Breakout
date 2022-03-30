PlayState=Class{__includes=BaseState}

function PlayState:enter(params)
 self.paddle = params.paddle
  self.brick = params.brick
  self.ball=params.ball
   self.health = params.health
   self.score = params.score
   self.level = params.level
    self.highScores = params.highScores
self.powerup=params.powerup
self.canhit=params.canhit
self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
    extraball=false
      self.compareScore=params.maxScore
  self.comparepaddle=params.Maxpaddle
  max=1
  extraballcount=0
self.extraballs={}
ballfall=0
end
function PlayState:update(dt)
	 if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end
    			self.ball:update(dt)
			self.paddle:update(dt)
       if extraball then
            for k,selfextraball in pairs(self.extraballs) do

selfextraball:update(dt)
end
end
			 if self.ball:collides(self.paddle) then
		 	self.ball.dy=-self.ball.dy
		 	self.ball.y=self.paddle.y-8

		 	
		 	 if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        
            -- else if we hit the paddle on its right side while moving right...
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end

   
                 gSounds['paddle-hit']:play()

          end
          if extraball then
            for k,selfextraball in pairs(self.extraballs) do

          if selfextraball:collides(self.paddle) then
      selfextraball.dy=-selfextraball.dy
      selfextraball.y=self.paddle.y-8

      
       if selfextraball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            selfextraball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - selfextraball.x))
        
            -- else if we hit the paddle on its right side while moving right...
        elseif selfextraball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            selfextraball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - selfextraball.x))
        end

   
                 gSounds['paddle-hit']:play()

          end
        end
      end
 for k,power in pairs(self.powerup) do
       if power:collide(self.paddle) then
        table.remove(self.powerup,k)
            power:hits()
            if power.type<=9 then
            extraballcount=extraballcount+1
    self.extraballs[extraballcount]=Ball()
   self.extraballs[extraballcount].skin=math.random(7)
          self.extraballs[extraballcount].x=self.paddle.x + (self.paddle.width / 2)
           self.extraballs[extraballcount].y=self.paddle.y-8
            self.extraballs[extraballcount].display=true

            self.extraballs[extraballcount].dx = math.random(-200, 200)
    self.extraballs[extraballcount].dy = math.random(-50, -60)
    extraball=true
    

  end

     if power.type==10 then
         self.canhit=true

     end          

       
        end
       end
          for k,brick in pairs(self.brick) do
            if brick.z and self.ball:collides(brick) and brick.inplay then
              if self.canhit then
                   self.score = self.score + 20000
                   self.paddle.size=4
                   brick:hit()
                 end
                  if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    ball = self.ball,
                     maxScore=self.compareScore,
               Maxpaddle=self.comparepaddle,
                 
                })
            end
                   if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - 8
            

            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                
                
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32
            
            elseif self.ball.y < brick.y then
                
                
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8
            
            
            else
                
          
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + 16
            end

           
            self.ball.dy = self.ball.dy * 1.02

            
           
                break
 
      end
			if brick.inplay and self.ball:collides(brick) then
              self.score = self.score + (brick.tier * 200 + brick.color * 25)
               for k,power in pairs(self.powerup) do
                  if power.x==brick.x and power.y==brick.y then
                    power.hit=true
                    if power.strength==0 then
                      power.strength=0
                    else
                    power.strength=power.strength-1
                  end
                  end
      end
                if self.score>self.compareScore*10000 then
                   self.compareScore=self.compareScore+1
                  if self.health<5 then
                     self.health=self.health+1

                  end
                
                end

                if self.score>self.comparepaddle*5000 then
                   self.comparepaddle=self.comparepaddle+1
                  if self.paddle.size<4 then
                    self.paddle.size=self.paddle.size+1
                  else
                    self.paddle.size=4
                  end
                          
                  
                
                end
  
				brick:hit()



          

   




                  if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    ball = self.ball,
                     maxScore=self.compareScore,
               Maxpaddle=self.comparepaddle,

                })
            end


               if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - 8
            

            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                
                
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32
            
            elseif self.ball.y < brick.y then
                
                
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8
            
            
            else
                
          
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + 16
            end

           
            self.ball.dy = self.ball.dy * 1.02

            
           
                break
 
			end
        if extraball then
            for k,selfextraball in pairs(self.extraballs) do

       if brick.z and selfextraball:collides(brick) and brick.inplay then
              if self.canhit then
                   self.score = self.score + 20000
                   self.paddle.size=4
                   brick:hit()
                 end
                  if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    ball = self.ball,
                     maxScore=self.compareScore,
               Maxpaddle=self.comparepaddle,
                 
                })
            end
           if selfextraball.x + 2 < brick.x and selfextraball.dx > 0 then
                
                selfextraball.dx = -selfextraball.dx
                selfextraball.x = brick.x - 8
            

            elseif selfextraball.x + 6 > brick.x + brick.width and selfextraball.dx < 0 then
                
                
                selfextraball.dx = -selfextraball.dx
                selfextraball.x = brick.x + 32
            
            elseif selfextraball.y < brick.y then
                
                
                selfextraball.dy = -selfextraball.dy
                selfextraball.y = brick.y - 8
            
            
            else
                
          
                selfextraball.dy = -selfextraball.dy
                selfextraball.y = brick.y + 16
            end
           
            selfextraball.dy = selfextraball.dy * 1.02

            
           
                break
 
      end
        if brick.inplay and selfextraball:collides(brick) then
              self.score = self.score + (brick.tier * 200 + brick.color * 25)
               for k,power in pairs(self.powerup) do
                  if power.x==brick.x and power.y==brick.y then
                    power.hit=true
                     if power.strength==0 then
                      power.strength=0
                    else
                    power.strength=power.strength-1
                  end
                  end
      end
                if self.score>self.compareScore*10000 then
                   self.compareScore=self.compareScore+1
                  if self.health<5 then
                     self.health=self.health+1

                  end
                
                end

                if self.score>self.comparepaddle*5000 then
                   self.comparepaddle=self.comparepaddle+1
                  if self.paddle.size<4 then
                    self.paddle.size=self.paddle.size+1
                  else
                    self.paddle.size=4
                  end
                          
                  
                
                end
  
        brick:hit()



          

   




                  if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    ball = self.ball,
                     maxScore=self.compareScore,
               Maxpaddle=self.comparepaddle,

                })
            end


               if selfextraball.x + 2 < brick.x and selfextraball.dx > 0 then
                
                selfextraball.dx = -selfextraball.dx
                selfextraball.x = brick.x - 8
            

            elseif selfextraball.x + 6 > brick.x + brick.width and selfextraball.dx < 0 then
                
                
                selfextraball.dx = -selfextraball.dx
                selfextraball.x = brick.x + 32
            
            elseif selfextraball.y < brick.y then
                
                
                selfextraball.dy = -selfextraball.dy
                selfextraball.y = brick.y - 8
            
            
            else
                
          
                selfextraball.dy = -selfextraball.dy
                selfextraball.y = brick.y + 16
            end

           
            selfextraball.dy = selfextraball.dy * 1.02

            
           
                break
 
      end
		end
  end
end
   for k,power in pairs(self.powerup) do
        power:update(dt)
        
      end
     for k, brick in pairs(self.brick) do
        brick:update(dt)
      
    end

    if extraball then
            
          if self.ball.y>VIRTUAL_HEIGHT  then
                 self.ball.display=false
                 for k,selfextraball in pairs(self.extraballs) do

                       if  selfextraball.y>VIRTUAL_HEIGHT then
                             ballfall=true
                                 table.remove(self.extraballs,k)
                           end
                      

                     end  
                       for k,selfextraball in pairs(self.extraballs) do

                       if  selfextraball.y<VIRTUAL_HEIGHT then
                             ballfall=false
                           end
                          

                     end  
          
          
           for k,power in pairs(self.powerup) do
    
         power.psystem:reset()
      end
     for k, brick in pairs(self.brick) do
   
         brick.psystem:reset()
    end
    if ballfall==true then
  self.health=self.health-1
                if self.paddle.size>1 then
                    self.paddle.size=self.paddle.size-1
                end
              gSounds['hurt']:play()


            if self.health==0 then
              gStateMachine:change('gameover',{
              score=self.score,
              highScores=self.highScores
                })
            else
                gStateMachine:change('serve',{
                  score=self.score,
                  health=self.health,
                  brick=self.brick,
                  paddle=self.paddle,
                     ball=self.ball,
                      highScores = self.highScores,
                      level = self.level,
                      maxScore=self.compareScore,
                      Maxpaddle=self.comparepaddle,
                   powerup=self.powerup,
                   canhit=self.canhit

                })
            end
          end
        end
      
		else 
         if self.ball.y>VIRTUAL_HEIGHT then
          	self.health=self.health-1
                if self.paddle.size>1 then
                    self.paddle.size=self.paddle.size-1
                end
          	  gSounds['hurt']:play()


          	if self.health==0 then
          		gStateMachine:change('gameover',{
          		score=self.score,
              highScores=self.highScores
                })
          	else
                gStateMachine:change('serve',{
                	score=self.score,
                	health=self.health,
                	brick=self.brick,
                	paddle=self.paddle,
                     ball=self.ball,
                      highScores = self.highScores,
                      level = self.level,
                      maxScore=self.compareScore,
                      Maxpaddle=self.comparepaddle,
                   powerup=self.powerup,
                   canhit=self.canhit

                })
            end
          end
end
      end
  

 function PlayState:render()
    self.paddle:render()
  self.ball:render()
    if extraball then
            for k,selfextraball in pairs(self.extraballs) do

  selfextraball:render()
end
end
     for k,power in pairs(self.powerup) do
        power:render()
      end
 	for k,brick in pairs(self.brick) do
 	brick:render()
 end
   for k, brick in pairs(self.brick) do
        brick:renderParticles()
    end
     for k,power in pairs(self.powerup) do
  power:renderParticles()
end
 	self.paddle:render()
 	self.ball:render()
   renderscore(self.score)
    renderHealth(self.health)
 	if self.paused==true then
 		 love.graphics.setFont(gFonts['large'])
 		love.graphics.printf('pause',0,VIRTUAL_HEIGHT/2-10,VIRTUAL_WIDTH,'center')
 	end
 end
function PlayState:checkVictory()
  for k,brick in pairs(self.brick) do
    if brick.inplay then
      return false
    end
  end

  return true
end


