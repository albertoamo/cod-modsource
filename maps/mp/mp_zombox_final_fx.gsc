//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
level thread precacheFX();
level thread spawnWorldFX();
}

precacheFX()
{
level._effect["wake_higgins"] = loadfx 
("fx/misc/wake_higgins.efx");
level._effect["spotlight_credits"] = loadfx ("fx/misc/spotlight_credits.efx");
level._effect["spotlight_credits2"] = loadfx ("fx/misc/spotlight_credits2.efx");
level._effect["corpses"] = loadfx
("fx/misc/corpses.efx");
level._effect["boom"] = loadfx
("fx/impacts/wall_impact_dirt.efx");
}

spawnWorldFX()
{
//Bloooddyyyyyyyyyyyyyyyyyyy
maps\mp\_fx::loopfx("wake_higgins", (496,-992,-2128), 2);

maps\mp\_fx::loopfx("spotlight_credits", (-136,7168,-2008), 5);

maps\mp\_fx::loopfx("spotlight_credits2", (1104,7168,-2008), 5);
}

