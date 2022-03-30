require'source/dependencies'

function love.load()
	 love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Breakout')

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }


     gTextures = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }
gFrames={
	['paddles']=GenerateQuadsPaddles(gTextures['main']),
	['ball']=GenerateQuadsBalls(gTextures['main']),
	['bricks']=GenerateQuadsBricks(gTextures['main']),
    ['heart']=GenerateQuads(gTextures['hearts'],10,9),
    ['arrows']=GenerateQuads(gTextures['arrows'],24,24),
    ['Powerup']=GenerateQuadsPowerups(gTextures['main']),
    ['key']=GenerateQuadskey(gTextures['main'])
}

push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
	fullscreen=false,
	resizable=true,
	vsync=true 
})

 gSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav','static'),
        ['score'] = love.audio.newSource('sounds/score.wav','static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav','static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav','static'),
        ['select'] = love.audio.newSource('sounds/select.wav','static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav','static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav','static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav','static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav','static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav','static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav','static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav','static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav','static'),
        ['music'] = love.audio.newSource('sounds/music.wav','static')
    }

  gStateMachine = StateMachine {
        ['start'] = function() return Startstate() end,
        ['play']=function() return PlayState() end,
        ['serve']=function() return Servestate() end,
        ['gameover']=function() return GameOverState() end,
        ['victory']=function() return VictoryState() end,
         ['high-scores'] = function() return HighScoreState() end,
         ['enter-high-score'] = function() return EnterHighScoreState() end,
         ['paddle-select']=function() return PaddleSelectState() end
    }
    gStateMachine:change('start', {
        highScores = loadHighScores()})

   

    love.keyboard.keysPressed = {}
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)
    
    gStateMachine:update(dt)


    love.keyboard.keysPressed = {}
end


function love.keypressed(key)
    
    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end


function love.draw()
    
    push:apply('start')

local backgroundwidth=gTextures['background']:getWidth()
local backgroundheight=gTextures['background']:getHeight()

love.graphics.draw(gTextures['background'],0,0,0,
	   VIRTUAL_WIDTH / (backgroundwidth - 1), VIRTUAL_HEIGHT / (backgroundheight - 1))

gStateMachine:render()
    

   displayFPS()
    
    push:apply('end')
end
function loadHighScores()
    love.filesystem.setIdentity('brea')

    -- if the file doesn't exist, initialize it with some default scores
    if  not love.filesystem.exists('brea.lst') then
        local score = ''
        for i = 10, 1, -1 do
            score = score .. 'CTO\n' .. tostring(i * 10) .. '\n'
        end

        love.filesystem.write('brea.lst', score)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('brea.lst') do
        if name then
            scores[counter].name = string.sub(line, 1,3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end


function renderHealth(health)
    -- start of our health rendering
    local healthX = VIRTUAL_WIDTH - 122
    healthz=health
    for i = 1, health do
        love.graphics.draw(gTextures['hearts'], gFrames['heart'][1], healthX, 4)
        healthX = healthX + 11
    end

   -- 
    for i = 1,  5-health do
        love.graphics.draw(gTextures['hearts'], gFrames['heart'][2], healthX, 4)
        healthX = healthX + 11
    end
end
 function renderscore(score)
 	 love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score:', VIRTUAL_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end

function displayFPS()
   
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0.2, 0.8, 0.2)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end
