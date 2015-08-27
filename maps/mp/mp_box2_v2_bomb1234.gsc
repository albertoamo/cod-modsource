main() 
{
level._effect["flak_dust_blowback"] = loadfx ("fx/dust/flak_dust_blowback.efx");
level._effect["barn_explosion"] = loadfx("fx/explosions/barn_explosion.efx");
level._effect["damaged_vehicle_smoke"] = loadfx("fx/smoke/damaged_vehicle_smoke.efx");
thread bomb();
}





bomb()
{

bomb = getent("tower_bomb", "targetname");
door = getent("tower_door", "targetname");
door_d = getent("tower_door_d", "targetname");
door_d hide();
door.health = 10000000;
trig = getent ("tower_trig", "targetname");
origin = (1544.0,4968.0,144.0);


trig waittill("trigger",other);
wait .05;
trig delete();

	bomb playLoopSound( "bomb_tick" );

wait 6;
      bomb stopLoopSound( "bomb_tick" );

	radiusdamage(origin, 216, 350, 50);
	earthquake( 0.25, 1, origin, 1000 );

      door playsound ("metaldoor_explosion_1");
	
playfx( level._effect["barn_explosion"], origin );
door delete();
bomb delete();
door_d show();
playfx( level._effect["damaged_vehicle_smoke"], origin );
playfx( level._effect["flak_dust_blowback"], origin );
}