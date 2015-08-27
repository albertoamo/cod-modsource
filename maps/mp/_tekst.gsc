main()
{
thread triggertekst_1();
thread triggertekst_2();
thread triggertekst_3();
}

triggertekst_1() 
{
trig = getent("staal1trigger","targetname"); 
while(1)
{
trig waittill ("trigger",user);
user iprintlnbold ("^1WARNING, WARNING!!"); 
wait 12;
wait(47);  
}
}

triggertekst_2() 
{
trig = getent("val","targetname"); 
while(1)
{
trig waittill ("trigger",user);
user iprintlnbold ("^1WARNING!"); 
wait 24; 
}
}

triggertekst_3() 
{
trig = getent("val2","targetname"); 
while(1)
{
trig waittill ("trigger",user);
user iprintlnbold ("^1WARNING!"); 
wait 24;  
}
}