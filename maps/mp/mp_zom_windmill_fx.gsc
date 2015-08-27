main()
{
	level thread precacheFX();
	level thread spawnWorldFX();
	level thread ambientFX();
}

precacheFX()
{
	level._effect["building_fire_med"]	= loadfx ("fx/fire/building_fire_med.efx");
	level._effect["building_fire_small"]	= loadfx ("fx/fire/building_fire_med.efx");
	level._effect["building_fire_large"]	= loadfx ("fx/fire/building_fire_large.efx");
	level._effect["dark_smoke_trail"]	= loadfx ("fx/smoke/dark_smoke_trail.efx");
}

spawnWorldFX()
{
}

ambientFX()
{
}