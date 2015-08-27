//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread quadro();
}

quadro()
{
quadro1 = getent("trig_quadro","targetname");
quadro2 = getent("quadro","targetname");
while(1)
{
quadro1 waittill ("trigger",user);
quadro2 PlaySound("move2");
wait 1;
quadro2 PlaySound("move3");
quadro2 rotateyaw (120,1);
quadro1 delete();
}
}

