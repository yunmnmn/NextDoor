function RegisterPlayerInstance(p_player)
{
	assert(p_player != noone, "Player instance is invalid");
	global.g_playerInstance = p_player;
}

function GetPlayerInstance()
{
	assert(global.g_playerInstance != noone, "Player is invalid");
	return global.g_playerInstance;
}

function PlayerSetPath(p_pathIndex, p_position)
{
	assert(p_pathIndex != noone, "Path is invalid");
	global.g_playerInstance.SetPath(p_pathIndex, p_position);
}

function PlayerSetPathEndCallback(p_callback)
{
	global.g_playerInstance.SetPathEndCallback(p_callback);
}

function PlayerSetMirrored(p_mirrored)
{
	global.g_playerInstance.SetMirrored(p_mirrored);
}

function PlayerSetPathStartCallback(p_callback)
{
	global.g_playerInstance.SetPathStartCallback(p_callback);
}

function PlayerAddPathCallback(p_pathIndex, p_position, p_callback, p_persistant)
{
	global.g_playerInstance.AddPathCallback(new PathCallback(p_pathIndex, p_position, p_callback, p_persistant));
}

function PlayerGetPath()
{
	return global.g_playerInstance.GetPath();
}

function PlayerPlayAnimation(p_spriteIndex, p_mirrored, p_callbackEnd)
{
	assert(p_spriteIndex != noone, "Passed sprite index is invalid");
	assert(global.g_playerInstance != noone, "Registered sprite is invalid");
	
	global.g_playerInstance.PlayAnimation(p_spriteIndex, p_callbackEnd);
	PlayerSetMirrored(p_mirrored);
}

function SnapToClosestPosition(p_positionX, p_positionY)
{
	assert(PlayerGetPath() != noone, "Path is invalid");
	assert(path_get_kind(PlayerGetPath()) == false, "Path is curved, this function doesn't support that");
	
	var pathNodeCount = path_get_number(PlayerGetPath());
	assert(pathNodeCount > 1, "Path only has one node, must have atleast 2");
	
	var MimiX = p_positionX;
	var MimiY = p_positionY;
	
	// TODO: find the max float number
	var minDistance = 999999999.0;
	var pointX = 0.0;
	var pointY = 0.0;
	var nodeIndex = 0;
	for(i = 0; i < pathNodeCount-1; i++)
	{
		// Current node's position
		var currentNodeX = path_get_point_x(PlayerGetPath(), i);
		var currentNodeY = path_get_point_y(PlayerGetPath(), i);
		
		// Next node's position 
		var nextNodeX = path_get_point_x(PlayerGetPath(), i+1);
		var nextNodeY = path_get_point_y(PlayerGetPath(), i+1);
		
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
		
		// Calculate the CosTheta. A . B = |A||B|CosTheta. A . B = A.x * B.x + A.y * B.y
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
	var pathLength = path_get_length(PlayerGetPath());
	
	var startLength = 0.0;
	for(i = 0; i <= nodeIndex - 1; i++)
	{
		// Current node's position
		var currentNodeX = path_get_point_x(PlayerGetPath(), i);
		var currentNodeY = path_get_point_y(PlayerGetPath(), i);
		// Next node's position 
		var nextNodeX = path_get_point_x(PlayerGetPath(), i+1);
		var nextNodeY = path_get_point_y(PlayerGetPath(), i+1);
		
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
	var currentNodeX = path_get_point_x(PlayerGetPath(), nodeIndex);
	var currentNodeY = path_get_point_y(PlayerGetPath(), nodeIndex);
	// Next node's position 
	var nextNodeX = path_get_point_x(PlayerGetPath(), nodeIndex+1);
	var nextNodeY = path_get_point_y(PlayerGetPath(), nodeIndex+1);
	
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
	
	var acceptence = 2;
	var iteration = 20;
	var binaryStep = normRatio;
	for(i = 0; i < iteration; i++)
	{
		binaryStep *= 0.5
		var binaryPath = startLength + binaryStep;
		var binaryPointX = path_get_x(PlayerGetPath(), binaryPath);
		var binaryPointY = path_get_y(PlayerGetPath(), binaryPath);
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