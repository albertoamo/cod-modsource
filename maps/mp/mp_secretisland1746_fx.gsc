main()
{
thread boat();
thread raft();
}

boat()
{
boat = getent("life_boat","targetname");

while(1)
{
wait(3);
boat movex(-1880,15,3,3);
boat waittill("movedone");
wait(3);
boat movex(1880,15,3,3);
boat waittill("movedone");
}
}

raft()
{
raft = getent("planks","targetname");

while(1)
{
wait(3);
raft movey(550,12,2.5,2.5);
raft waittill("movedone");
wait(3);
raft movey(-550,12,2.5,2.5);
raft waittill("movedone");
}
}