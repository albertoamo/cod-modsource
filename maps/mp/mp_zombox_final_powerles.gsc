//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread powerles();
}

powerles()
{
power = getent("keylogger","targetname");
power1 = getent("keylogger1","targetname");
power2 = getent("keylogger3","targetname");
power3 = getent("keylogger4","targetname");
while(1)
{
power waittill ("trigger",user);
power hide();
//power notsolid();
power2 hide();
power2 notsolid();
power3 hide();
power3 notsolid();
wait 1;
iprintlnbold ("Nice " + user.name, " ^7found the key!!!"); 
wait 1;
iprintlnbold ("^1H^7unter ^1R^7efuge is now open^1!!!"); 
wait 1;
user iprintlnbold ("This place is near the explosion"); 
power delete();
}
}