main()
{
	level thread precacheFX();
	level thread spawnWorldFX();
}

precacheFX()
{
	level._effect["ground_fire_small_oneshot"] = loadfx ("fx/fire/ground_fire_small_oneshot.efx");
	level._effect["thin_light_smoke_S"] = loadfx ("fx/smoke/thin_light_smoke_S.efx");

	level._effect["ground_fire_small_oneshot"] = loadfx ("fx/fire/ground_fire_small_oneshot.efx");
	level._effect["thin_light_smoke_S"] = loadfx ("fx/smoke/thin_light_smoke_S.efx");
}

spawnWorldFX()
{
//fire
	maps\mp\_fx::loopfx("ground_fire_small_oneshot", (700, -1656, -413), 0.6);
	maps\mp\_fx::loopfx("ground_fire_small_oneshot", (697, -1489, -409), 0.6);

//smoke
	maps\mp\_fx::loopfx("thin_light_smoke_S", (700, -1656, -368), 0.7);
	maps\mp\_fx::loopfx("thin_light_smoke_S", (697, -1489, -364), 0.7);
}