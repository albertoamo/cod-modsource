main()
{

level._effect["mortexplosion"] = loadfx("fx/explosions/artilleryExp_dirt_brown.efx");


thread mortar1();
thread mortar2();
thread mortar3();
thread mortar4();


}

mortar1()
{

action = getent ("action","targetname");
botground = getent ("botlayer","targetname");
topground = getent ("toplayer","targetname");
trigger = getent ("morttrig","targetname");

botground hide();

trigger waittill ("trigger");

origin = action getorigin();

action playsound("incoming_mortar");

wait (1);

action playsound("explosion_ground");

playfx(level._effect["mortexplosion"], origin);

botground show();

topground delete();



} 

mortar2()
{

action = getent ("action2","targetname");
botground = getent ("botlayer2","targetname");
topground = getent ("toplayer2","targetname");
trigger = getent ("morttrig2","targetname");

botground hide();

trigger waittill ("trigger");

origin = action getorigin();

action playsound("incoming_mortar");

wait (1);

action playsound("explosion_ground");

playfx(level._effect["mortexplosion"], origin);

botground show();

topground delete();



} 

mortar3()
{

action = getent ("action3","targetname");
botground = getent ("botlayer3","targetname");
topground = getent ("toplayer3","targetname");
trigger = getent ("morttrig3","targetname");

botground hide();

trigger waittill ("trigger");

origin = action getorigin();

action playsound("incoming_mortar");

wait (1);

action playsound("explosion_ground");

playfx(level._effect["mortexplosion"], origin);

botground show();

topground delete();



} 


mortar4()
{

action = getent ("action4","targetname");
topground = getent ("toplayer4","targetname");
trigger = getent ("morttrig4","targetname");

trigger waittill ("trigger");

origin = action getorigin();

action playsound("incoming_mortar");

wait (1);

action playsound("explosion_ground");

playfx(level._effect["mortexplosion"], origin);

topground delete();
} 