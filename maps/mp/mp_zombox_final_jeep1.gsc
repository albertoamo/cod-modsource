main() 
{
	if( getCvarInt("dvar_jeepsEnabled") == 1 || getCvar("dvar_jeepsEnabled") == "")
		thread jeepy_zom();
}

main_callbacks() 
{
game["objjeep"] = "jeep_obj";
	
precacheitem("jeep_crush_mp");
precacheitem("aa_mp");
precacheShader( game["objjeep"] );
}

manualRadiusDamage(attacker,origin,weapon,mdeath, range,damage, maxDamage ,killIfBlocking) {
if( isDefined( mdeath ) )
mDeath = "MOD_EXPLOSIVE";

if( !isDefined( weapon ) )
weapon = "none";

damageMultiplier = range / maxDamage;
players = getentarray("player", "classname");
for( j3 = 0; j3 < players.size; j3++ ) {
peep = players[j3];

if( peep == self )
continue;
pOrigin = peep getOrigin();
dist = distance( origin, pOrigin );
if( dist > range )
continue;

currDamage = int(dist / damageMultiplier);

if( currDamage < damage )
currDamage = damage;

trace = bulletTrace( origin + (0,0,10 ), pOrigin + ( 0 ,0 ,40 ), true, undefined );

ent = trace["entity"];

if( isDefined( ent ) && ent != peep )
if( killIfBlocking != true )
continue;

direction = vectorToAngles( pOrigin - origin );
direction = anglesToForward( direction );

peep thread [[level.callbackPlayerDamage]](self, attacker, currDamage, 1, mdeath, weapon, pOrigin, direction, "none",0);
}
}

monitorExKeys() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("disconnect");

if( isDefined( self.monitorExtraKeys ) )
return;
self.monitorExtraKeys = true;
wait 1;
if( !isDefined( self ) )
return;

while( isDefined( self ) ) {
self waittill("menuresponse", menu, response);

if( menu == "-1" && isAlive( self ) ) {
self notify( "key_" + response );
}
else {
}
}
}
//*****************************************************
// Util
//*****************************************************
getDiffV2(rollNew, rollOld) {

val1 = positiveMod( rollNew );
val2 = positiveMod( rollOld );

if( val1 > val2 ) {
temp = val1;
val1 = val2;
val2 = temp;
} 

if( ( val2 - val1 ) < 180 )
return val2 - val1;
else {
return ( ( 360 - val2) + val1 ) ;
}

}

//*****************************************************
// Util
//*****************************************************
positiveMod(rollNew) {
if( rollNew < 0 ) {
if( rollNew < -1000 ) {
temp = int( rollNew / -360) - 1;

rollNew -= ( -360 * temp );
}

while( rollNew < -360 )
rollNew += 360;

rollNew = (360 + rollNew ) ;
}
else if( rollNew > 0 ) {
if( rollNew > 1000 ) {
temp = int( rollNew / 360 ) - 1;

rollNew -= ( 360 * temp );
}

while( rollNew > 360 )
rollNew -= 360;
}
return rollNew;
}
//*********************************************
// Util reset angles
//*********************************************
resetAngles( a ) {
a0 = angleMod( a[0] );
a1 = angleMod( a[1] );
a2 = angleMod( a[2] );
if( a0 != a[0] || a1 != a[1] || a2 != a[2] )
return ( a0, a1, a2 );
else
return undefined;
}
//*****************************************
// Util angle mod
//*****************************************
angleMod( pval ) {
if( pval <= -360 ) {
for( j3 = 0; j3 <= 100; j3++ ) {
if( pval <= -360 )
pval += 360;
else
break;
}
}

if( pval >= 360 ) {
for( j3 = 0; j3 <= 100; j3++ ) {
if( pval >= 360 )
pval -= 360;
else
break;
}
}
return pval;
}
//*****************************************************
// Util mod
//*****************************************************
miscMod(rollNew) {
if( rollNew < 0 ) {
if( rollNew < -1000 ) {
temp = int( rollNew / -360) - 1;

rollNew -= ( -360 * temp );
}

while( rollNew <= -360 )
rollNew += 360;

}
else if( rollNew > 0 ) {
if( rollNew > 1000 ) {
temp = int( rollNew / 360 ) - 1;

rollNew -= ( 360 * temp );
}

while( rollNew >= 360 )
rollNew -= 360;

}

return rollNew;
}

// Util turn direction 
turnDirection( newDirection, oldDirection) {
iResult = 0;
newDirection = miscMod( newDirection );
olddirection = miscMod( oldDirection );

if( newDirection <= 180 ) {
temp = newDirection + 180;

if( oldDirection >= newDirection && oldDirection <= temp )

iResult = 1;
else
iResult = -1;
}
else {
temp = newDirection - 180;
if( oldDirection >= temp && oldDirection <= newDirection )
iResult = -1;
else
iResult = 1;
}

return iResult;

}

// Find a safe place to put the player after unmounting a vehicle.

safeGround(ent,dist,height) {
anglesF = anglesToForward( ent.angles );
anglesR = anglesToRight( ent.angles );
origin = self getOrigin();
direction = (0,0,0);
iPosFound = false;
if( isDefined( ent ) ) {

temp = vector_scale( anglesR, dist );
trace = bulletTrace( origin, origin + temp, false, self );
if( trace["surfacetype"] == "none" || trace["surfacetype"] == "default" ) {
pos = trace["position"];
trace = bulletTrace(pos + (0,0,500), pos - (0,0,200),false, self);

direction = vectorToAngles( origin - pos );

self setOrigin(trace["position"] + (0,0,height));
iPosFound = true;

}

temp = vector_scale( anglesR, dist - ( dist * 2 ));
trace = bulletTrace( origin, origin + temp, false, self );
if( iPosFound == false && trace["surfacetype"] == "none" || trace["surfacetype"] == "default" ) {

pos = trace["position"];
direction = vectorToAngles( origin - pos );

trace = bulletTrace(pos + (0,0,500), pos - (0,0,200),false, self);
self setOrigin(trace["position"] + (0,0,height));

iPosFound = true;
}

temp = vector_scale( anglesF, dist - ( dist * 2 ));
trace = bulletTrace( origin, origin + temp, false, self );
if( iPosFound == false && trace["surfacetype"] == "none" || trace["surfacetype"] == "default" ) {
pos = trace["position"];
direction = vectorToAngles( origin - pos );

trace = bulletTrace(pos + (0,0,500), pos - (0,0,200),false, self);
self setOrigin(trace["position"] + (0,0,height));

iPosFound = true;
}

wait 1;
// Handle players stuck on walls
direction = anglesToForward( direction );
while( isDefined( self ) && isAlive( self ) && self isOnGround() == false ) {
temp = vector_scale( direction, 10 );
self setOrigin( self getOrigin() + temp );
wait .5;
}
}

}

vector_scale(vec, scale) {
vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
return vec;
}

jeepy_zom() {

precacheStuff();

//thread jeepgrendamage();
level thread onPlayerConnected();
wait 5;
level.jeeps = [];
level.globalOrg = (-39200, 11083, 350);

for( j3 = 0; j3 <= 3190; j3+=3190) 
{
	origin = (80,2370,-2192) + (j3*0.00001,j3*0.04,j3*0.00001);
	thread spawn_jeep(origin, undefined);

	origin = (944,2370,-2192) + (j3*0.00001,j3*0.04,j3*0.00001);
	thread spawn_jeep(origin, (0,180,0));
}
}

onPlayerConnected() {
level endon("intermission");
level endon("cleanUP_endmap");

while(true) {
self waittill("connected", player);
player thread onPlayerDisconnect();
player thread onPlayerSpawn();
}
}

onPlayerSpawn() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("disconnect");

while(true) {
self waittill("spawned_player");

self thread onPlayerKilled();
self.cancelSprint = undefined;
self.jeep = undefined;

self thread monitorExKeys();
}
}

onPlayerKilled() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("disconnect");

self waittill("killed_player");
self detachFromJeep();
self detachFromJeep();
}

onPlayerDisconnect() {
level endon("intermission");
level endon("cleanUP_endmap");

self waittill("disconnect");
self detachFromJeep(); 
}

engineON(spawnorigin, newangles) {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("disconnect");
self endon("jeep_done");

jeep = self;
wait .5;
self thread jeepShocks();
self thread dust();
self thread trackDamage();
jeep thread detectCollition();
jeep thread onJeepCollition();
jeep thread onDestroyedJeep(spawnorigin, newangles);

imoving = 0;
while( isDefined( jeep )) {

direction = anglesToForward( jeep.angles );

origin = jeep getOrigin();

if( !isDefined( jeep.driver ) ) {
if( jeep.speed <= -2 ) {
jeepAccel();
}
else if( jeep.speed > 2 ) {
jeepDecel();
}
}
else {
if( iMoving == 0 ) {
}
else {
}
}
if( jeep.speed > 2 || jeep.speed < -2 ) {
temp = vector_Scale(direction, jeep.speed );
nextPos = origin + temp;

trace = bulletTrace( nextPos + (0,0,100), (nextPos[0],nextPos[1],origin[2] - 25), false, jeep );

if( !isDefined( trace["entity"] ) )
nextPos = trace["position"];

jeep moveTo( nextPos, 0.1,0,0 );
}
wait .1;
}
}

trackDamage() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon( "destroyed_jeep" );

wait(2);

jeep = self;

while( isDefined(jeep) ) {
if(jeep.damage >= jeep.maxDamage ) {

self notify("destroyed_jeep");

self.damage = self.maxDamage;
return;
}

if( self.damage > 1 ) {
origin = self getOrigin();
anglesForward = anglesToForward( self.angles );
anglesUp = anglesToUp( self.angles );

temp = vector_scale( anglesForward, 55 );
temp += origin + vector_scale( anglesUp, 40 );

playFX( level._effect["vehicle_steam"], temp );

wait ( 1.6 / self.damage );
}
else
wait(.5);
}
}

onDestroyedJeep(spawnorigin, newangles) {
level endon("intermission");
level endon("cleanUP_endmap");

team = self.teamAlt;
self waittill("destroyed_jeep");

peep = self.driver;
peep2 = self.passenger1;

if( isDefined( self.driver ) && self.driver.jeep == self )
self.driver unlink();
if( isDefined( self.passenger1 ) && self.passenger1.jeep == self)
self.passenger1 unlink();

if( isDefined( self.hitBy ) ) {

hitBy = self.hitBy;
hitWeapon = self.hitWeapon;

if( isDefined( peep ) && isAlive( peep ) ) {
peep detachFromJeep();
peep thread [[level.callbackPlayerDamage]](hitBy, hitBy, 1000, 1, "MOD_BULLET", hitWeapon, peep getOrigin(), undefined, "none",0);
}
if( isDefined( peep2 ) && isAlive( peep2 ) ) {
peep2 detachFromJeep();
peep2 thread [[level.callbackPlayerDamage]](hitBy, hitBy, 1000, 1, "MOD_BULLET", hitWeapon, peep2 getOrigin(), undefined, "none",0);
}
}
else {
if( isDefined( peep ) && isAlive( peep ) ) {
peep detachFromJeep();
peep thread [[level.callbackPlayerDamage]](peep, peep, 1000, 1, "MOD_BULLET", "none", peep getOrigin(), undefined, "none",0);
}
if( isDefined( peep2 ) && isAlive( peep2 ) ) {
peep2 detachFromJeep();
peep2 thread [[level.callbackPlayerDamage]](peep2, peep2, 1000, 1, "MOD_BULLET", "none", peep2 getOrigin(), undefined, "none",0);
}
}

origin = self getOrigin();
anglesForward = anglesToForward( self.angles );
anglesUp = anglesToUp( self.angles );

temp = vector_scale( anglesForward, 20 );
temp += origin + vector_scale( anglesUp, 35 );

self playSound("mortar_explosion" + randomIntRange(1,5) );
playFX( level._effect["armoredcar_explosion"], temp );

self notify("jeep_done");

self setModel(game["jeepd"]);

wait(300);

thread spawn_jeep(spawnorigin, newangles);

self hide();
self delete();
}

dust(){
level endon("intermission");
level endon("cleanUP_endmap");
self endon("destroyed_jeep");

while(true) {
if( self.speed > 2 || self.speed < -2 ) {

anglesForward = anglesToForward( self.angles );
temp = vector_scale(anglesForward, -100 );
playFX(level._effect["libya_dust_kickup"], self getOrigin() + temp );
speed = self.speed;
wtime = .5;
if( speed < 0 ) {
speed = (speed - (speed * 2 ) );
}

wtime = (30/ speed);
if( wtime < .005 )
wtime = .005;
wait( wtime );
}
else
wait .5;
}
}

//***************************************
// Jeep Driver
//***************************************

jeepDriver() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("killed_player");
self endon("disconnect");
self endon("destroyed_jeep");

jeep = self.jeep;
jeep.angleYaw = jeep.angles[1];

while( isDefined( self.jeep ) && isAlive( self ) && self.jeep == jeep) {
wait .1;

if( !isDefined( jeep.driver ) )
break;
if( jeep.driver != self )
break;

angles = self getPlayerAngles();
jeepAngles = jeep.angles;
origin = jeep getOrigin();

anglesForward = anglesToForward( angles );
jeepAnglesForward = anglesToForward( jeepAngles );

temp = vector_scale( anglesForward, 10000 );
temp += origin;
lookDirection = vectorToAngles( temp - origin );

temp = vector_scale( jeepAnglesForward, - 10000 );
temp += origin;

backDirection = vectorToAngles( temp - origin );

hdirection = turnDirection ( lookDirection[1], backDirection[1] );

hdiff = getDiffV2( lookDirection[1], jeep.angles[1] );

if( hdirection != 0 ) {
tempYaw = hdirection;

iYaw = hdiff;

tempYaw *= ( hdiff * (10/ (20 + iYaw * 1 ) ) );

jeep.angleYaw = jeep.angles[1] + tempYaw;
}
}
}

//**********************************************
// Util pitch 
//**********************************************

jeepShocks() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("destroyed_jeep");

jeep = self;

while(true) {
if( jeep.speed < -5 || jeep.speed > 5 ) {
o = jeep getOrigin();
angles = vectorToAngles(self getOrigin() - o);

a = anglesToForward( jeep.angles );
temp = vector_scale( a, 1000 );
o2 = temp + self getOrigin();
angles = vectorToAngles(o2 - o);

startPos = jeep.frontLeftTire getOrigin() + (0,0,200 );
endPos = jeep.frontLeftTire getOrigin() - (0,0,20 );
trace = bulletTrace( startPos, endPos, true, jeep );
fltire = trace["position"];

startPos = jeep.frontRightTire getOrigin() + (0,0,200 );
endPos = jeep.frontRightTire getOrigin() - (0,0,20 );
trace = bulletTrace( startPos, endPos, true, jeep );
frtire = trace["position"];

startPos = jeep.backLeftTire getOrigin() + (0,0,200 );
endPos = jeep.backLeftTire getOrigin() - (0,0,15 );
trace = bulletTrace( startPos, endPos, true, jeep );
bltire = trace["position"];

startPos = jeep.backRightTire getOrigin() + (0,0,200 );
endPos = jeep.backRightTire getOrigin() - (0,0,15 );
trace = bulletTrace( startPos, endPos, true, jeep );
brtire = trace["position"];

bl = vectorToAngles( frtire - bltire );
br = vectorToAngles( fltire - brtire ); 

bl2 = vectorToAngles( frtire - fltire );
br2 = vectorToAngles( brtire - bltire ); 

x = bl[0];
if( bl[0] < br[0] )
x = br[0];

z = bl2[0];
if( bl2[0] < br2[0] )
z = br2[0];

jeep rotateTo( (x ,self.angleYaw, z), .2, 0, 0);
}
wait .2;
}
}

//***************************************
// Gas
//***************************************

jeepGas() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("disconnect");
self endon("killed_player");
self endon("destroyed_jeep");
self thread jeepDriver();

jeep = self.jeep;
iState = 3;
iOldState = 0;
stateC = jeep.maxSpeed / 150;
while( isDefined( self.jeep ) && isDefined( self.jeep.driver ) && self == self.jeep.driver ) {

if( self meleeButtonPressed() == true && self attackButtonPressed() == true ) {
if( jeep.speed > 2 ) {
jeep jeepDecel();
jeep jeepDecel();
}
jeep jeepDecel();
iState = 2;
}
else if( self meleeButtonPressed() == true ) {
if( jeep.speed < -2 ) {
jeep jeepAccel();
jeep jeepAccel();
}
jeep jeepAccel();
iState = 2;
}
else {
if( jeep.speed > 2 ) {
jeep jeepDecel();
}
else if( jeep.speed < -2 ) {
jeep jeepAccel();
}
if( jeep.speed < 20 && jeep.speed > -15 )
iState = 1;
} 
if( iState != iOldState )
jeep jeepPlaySound( iState );

iOldState = iState;
wait .1;
}
}

//***************************************
// Decel and Accel functions
//***************************************

jeepDecel() {

if( self.speed > self.minSpeed )
self.speed -= 1;

if( self.speed < self.minSpeed )
self.speed = self.minSpeed;
}

jeepAccel() {
iAccel = 1;
if( isDefined(self.passenger1) )
iAccel = .8;

if( self.speed < self.maxSpeed )
self.speed += iAccel;

if( !isDefined( self.passenger1 ) ) {
if( self.speed > (self.maxSpeed + 3) )
self.speed = (self.maxSpeed + 3) ;
}
else {
if( self.speed > self.maxSpeed )
self.speed = self.maxSpeed;
}
}

//*******************************************
// Detach player from jeep
//*******************************************

detachFromJeep() {
self notify("detached_player");

if( !isDefined( self.jeep ) ) {
self.jeep = undefined;
return;
}
jeep = self.jeep;

self.vehicle = undefined;

self.jeep = undefined;
if( isDefined( jeep.driver ) && jeep.driver == self ) {
jeep jeepStopSound();
self unlink();
self.jeep = undefined; 
jeep.driver = undefined;
//releaseMiscObjective( jeep.objective );

d = anglesToRight( jeep.angles );

temp = vector_scale(d, -90 );
temp += jeep getOrigin();

self safeGround(jeep,120,50);
self enableWeapon();
self.cancelSprint = undefined;
}
else if( isDefined( jeep.passenger1 ) && jeep.passenger1 == self ) { 
self unlink();
self.jeep = undefined; 
jeep.passenger1 = undefined;

d = anglesToRight( jeep.angles );

temp = vector_scale(d, 80 );
temp += jeep getOrigin();

self safeGround(jeep,120,50);

self enableWeapon();
self.cancelSprint = undefined; 
}
else if( isDefined( jeep.passenger2 ) && jeep.passenger2 == self ) {
self unlink();
self.jeep = undefined;
jeep.passenger2 = undefined;

d = anglesToForward( jeep.angles );

temp = vector_scale(d, -120 );
temp += jeep getOrigin();

trace = bulletTrace( temp + (0,0,100 ), temp + (0,0,-100), false, self );

self setOrigin( trace["position"] );
self enableWeapon();
self.cancelSprint = undefined;
}
}

detectCollition() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("jeep_done");
self endon("destroyed_jeep");

while(true) {
origin = self getOrigin();
anglesF = anglesToForward( self.angles );
anglesR = anglesToRight( self.angles );

// Scan the FRONT and BACK first from left to right, bottom fender and upper

for( j3 = -40; j3 <= 40; j3 += 8 ) {
temp = vector_scale( anglesR, j3 );
temp += origin;
startPos = temp + vector_scale( anglesF, 25 );
endPos = temp + vector_scale( anglesF, 90 );

trace = bulletTrace( startPos + (0,0,45), endPos + (0,0,45), true, self );

ent = trace["entity"];
if( isDefined(ent) ||
(trace["surfacetype"] != "none" && trace["surfacetype"] != "default") ) {
self notify("trigger_col", ent, 1 );
self.colPos = trace["position"];
self.colSurf = trace["surfacetype"];
}

startPos = temp + vector_scale( anglesF, -65 );
endPos = temp + vector_scale( anglesF, -90 );

trace = bulletTrace( startPos + (0,0,45), endPos + (0,0,45), true, self );

ent = trace["entity"];
if( isDefined(ent) ||
(trace["surfacetype"] != "none" && trace["surfacetype"] != "default") ) {
self notify("trigger_col", ent, 2 );
self.colPos = trace["position"];
self.colSurf = trace["surfacetype"];
}
}

origin = self getOrigin();
anglesF = anglesToForward( self.angles );
anglesR = anglesToRight( self.angles );

// Scan sides, left first
for( j3 = -80; j3 <= 80; j3 += 8 ) {
temp = vector_scale( anglesF, j3 );
temp += origin;
startPos = temp + vector_scale( anglesR, -34 );
endPos = temp + vector_scale( anglesR, -45 );

trace = bulletTrace( startPos + (0,0,45), endPos + (0,0,45), true, self );

ent = trace["entity"];
if( isDefined(ent) ||
(trace["surfacetype"] != "none" && trace["surfacetype"] != "default") ) {
self notify("trigger_col", ent,3 );
self.colPos = trace["position"];
self.colSurf = trace["surfacetype"];
}

// right side
startPos = temp + vector_scale( anglesR, 34 );
endPos = temp + vector_scale( anglesR, 45 );

trace = bulletTrace( startPos + (0,0,45), endPos + (0,0,45), true, self );
ent = trace["entity"];
if( isDefined(ent) ||
(trace["surfacetype"] != "none" && trace["surfacetype"] != "default") ) {
self notify("trigger_col", ent,4 );
self.colPos = trace["position"];
self.colSurf = trace["surfacetype"];
}
}
wait .1;
}
}

//*********************************************
// Jeep Collition
//*********************************************

onJeepCollition() {
self endon("intermission");
self endon("jeep_done");
self endon("destroyed_jeep");

while(true) {
self waittill("trigger_col", ent,side );

if( isPlayer( ent ) ) {
self movePlayerBack( ent, side );
self attachPlayer( ent );
}
else {

self.damage += 1;

if( isDefined( self.collition ) )
return;

pos = self.colPos;
surf = self.colSurf;

if( self.speed < -2 || self.speed > 2 )
self.frontLeftTire playSound( "bullet_ap_" + surf, pos );

spd = self.speed;

if( spd < 0 && spd > 0 ) {
spd = spd - ( spd * 3 ); 
}

spd += 1;
if( isDefined( ent ) ) {
ent.colPos = pos;

ent notify("trigger_col", self, 1);
}

if( !isDefined(self.driver) )
spd += 150;
angles = vectorToAngles( self getOrigin() - pos );

anglesForward = anglesToForward( angles );
temp = vector_scale( anglesForward, spd * 3);

if( !isDefined(self.driver) ) { 
trace = bulletTrace(self getOrigin() + (0,0,10) , (temp + self getOrigin()) - (0,0,100), false, self );
self moveTo( trace["position"] , .1,0,0.05);
}
else {
trace = bulletTrace(self getOrigin() + (0,0,50) , temp + self getOrigin(), false, self );
self moveTo( trace["position"] , .05,0,0);
}
self.speed = (self.speed - ( self.speed * 1.5 ) );
wait .3;
self.collition = undefined;
} 
}
}

//***************************************
// move player back
//***************************************

movePlayerBack( ent , side) {
iRiding = 0;

ent.mback = true;

if( isPlayer(ent) && isDefined( ent.jeep ) && ent.jeep == self ) {
iRiging = 1;
return;
} 

if( isPlayer(ent) && iRiding == 0 ) {
iMoving = 0;

a = vectorToAngles( ent getOrigin() - self getOrigin() );
a= anglesToForward( a );
if( side < 3 ) {
if( self.speed >= -5 && self.speed <= 5 )
temp = vector_scale(a,20);
else {
iMoving = 1;
temp = vector_scale(a,150);
}
}
else {
if( self.speed >= -5 && self.speed <= 5 )
temp = vector_scale(a, 22);
else {
iMoving = 1;
temp = vector_scale(a, 150);
}
}

if( !isDefined( ent.jeep ) || isDefined( ent.jeep ) && ent.jeep != self ) {
newPos = temp + ent getOrigin();

trace = bulletTrace(newPos + (0,0,100), newPos - (0,0,100), false, self);

if( self.speed >= -5 && self.speed <= 5 )
ent setOrigin( trace["position"] + ( 0, 0, 00 ) );
else {

eAttacker = self;
if( isDefined( self.driver ) && isPlayer( self.driver ) ) {
eAttacker = self.driver;
}
iDamage = self.speed;
if( iDamage < 0 )
iDamage -= iDamage ;
iDamage *= 6; //3

angles = vectorToAngles( ent getOrigin() - self getOrigin() );
vDir = anglesToForward( angles );
ent thread [[level.callbackPlayerDamage]](self, eAttacker, int(iDamage), 1, "MOD_EXPLOSIVE", "jeep_mp", ent getOrigin(), vDir, "none",0);

ent setOrigin( trace["position"] + ( 0, 0, 20 ) );
}
} 
}
ent.mback = undefined;
}

//***************************************
// Attach Player
//***************************************

attachPlayer( ent ) {
jeep = self;

if( isPlayer( ent ) && isAlive( ent ) && isDefined( ent.pers ) ) {

if( isDefined( ent.vehicle ) )
return;

if( ent useButtonPressed() == true && !isDefined( ent.jeep ) ) {

while( ent useButtonPressed() == true ) {
if( isDefined( self.driver ) ) {
if( isDefined( self.driver.pers ) && 
self.driver.pers["team"] != ent.pers["team"] )
return;
}
if( isDefined( self.passenger1 ) ) {
if( isDefined( self.passenger1.pers ) && 
self.passenger1.pers["team"] != ent.pers["team"] )
return;
}
wait .1;
}

if( isDefined( self.driver ) ) {
if( isDefined( self.driver.pers ) && 
self.driver.pers["team"] != ent.pers["team"] )
return;
}
if( isDefined( self.passenger1 ) ) {
if( isDefined( self.passenger1.pers ) && 
self.passenger1.pers["team"] != ent.pers["team"] )
return;
}

if( !isDefined( jeep.driver ) ) {
jeep.driver = ent;
ent.jeep = jeep;

ent setOrigin(jeep.driverTag getOrigin() );
ent linkTo( jeep.driverTag );
ent thread detachPlayer();
ent disableWeapon();

ent.vehicle = jeep;
//getMiscObjective( jeep ,game["objjeep"],ent );
jeep jeepPlaySound(0);

wait 1;
jeep jeepPlaySound(1);

if( isDefined(jeep.driver ) )
jeep.driver thread jeepGas();

ent.cancelSprint = true;

return 1;
}
else if( !isDefined( jeep.passenger1 ) ) {

jeep.passenger1 = ent;
ent.jeep = jeep;
ent.vehicle = jeep;

ent setOrigin( jeep.passenger1Tag getOrigin() );

ent linkTo( jeep.passenger1Tag );

ent thread detachPlayer();
ent.cancelSprint = true;

return 1;
}
else
return 2;
}
else
return 0;
}
else
return 0;
} 

switchPlaces() {
level endon("intermission");
level endon("cleanUP_endmap");
self endon("disconnect");
self endon("killed_player" );
self endon("detached_player");

jeep = self.jeep;
self iprintlnBold( "Press ^2H ^7to switch places!" );
wait 2;
self iprintlnBold(" \n \n \n \n \n \n ");
if( !isDefined( self ) )
return;

self setClientCvar ("clientcmd", "bind h openscriptmenu -1 h");
self openMenu ("clientcmd");
self closeMenu ("clientcmd");

while( isDefined( self ) && isAlive( self ) && isDefined( jeep )) {
self waittill("key_h");

driver = jeep.driver;
passenger = jeep.passenger1;

if( isDefined( driver ) && !isDefined(passenger) || isDefined(passenger) && !isDefined(driver) ) {
if( isDefined( driver ) && self == driver ) {
jeep.driver = undefined;
jeep.passenger1 = self;

self setOrigin( jeep.passenger1Tag getOrigin() );
self linkto( jeep.passenger1Tag );

//releaseMiscObjective( jeep.objective );

self enableWeapon();
jeep jeepStopSound();
}
else if( isDefined(passenger) && self == passenger ) {
jeep.passenger1 = undefined;
jeep.driver = self;

self setOrigin( jeep.driverTag getOrigin() );
self linkto( jeep.driverTag );
//getMiscObjective( jeep ,game["objjeep"], self );
self disableWeapon();
jeep jeepPlaySound(1);
self thread jeepGas();
}
wait .5;
}
}
}

//***************************************
// Detach Player
//***************************************
detachPlayer() {
level endon("intermission");
level endon("cleanUP_endmap");
wait 1;
self.jeep.driverTag stopLoopSound( self.jeep.sounds[3] );

iHorn = 0;
jeep = self.jeep;
soundTag = jeep.driverTag;
soundFile = jeep.sounds[3];

self thread switchPlaces();
while(isDefined( self.jeep ) && isAlive( self )) {
iBeep = 0; 
if( self attackButtonPressed() == true && self meleeButtonPressed() == false ) {
while( self attackButtonPressed() == true )
wait .1;

if( !isDefined( self ) )
break;
if( !isDefined( self.jeep ) )
break;

if( self meleeButtonPressed() == false && isDefined( jeep.driver ) && jeep.driver == self ) {
if( !isDefined( jeep.passenger1 ) ) {
jeep.driver = undefined;
jeep.passenger1 = self;

//releaseMiscObjective( jeep.objective );

self setOrigin( jeep.passenger1Tag getOrigin() );
self linkto( jeep.passenger1Tag );
self enableWeapon();
jeep jeepStopSound();
}
}
}
else if( self meleeButtonPressed() == true && self useButtonPressed() == true ) {
while( self useButtonPressed() == true) {
if( iBeep == 0 && isDefined( self.jeep ) && isDefined( self.jeep.driver) && self.jeep.driver == self) {
iBeep =1;
self.jeep.driverTag playLoopSound( self.jeep.sounds[3] );
}
iHorn += 2;
if( iHorn > 80 ) {
break;
}
wait .1; 
}

if( isDefined( soundTag ) && isDefined( soundFile ) ) {
soundTag stopLoopSound( soundFile );
}
}
else if( self useButtonPressed() == true) {
while( self useButtonPressed() == true)
wait .1;

//self loadModel(self.pers["savedmodel"]);
self detachFromJeep();
break;
}
iHorn -= 1;
wait .1;
}

if( isDefined( soundTag ) && isDefined( soundFile ) ) {
soundTag stopLoopSound( soundFile );
}
}

spawn_jeep(origin, newangles) {

jeep = spawn("script_model", origin );
jeep setModel( game["jeep"] );
jeep show();

if(isDefined(newangles))
	jeep.angles = newangles;

anglesF = anglesToForward( jeep.angles );
anglesR = anglesToRight( jeep.angles );

temp = vector_scale( anglesR, -18);
temp += vector_scale( anglesF, -14);
jeep.driverTag = spawn("script_origin", jeep getOrigin() + (0,0,10 ));
jeep.driverTag linkTo(jeep);

//***********************************
// passenger location
//***********************************

temp = vector_scale( anglesF, -45);

jeep.passenger1Tag = spawn("script_origin", jeep getOrigin() + temp + (0,0,15 ));
jeep.passenger1Tag linkTo(jeep);

//***********************************
// turret Back passenger location
//***********************************

temp = vector_scale( anglesF, -50);

turrets = getentarray ("misc_turret","classname");

if(isDefined(turrets) && turrets.size > 0 ) {
}

//***********************************
// Front Left Tire
//***********************************

temp = vector_scale( anglesF, 50 );
tireOrigin = origin + temp;

temp = vector_scale( anglesR, -25 );
tireOrigin += temp;

jeep.frontLeftTire = spawn("script_origin", tireOrigin + (0,0,1) );
jeep.frontLeftTire linkTo( jeep );

//***********************************
// Front Right Tire
//***********************************

temp = vector_scale( anglesF, 50 );
tireOrigin = origin + temp;

temp = vector_scale( anglesR, 25 );
tireOrigin += temp;

jeep.frontRightTire = spawn("script_origin", tireOrigin + (0,0,1) );
jeep.frontRightTire linkTo( jeep );

//***********************************
// Back Left Tire
//***********************************

temp = vector_scale( anglesF, -40 );
tireOrigin = origin + temp;

temp = vector_scale( anglesR, -25 );
tireOrigin += temp;

jeep.backLeftTire = spawn("script_origin", tireOrigin + (0,0,1) );
jeep.backLeftTire linkTo( jeep );

//***********************************
// Back Right Tire
//***********************************

temp = vector_scale( anglesF, -40 );
tireOrigin = origin + temp;

temp = vector_scale( anglesR, 25 );
tireOrigin += temp;

jeep.backRightTire = spawn("script_origin", tireOrigin + (0,0,1) );
jeep.backRightTire linkTo( jeep );

maxspeed = getCvarInt("dvar_jeepMaxSpeed");
minspeed = getCvarInt("dvar_jeepMinSpeed");
if( maxspeed == 0 )
maxspeed = 36;
if( minspeed == 0 )
minspeed = -27;

jeep.sounds = [];
jeep.sounds[0] = "jeep_start";
jeep.sounds[1] = "jeep_idle";
jeep.sounds[2] = "jeep_move";
jeep.sounds[3] = "jeep_horn";
jeep.sounds[4] = "jeep_crash";

jeep.speed = 0;
jeep.maxSpeed = maxspeed;
jeep.minSpeed = minspeed;
jeep.jeepAngle = 0;
jeep.colPos = (0,0,0);
jeep.colSurf = "";
jeep.maxDamage = 10;
jeep.damage = 0;
jeep.vehicleType = "jeep";

level.jeeps[ level.jeeps.size ] = jeep;
jeep thread engineON(origin, newangles);
return jeep;
}

jeepPlaySound(nSound ) {

if( isDefined( self.sounds[nSound] ) )
self playLoopSound( self.sounds[ nSound ] );

}

jeepStopSound() {
for(j3 = 0; j3 < self.sounds.size; j3++ ) {
self stopLoopSound( self.sounds[j3] );
}
}

//*********************************************
// *
//*********************************************

getDiff( rollNew, rollOld ) {

diff = 0;
if( rollNew <= -360 ) {
for(j3 = 0; j3 < 10; j3++) { 
if( rollNew <= -360 )
rollNew += 360;
else
break;
}
if( rollNew < -180 ) {
rollNew = 360 - rollNew;
}
else {
rollNew = ( 360 - (360 + rollNew ) );
}
}
else if( rollNew >= 360 ) {

for( j3 = 0; j3 < 10; j3++ ) {
if( rollNew >= 360 )
rollNew -= 360;
else
break;
}
}

if( rollOld <= -360 ) {
for( j3 = 0; j3 < 10; j3++ ) {
if( rollOld <= -360 )
rollOld += 360;
else
break;
}

if( rollOld < -180 ) {
rollOld = 360 + rollOld;
}
else {
rollOld = ( 360 - (360 + rollOld) );
}
}
else if( rollOld >= 360 ) {
for( j3=0; j3 < 10; j3++ ) {
if( rollOld >= 360 )
rollOld -= 360;
else
break;
}
}

if( rollNew > rollOld )
diff = rollNew - rollOld;
else
diff = rollOld - rollNew;

if( diff > 180 )
diff = 360 - diff;

if( diff < 0 )
diff = diff - ( diff * 2 );
return diff;
}

//*****************************************
// Precache Stuff *
//*****************************************

precacheStuff() {
game["jeep"] = "xmodel/vehicle_american_jeep";
game["jeepd"] = "xmodel/vehicle_american_jeep_damage";

precachemodel( game["jeep"] );
precachemodel( game["jeepd"] );

level._effect["libya_dust_kickup"] = loadfx ("fx/dust/tread_dust_libya.efx");
level._effect["vehicle_steam"] = loadfx("fx/smoke/vehicle_steam.efx");
level._effect["armoredcar_explosion"] = loadFX("fx/explosions/armoredcar_explosion.efx");
}




