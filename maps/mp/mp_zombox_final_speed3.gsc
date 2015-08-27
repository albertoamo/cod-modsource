//Scripted By PwN3R
//Hmmm now learn how to put it in your map buahahahahaha
//Xfire:punishman1993

main()
{
  ents=getentarray("speed3","targetname");
  for(a=0;a<ents.size;a++)
    ents[a] thread speed();
}

speed()
{
  while(1)
  {
    speed = randomint((1000)+500);
    plate = getent(self.target, "targetname");
    org = plate.origin;
    self waittill("trigger",other);
    other PlaySound("whoosh");
    plate movegravity((0,1000,1050), 3);
    wait(0.9);
    plate notsolid();
    plate.origin = org;
    plate solid();
  }
}