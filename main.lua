-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
--
-- main.lua
--apenas para mostrar o atual codigo em funcionamento, menus e cenas ficaram na outra versao
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local physics = require "physics"

physics.start()
physics.setGravity( 0, 0 )

--FUNDOS DE TELA
local background = {}


background[5] = display.newRect(350,667, 600, 1334)
background[5]:setFillColor(0.7)
background[5].speed = 20

background[6] = display.newRect(350,-667,600,1334)
background[6]:setFillColor(0.9)
background[6].speed = 20

background[3] = display.newRect(350,667, 500, 1334)
background[3]:setFillColor(0.5)
background[3].speed = 22

background[4] = display.newRect(350,-667,500,1334)
background[4]:setFillColor(0.6)
background[4].speed = 22


background[1] = display.newImage("road.jpg",350,667)
background[1].speed = 25

background[2] = display.newImage("roadcopy.jpg", 350,-667)
background[2].speed = 25


--OBJETOS
--PRINCIPAL
local car = display.newImage("moto.png", 412.5, 1100)
physics.addBody( car, "dynamic", { density = .1, bounce=0.0, friction=0.3 } )
car.type = "main"
car.alive = true

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


--OBSTACULOS

local car1 = {
obstaclecar = "obstaclecar1.png", 
speed = math.random(8, 12),
objectType = "enemy"
}

local car2 = {
obstaclecar = "obstaclecar2.png", 
speed = math.random(9, 13),
objectType = "enemy",
}

local car3 = {
obstaclecar = "obstaclecar3.png",
speed = math.random(10, 14),
objectType = "enemy"
}
local car4 = {
obstaclecar = "obstaclecar4.png", 
speed = math.random(11, 15),
objectType = "enemy"
}

local obstacleCarList = {}
obstacleCarList[1] = car1
obstacleCarList[2] = car2
obstacleCarList[3] = car3
obstacleCarList[4] = car4



local crate = display.newImage("crate.png", 537.5, -1100)
crate.speed = math.random(19, 22)
physics.addBody( crate, "static", { density = .1, bounce=0.0, friction=0.3 } )
crate.type = "enemy"

--SCORE
local scoreValue = 0




-- FUNCOES
--efeito scroll parallax
--SCROLL DA RUA


function parallaxScroll1(self, event)
	if self.y > 1900 then
		
		self.y = -666
	else
	self.y = self.y + self.speed
	scoreValue = scoreValue + 1
	if (scoreValue % 100) == 0 then
		print("score: ",scoreValue)
	end

	-- body
	end

end
--SCROLL BACKGROUND 1
function parallaxScroll2(self, event)
	if self.y > 1970 then
		self.y = -666
	else
	self.y = self.y + self.speed
	-- body
	end
end
--SCROLL BACKGROUND 2
function parallaxScroll3(self, event)
	if self.y > 1970 then

		self.y = -666
	else
	self.y = self.y + self.speed
	-- body
	end
end
--SCROLL DE OBSTACULOS DO TIPO CARRO
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



--DETECTAR DIRECAO DE SWIPE
local beginSwipeX
local endSwipeX

local distanceX

function checkSwipeDirection()
xDistance =  math.abs(endSwipeX - beginSwipeX)
if beginSwipeX > endSwipeX then
	if car.x >= 287.5 then
	transition.moveBy( car, { x=-125,  time=200 } )
	print("swipe left: ", car.x)
	else
	print("left limit reached")
	end
else
	if car.x <= 412.5 then
	transition.moveBy( car, { x=125,  time=200 } )
	print("swipe right: ", car.x)
	else
	print("right limit reached")
	end
end
end

function swipe(event)
	if event.phase == "began" then
		beginSwipeX = event.x
	end
	if event.phase == "ended" then
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
			car.alive = false
			car:removeSelf()
			
			crate:removeSelf()

			Runtime:removeEventListener("enterFrame", car)
			
			Runtime:removeEventListener("enterFrame", crate)
			Runtime:removeEventListener("touch", swipe)

			background[1].speed = 5
			background[2].speed = 5
		print("final score: ", scoreValue)
		local caixaTexto = display.newRect(350, 667, 250, 50)
		caixaTexto:setFillColor(1, 0.5, 0.5)
		local texto = display.newText("VOCE PERDEU", 350, 667 )
		texto:setFillColor(1, 0.2, 0.2, 1)
		end
		if (type1 == "enemy" and type2 == "enemy") then  
			print("there was a collision between two obstacles")
			event.object1.speed = math.random(8,10)
			event.object2.speed = event.object1.speed
		end


end

function spawnCar (param, x, y)

local newObstacleCar = display.newImage(param.obstaclecar, x, y)
newObstacleCar.speed = param.speed
newObstacleCar.type = param.objectType
newObstacleCar.isFixedRotation = true
physics.addBody( newObstacleCar, "dynamic", { density=.1, bounce=0.0, friction=0.3 } )
newObstacleCar.enterFrame = parallaxScrollObstacleCar
Runtime:addEventListener("enterFrame", newObstacleCar)
print("A new car was spawned. The y is: " , newObstacleCar.y)
print("A new car was spawned. The x is: " , newObstacleCar.x)

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

function spawnCarSet(param)
	if param == 1 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[5])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[2])
	end
	if param == 2 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[5])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[5])
	end
	if param == 3 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[7])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[3])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[6])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
	end
	if param == 4 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[6])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
	end
	if param == 5 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[6])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
	end
	if param == 6 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[6])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
	end
	if param == 7 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[6])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
	end
	if param == 8 then
		print("Caso: ", param)
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[1], positionY[6])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[1])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[2], positionY[4])
	spawnCar(obstacleCarList[math.random(1,4)], positionX[3], positionY[7])
	end
	
end
function startGame()
print("this is from start game")
spawnCarSet(math.random(1,8))
end

--EVENTOS
--EVENTOS BACKGROUND
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

startGame()
