main ()
{
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff();
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
hurtzone1 = getent("door1trig","targetname");
hurtzone1 thread maps\mp\_utility::triggerOff(); 
hurtzone2 = getent("door2trig","targetname");
hurtzone2 thread maps\mp\_utility::triggerOn(); 


thread codet_spawn_coded();
thread codet_delete_codet();
thread codet_delete_FailedO();   
thread codet_spawn_FailedU();

thread coded_spawn_codej();
thread coded_delete_coded();
thread coded_delete_FailedY();   
thread coded_spawn_FailedO();

thread codej_spawn_codeh();
thread codej_delete_codej();
thread codej_delete_FailedU();  
thread codej_spawn_FailedY();

thread codeh_spawn_codez();
thread codeh_delete_codeh();
thread codeh_delete_FailedN();   
thread codeh_spawn_FailedU();

thread codez_spawn_codet();
thread codez_delete_codez();
thread codez_delete_FailedU();   
thread codez_spawn_FailedN();
thread codez_delete_door1trig();   
thread codez_spawn_door1trig();
thread codez_delete_door2trig();   
thread codez_spawn_door2trig();
thread door2_open();
thread door1_open();


thread FailedN_spawn_codet();
thread FailedN_delete_FailedU();
thread FailedN_delete_codez();
thread FailedN_delete_coded();   
thread FailedN_delete_codej();
thread FailedN_delete_codeh();
thread FailedN_spawn_FailedO();
thread FailedN_spawn_FailedN();   
thread FailedN_spawn_FailedY();

thread FailedD_spawn_codet();
thread FailedD_delete_FailedU();
thread FailedD_delete_codez();
thread FailedD_delete_coded();   
thread FailedD_delete_codej();
thread FailedD_delete_codeh();
thread FailedD_spawn_FailedO();
thread FailedD_spawn_FailedN();   
thread FailedD_spawn_FailedY();

thread FailedY_spawn_codet();
thread FailedY_delete_FailedU();
thread FailedY_delete_codez();
thread FailedY_delete_coded();   
thread FailedY_delete_codej();
thread FailedY_delete_codeh();
thread FailedY_spawn_FailedO();
thread FailedY_spawn_FailedN();   
thread FailedY_spawn_FailedY();

thread FailedS_spawn_codet();
thread FailedS_delete_FailedU();
thread FailedS_delete_codez();
thread FailedS_delete_coded();   
thread FailedS_delete_codej();
thread FailedS_delete_codeh();
thread FailedS_spawn_FailedO();
thread FailedS_spawn_FailedN();   
thread FailedS_spawn_FailedY();

thread FailedA_spawn_codet();
thread FailedA_delete_FailedU();
thread FailedA_delete_codez();
thread FailedA_delete_coded();   
thread FailedA_delete_codej();
thread FailedA_delete_codeh();
thread FailedA_spawn_FailedO();
thread FailedA_spawn_FailedN();   
thread FailedA_spawn_FailedY();

thread FailedB_spawn_codet();
thread FailedB_delete_FailedU();
thread FailedB_delete_codez();
thread FailedB_delete_coded();   
thread FailedB_delete_codej();
thread FailedB_delete_codeh();
thread FailedB_spawn_FailedO();
thread FailedB_spawn_FailedN();   
thread FailedB_spawn_FailedY();

thread FailedP_spawn_codet();
thread FailedP_delete_FailedU();
thread FailedP_delete_codez();
thread FailedP_delete_coded();   
thread FailedP_delete_codej();
thread FailedP_delete_codeh();
thread FailedP_spawn_FailedO();
thread FailedP_spawn_FailedN();   
thread FailedP_spawn_FailedY();

thread FailedO_spawn_codet();
thread FailedO_delete_FailedU();
thread FailedO_delete_codez();
thread FailedO_delete_coded();   
thread FailedO_delete_codej();
thread FailedO_delete_codeh();
thread FailedO_spawn_FailedO();
thread FailedO_spawn_FailedN();   
thread FailedO_spawn_FailedY();

thread FailedU_spawn_codet();
thread FailedU_delete_FailedU();
thread FailedU_delete_codez();
thread FailedU_delete_coded();   
thread FailedU_delete_codej();
thread FailedU_delete_codeh();
thread FailedU_spawn_FailedO();
thread FailedU_spawn_FailedN();   
thread FailedU_spawn_FailedY();  

thread doorsound1();






}
codet_spawn_coded()
{
getent("codet","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codet_spawn_coded();
}
codet_delete_codet()
{
getent("codet","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codet_delete_codet();
}
codet_delete_FailedO()
{
getent("codet","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codet_delete_FailedO();
}
codet_spawn_FailedU()
{
getent("codet","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codet_spawn_FailedU();
}
coded_spawn_codej()
{
getent("coded","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread coded_spawn_codej();
}
coded_delete_coded()
{
getent("coded","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread coded_delete_coded();
}
coded_delete_FailedY()
{
getent("coded","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread coded_delete_FailedY();
}
coded_spawn_FailedO()
{
getent("coded","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread coded_spawn_FailedO();
}
codej_spawn_codeh()
{
getent("codej","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codej_spawn_codeh();
}
codej_delete_codej()
{
getent("codej","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codej_delete_codej();
}
codej_delete_FailedU()
{
getent("codej","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codej_delete_FailedU();
}
codej_spawn_FailedY()
{
getent("codej","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codej_spawn_FailedY();
}
codeh_spawn_codez()
{
getent("codeh","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codeh_spawn_codez();
}
codeh_delete_codeh()
{
getent("codeh","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codeh_delete_codeh();
}
codeh_delete_FailedN()
{
getent("codeh","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codeh_delete_FailedN();
}
codeh_spawn_FailedU()
{
getent("codeh","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codeh_spawn_FailedU();
}
codez_spawn_codet()
{
getent("codez","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codez_spawn_codet();
}
codez_delete_codez()
{
getent("codez","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codez_delete_codez();
}
codez_delete_FailedU()
{
getent("codez","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread codez_delete_FailedU();
}
codez_spawn_FailedN()
{
getent("codez","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread codez_spawn_FailedN();
}
codez_spawn_door1trig()
{
getent("codez","targetname") waittill ("trigger");
wait (2); 
hurtzone1 = getent("door1trig","targetname");
hurtzone1 thread maps\mp\_utility::triggerOn(); 
wait (10);
thread codez_spawn_door1trig();
}
codez_delete_door1trig()
{
getent("codez","targetname") waittill ("trigger");
wait (8); 
hurtzone1 = getent("door1trig","targetname");
hurtzone1 thread maps\mp\_utility::triggerOff(); 
wait (4);
thread codez_delete_door1trig();
}
codez_spawn_door2trig()
{
getent("codez","targetname") waittill ("trigger");
wait (9); 
hurtzone2 = getent("door2trig","targetname");
hurtzone2 thread maps\mp\_utility::triggerOn(); 
wait (3);
thread codez_spawn_door2trig();
}
codez_delete_door2trig()
{
getent("codez","targetname") waittill ("trigger");
wait (2); 
hurtzone2 = getent("door2trig","targetname");
hurtzone2 thread maps\mp\_utility::triggerOff(); 
wait (10);
thread codez_delete_door2trig();
}
door2_open()
{
door = getent ("door2", "targetname");
trig = getent ("codez", "targetname");
trig waittill ("trigger");
wait (2);
door movex (42,2);
wait (6);
door movex (-42,2);
wait (4);
thread door2_open();
}
door1_open()
{
door = getent ("door1", "targetname");
trig = getent ("codez", "targetname");
trig waittill ("trigger");
door movex (-42,2);
wait (10);
door movex (42,2);
wait (2);
thread door1_open();
}






FailedN_spawn_codet()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedN_spawn_codet();
}
FailedN_delete_FailedU()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedN_delete_FailedU();
}
FailedN_delete_codez()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedN_delete_codez();
}
FailedN_delete_coded()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedN_delete_coded();
}
FailedN_delete_codej()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedN_delete_codej();
}
FailedN_delete_codeh()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedN_delete_codeh();
}
FailedN_spawn_FailedO()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedN_spawn_FailedO();
}
FailedN_spawn_FailedN()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedN_spawn_FailedN();
}
FailedN_spawn_FailedY()
{
getent("FailedN","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedN_spawn_FailedY();
}





FailedD_spawn_codet()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedD_spawn_codet();
}
FailedD_delete_FailedU()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedD_delete_FailedU();
}
FailedD_delete_codez()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedD_delete_codez();
}
FailedD_delete_coded()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedD_delete_coded();
}
FailedD_delete_codej()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedD_delete_codej();
}
FailedD_delete_codeh()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedD_delete_codeh();
}
FailedD_spawn_FailedO()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedD_spawn_FailedO();
}
FailedD_spawn_FailedN()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedD_spawn_FailedN();
}
FailedD_spawn_FailedY()
{
getent("FailedD","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedD_spawn_FailedY();
}





FailedY_spawn_codet()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedY_spawn_codet();
}
FailedY_delete_FailedU()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedY_delete_FailedU();
}
FailedY_delete_codez()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedY_delete_codez();
}
FailedY_delete_coded()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedY_delete_coded();
}
FailedY_delete_codej()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedY_delete_codej();
}
FailedY_delete_codeh()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedY_delete_codeh();
}
FailedY_spawn_FailedO()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedY_spawn_FailedO();
}
FailedY_spawn_FailedN()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedY_spawn_FailedN();
}
FailedY_spawn_FailedY()
{
getent("FailedY","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedY_spawn_FailedY();
}






FailedS_spawn_codet()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedS_spawn_codet();
}
FailedS_delete_FailedU()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedS_delete_FailedU();
}
FailedS_delete_codez()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedS_delete_codez();
}
FailedS_delete_coded()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedS_delete_coded();
}
FailedS_delete_codej()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedS_delete_codej();
}
FailedS_delete_codeh()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedS_delete_codeh();
}
FailedS_spawn_FailedO()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedS_spawn_FailedO();
}
FailedS_spawn_FailedN()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedS_spawn_FailedN();
}
FailedS_spawn_FailedY()
{
getent("FailedS","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedS_spawn_FailedY();
}





FailedA_spawn_codet()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedA_spawn_codet();
}
FailedA_delete_FailedU()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedA_delete_FailedU();
}
FailedA_delete_codez()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedA_delete_codez();
}
FailedA_delete_coded()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedA_delete_coded();
}
FailedA_delete_codej()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedA_delete_codej();
}
FailedA_delete_codeh()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedA_delete_codeh();
}
FailedA_spawn_FailedO()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedA_spawn_FailedO();
}
FailedA_spawn_FailedN()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedA_spawn_FailedN();
}
FailedA_spawn_FailedY()
{
getent("FailedA","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedA_spawn_FailedY();
}





FailedB_spawn_codet()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedB_spawn_codet();
}
FailedB_delete_FailedU()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedB_delete_FailedU();
}
FailedB_delete_codez()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedB_delete_codez();
}
FailedB_delete_coded()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedB_delete_coded();
}
FailedB_delete_codej()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedB_delete_codej();
}
FailedB_delete_codeh()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedB_delete_codeh();
}
FailedB_spawn_FailedO()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedB_spawn_FailedO();
}
FailedB_spawn_FailedN()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedB_spawn_FailedN();
}
FailedB_spawn_FailedY()
{
getent("FailedB","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedB_spawn_FailedY();
}





FailedP_spawn_codet()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedP_spawn_codet();
}
FailedP_delete_FailedU()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedP_delete_FailedU();
}
FailedP_delete_codez()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedP_delete_codez();
}
FailedP_delete_coded()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedP_delete_coded();
}
FailedP_delete_codej()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedP_delete_codej();
}
FailedP_delete_codeh()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedP_delete_codeh();
}
FailedP_spawn_FailedO()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedP_spawn_FailedO();
}
FailedP_spawn_FailedN()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedP_spawn_FailedN();
}
FailedP_spawn_FailedY()
{
getent("FailedP","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedP_spawn_FailedY();
}






FailedO_spawn_codet()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedO_spawn_codet();
}
FailedO_delete_FailedU()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedO_delete_FailedU();
}
FailedO_delete_codez()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedO_delete_codez();
}
FailedO_delete_coded()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedO_delete_coded();
}
FailedO_delete_codej()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedO_delete_codej();
}
FailedO_delete_codeh()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedO_delete_codeh();
}
FailedO_spawn_FailedO()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedO_spawn_FailedO();
}
FailedO_spawn_FailedN()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedO_spawn_FailedN();
}
FailedO_spawn_FailedY()
{
getent("FailedO","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedO_spawn_FailedY();
}





FailedU_spawn_codet()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys2 = getent("codet","targetname");
Keys2 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedU_spawn_codet();
}
FailedU_delete_FailedU()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys4 = getent("FailedU","targetname");
Keys4 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedU_delete_FailedU();
}
FailedU_delete_codez()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys8 = getent("codez","targetname");
Keys8 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedU_delete_codez();
}
FailedU_delete_coded()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys1 = getent("coded","targetname");
Keys1 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedU_delete_coded();
}
FailedU_delete_codej()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys5 = getent("codej","targetname");
Keys5 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedU_delete_codej();
}
FailedU_delete_codeh()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys7 = getent("codeh","targetname");
Keys7 thread maps\mp\_utility::triggerOff(); 
wait (0);
thread FailedU_delete_codeh();
}
FailedU_spawn_FailedO()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys3 = getent("FailedO","targetname");
Keys3 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedU_spawn_FailedO();
}
FailedU_spawn_FailedN()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys9 = getent("FailedN","targetname");
Keys9 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedU_spawn_FailedN();
}
FailedU_spawn_FailedY()
{
getent("FailedU","targetname") waittill ("trigger");
wait (0); 
Keys6 = getent("FailedY","targetname");
Keys6 thread maps\mp\_utility::triggerOn(); 
wait (0);
thread FailedU_spawn_FailedY();
}




doorsound1()
{
	alerts = getentarray ("doorsound", "targetname");
	while (1)
	{
                     trig = getent ("codez", "targetname");
                     trig waittill ("trigger");
		
		{
			for (i=1;i<alerts.size;i++)
				alerts[0] playsound("doors");

			alerts[0] playsound("doors");

			wait (12);
		}
		}
	}




