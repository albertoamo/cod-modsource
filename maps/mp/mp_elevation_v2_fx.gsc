main()
{
precacheFX();
ambientFX();
level.scr_sound["flak88_explode"] = "flak88_explode"; // needed for sd
}

precacheFX()
{
level._effect["flak_explosion"] = loadfx ("fx/explosions/flak88_explosion.efx"); //needed for sd

level._effect["building_fire_med"] = loadfx ("fx/fire/building_fire_med.efx");

level._effect["thin_light_smoke_L"] = loadfx ("fx/smoke/thin_light_smoke_L.efx");

}

ambientFX()
{
//Fire FX
maps\mp\_fx::loopfx("building_fire_med", (112.0, 2072.0, 512.0), 2);
maps\mp\_fx::loopfx("building_fire_med", (512.0, 960.0, 40.0), 2);

//Smoke FX
maps\mp\_fx::loopfx("thin_light_smoke_L", (112.0, 2073.0, 513.0), 0.6);
maps\mp\_fx::loopfx("thin_light_smoke_L", (512.0, 960.0, 41.0), 0.6);
maps\mp\_fx::loopfx("thin_light_smoke_L", (1148.0, 788.0, 152.0), 0.3);

//Sound FX
maps\mp\_fx::soundfx("medfire", (112,2072,512));
maps\mp\_fx::soundfx("medfire", (512,960,40));

}