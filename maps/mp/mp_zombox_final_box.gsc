//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread box();
}

box()
{
boxer=getent("trig_cocaine","targetname");
boxer1=getent("cocaine","targetname");
boxer2=getent("cocaine1","targetname");
boxer3=getent("cocaine2","targetname");
while(1)
{
boxer waittill ("trigger",user);
iprintlnbold ("The box was open by " + user.name, "^7!!!");
wait 1;
iprintlnbold ("Zombie infection is coming!!!");
wait 1;
boxer1 hide();
boxer1 notsolid();
wait(1);
boxer2 hide();
boxer2 notsolid();
wait(1);
boxer3 hide();
boxer3 notsolid();
wait(1);
boxer delete();
}
}