//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread kemao();
}

kemao()
{
quemao1 = getent("trig_kemao","targetname");
quemao2 = getent("kemao1","targetname");
quemao3 = getent("kemau","targetname");
quemao4 = getent("railtop","targetname");
while(1)
{
quemao1 waittill ("trigger",user);
quemao4 PlaySound("move");
quemao4 hide();
wait 1;
quemao2 PlaySound("move1");
quemao2 movey (64,2);
quemao3 movey (64,2);
quemao1 delete();
}
}
