local composer = require( "composer" )

local scene = composer.newScene()

composer.recycleOnSceneChange = true

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


print("this is the gameover file")
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view


    local gameOverText = display.newText("PAUSE", 370, 300 )
    sceneGroup:insert(gameOverText)

    local backButton = display.newImage("backbutton.png", 370, 1100)
    sceneGroup:insert(backButton)

    local function resume(event)
        print("back button has been pressed")
        composer.hideOverlay()
        return true
    end

    backButton:addEventListener("tap", resume)

    local restartButton = display.newImage("restartbutton.png", 370, 900)
    sceneGroup:insert(restartButton)

    local function restart(event)
        print("restart button has been pressed")
        composer.gotoScene("game", {effect = "fade"})

    end

    restartButton:addEventListener("tap", restart)


    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene