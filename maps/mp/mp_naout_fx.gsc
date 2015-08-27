main()
{
	precacheFX();
	ambientFX();
	level.scr_sound["flak88_explode"]	= "flak88_explode";
}

precacheFX()
{
	level._effect["flak_explosion"]		= loadfx("fx/explosions/flak88_explosion.efx");
	level._effect["dust_wind"]			= loadfx ("fx/dust/dust_wind_brown_thick.efx");

}

ambientFX()
{
	

	maps\mp\_fx::loopfx("dust_wind", (-2064, 1728, 72), 3, (-2064, 1728, 1800));

	


}