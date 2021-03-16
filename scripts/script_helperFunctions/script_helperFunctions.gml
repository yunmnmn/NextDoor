// Returns the width and height from a sprite index
function GetSpriteSize(p_spriteIndex)
{	
	assert(p_spriteIndex != noone, "spriteIndex is invalid");
	return new Vector2(sprite_get_width(p_spriteIndex), sprite_get_height(p_spriteIndex));
}

// Returns the world position of the instance
function GetWorldPosition(p_instanceIndex)
{
	assert(p_instanceIndex != noone, "instanceIndex is invalid");
	return new Vector2(p_instanceIndex.x, p_instanceIndex.y);
}

// Returns the delta time in miliseconds rather than the default (microsecond)
function DeltaTimeInMiliseconds()
{
	return delta_time / 1000;
}

// Calculate the average delta time over frames
global.averageDeltaTimeInMiliseconds = noone;
function AverageDeltaTimeInMiliseconds()
{
	if(global.averageDeltaTimeInMiliseconds == noone)
	{
		global.averageDeltaTimeInMiliseconds = DeltaTimeInMiliseconds();
	}
	else
	{
		var dt = DeltaTimeInMiliseconds();
		global.averageDeltaTimeInMiliseconds = (dt + global.averageDeltaTimeInMiliseconds) * 0.5;
	}
}

function GetAverageDeltaTimeInMiliseconds()
{
	return global.averageDeltaTimeInMiliseconds;
}

// Play a timeline
function PlayTimeline(p_timelineIndex)
{
	timeline_index = p_timelineIndex;
	timeline_position = 0;
	timeline_speed = GetAverageDeltaTimeInMiliseconds();
	timeline_running = true;
}

// Play a timeline
function StopTimeline()
{
	timeline_index = noone;
	timeline_position = 0;
	timeline_speed = 0;
	timeline_running = false;
}

// Converts the pixel distance to path distance
function GetPathDistanceFromPixels(p_pathIndex, p_pixels)
{
	var onePixel = 1.0 / path_get_length(p_pathIndex)
	return onePixel * p_pixels;
}

function SnapToClosestPathIndex(p_pathIndex, p_pathPoint)
{
	var xPos = path_get_point_x(p_pathIndex, p_pathPoint);
    var yPos = path_get_point_y(p_pathIndex, p_pathPoint);
	
	return SnapToClosestPosition(p_pathIndex, xPos, yPos);
}

// Finds the normalized path position from the room position
function SnapToClosestPosition(p_pathIndex, p_positionX, p_positionY)
{
	assert(p_pathIndex != noone, "Path is invalid");
	assert(path_get_kind(p_pathIndex) == false, "Path is curved, this function doesn't support that");
	
	var pathNodeCount = path_get_number(p_pathIndex);
	assert(pathNodeCount > 1, "Path only has one node, must have atleast 2");
	
	var MimiX = p_positionX;
	var MimiY = p_positionY;
	
	// TODO: find the max float number
	var minDistance = 999999999.0;
	var pointX = 0.0;
	var pointY = 0.0;
	var nodeIndex = 0;
	for(var i = 0; i < pathNodeCount-1; i++)
	{
		// Current node's position
		var currentNodeX = path_get_point_x(p_pathIndex, i);
		var currentNodeY = path_get_point_y(p_pathIndex, i);
		
		// Next node's position 
		var nextNodeX = path_get_point_x(p_pathIndex, i+1);
		var nextNodeY = path_get_point_y(p_pathIndex, i+1);
		
		// HACK: make sure mimi and the current node aren't on the same position
		if(MimiX == currentNodeX)
		{
			MimiX += 0.0001;
		}
		if(MimiY == currentNodeY)
		{
			MimiY += 0.0001;
		}
		
		// Calculate the currentNOde -> nextNode vector
		var vectorToNextX = nextNodeX - currentNodeX;
		var vectorToNextY = nextNodeY - currentNodeY;
		var absVectorToNextX = abs(vectorToNextX);
		var absVectorToNextY = abs(vectorToNextY);
		var lengthVectorToNext = sqrt(absVectorToNextX * absVectorToNextX + absVectorToNextY * absVectorToNextY);
		var normVectorToNextX = vectorToNextX / lengthVectorToNext;
		var normVectorToNextY = vectorToNextY / lengthVectorToNext;
		
		// Calculate the currentNode -> Mimi vector
		var vectorToMimiX = MimiX - currentNodeX;
		var vectorToMimiY = MimiY - currentNodeY;
		var absVectorToMimiX = abs(vectorToMimiX);
		var absVectorToMimiY = abs(vectorToMimiY);
		var lengthVectorToMimi = sqrt(absVectorToMimiX * absVectorToMimiX + absVectorToMimiY * absVectorToMimiY);
		var normVectorToMimiX = vectorToMimiX / lengthVectorToMimi;
		var normVectorToMimiY = vectorToMimiY / lengthVectorToMimi;
		
		// Calculate CosTheta. A . B = |A||B|CosTheta. A . B = A.x * B.x + A.y * B.y
		var cosTheta = normVectorToNextX * normVectorToMimiX + normVectorToNextY * normVectorToMimiY;
		
		// Calculate the projected lenght of toMimiVector on the toNextNode vector
		var proj = cosTheta * lengthVectorToMimi;
		
		// Calculate the closest point on the line to Mimi. Take into account the position of the next Node
		var lengthOfIdealPoint = min(proj, lengthVectorToNext);
		var idealPointX = lengthOfIdealPoint * normVectorToNextX + currentNodeX;
		var idealPointY = lengthOfIdealPoint * normVectorToNextY + currentNodeY;
		
		// Calculate the distance between the idealPoint and Mimi
		var idealToMimiX = MimiX - idealPointX;
		var idealToMimiY = MimiY - idealPointY;
		var absIdealToMimiX = abs(idealToMimiX);
		var absIdealToMimiY = abs(idealToMimiY);
		var lengthIdealToMimi = sqrt(absIdealToMimiX * absIdealToMimiX + absIdealToMimiY * absIdealToMimiY);
		
		// Check of this idealPoint is closer than the previous
		if(lengthIdealToMimi < minDistance)
		{
			minDistance = lengthIdealToMimi;
			pointX = 0.0;
			pointY = 0.0;
			nodeIndex = i;
		}
	}
	
	// Calculate the normalized distance between this node and the next
	var pathLength = path_get_length(p_pathIndex);
	
	var startLength = 0.0;
	for(var i = 0; i <= nodeIndex - 1; i++)
	{
		// Current node's position
		var currentNodeX = path_get_point_x(p_pathIndex, i);
		var currentNodeY = path_get_point_y(p_pathIndex, i);
		// Next node's position 
		var nextNodeX = path_get_point_x(p_pathIndex, i+1);
		var nextNodeY = path_get_point_y(p_pathIndex, i+1);
		
		var vectorToNextX = nextNodeX - currentNodeX;
		var vectorToNextY = nextNodeY - currentNodeY;
		var absVectorToNextX = abs(vectorToNextX);
		var absVectorToNextY = abs(vectorToNextY);
		var lengthVectorToNext = sqrt(absVectorToNextX * absVectorToNextX + absVectorToNextY * absVectorToNextY);
	
		var ratio = pathLength / lengthVectorToNext;
		var normRatio = 1.0 / ratio;
		startLength += normRatio;
	}
	
	// Current node's position
	var currentNodeX = path_get_point_x(p_pathIndex, nodeIndex);
	var currentNodeY = path_get_point_y(p_pathIndex, nodeIndex);
	// Next node's position 
	var nextNodeX = path_get_point_x(p_pathIndex, nodeIndex+1);
	var nextNodeY = path_get_point_y(p_pathIndex, nodeIndex+1);
	
	// Calculate the vector stuff for the next node
	var vectorToNextX = nextNodeX - currentNodeX;
	var vectorToNextY = nextNodeY - currentNodeY;
	var absVectorToNextX = abs(vectorToNextX);
	var absVectorToNextY = abs(vectorToNextY);
	var lengthVectorToNext = sqrt(absVectorToNextX * absVectorToNextX + absVectorToNextY * absVectorToNextY);
	
	// Calculate the vector stuff for the Mimi's position
	var vectorToMimiX = MimiX - currentNodeX;
	var vectorToMimiY = MimiY - currentNodeY;
	var absVectorToMimiX = abs(vectorToMimiX);
	var absVectorToMimiY = abs(vectorToMimiY);
	var lengthVectorToMimi = sqrt(absVectorToMimiX * absVectorToMimiX + absVectorToMimiY * absVectorToMimiY);
	var normVectorToMimiX = vectorToMimiX / lengthVectorToMimi;
	var normVectorToMimiY = vectorToMimiY / lengthVectorToMimi;
		
	// Calculate the CosTheta. A . B = |A||B|CosTheta. A . B = A.x * B.x + A.y * B.y
	var cosTheta = normVectorToNextX * normVectorToMimiX + normVectorToNextY * normVectorToMimiY;
		
	// Calculate the projected lenght of toMimiVector on the toNextNode vector
	var proj = cosTheta * lengthVectorToMimi;
	
	// Calculate the vector stuff again for the other point...
	var mimiPointOnLineX = proj * normVectorToMimiX + currentNodeX;
	var mimiPointOnLineY = proj * normVectorToMimiY + currentNodeY;
	var vectorToMimiPointOnLineX = mimiPointOnLineX - currentNodeX;
	var vectorToMimiPointOnLineY = mimiPointOnLineY - currentNodeY;
	var absVectorToMimiPointOnLineX = abs(vectorToMimiPointOnLineX);
	var absVectorToMimiPointOnLineY = abs(vectorToMimiPointOnLineY);
	var lengthVectorToMimiPointOnLine = sqrt(absVectorToMimiPointOnLineX * absVectorToMimiPointOnLineX + absVectorToMimiPointOnLineY * absVectorToMimiPointOnLineY);

	// Binary search till we go over the iteration thresshold, or acceptence thresshold
	var ratio = pathLength / lengthVectorToNext;
	var normRatio = 1.0 / ratio;
	
	var acceptence = 0.5;
	var iteration = 20;
	var binaryStep = normRatio;
	for(var i = 0; i < iteration; i++)
	{
		binaryStep *= 0.5
		var binaryPath = startLength + binaryStep;
		var binaryPointX = path_get_x(p_pathIndex, binaryPath);
		var binaryPointY = path_get_y(p_pathIndex, binaryPath);
		var vectorToBinaryPointX = binaryPointX - currentNodeX;
		var vectorToBinaryPointY = binaryPointY - currentNodeY;
		var absVectorToBinaryPointX = abs(vectorToBinaryPointX);
		var absVectorToBinaryPointY = abs(vectorToBinaryPointY);
		var lengthVectorToBinaryPoint = sqrt(absVectorToBinaryPointX * absVectorToBinaryPointX + absVectorToBinaryPointY * absVectorToBinaryPointY);
		
		// Check if the binary point is within the distance acceptence threshold
		if(abs(lengthVectorToMimiPointOnLine - lengthVectorToBinaryPoint) < acceptence)
		{
			return binaryPath;
		}
		
		// Check if Mimi's distance to the node is closer or further. If it's further, add the binary step
		if(lengthVectorToMimiPointOnLine > lengthVectorToBinaryPoint)
		{
			startLength += binaryStep;
		}
	}
	
	// Return the closest point
	return startLength;
}