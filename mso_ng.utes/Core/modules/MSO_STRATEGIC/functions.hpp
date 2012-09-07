class Strategic {
	file = "core\modules\MSO_STRATEGIC\functions";
	class getObjectsByType {
		description = "Returns objects by their P3D name for the entire map";
	};
	class getNearestObjectInCluster {
		description = "Returns the nearest object to the given object from a list of objects";
	};
	class findClusterCenter {
		description = "Return the centre position of an object cluster";
	};
	class chooseInitialCenters {
		description = "Use K-means++ to choose the initial centers";
	};
	class assignPointsToClusters {
		description = "Assign cluster objects to nearest cluster centre";
	};
	class findClusters {
		description = "Returns a list of object clusters";
	};
	class getEnterableHouses {
		description = "Returns an array of all enterable Houses in a given radius";
	};
	class getAllEnterableHouses {
		description = "Returns an array of all enterable Houses on the map";
	};
	class findNearHousePositions {
		description = "Provide a list of house positions in the area";
	};
	class findIndoorHousePositions {
		description = "Provide a list of indoor house positions in the area";
	};
	class getBuildingPositions {
		description = "Returns the building positions for a given object";
	};
	class isHouseEnterable {
		description = "Returns true if the building is enterable";
	};
};
