local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")

local workspaceWhitelist = {}
local mapWhitelist = {}

local function add(tbl, obj)
	if obj then
		tbl[obj] = true
	end
end

local function findPath(...)
	local current = workspace

	for _, name in ipairs({...}) do
		current = current:FindFirstChild(name)
		if not current then
			return nil
		end
	end

	return current
end

local function rebuildWhitelist()
	table.clear(workspaceWhitelist)
	table.clear(mapWhitelist)

	add(workspaceWhitelist, workspace:FindFirstChild("Camera"))
	add(workspaceWhitelist, workspace:FindFirstChild("Terrain"))
	add(workspaceWhitelist, workspace:FindFirstChild("Debris"))
	add(workspaceWhitelist, workspace:FindFirstChild("Plots"))
	add(workspaceWhitelist, workspace:FindFirstChild("RenderedMovingAnimals"))

	add(workspaceWhitelist, findPath("Map"))

	add(mapWhitelist, findPath("Map", "WallModels"))
	add(mapWhitelist, findPath("Map", "__StreamCheck_DontDelete"))
	add(mapWhitelist, findPath("Map", "Carpet"))
	add(mapWhitelist, findPath("Map", "Ground"))
	add(mapWhitelist, findPath("Map", "Ground_Left"))
	add(mapWhitelist, findPath("Map", "Ground_Right"))
end

local function isUUID(name)
	return name:match(
		"^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"
	) ~= nil
end

-- One-time AnimationController removal
local function removeAnimationControllers()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("AnimationController") then
			pcall(function()
				obj:Destroy()
			end)
		end
	end
end

-- One-time visual cleanup
local function removeVisuals()
	for _, obj in ipairs(workspace:GetDescendants()) do
		pcall(function()

			if obj:IsA("Texture")
			or obj:IsA("Decal")
			or obj:IsA("SurfaceAppearance") then

				obj:Destroy()

			elseif obj:IsA("SpecialMesh") then
				obj.TextureId = ""

			elseif obj:IsA("MeshPart") then
				obj.TextureID = ""
				obj.CastShadow = false

			elseif obj:IsA("ParticleEmitter")
			or obj:IsA("Trail")
			or obj:IsA("Beam")
			or obj:IsA("Fire")
			or obj:IsA("Smoke")
			or obj:IsA("Sparkles")
			or obj:IsA("Highlight")
			or obj:IsA("Explosion")
			or obj:IsA("PointLight")
			or obj:IsA("SpotLight")
			or obj:IsA("SurfaceLight") then

				obj:Destroy()

			elseif obj:IsA("BasePart") then
				obj.CastShadow = false
				obj.Material = Enum.Material.Plastic
				obj.MaterialVariant = ""
				obj.Reflectance = 0
			end

		end)
	end
end

local function cleanMap()
	local map = workspace:FindFirstChild("Map")
	if not map then
		return
	end

	for _, obj in ipairs(map:GetChildren()) do
		if not mapWhitelist[obj] then
			obj:Destroy()
		end
	end
end

local function cleanWorkspace()
	rebuildWhitelist()

	for _, obj in ipairs(workspace:GetChildren()) do
		if not workspaceWhitelist[obj] then
			if not isUUID(obj.Name)
			and not Players:FindFirstChild(obj.Name) then
				obj:Destroy()
			end
		end
	end

	cleanMap()
end

local function cleanLighting()
	for _, obj in ipairs(Lighting:GetChildren()) do
		if obj:IsA("PostEffect")
		or obj:IsA("Atmosphere")
		or obj:IsA("Clouds") then
			obj:Destroy()
		end
	end
end

-- Initial cleanup
removeAnimationControllers()
removeVisuals()
cleanWorkspace()
cleanLighting()

-- Constant guards
workspace.DescendantAdded:Connect(function(obj)
	task.defer(function()
		if obj:IsA("Texture")
		or obj:IsA("Decal")
		or obj:IsA("SurfaceAppearance")
		or obj:IsA("ParticleEmitter")
		or obj:IsA("Trail")
		or obj:IsA("Beam")
		or obj:IsA("Fire")
		or obj:IsA("Smoke")
		or obj:IsA("Sparkles")
		or obj:IsA("Highlight")
		or obj:IsA("AnimationController") then

			pcall(function()
				obj:Destroy()
			end)
		end
	end)
end)

Lighting.DescendantAdded:Connect(function(obj)
	if obj:IsA("PostEffect")
	or obj:IsA("Atmosphere")
	or obj:IsA("Clouds") then
		pcall(function()
			obj:Destroy()
		end)
	end
end)

MaterialService.DescendantAdded:Connect(function(obj)
	pcall(function()
		obj:Destroy()
	end)
end)

while task.wait(2) do
	cleanWorkspace()
	cleanLighting()
end
