main()
{
	precacheFX();
	ambientFX();
	level.scr_sound["flak88_explode"]	= "flak88_explode"; 
}

precacheFX()
{
	level._effect["flak_explosion"]		= loadfx("fx/explosions/flak88_explosion.efx");
	level._effect["snow_light"]		= loadfx ("fx/misc/snow_light_mp_downtown.efx");
	level._effect["snow_wind_cityhall"]		= loadfx ("fx/misc/snow_wind_cityhall.efx");
	level._effect["thin_black_smoke_M"]	= loadfx ("fx/smoke/damaged_vehicle_smoke.efx");   
	level._effect["tank_fire_turret_large"]	= loadfx ("fx/fire/tank_fire_turret_large.efx");    
	level._effect["tank_fire_engine"] 		= loadfx ("fx/fire/tank_fire_engine.efx");
	level._effect["fogbank_small_duhoc"]	= loadfx ("fx/misc/fogbank_small_duhoc.efx");
	level._effect["vehicle_steam"]		= loadfx ("fx/smoke/vehicle_steam.efx");	
}
	

ambientFX()
{
	//world snow
	//maps\mp\_fx::loopfx("snow_light", (912,-288,170), 0.6, (912,-288,270));
	//maps\mp\_fx::loopfx("snow_light", (3768,-288,170), 0.6, (3768,-288,270));
	
	
	//ground effects
	maps\mp\_fx::loopfx("thin_black_smoke_M", (4088,1704,8), 0.8, (4088,1704,108));
	maps\mp\_fx::loopfx("thin_black_smoke_M", (4800,1976,712), 0.8, (4800,1976,812));
	maps\mp\_fx::loopfx("thin_black_smoke_M", (5472,1904,712), 0.8, (5472,1904,812));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (377,91,-40), 0.5, (377,91,60));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (-459,118,-40), 0.5, (-459,118,60));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (3895,-279,-60), 0.5, (3895,-279,40));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (3061,9,-40), 0.5, (3061,9,60));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (1024,-2014,-70), 0.5, (1024,-2014,30));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (2424,-1916,-70), 0.5, (2424,1916,30));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (3172,-2136,-70), 0.5, (3172,-2136,30));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (4150,-346,-65), 0.5, (4150,-346,35));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (4656,900,-65), 0.5, (4656,900,35));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (4169,1159,-65), 0.5, (4169,1159,35));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (2869,955,-65), 0.5, (2869,955,35));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (964,1148,-60), 0.5, (964,1148,40));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (1072,-35,-60), 0.5, (1072,-55,40));
	maps\mp\_fx::loopfx("snow_wind_cityhall", (3536,-16,-60), 0.5, (3536,-16,40));
	maps\mp\_fx::loopfx("vehicle_steam", (355,-15,0), 2, (355,-15,50));

	//interior fog
	maps\mp\_fx::loopfx("fogbank_small_duhoc", (1512,1128,-32), 2, (1512,1128,68));
	maps\mp\_fx::loopfx("fogbank_small_duhoc", (1472,640,-32), 2, (1472,640,68));
	maps\mp\_fx::loopfx("fogbank_small_duhoc", (1000,-840,-32), 2, (1000,-840,68));
	
	//tank fire
	maps\mp\_fx::loopfx("tank_fire_turret_large", (4094,200,-36), 1, (4094,200,62));
	maps\mp\_fx::loopfx("tank_fire_turret_large", (2745,-134,-34), 1, (2745,-134,66));
	maps\mp\_fx::loopfx("tank_fire_engine", (2744,-160,0), 1, (2744,-160,100));
		
	//barrell fire
	maps\mp\_fx::loopfx("tank_fire_engine", (4638,-770,-45), 1, (4638,-770,55));	

	//SoundFX
	maps\mp\_fx::soundfx("medfire", (4094,200,-40));
	maps\mp\_fx::soundfx("medfire", (2745,-134,-35));
	maps\mp\_fx::soundfx("medfire", (4643,-763,-45));
}