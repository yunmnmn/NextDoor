// Play the movie
instance_movie.PlayMovie(instance_windowTrigger.MimiFallsBackwards);

// Place the viewport already in the correct position while the movie is playing
SetViewportFollowSpeed(1);
FollowPosition(new Vector2(1960, GetPlayerInstance().y));