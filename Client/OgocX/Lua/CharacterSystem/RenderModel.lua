OpenFolder("Definitions")

--[[
Render your itens
--]]

local anyWingGhost = 0
local WingGhostStartImg = 50000

function StartLoadImages()
	for i = 0, 11 do
		LoadImage(string.format("Item\\fire_sq_%05d.jpg", i), WingGhostStartImg + i)
	end
	
	LoadImage("Item\\season_wing_period_render.jpg", 50020)
end

function RenderModelBody(BMDStruct, ObjectStruct, ItemIndex)
	--[[if (ItemIndex == GET_ITEM_MODEL(12, 202))
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)
		
		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			--Render Character
			Bmd:glColor3fv()

			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-6.0, 0.0) + 0.30

			if Vertex > 1.0
			then
				Vertex = 1.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)

			Bmd:RenderMesh(0, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), 50020)

			Bmd:SetLight(1.0, 0.80, 0.65)

			Bmd:RenderMesh(0, 68, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), 32042)

			Bmd:SetLight(0.40, 0.45, 1.0)

			Bmd:RenderMesh(1, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			Bmd:SetLight(0.25, 0.35, 1.0)

			Bmd:glColor3fv()

			Bmd:RenderMesh(2, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local AnyTex = worldTime()
			local TexCoordU = (math.floor((AnyTex % (15 * 40) / 40) % 4)) * 0.25
			local TexCoordV = (math.floor((AnyTex % (15 * 40) / 40) / 4)) * 0.25

			Bmd:SetLight(0.25, 0.35, 1.0)

			Bmd:RenderMesh(3, 66, Obj:Alpha(), 3, Obj:Light(), TexCoordU, TexCoordV, Obj:Hidden())

			Bmd:SetLight(0.40, 0.76, 0.95)

			local Textured = math.abs(math.floor(Obj:getTime()))

			Bmd:RenderMesh(4, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Textured + WingGhostStartImg)

			Obj:setTime(Obj:getTime() + 0.75)

			if (Obj:getTime() > 11.0)
			then
				Obj:setTime(0.0)
			end
		else
			--Render Inventory
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-6.0, 0.0) + 0.30

			if Vertex > 1.0
			then
				Vertex = 1.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)

			Bmd:RenderMesh(0, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), 50020)

			Bmd:SetLight(1.0, 0.80, 0.65)

			Bmd:RenderMesh(0, 68, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), 32042)

			Bmd:SetLight(0.40, 0.45, 1.0)

			Bmd:RenderMesh(1, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			Bmd:SetLight(0.25, 0.35, 1.0)

			Bmd:RenderMesh(2, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local AnyTex = worldTime()
			local TexCoordU = (math.floor((AnyTex % (15 * 40) / 40) % 4)) * 0.25
			local TexCoordV = (math.floor((AnyTex % (15 * 40) / 40) / 4)) * 0.25

			Bmd:SetLight(0.25, 0.35, 1.0)

			Bmd:RenderMesh(3, 66, Obj:Alpha(), 3, Obj:Light(), TexCoordU, TexCoordV, Obj:Hidden())

			Bmd:SetLight(0.40, 0.76, 0.95)

			local Textured = math.abs(math.floor(anyWingGhost))

			Bmd:RenderMesh(4, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Textured + WingGhostStartImg)

			Bmd:SetLight(1.00, 1.00, 1.00)

			Bmd:glColor3fv()

			Bmd:RenderMesh(5, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			anyWingGhost = anyWingGhost + 0.50

			if anyWingGhost > 11.0
			then
				anyWingGhost = 0.0
			end
		end
		
		Bmd = nil
		Obj = nil
		collectgarbage()
		return 1
	end--]]
	
	return 0
end

function RenderModelBodyColor(BMDStruct, ObjectStruct, ItemIndex)
	--[[if (ItemIndex == GET_ITEM_MODEL(12, 202))
	then
		return 1
	end--]]
	
	return 0
end

function RenderModelBodyColor2(BMDStruct, ObjectStruct, ItemIndex)
	--[[if (ItemIndex == GET_ITEM_MODEL(12, 202))
	then
		return 1
	end--]]
	
	return 0
end