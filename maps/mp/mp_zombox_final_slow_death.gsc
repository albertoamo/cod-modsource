//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread lolzor(); 
thread lolzer();
}
lolzor() 
{
trig = getent("slow_death","targetname"); 
while(1)
{
trig waittill ("trigger",user);
trig playsound("eliminated");
user iprintlnbold ("^1You have chosen a slow death");
wait 3; 
}
}
lolzer() 
{
trig = getent("fast_death","targetname"); 
while(1)
{
trig waittill ("trigger",user);
trig playsound("eliminated");
user iprintlnbold ("^1You have chosen a fast death"); 
wait 3; 
}
}
