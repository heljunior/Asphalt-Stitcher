local composer = require( "composer" )

local scene = composer.newScene()

composer.recycleOnSceneChange = true


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

print("this is the game file")
-- "scene:create()"
function scene:create( event )

    --LOCAL GROUP
    local sceneGroup = self.view

    --STARTING PHYSICS
    local physics = require "physics"
    
    physics.start()
    physics.setGravity( 0, 0 )
    
    print("physics is running")

    

    --BACKGROUND
    local background = {}


    background[5] = display.newRect(350,667, 600, 1334)
    background[5]:setFillColor(0.7)
    background[5].speed = 20
    sceneGroup:insert(background[5])


    background[6] = display.newRect(350,-667,600,1334)
    background[6]:setFillColor(0.9)
    background[6].speed = 20
    sceneGroup:insert(background[6])

    background[3] = display.newRect(350,667, 500, 1334)
    background[3]:setFillColor(0.5)
    background[3].speed = 22
    sceneGroup:insert(background[3])

    background[4] = display.newRect(350,-667,500,1334)
    background[4]:setFillColor(0.6)
    background[4].speed = 22
    sceneGroup:insert(background[4])


    background[1] = display.newImage("road.jpg",350,667)
    background[1].speed = 25
    sceneGroup:insert(background[1])

    background[2] = display.newImage("roadcopy.jpg", 350,-667)
    background[2].speed = 25
    sceneGroup:insert(background[2])


    --POSICOES OBJETOS
    --POSICOES DOS NOVOS SPAWNS
    local positionX = {}
    positionX[1] = 162.5
    positionX[2] = 287.5
    positionX[3] = 412.5
    positionX[4] = 537.5

    local positionY = {}
    for i=1,20,1 do
        positionY[i] = -i*100
    end


    --OBJECTS 
    local moto = display.newImage("moto.png", 412.5, 1100)
    physics.addBody( moto, "dynamic", { density = .1, bounce=0.0, friction=0.3 } )
    moto.type = "main"
    moto.alive = true
    moto.x = positionX[math.random(1,4)]
    moto.y = 1100
    sceneGroup:insert(moto)

    local car1 = {
    obstaclecar = "obstaclecar1.png", 
    speed = math.random(10, 14),
    objectType = "enemy"
    }

    local car2 = {
    obstaclecar = "obstaclecar2.png", 
    speed = math.random(11, 15),
    objectType = "enemy",
    }

    local car3 = {
    obstaclecar = "obstaclecar3.png",
    speed = math.random(12, 16),
    objectType = "enemy"
    }
    local car4 = {
    obstaclecar = "obstaclecar4.png", 
    speed = math.random(13, 17),
    objectType = "enemy"
    }

    local obstacleCarList = {}
    obstacleCarList[1] = car1
    obstacleCarList[2] = car2
    obstacleCarList[3] = car3
    obstacleCarList[4] = car4

    --SCORE 
    local scoreValue = 0
    local finalScore = 0

    --GAME FUNCTIONS
    function spawnCarSet(param)
    if param == 1 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[5])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[2])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[8])

    end
    if param == 2 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[4])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[5])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[1])
    end
    if param == 3 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[2])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[8])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[6])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[7])
    
    end
    if param == 4 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[5])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[2])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[6])
    end
    if param == 5 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[6])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[2])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[6])
    end
    if param == 6 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[6])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[2])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
    end
    if param == 7 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[3])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[9])
    
    end
    if param == 8 then
        print("Caso: ", param)
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[5])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[2])
    spawnCar(obstacleCarList[math.random(1,4)], positionX[4], positionY[6])
    end
    
end
    
local pauseButton = display.newImage("pausebutton.png", 500, 100)
sceneGroup:insert(pauseButton)

local function pausedGame(event)
    -- body
    print("game has been paused")
     
end

pauseButton:addEventListener("tap", pausedGame)

--[[local function pause(event)
        print("pause button has been tapped")
        
        composer.showOverlay( "pause", {isModal = true} )

        return true
    end
    pauseButton:addEventListener("tap", pause)

]]--
local scoreText = display.newText(scoreValue, 100, 100)
scoreText:setFillColor(0,0,0)
sceneGroup:insert(scoreText)

    function parallaxScroll1(self, event)

        if  self.y > 1900 then
        
            self.y = -666

        else
            self.y = self.y + self.speed
            scoreValue = scoreValue + 1
        if (scoreValue % 100) == 0 then
            scoreText.text = scoreValue
        end

        if (scoreValue % 200) == 0 then
            spawnCarSet(math.random(1,8))
        end

    -- body
        end
    end


    function parallaxScroll2(self, event)
        if  self.y > 1970 then
            self.y = -666
        else
            self.y = self.y + self.speed
        -- body
        end
    end
    --SCROLL BACKGROUND 2
    function parallaxScroll3(self, event)
        if  self.y > 1970 then

            self.y = -666
        else
            self.y = self.y + self.speed
        -- body
        end
    end

    function parallaxScrollObstacleFixed(self, event)
        if self.y > 1500 then

            self.y = positionY[math.random(1,5)]
            obstacleposition = math.random(1,4)
            self.speed = math.random(18, 20)
            self.x = positionX[math.random(1,4)]

        else
         self.y = self.y + self.speed

    -- body
        end
    end

    function checkSwipeDirection()
        xDistance =  math.abs(endSwipeX - beginSwipeX)
        if beginSwipeX > endSwipeX then
            if moto.x >= 287.5 then
            transition.moveBy( moto, { x=-125,  time=150 } )
            print("swipe left: ", moto.x)
            else
            print("left limit reached")
            end
        else
            if moto.x <= 412.5 then
            transition.moveBy( moto, { x=125,  time=150 } )
            print("swipe right: ", moto.x)
            else
            print("right limit reached")
            end
        end
    end

    function swipe(event)
        if  event.phase == "began" then
            beginSwipeX = event.x
        end
        if  event.phase == "ended" then
            endSwipeX = event.x
            checkSwipeDirection()
        end
    end

--DETECTAR COLISAO
function onCollision(event)

    local type1 = event.object1.type
    local type2 = event.object2.type
        if (type1 == "main" and type2 == "enemy") then
        
        print("you lost")
                
            finalScore = scoreValue
            --sceneGroup:remove(scoreText)

            finalScoreText = display.newText(finalScore, 200, 100)
            finalScoreText:setFillColor(0, 0, 0)
            sceneGroup:insert(finalScoreText)
            print("Your final score is: ", finalScore)
            
            
            Runtime:removeEventListener("touch", swipe)

            background[1].speed = 5
            background[2].speed = 5
        print("final score: ", scoreValue)
        
        composer.gotoScene("gameover", {effect = "fade"})
        
        end
        if (type1 == "enemy" and type2 == "enemy") then  
            print("there was a collision between two obstacles")
        end

        if (type1 == "bomb" and type2 == "enemy") then
            event.object1:removeSelf()
            Runtime:removeEventListener("enterFrame", event.object1)
            event.object2:removeSelf()
            Runtime:removeEventListener("enterFrame", event.object2)
        end


end

function setSpeed() -- speed level
    
    speedLevel = math.random(13, 15)

    if (scoreValue > 1000) then
        speedLevel = (scoreValue / 1000) + math.random(11, 13)
    end
    return speedLevel
end

function spawnCar (param, x, y)

local newObstacleCar = display.newImage(param.obstaclecar, x, y)
newObstacleCar.speed = setSpeed()
newObstacleCar.type = param.objectType
--newObstacleCar.isFixedRotation = true
physics.addBody( newObstacleCar, "dynamic", { density=.1, bounce=0.0, friction=0.3 } )
newObstacleCar.enterFrame = parallaxScrollObstacleCar
sceneGroup:insert(newObstacleCar)
Runtime:addEventListener("enterFrame", newObstacleCar)
--print("A new car was spawned. The speed is: " , newObstacleCar.speed)

end

function parallaxScrollObstacleCar(self, event)
    if self.y > 1450 then
        
        self:removeSelf()
        Runtime:removeEventListener("enterFrame", self)
                
    else
    self.y = self.y + self.speed
        
    -- body
    end
end


function startGame()
print("this is from start game")
background[1].enterFrame = parallaxScroll1
Runtime:addEventListener("enterFrame", background[1])

background[3].enterFrame = parallaxScroll2
Runtime:addEventListener("enterFrame", background[3])

background[5].enterFrame = parallaxScroll3
Runtime:addEventListener("enterFrame", background[5])

background[2].enterFrame = parallaxScroll1
Runtime:addEventListener("enterFrame", background[2])

background[4].enterFrame = parallaxScroll2
Runtime:addEventListener("enterFrame", background[4])

background[6].enterFrame = parallaxScroll3
Runtime:addEventListener("enterFrame", background[6])


Runtime:addEventListener("touch", swipe)

Runtime:addEventListener("collision", onCollision)

end

function pauseGame()
    print("this is from pause game")

    Runtime:removeEventListener("enterFrame", background[1])

    Runtime:removeEventListener("enterFrame", background[3])

    Runtime:removeEventListener("enterFrame", background[5])

    Runtime:removeEventListener("enterFrame", background[2])

    Runtime:removeEventListener("enterFrame", background[4])

    Runtime:removeEventListener("enterFrame", background[6])

    Runtime:removeEventListener("touch", swipe)

    Runtime:removeEventListener("collision", onCollision)


end
    

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
        startGame()

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
        
   pauseGame()

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