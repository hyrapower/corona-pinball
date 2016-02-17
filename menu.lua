--Menu

local composer = require( "composer" )
local scene = composer.newScene()

-- Physics

local physics = require('physics')
physics.start()
--physics.setDrawMode('hybrid')

-- Widget
local widget = require "widget"


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

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
		-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- local function startButtonListeners(action)
-- 	if(action == 'add') then
-- 		playBtn:addEventListener('tap', showGameView)
-- 		creditsBtn:addEventListener('tap', showCredits)
-- 	else
-- 		playBtn:removeEventListener('tap', showGameView)
-- 		creditsBtn:removeEventListener('tap', showCredits)
-- 	end
-- end

-- local function showCredits:tap(e)
-- 	playBtn.isVisible = false
-- 	creditsBtn.isVisible = false
-- 	creditsView = display.newImage('credits.png', display.contentCenterX, display.contentHeight)
	
-- 	lastY = titleBg.y
-- 	transition.to(titleBg, {time = 300, y = (display.contentHeight * 0.5) - (titleBg.height + 50)})
-- 	transition.to(creditsView, {time = 300, y = (display.contentHeight * 0.5) + 35, onComplete = function() creditsView:addEventListener('tap', hideCredits) end})
-- end

-- local function hideCredits:tap(e)
-- 	transition.to(creditsView, {time = 300, y = display.contentHeight + 25, onComplete = function() creditsBtn.isVisible = true playBtn.isVisible = true creditsView:removeEventListener('tap', hideCredits) display.remove(creditsView) creditsView = nil end})
-- 	transition.to(titleBg, {time = 300, y = lastY});
-- end

-- local function showGameView:tap(e)
--     transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') display.remove(titleView) titleView = nil end})
--     end

--Called when the scene's view does not exist
function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImage('bg.png', display.contentCenterX, display.contentCenterY)
	background.width = 480
	background.height = 800
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImage('title.png', display.contentCenterX - 97, 96)
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Play Now",
		labelColor = { default={255}, over={128} },
		default="bumper.png",
		over="bumper.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 125

	--titleBg = display.newImage('title.png', display.contentCenterX - 97, 96)
	--playBtn = display.newImage('playBtn.png', display.contentCenterX - 30, display.contentCenterY + 10)
	--creditsBtn = display.newImage('creditsBtn.png', display.contentCenterX - 44.5, display.contentCenterY + 65)
	--titleView = display.newGroup(titleBg, playBtn, creditsBtn)
	
	--startButtonListeners('add')

	 --transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') display.remove(titleView) titleView = nil end})
    end

--     -- Left Wall Parts
     
--     l1 = display.newImage('l1.png')
--     l2 = display.newImage('l2.png', 0, 214)
--     l3 = display.newImage('l3.png', 0, 273)
--     l4 = display.newImage('l4.png', 0, 387)

--     -- Right Wall Parts
 
-- r1 = display.newImage('r1.png', 238, 0)
-- r2 = display.newImage('r2.png', 274, 214)
-- r3 = display.newImage('r3.png', 291, 273)
-- r4 = display.newImage('r4.png', 195, 387)

-- ball = display.newImage('ball.png', display.contentWidth * 0.5, 0)
-- hitLine1 = display.newImage('hitLine.png', 70, 28)
-- hitLine2 = display.newImage('hitLine.png', 110, 28)

-- -- Hit balls
 
-- hitBall1 = display.newImage('hitBall.png', 160, 186)
-- hitBall2 = display.newImage('hitBall.png', 130, 236)
-- hitBall3 = display.newImage('hitBall.png', 187, 236)
-- hitBall1.name = 'hBall'
-- hitBall2.name = 'hBall'
-- hitBall3.name = 'hBall'

-- pLeft = display.newImage('paddleL.png', 74, 425)
-- pRight = display.newImage('paddleR.png', 183, 425)
-- pLeft.name = 'leftPaddle'
-- pRight.name = 'rightPaddle'

-- lBtn = display.newImage('lBtn.png', 20, 425)
-- rBtn = display.newImage('rBtn.png', 260, 425)
-- lBtn.name = 'left'
-- rBtn.name = 'right'

-- -- Score TextField
 
-- score = display.newText('0', 2, 0, 'Marker Felt', 14)
-- score:setTextColor(255, 206, 0)

-- -- Left Wall Parts
 
-- physics.addBody(l1, 'static', {shape = {-40, -107, -11, -107, 40, 70, 3, 106, -41, 106}})
-- physics.addBody(l2, 'static', {shape = {-23, -30, 22, -30, 22, 8, 6, 29, -23, 29}})
-- physics.addBody(l3, 'static', {shape = {-14, -56, 14, -56, 14, 56, -14, 56}})
-- physics.addBody(l4, 'static', {shape = {-62, -46, -33, -46, 61, 45, -62, 45}})
 
-- -- Right Wall Parts
 
-- physics.addBody(r1, 'static', {shape = {10, -107, 39, -107, 40, 106, -5, 106, -41, 70}})
-- physics.addBody(r2, 'static', {shape = {-22, -30, 22, -30, 22, 29, -6, 29, -23, 9}})
-- physics.addBody(r3, 'static', {shape = {-14, -56, 14, -56, 14, 56, -14, 56}})
-- physics.addBody(r4, 'static', {shape = {32, -46, 61, -46, 61, 45, -62, 45}})

-- physics.addBody(ball, 'dynamic', {radius = 8, bounce = 0.4})
-- physics.addBody(hitLine1, 'static', {shape = {-20, -42, -15, -49, -6, -46, 18, 39, 15, 44, 5, 44, }})
-- physics.addBody(hitLine2, 'static', {shape = {-20, -42, -15, -49, -6, -46, 18, 39, 15, 44, 5, 44, }})
-- physics.addBody(hitBall1, 'static', {radius = 15})
-- physics.addBody(hitBall2, 'static', {radius = 15})
-- physics.addBody(hitBall3, 'static', {radius = 15})
-- physics.addBody(pRight, 'static', {shape = {-33, 11, 27, -12, 32, 1}})
-- physics.addBody(pLeft, 'static', {shape = {-33, 1, -28, -12, 32, 11}})

-- -- Top Wall
 
-- local topWall = display.newLine(display.contentWidth * 0.5, -1, display.contentWidth * 2, -1)
-- physics.addBody(topWall, 'static')
	
-- 	-- all display objects must be inserted into group
-- 	sceneGroup:insert( background )
-- 	sceneGroup:insert( titleLogo )
-- 	sceneGroup:insert( playBtn )
-- end

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
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene