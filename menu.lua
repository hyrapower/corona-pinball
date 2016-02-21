--Menu

local composer = require( "composer" )
local scene = composer.newScene()

-- Physics

local physics = require('physics')
physics.start()
--physics.setDrawMode('hybrid')

-- Widget
local widget = require "widget"


-- [Credits]

--local creditsView
local credit


-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
		-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function onCredBtnRelease()
		-- close credit window
		credit:removeSelf()
		credit = nil
	return true
end

local function onCredBtnPress()
		--open credit window
		credit = display.newImage('credits.png', display.contentCenterx, display.contentCenterY)
		credit.x = 250
		credit.y = 250
		credit:setFillColor(1,0,0)
	return true
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
	background.width = display.actualContentWidth
	background.height = display.actualContentHeight
	
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

	-- create widget button for credits (loads on release)
	credBtn = widget.newButton{
		label="Credits",
		labelColor= { default={255}, over={128} },
		default="creditsBtn.png",
		over="creditsBtn.png",
		width=154, height=40,
		onPress = onCredBtnPress, -- event listener function
		onRelease = onCredBtnRelease -- event listener function
	}
	credBtn.x = 250
	credBtn.y = 700

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( credBtn )
	--titleBg = display.newImage('title.png', display.contentCenterX - 97, 96)
	--playBtn = display.newImage('playBtn.png', display.contentCenterX - 30, display.contentCenterY + 10)
	--creditsBtn = display.newImage('creditsBtn.png', display.contentCenterX - 44.5, display.contentCenterY + 65)
	--titleView = display.newGroup(titleBg, playBtn, creditsBtn)
	
	--startButtonListeners('add')

	 --transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') display.remove(titleView) titleView = nil end})
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

	if credBtn then
		credBtn:removeSelf()
		credBtn = nil
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