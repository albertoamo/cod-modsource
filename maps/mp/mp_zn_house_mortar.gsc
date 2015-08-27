main()
{

level._effect["mortexplosion"] = loadfx("fx/explosions/artilleryExp_dirt_libya.efx");


thread mortar1();
thread mortar2();


}

mortar1()
{

action = getent ("action","targetname");
botground1 = getent ("botlayer","targetname");
topground = getent ("toplayer","targetname");
trigger = getent ("morttrig","targetname");

botground1 hide();

trigger waittill ("trigger");

origin = action getorigin();

action playsound("incoming_mortar");

wait (1);

action playsound("explosion_ground");

playfx(level._effect["mortexplosion"], origin);

botground1 show();

topground delete();



} 

mortar2()
{

action = getent ("action4","targetname");
botground2 = getent ("botlayer4","targetname");
topground = getent ("toplayer4","targetname");
trigger = getent ("morttrig4","targetname");

botground2 hide();

trigger waittill ("trigger");

origin = action getorigin();

action playsound("incoming_mortar");

wait (1);

action playsound("explosion_ground");

playfx(level._effect["mortexplosion"], origin);

botground2 show();

topground delete();



}
