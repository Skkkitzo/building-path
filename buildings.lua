local mod = ...

-- register asset ids
mod:registerAssetId("models/test.fbx/Prefab/buildingPart", "PREFAB_TEST")
mod:registerAssetId("models/test.fbx/Prefab/Construction_Steps", "PREFAB_TEST_CONSTRUCTION")

-- register asset processor (for paths)
mod:registerAssetProcessor("models/test.fbx", { DataType = "BUILDING_ASSET_PROCESSOR" })

-- register our basic building (white cube)
mod:register({
	DataType = "BUILDING",
	Id = "TEST",
	Name = "TEST_NAME",
	Description = "TEST_DESC",
	BuildingType = "GENERAL",
	BuildingPartSetList = {
		{
			Name = "GENERAL",
	        BuildingPartList = { "TEST_PART" }
    	}
	}
})

-- register the required building part
mod:register({
	DataType = "BUILDING_PART",
	Id = "TEST_PART",
	ConstructorData = {
		DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
		CoreObjectPrefab = "PREFAB_TEST"
	},
	BuildingZoneData = {
		Polygon = polygon.createRectangle({ 2, 2 })
	},
	ConstructionVisual = "PREFAB_TEST_CONSTRUCTION",
	BuildingFunction = "TEST_FUNCTION",
	Cost = {
		RessourcesNeeded = {
			{ Resource = "WOOD", Quantity = 1 }
		}
	}
})

-- set the building's function
mod:register({
    DataType = "BUILDING_FUNCTION_WORKPLACE",
    Id = "TEST_FUNCTION",
	Name = "TEST_FUNCTION_NAME",
    WorkerCapacity = 2,
	RelatedJob = { Job = "CARPENTER", Behavior = "WORK_BEHAVIOR" },
	InputInventoryCapacity = {{ Resource = "WOOD", Quantity = 50 }},
	ResourceListNeeded = {{ Resource = "WOOD", Quantity = 1 }},
	ResourceProduced = {{ Resource = "BREAD", Quantity = 1 }}	
})

-- remove the grass in surrounding area
mod:registerPrefabComponent("models/test.fbx/Prefab/buildingPart", {
	DataType = "COMP_DIRT_RECTANGLE",
	Size = {2, 2}
})

-- ground the building part
mod:registerPrefabComponent("models/test.fbx/Prefab/buildingPart", {
	DataType = "COMP_GROUNDED"
})