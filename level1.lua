-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

-- Widget
local widget = require "widget"

-- [Title View]

local titleBg
local playBtn
local creditsBtn
local titleView

-- [Walls]

local l1
local l2
local l3
local l4

local r1
local r2
local r3
local r4

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

-- [Ball]

local ball 



-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- adds background
	local background =  display.newImage('bg.png', display.contentCenterX, display.contentCenterY)
	background.width = display.actualContentWidth
	background.height = display.actualContentHeight
	background:setFillColor(0,0,1)

	 -- Left Wall Parts
     
    l1 = display.newImage('l1.png')
    l2 = display.newImage('l2.png', 0, display.contentCenterY * .75)
    l3 = display.newImage('l3.png', 0, display.contentCenterY * 1.5)
    l4 = display.newImage('l4.png', 0, display.contentCenterY * 2)

  	-- Right Wall Parts

    r1 = display.newImage('r1.png', display.actualContentWidth, display.contentScaleY)
	r2 = display.newImage('r2.png', display.actualContentWidth, display.contentCenterY * .75)
	r3 = display.newImage('r3.png', display.actualContentWidth, display.contentCenterY * 1.5)
	r4 = display.newImage('r4.png', display.actualContentWidth, display.contentCenterY * 2)

	
	-- Ball shit

	ball = display.newImage('ball.png', display.contentWidth * 0.5, 0)
	hitLine1 = display.newImage('hitLine.png', display.contentWidth - 150, display.contentHeight - 600)
	hitLine2 = display.newImage('hitLine.png', display.contentWidth - 350, display.contentHeight - 600)

	-- Hit balls
 
	hitBall1 = display.newImage('hitBall.png', display.contentCenterX, display.contentCenterY)
	hitBall2 = display.newImage('hitBall.png', display.contentCenterX - 50, display.contentCenterY)
	hitBall3 = display.newImage('hitBall.png', display.contentCenterX + 50, display.contentCenterY)
	hitBall1.name = 'hBall'
	hitBall2.name = 'hBall'
	hitBall3.name = 'hBall'

	pLeft = display.newImage('paddleL.png', display.contentCenterX + 100, display.contentCenterY * 2)
	pRight = display.newImage('paddleR.png', display.contentCenterX - 100, display.contentCenterY * 2)
	pLeft.name = 'leftPaddle'
	pRight.name = 'rightPaddle'

	lBtn = display.newImage('lBtn.png', display.contentCenterX + 150, display.contentCenterY * 2)
	rBtn = display.newImage('rBtn.png', display.contentCenterX - 150, display.contentCenterY * 2)
	lBtn.name = 'left'
	rBtn.name = 'right'

	-- Score TextField
 
	score = display.newText('0TEST', 30, 0, 'Marker Felt', 14)
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
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert(l1)
	sceneGroup:insert(l2)
	sceneGroup:insert(l3)
	sceneGroup:insert(l4)
	sceneGroup:insert(r1)
	sceneGroup:insert(r2)
	sceneGroup:insert(r3)
	sceneGroup:insert(r4)
	sceneGroup:insert(ball)
	sceneGroup:insert(hitLine1)
	sceneGroup:insert(hitLine2)
	sceneGroup:insert(hitBall1)
	sceneGroup:insert(hitBall2)
	sceneGroup:insert(hitBall3)
	sceneGroup:insert(pLeft)
	sceneGroup:insert(pRight)
	sceneGroup:insert(lBtn)
	sceneGroup:insert(rBtn)
	sceneGroup:insert(score)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end
	---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene