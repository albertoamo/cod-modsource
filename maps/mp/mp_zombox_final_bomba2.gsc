//Scripted By PwN3R
//Xfire:punishman1993
//Edited 2-3-09 by Mitch
//Changed earthquake & sound & added damage 
main()
{
thread bomba2();
}

bomba2()
{
clses=getent("trig_barra","targetname");
cls=getent("barra","targetname");
cls1=getent("barra1","targetname");
cls2=getent("tnt","targetname");
cls3=getent("tnt1","targetname");
cls4=getent("tnt2","targetname");
cls5=getent("tnt3","targetname");
cls6=getent("tnt4","targetname");
cls7=getent("tnt5","targetname");
cls8=getent("tnt6","targetname");
cls9=getent("tnt7","targetname");
while(1)
{
clses waittill ("trigger",user);
user iprintlnbold ("Explosives planted!!! Get cover!!!");
cls2 PlaySound("tictac");
wait 2;
cls2 PlaySound("tictac");
wait 2;
cls2 PlaySound("tictac");
wait 2;
cls2 PlaySound("buum2");
range = 300;
maxdamage = 300;
mindamage = 30;
PlayFX(level._effect["boom"] ,(1208,-2232,-1608));
Earthquake( 0.3, 3, (1208,-2232,-1608), 850 );
radiusDamage((1208,-2232,-1608), range, maxdamage, mindamage);
cls hide();
cls notsolid();
cls1 hide();
cls1 notsolid();
cls2 hide();
cls2 notsolid();
cls3 hide();
cls3 notsolid();
cls4 hide();
cls4 notsolid();
cls5 hide();
cls5 notsolid();
cls6 hide();
cls6 notsolid();
cls7 hide();
cls7 notsolid();
cls8 hide();
cls8 notsolid();
cls9 hide();
cls9 notsolid();
wait 1;
clses delete();
}
}
