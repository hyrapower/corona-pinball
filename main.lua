-- Pinball Game
-- Developed by Carlos Yanez

-- Hide Status Bar

display.setStatusBar(display.HiddenStatusBar)

-- Physics

local physics = require('physics')
physics.start()
--physics.setDrawMode('hybrid')

-- Graphics

-- [Background]

local bg = display.newImage('bg.png', display.contentCenterX, display.contentCenterY)
bg.width = 480
bg.height = 800

-- [Title View]

local titleBg
local playBtn
local creditsBtn
local titleView

-- [Credits]

local creditsView

-- [Walls]

local l1
local l2
local l3
local l4

local r1
local r2
local r3
local r4

-- [Ball]

local ball 

-- [Hit Lines]

local hitLine1
local hitLine2

-- [Hit Balls]

local hitBall1
local hitBall2
local hitBall3

-- [Paddles]

local pLeft
local pRight

-- [Paddle Buttons]

local lBtn
local rBtn

-- Score

local score

-- Sounds

local bell = audio.loadSound('bell.caf')
local buzz = audio.loadSound('buzz.caf')

-- Variables

local lastY

-- Functions

local Main = {}
local startButtonListeners = {}
local showCredits = {}
local hideCredits = {}
local showGameView = {}
local gameListeners = {}
local movePaddle = {}
local onCollision = {}
local update = {}

-- Main Function

function Main()
	titleBg = display.newImage('title.png', display.contentCenterX - 97, 96)
	playBtn = display.newImage('playBtn.png', display.contentCenterX - 30, display.contentCenterY + 10)
	creditsBtn = display.newImage('creditsBtn.png', display.contentCenterX - 44.5, display.contentCenterY + 65)
	titleView = display.newGroup(titleBg, playBtn, creditsBtn)
	
	startButtonListeners('add')
end

function startButtonListeners(action)
	if(action == 'add') then
		playBtn:addEventListener('tap', showGameView)
		creditsBtn:addEventListener('tap', showCredits)
	else
		playBtn:removeEventListener('tap', showGameView)
		creditsBtn:removeEventListener('tap', showCredits)
	end
end

function showCredits:tap(e)
	playBtn.isVisible = false
	creditsBtn.isVisible = false
	creditsView = display.newImage('credits.png', display.contentCenterX, display.contentHeight)
	
	lastY = titleBg.y
	transition.to(titleBg, {time = 300, y = (display.contentHeight * 0.5) - (titleBg.height + 50)})
	transition.to(creditsView, {time = 300, y = (display.contentHeight * 0.5) + 35, onComplete = function() creditsView:addEventListener('tap', hideCredits) end})
end

function hideCredits:tap(e)
	transition.to(creditsView, {time = 300, y = display.contentHeight + 25, onComplete = function() creditsBtn.isVisible = true playBtn.isVisible = true creditsView:removeEventListener('tap', hideCredits) display.remove(creditsView) creditsView = nil end})
	transition.to(titleBg, {time = 300, y = lastY});
end

function showGameView:tap(e)
    transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') display.remove(titleView) titleView = nil end})
    end

    -- Left Wall Parts
     
    l1 = display.newImage('l1.png')
    l2 = display.newImage('l2.png', 0, 214)
    l3 = display.newImage('l3.png', 0, 273)
    l4 = display.newImage('l4.png', 0, 387)

    -- Right Wall Parts
 
r1 = display.newImage('r1.png', 238, 0)
r2 = display.newImage('r2.png', 274, 214)
r3 = display.newImage('r3.png', 291, 273)
r4 = display.newImage('r4.png', 195, 387)

ball = display.newImage('ball.png', display.contentWidth * 0.5, 0)
hitLine1 = display.newImage('hitLine.png', 70, 28)
hitLine2 = display.newImage('hitLine.png', 110, 28)

-- Hit balls
 
hitBall1 = display.newImage('hitBall.png', 160, 186)
hitBall2 = display.newImage('hitBall.png', 130, 236)
hitBall3 = display.newImage('hitBall.png', 187, 236)
hitBall1.name = 'hBall'
hitBall2.name = 'hBall'
hitBall3.name = 'hBall'

pLeft = display.newImage('paddleL.png', 74, 425)
pRight = display.newImage('paddleR.png', 183, 425)
pLeft.name = 'leftPaddle'
pRight.name = 'rightPaddle'

lBtn = display.newImage('lBtn.png', 20, 425)
rBtn = display.newImage('rBtn.png', 260, 425)
lBtn.name = 'left'
rBtn.name = 'right'

-- Score TextField
 
score = display.newText('0', 2, 0, 'Marker Felt', 14)
score:setTextColor(255, 206, 0)

-- Left Wall Parts
 
physics.addBody(l1, 'static', {shape = {-40, -107, -11, -107, 40, 70, 3, 106, -41, 106}})
physics.addBody(l2, 'static', {shape = {-23, -30, 22, -30, 22, 8, 6, 29, -23, 29}})
physics.addBody(l3, 'static', {shape = {-14, -56, 14, -56, 14, 56, -14, 56}})
physics.addBody(l4, 'static', {shape = {-62, -46, -33, -46, 61, 45, -62, 45}})
 
-- Right Wall Parts
 
physics.addBody(r1, 'static', {shape = {10, -107, 39, -107, 40, 106, -5, 106, -41, 70}})
physics.addBody(r2, 'static', {shape = {-22, -30, 22, -30, 22, 29, -6, 29, -23, 9}})
physics.addBody(r3, 'static', {shape = {-14, -56, 14, -56, 14, 56, -14, 56}})
physics.addBody(r4, 'static', {shape = {32, -46, 61, -46, 61, 45, -62, 45}})

physics.addBody(ball, 'dynamic', {radius = 8, bounce = 0.4})
physics.addBody(hitLine1, 'static', {shape = {-20, -42, -15, -49, -6, -46, 18, 39, 15, 44, 5, 44, }})
physics.addBody(hitLine2, 'static', {shape = {-20, -42, -15, -49, -6, -46, 18, 39, 15, 44, 5, 44, }})
physics.addBody(hitBall1, 'static', {radius = 15})
physics.addBody(hitBall2, 'static', {radius = 15})
physics.addBody(hitBall3, 'static', {radius = 15})
physics.addBody(pRight, 'static', {shape = {-33, 11, 27, -12, 32, 1}})
physics.addBody(pLeft, 'static', {shape = {-33, 1, -28, -12, 32, 11}})

-- Top Wall
 
local topWall = display.newLine(display.contentWidth * 0.5, -1, display.contentWidth * 2, -1)
physics.addBody(topWall, 'static')

function gameListeners(action)
    if(action == 'add') then
        lBtn:addEventListener('touch', movePaddle)
        rBtn:addEventListener('touch', movePaddle)
        ball:addEventListener('collision', onCollision)
        Runtime:addEventListener('enterFrame', update)
    else
        lBtn:removeEventListener('touch', movePaddle)
        rBtn:removeEventListener('touch', movePaddle)
        ball:removeEventListener('collision', onCollision)
        Runtime:removeEventListener('enterFrame', update)
    end
end

function movePaddle(e)
    if(e.phase == 'began' and e.target.name == 'left') then
        pLeft.rotation = -40
    elseif(e.phase == 'began' and e.target.name == 'right') then
        pRight.rotation = 40
    end
        if(e.phase == 'ended') then
        pLeft.rotation = 0
        pRight.rotation = 0
    end
end

function onCollision(e)
    -- Shoot
    if(e.phase == 'began' and e.other.name == 'leftPaddle' and e.other.rotation == -40) then
        ball:applyLinearImpulse(0.05, 0.05, ball.y, ball.y)
    elseif(e.phase == 'began' and e.other.name == 'rightPaddle' and e.other.rotation == 40) then
        ball:applyLinearImpulse(0.05, 0.05, ball.y, ball.y)
    end
    if(e.phase == 'ended' and e.other.name == 'hBall') then
        score.text = tostring(tonumber(score.text) + 100)
        score:setReferencePoint(display.TopLeftReferencePoint)
        score.x = 2
        audio.play(bell)
    end
end

function update()
    -- Check if ball hit bottom
    if(ball.y > display.contentHeight) then
        ball.y = 0
        audio.play(buzz)
    end
end


Main()
