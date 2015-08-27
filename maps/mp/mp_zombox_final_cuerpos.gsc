//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread cuerpos(); 
}

cuerpos()
{
cuerp = getent("trig_cuerpos", "targetname");	
while (1)
{
cuerp waittill("trigger",user);
user iprintlnbold ("You have found zombie body parts!!!");
PlayFX(level._effect["corpses"] ,(144,-2232,-216));
PlayFX(level._effect["corpses"] ,(768,-2232,-216));
wait 5;
}
}

