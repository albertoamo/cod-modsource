//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
//This one don't works dunno why......
main()
{
thread radio();
}

radio()
{
radio=getent("trig_radiolopper","targetname");
while(1)
{
radio waittill ("trigger",user);
if(getcvar("zm_f_radio_en") == "1")
{
sound = spawn("script_model", user.origin);
wait 0.05;
sound show();
sound PlaySound("heavy");
wait 26;
sound PlaySound("germaner");
wait 2;
sound PlaySound("musikita");
wait 125;
sound PlaySound("germaner");
wait 2;
sound PlaySound("musikita2");
wait 32;
sound PlaySound("germaner");
wait 2;
sound PlaySound("musikita3");
wait 120;
sound delete();
}
else
{
user iprintln("^7Message^1: ^7Unlock all secrets first^1!");
}
}
}
