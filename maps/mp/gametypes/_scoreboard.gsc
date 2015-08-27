init()
{
	precacheShader("mpflag_spectator");

	precacheShader("mpflag_american");
	setcvar("g_TeamName_Allies", "^2H^9unters^2");
	setcvar("g_TeamColor_Allies", ".25 .75 .25");
	setcvar("g_ScoresBanner_Allies", "mpflag_american");

	assert(game["axis"] == "german");
	precacheShader("mpflag_german");
	setcvar("g_TeamName_Axis", "^2Z^9ombies^1");
	setcvar("g_TeamColor_Axis", ".6 .6 .6");
	setcvar("g_ScoresBanner_Axis", "mpflag_german");
}
