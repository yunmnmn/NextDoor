function CollisionContext(p_collisionInstance, p_callback) constructor
{
	m_collisionInstance = p_collisionInstance;
	m_callback = p_callback;
	
	m_globalStates = ds_list_create();
	
	m_allStates = false;
	
	AddGlobalState1 = function(p_globalState1)
	{
		ds_list_add(m_globalStates, AddGlobalState1);
	}
	
	AddGlobalState2 = function(p_globalState1, p_globalState2)
	{
		AddGlobalState1(p_globalState1);
		ds_list_add(m_globalStates, p_globalState2);
	}

	AddGlobalState3 = function(p_globalState1, p_globalState2, p_globalState3)
	{
		AddGlobalState2(p_globalState1, p_globalState2);
		ds_list_add(m_globalStates, p_globalState3);
	}
	
	AddGlobalState4 = function(p_globalState1, p_globalState2, p_globalState3, p_globalState4)
	{
		AddGlobalState3(p_globalState1, p_globalState2, p_globalState3);
		ds_list_add(m_globalStates, p_globalState4);
	}
	
	AddGlobalState5 = function(p_globalState1, p_globalState2, p_globalState3, p_globalState4, p_globalState5)
	{
		AddGlobalState4(p_globalState1, p_globalState2, p_globalState3, p_globalState4);
		ds_list_add(m_globalStates, p_globalState5);
	}	
	
	AllStates = function()
	{
		m_allStates = true;
	}
}

// Add a CollisionContext 
function AddCollisionContext(p_collisionContext)
{
	ds_list_add(m_collisionContexts, p_collisionContext);
}

m_collisionContexts = ds_list_create();

m_drawButtonPrompt = false;

// Fixed
m_framesPerSecond = 6.0;
m_frameTimeInMiliseconds = 1000.0 / m_framesPerSecond;
// Changes over frames
m_drawFrame = 0;
m_elapsedTimeInMiliseconds = 0.0;

