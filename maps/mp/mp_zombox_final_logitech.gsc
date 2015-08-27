//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread logitech();
}

logitech()
{
logy1 = getent("trig_logitech","targetname");
logy2 = getent("logitech","targetname");
logy3 = getent("logitech2","targetname");
while(1)
{
logy1 waittill ("trigger",user);
logy3 hide();
logy3 notsolid();
logy2 hide();
logy2 notsolid();
wait 1;
iprintlnbold ("^1WTF^7 " + user.name, " ^1FOUND THE SECRET BUNKER^7!!!"); 
wait 1;
iprintlnbold ("^1Hmm....where is that^7???"); 
wait 1;
iprintlnbold ("^1 I think it is near the ring"); 
logy1 delete();
}
}