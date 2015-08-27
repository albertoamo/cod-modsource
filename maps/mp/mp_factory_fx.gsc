main()
{
precacheFX();
ambientFX();

}

precacheFX()
{


level._effect["thin_light_smoke_L"] = loadfx ("fx/smoke/thin_light_smoke_L.efx");



}

ambientFX()
{

//smoke for chimney
maps\mp\_fx::loopfx("thin_light_smoke_L", (88, 8, 1088), 1, (88, 8, 1900));

//smoke for side chimney
maps\mp\_fx::loopfx("thin_light_smoke_L", (1952, -2312, 1176), 1, (1952, -2312, 1900));

}