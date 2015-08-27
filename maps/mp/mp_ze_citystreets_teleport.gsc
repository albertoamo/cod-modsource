main()
{
entTransporter = getentarray("enter","targetname");

if(isdefined(entTransporter))
{
for(i=0;i<entTransporter.size;i++)
entTransporter[i] thread Transporter();
}
}

Transporter()
{
while(1)
{
self waittill("trigger",user);
entTarget = getent(self.target, "targetname");

wait .1;
user setorigin(entTarget.origin);
wait .1;
}
} 