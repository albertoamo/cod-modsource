barrelInit()
{
level._effect["barrel_fire"] = loadfx ("fx/fire/tank_fire_engine.efx");
level._effect["barrel_explosion"] = loadfx("fx/explosions/ammo_supply_exp.efx");
precacheModel("xmodel/prop_barrel_black");

barrel_trig = getentarray("barrel_trig", "targetname");
barrel_clip = getentarray("barrel_clip", "targetname");

//grab corresponding entities
for( k = 0 ; k < barrel_trig.size ; k++ ) {
barrel1 = getent(barrel_trig[k].target, "targetname");
barrel1.trig = barrel_trig[k];
level.barrels[k] = barrel1;
}

for( k = 0 ; k < barrel_clip.size ; k++ ) {
barrel2 = getent(barrel_clip[k].target, "targetname");
barrel2.clip = barrel_clip[k];
}


//records the name and state, then launch a thread for each barrel
for( k = 0 ; k < level.barrels.size ; k++ ) {
level.barrels[k].name = "barrel ^" + k + "#" + k; 
level.barrels[k].exploded = false;
level.barrels[k].soundOrigin = spawn("script_origin", level.barrels[k].origin);
level.barrels[k] thread barrelThink();
}
}

barrelThink()
{
if (self.exploded == true)
wait(240);

self entityOn();
self.trig entityOn();
self.clip entityOn();

self.accDamage = 0;
self.onfire = false;
self.exploded = false;

while(isdefined (self))
{
self.trig waittill("damage", amount);

self.accDamage = self.accDamage + amount;

//iprintlnbold(self.name + " 's damage = " + self.accDamage);

if (self.exploded != true) 
{
if (self.accDamage > 80 && self.onfire != true) //catch fire
{
self.onfire = true;
self thread barrelFire(); //fire start
self thread barrelFireDamage(); //self injury start
} 
if (self.accDamage > 80 && self.onfire == true) 
{
//nothing
}
if (self.accDamage > 200) //explosion
{
self.onfire = false;
self.exploded = true;
self.soundOrigin playsound("barrel_explosion_imminent");
wait(4); //lenght of sound file
self thread barrelExplode();
self.trig entityOff();
self.clip entityOff();
self entityOff();
self barrelThink();
break;
}
} else //(self.exploded == true)
break; 
}

}

//injures itself until exploded. only one thread per barrel
barrelFireDamage()
{
while (self.exploded != true)
{
self.trig notify ("damage", 10);
wait(randomint(2)+1);
}
}


//play the fx. only one thread of it should exist per barrel
barrelFire() 
{
while(self.exploded != true) //keeps playing the effect until exploded
{
self.soundOrigin playsound("barrel_fire");
playfx(level._effect["barrel_fire"], self.origin + (0,0,32));
radiusDamage(self.origin + (0,0,12), 75, 10, 0);
wait(2);
}

}

barrelExplode() 
{
//inflict damage to adjacent barrels, linearly wrt distance
for (k = 0; k < level.barrels.size; k++)
{
if ( level.barrels[k].exploded != true && level.barrels[k] != self)
{
dist = distance(level.barrels[k].origin, self.origin);
if (dist < 100 && dist != 0)
level.barrels[k].trig notify("damage", ((1-(dist/100))*100)+100); // between 100 and 200 of damage
}
}

self.soundOrigin playsound("barrel_explosion");
playfx(level._effect["barrel_explosion"], self.origin);

//give lots of damage around self
radiusDamage(self.origin + (0,0,12), 400, 200, 30);

//self.trig notify ("damage", 5); //final blow
}

//barrel spawning functions. it just moves them away and back.
entityOff()
{
if (!isdefined (self.realOrigin))
self.realOrigin = self.origin;

if (self.origin == self.realorigin)
self.origin += (0, 0, -10000);
}

entityOn()
{
if (isDefined (self.realOrigin) )
self.origin = self.realOrigin;
} 

