//Scripted By PwN3R
//Xfire:punishman1993
//Edited 2-3-09 by Mitch
//Added damage & changed the sound.
main()
{
thread bomba();
}

bomba()
{
bomba=getent("trig_boom","targetname");
boomer=getent("boom","targetname");
boomer1=getent("boom1","targetname");
boomer2=getent("boom2","targetname");
boomer3=getent("boom3","targetname");
while(1)
{
bomba waittill ("trigger",user);
boomer movez (-6, 0.5);
boomer2 PlaySound("click");
wait 0.5;
boomer2 PlaySound("buum");
range = 300;
maxdamage = 150;
mindamage = 10;
PlayFX(level._effect["boom"] ,(4464,-1944,-1944));
radiusDamage((4464,-1944,-1944), range, maxdamage, mindamage);
boomer1 hide();
boomer1 notsolid();
boomer2 hide();
boomer2 notsolid();
boomer3 hide();
boomer3 notsolid();
wait 1;
bomba delete();
}
}
