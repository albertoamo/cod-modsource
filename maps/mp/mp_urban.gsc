// Script by G.T.
main()
{

maps\mp\_load::main(); 

thread gru();	

thread ascensore();

thread ascensore2();

thread ascensore3();

thread ascensore4();

}


gru()
{
gru = getent("gru","targetname");
carrello = getent("carrello","targetname");
carico = getent("carico","targetname");

carico moveX (851,4,1,1);
carrello moveX (851,4,1,1);
carico waittill ("movedone");
//carrello waittill ("movedone");

carico moveZ (-160,2,1,1);
carico waittill ("movedone");

wait(3);

carico moveZ (160,2,1,1);
carico waittill ("movedone");


carico moveX (-851,4,1,1);
carrello moveX (-851,4,1,1);
carico waittill ("movedone");
//carrello waittill ("movedone");


gru RotateYaw (90,3,1,1);
carrello RotateYaw (90,3,1,1);
carico RotateYaw (90,3,1,1);
//gru waittill ("rotatedone");
//carrello waittill ("rotatedone");
carico waittill ("rotatedone");

carico moveY (600,4,1,1);
carrello moveY (600,4,1,1);
carico waittill ("movedone");
//carrello waittill ("movedone");


carico moveZ (-168,2,1,1);
carico waittill ("movedone");

wait(3);

carico moveZ (168,2,1,1);
carico waittill ("movedone");

carico moveY (-600,4,1,1);
carrello moveY (-600,4,1,1);
carico waittill ("movedone");
//carrello waittill ("movedone");

//rotate 48


gru RotateYaw (-133,5,1,1);
carrello RotateYaw (-133,5,1,1);
carico RotateYaw (-133,5,1,1);
//gru waittill ("rotatedone");
//carrello waittill ("rotatedone");
carico waittill ("rotatedone");

carico moveZ (-464,3,1,1);
carico waittill ("movedone");
wait (3);

carico moveZ (464,3,1,1);
carico waittill ("movedone");

gru RotateYaw (43,3,1,1);
carrello RotateYaw (43,3,1,1);
carico RotateYaw (43,3,1,1);
//gru waittill ("rotatedone");
//carrello waittill ("rotatedone");
carico waittill ("rotatedone");

carico moveX (851,4,1,1);
carrello moveX (851,4,1,1);
carico waittill ("movedone");
//carrello waittill ("movedone");

carico moveZ (-160,2,1,1);
carico waittill ("movedone");

wait(3);

carico moveZ (160,2,1,1);
carico waittill ("movedone");


carico moveX (-851,4,1,1);
carrello moveX (-851,4,1,1);
carico waittill ("movedone");
//carrello waittill ("movedone");

gru RotateYaw (-43,3,1,1);
carrello RotateYaw (-43,3,1,1);
carico RotateYaw (-43,3,1,1);
//gru waittill ("rotatedone");
//carrello waittill ("rotatedone");
carico waittill ("rotatedone");

carico moveZ (-464,3,1,1);
carico waittill ("movedone");
wait (3);

carico moveZ (464,3,1,1);
carico waittill ("movedone");

gru RotateYaw (43,3,1,1);
carrello RotateYaw (43,3,1,1);
carico RotateYaw (43,3,1,1);
//gru waittill ("rotatedone");
//carrello waittill ("rotatedone");
carico waittill ("rotatedone");



thread gru();

}




ascensore()
{
ascensore = getent("ascensore","targetname");
tasto1 = getent("tasto1","targetname");
tasto2 = getent("tasto2","targetname");


while(1)
{
tasto1 waittill ("trigger");
tasto1 thread maps\mp\_utility::triggerOff();
tasto2 thread maps\mp\_utility::triggerOff();
ascensore moveZ (-1288,5,1,1);
ascensore waittill ("movedone");
wait(3);
ascensore moveZ (1288,5,1,1);
ascensore waittill ("movedone");
tasto1 thread maps\mp\_utility::triggerOn();
tasto2 thread maps\mp\_utility::triggerOn();
}
}

ascensore2()
{
ascensore = getent("ascensore","targetname");
tasto1 = getent("tasto2","targetname");
tasto2 = getent("tasto1","targetname");


while(1)
{
tasto1 waittill ("trigger");
tasto1 thread maps\mp\_utility::triggerOff();
tasto2 thread maps\mp\_utility::triggerOff();
ascensore moveZ (-1288,5,1,1);
ascensore waittill ("movedone");
wait(3);
ascensore moveZ (1288,5,1,1);
ascensore waittill ("movedone");
tasto1 thread maps\mp\_utility::triggerOn();
tasto2 thread maps\mp\_utility::triggerOn();
}
}





ascensore3()
{
ascensore = getent("ascensore2","targetname");
tasto1 = getent("tast1","targetname");
tasto2 = getent("tast2","targetname");


while(1)
{
tasto1 waittill ("trigger");
tasto1 thread maps\mp\_utility::triggerOff();
tasto2 thread maps\mp\_utility::triggerOff();
ascensore moveZ (-1288,5,1,1);
ascensore waittill ("movedone");
wait(3);
ascensore moveZ (1288,5,1,1);
ascensore waittill ("movedone");
tasto1 thread maps\mp\_utility::triggerOn();
tasto2 thread maps\mp\_utility::triggerOn();
}
}


ascensore4()
{
ascensore = getent("ascensore2","targetname");
tasto1 = getent("tast2","targetname");
tasto2 = getent("tast1","targetname");


while(1)
{
tasto1 waittill ("trigger");
tasto1 thread maps\mp\_utility::triggerOff();
tasto2 thread maps\mp\_utility::triggerOff();
ascensore moveZ (-1288,5,1,1);
ascensore waittill ("movedone");
wait(3);
ascensore moveZ (1288,5,1,1);
ascensore waittill ("movedone");
tasto1 thread maps\mp\_utility::triggerOn();
tasto2 thread maps\mp\_utility::triggerOn();
}
}




