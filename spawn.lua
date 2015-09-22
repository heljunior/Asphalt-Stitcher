I have seen a lot of posts on the forums regarding spawning of objects/display images. Some of you are having problems and others missing some key aspects regarding spawning.

This is going to be a little tutorial that explains how to spawn objects properly and allow you to manage each individually spawned object.


Hey guys & gals.
I have seen a lot of posts on the forums regarding spawning of objects/display images. Some of you are having problems and others missing some key aspects regarding spawning.
This is going to be a little tutorial that explains how to spawn objects properly and allow you to manage each individually spawned object.

The concept :
The concept of spawning is to create multiple copies of a single object with each copy having it’s own individual parameters that are accessible from anywhere.

How to do it :
First things first, here is a basic spawning example that is incorrect :


local function spawn()
local object = display.newImage(“myImage.png”)
end

Why is this wrong? Well here is why. This function will create a new copy of “myImage.png” each time it is called, however the only place that it is stored is in the object variable which is created each time the function is run and local only to that function. So after spawning the object you have no way of manipulating it.
To fix this you return the object and assign it to a variable :


--Function to spawn an object
local function spawn()
local object = display.newImage(“myImage.png”)
return object
end

--Create a table to hold our spawns
local spawnTable = {}

--Spawn two objects
for i = 1, 2 do
spawnTable[i] = spawn()
end

Now that you have returned the object and assigned it to a table index, each object is now unique and can be accessed by the table :


print(spawnTable[1])
print(spawnTable[2])

The code is still pretty rigid and unusable for most purposes at present, now we will introduce the power of function parameters :


--Function to spawn an object
local function spawn(params)
local object = display.newImage(params.image)

return object
end

Now we can spawn like so:


local spawn1 = spawn(
{
image = "myImage.png"
}
)

local spawn2 = spawn(
{
image = "myImage2.png"
}
)

So we now know how to spawn an image, return it so it becomes a unique object and also have a little knowledge about using function parameters. Now lets get a little bit more advanced. Why should we have to manually copy the references to a table when we can let the function do it for us?


--Create a table to hold our spawns
local spawnTable = {}

--Function to spawn an object
local function spawn(params)
local object = display.newImage(params.image)
--Set the objects table to a table passed in by parameters
object.objTable = params.objTable
--Automatically set the table index to be inserted into the next available table index
object.index = #object.objTable + 1

--Give the object a custom name
object.myName = "Object : " .. object.index

--Insert the object into the table at the specified index
object.objTable[object.index] = object

return object
end

Now when you call the spawn function you can clearly see the magic in action :


--Create 2 spawns
for i = 1, 2 do
local spawns = spawn(
{
image = "myImage.png",
objTable = spawnTable,
}
)
end

--Now print the names of both created spawns
for i = 1, #spawnTable do
print(spawnTable[i].myName)
end

Now you can see that the output has printed :


Object : 1
Object : 2

So the function now takes care of inserting the spawn into a table and giving it a unique index. This is only the beggining though, what if you also wanted to automatically insert it into a group passed by parameters?


--Function to spawn an object
local function spawn(params)
local object = display.newImage(params.image)
--Set the objects table to a table passed in by parameters
object.objTable = params.objTable
--Automatically set the table index to be inserted into the next available table index
object.index = #object.objTable + 1

--Give the object a custom name
object.myName = "Object : " .. object.index

--The objects group
object.group = params.group or nil

--If the function call has a parameter named group then insert it into the specified group
object.group:insert(object)

--Insert the object into the table at the specified index
object.objTable[object.index] = object

return object
end

Now all we have to do to automatically insert it into a chosen group is this:


local localGroup = display.newGroup()

--Create a table to hold our spawns
local spawnTable = {}

--Create 2 spawns
for i = 1, 2 do
local spawns = spawn(
{
image = "myImage.png",
objTable = spawnTable,
group = localGroup,
}
)
end

Easy or what? Now the spawn function can automatically insert the spawn into a table, into a group and give it a unique index. How about if we wanted certain objects to also have a physical body?


--Function to spawn an object
local function spawn(params)
local object = display.newImage(params.image)
--Set the objects table to a table passed in by parameters
object.objTable = params.objTable
--Automatically set the table index to be inserted into the next available table index
object.index = #object.objTable + 1

--Give the object a custom name
object.myName = "Object : " .. object.index

--If the object should have a body create it, else dont.
if params.hasBody then
--Allow physics parameters to be passed by parameters:
object.density = params.density or 0
object.friction = params.friction or 0
object.bounce = params.bounce or 0
object.isSensor = params.isSensor or false
object.bodyType = params.bodyType or "dynamic"

physics.addBody(object, object.bodyType, {density = object.density, friction = object.friction, bounce = object.bounce, isSensor = object.isSensor})
end

--The objects group
object.group = params.group or nil

--If the function call has a parameter named group then insert it into the specified group
object.group:insert(object)

--Insert the object into the table at the specified index
object.objTable[object.index] = object

return object
end

So basically what we have done there is add an extra parameter that basically says, if a parameter named “hasBody” is passed then add a body with specified paramenters. If those paramenters don’t exist then revert to default parameters.

Here it is in action :


local localGroup = display.newGroup()

--Create a table to hold our spawns
local spawnTable = {}

--Create 2 spawns
for i = 1, 2 do
local spawns = spawn(
{
image = "myImage.png",
objTable = spawnTable,
hasBody = true,
friction = 0.4,
bounce = 0.4,
bodyType = "static",
group = localGroup,
}
)
end

Now we have created a spawn with a physical body. Notice how I ommited some parameters? Thats the beauty of using parameters. You don’t *have* to explicitly call them. I was happy with density being 0 so I didn’t specify it, i didnt want the object to be a sensor so i didn’t specify it, so it reverted to the default of false.

Using the parameter technique you can make hugely powerful functions (not just limited to spawning). You can push out as much or as little as you want to parameters and customize an individual spawn easilly by setting up a solid spawn function that takes care of the dirty work for you.

Hope this helps you all, any questions feel free to ask via comments :)