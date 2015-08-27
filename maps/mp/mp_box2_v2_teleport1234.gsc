
main()
{
thread teleport1234();
}



teleport1234()
{
  entTransporter = getentarray("enter1234","targetname");
  if(isdefined(entTransporter))
  {
    for(lp=0;lp<entTransporter.size;lp=lp+1)
      entTransporter[lp] thread Transporter1234();
  }


}


Transporter1234()
{
  while(true)
  {
    self waittill("trigger",other);
    entTarget = getent(self.target, "targetname");

    wait(0.10);
    other setorigin(entTarget.origin);
    other setplayerangles(entTarget.angles);
    //iprintlnbold ("You have been teleported !!!");");
    wait(0.10);
}
}