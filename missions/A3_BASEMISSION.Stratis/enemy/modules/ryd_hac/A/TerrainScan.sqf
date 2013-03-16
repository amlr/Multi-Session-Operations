

_position = _this select 0;

_posX = _position select 0;
_posY = _position select 1;



_radius = 5;
_precision = 1;
_sourcesCount = 1;

_expression = "Houses";

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];


_city = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_city0 = _city select 0;
_city0 = _city0 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_city = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_city1 = _city select 0;
_city1 = _city1 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_city = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_city2 = _city select 0;
_city2 = _city2 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_city = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_city3 = _city select 0;
_city3 = _city3 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_city = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_city4 = _city select 0;
_city4 = _city4 select 1;

_city = (_city0 + _city1 + _city2 + _city3 + _city4)/5; 

_expression = "Trees";

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_trees = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_trees0 = _trees select 0;
_trees0 = _trees0 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_trees = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_trees1 = _trees select 0;
_trees1 = _trees1 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_trees = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_trees2 = _trees select 0;
_trees2 = _trees2 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_trees = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_trees3 = _trees select 0;
_trees3 = _trees3 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_trees = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_trees4 = _trees select 0;
_trees4 = _trees4 select 1;

_trees = (_trees0 + _trees1 + _trees2 + _trees3 + _trees4)/5; 


_expression = "Forest";

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_forest = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_forest0 = _forest select 0;
_forest0 = _forest0 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_forest = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_forest1 = _forest select 0;
_forest1 = _forest1 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_forest = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_forest2 = _forest select 0;
_forest2 = _forest2 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_forest = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_forest3 = _forest select 0;
_forest3 = _forest3 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_forest = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_forest4 = _forest select 0;
_forest4 = _forest4 select 1;

_forest = (_forest0 + _forest1 + _forest2 + _forest3 + _forest4)/5; 


_expression = "Hills";

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_hills = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_hills0 = _hills select 0;
_hills0 = _hills0 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_hills = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_hills1 = _hills select 0;
_hills1 = _hills1 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_hills = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_hills2 = _hills select 0;
_hills2 = _hills2 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_hills = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_hills3 = _hills select 0;
_hills3 = _hills3 select 1;

_position = [_posX + random 10 - random 10,_posY + random 10 - random 10];

_hills = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];

_hills4 = _hills select 0;
_hills4 = _hills4 select 1;

_hills = (_hills0 + _hills1 + _hills2 + _hills3 + _hills4)/5; 

RydHQ_ScanCity = _city;
RydHQ_ScanTrees = _trees;
RydHQ_ScanForest = _forest;
RydHQ_ScanHills = _hills;
RydHQ_Scan = true;