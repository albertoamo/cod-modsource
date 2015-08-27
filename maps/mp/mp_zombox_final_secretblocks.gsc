//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread secretblockers ();
}

secretblockers()
{
trig=getent("trig_secrets","targetname");
secretblocks1=getent("extern","targetname");
secretblocks2=getent("extern1","targetname");
secretblocks3=getent("extern2","targetname");
secretblocks4=getent("extern3","targetname");
secretblocks5=getent("extern4","targetname");
secretblocks6=getent("extern5","targetname");
secretblocks7=getent("extern6","targetname");
while(1)
{
trig waittill ("trigger",user);
ambientplay ("heavy");
iprintlnbold ("Secrets were unlocked by " + user.name, "^7!!!");
setcvar("zm_f_radio_en", "1");
wait 1;
iprintlnbold ("If u get killed by a zom insult him not me xD");
wait 1;
current = user getcurrentweapon();
weapon1 = user getweaponslotweapon("primary");
if(current == weapon1 && current == "katana_mp")
user GiveMaxAmmo( "glock_mp" );
PlayFX(level._effect["corpses"] ,(712,-1072,-2328));
PlayFX(level._effect["corpses"] ,(816,-976,-2328));
PlayFX(level._effect["corpses"] ,(576,-976,-2328));
wait 1;
secretblocks1 hide();
secretblocks1 notsolid();
wait(1);
secretblocks2 hide();
secretblocks2 notsolid();
wait(1);
secretblocks3 hide();
secretblocks3 notsolid();
wait(1);
secretblocks4 hide();
secretblocks4 notsolid();
wait(1);
secretblocks5 hide();
secretblocks5 notsolid();
wait(1);
secretblocks6 hide();
secretblocks6 notsolid();
wait(1);
secretblocks7 hide();
secretblocks7 notsolid();
wait(1);
trig delete();
}
}