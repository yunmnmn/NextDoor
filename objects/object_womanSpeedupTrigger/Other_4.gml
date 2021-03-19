// Going to the ending sequence
GameEndingRoom = function()
{	
	// Set the animation speed faster
	instance_youngsetRoomWomenOutside.image_speed = 2.0;
	
	// Set her crawling speed faster
	instance_youngsetRoomWomenOutside.path_speed = 1.4;
}

var endingCollisionContext = new CollisionContext(GetPlayerInstance(), GameEndingRoom);
endingCollisionContext.AddGlobalState1(GlobalGameStates.MimiGetsChased);
endingCollisionContext.ExecuteOnHit();
AddCollisionContext(endingCollisionContext);