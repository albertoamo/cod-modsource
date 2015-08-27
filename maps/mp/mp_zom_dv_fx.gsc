main()
{
	precacheFX();
	ambientFX();
	level.scr_sound["flak88_explode"]	= "flak88_explode";
}

precacheFX()
{
	level._effect["flak_explosion"]		= loadfx("fx/explosions/flak88_explosion.efx");					
	level._effect["fogbank_small_duhoc"]		= loadfx ("fx/misc/fogbank_small_duhoc.efx");
	level._effect["thin_light_smoke_M"]			= loadfx ("fx/smoke/thin_light_smoke_M.efx");   				
level._effect["battlefield_smokebank_S"]		= loadfx ("fx/smoke/battlefield_smokebank_S.efx");

}

ambientFX()
{
maps\mp\_fx::loopfx("thin_light_smoke_M", (590,680,0), 1, (592,680,100));

maps\mp\_fx::loopfx("thin_light_smoke_M", (369,-1189,-5), 1, (369,-1189,-155));

maps\mp\_fx::loopfx("thin_light_smoke_M", (-360,1184,8), 1, (-360,1184,108));

maps\mp\_fx::loopfx("battlefield_smokebank_S", (352,-2560,16), 1, (352,-2560,116));

maps\mp\_fx::loopfx("battlefield_smokebank_S", (87,-1214,18), 1, (87,-1214,158));

maps\mp\_fx::loopfx("battlefield_smokebank_S", (-341,-794,18), 1, (-341,-794,158));

maps\mp\_fx::loopfx("fogbank_small_duhoc", (-1048,-1892,-8), 1, (-1048,-1892,128));

maps\mp\_fx::loopfx("fogbank_small_duhoc", (-2043,880,4), 1, (-043,880,154));
}