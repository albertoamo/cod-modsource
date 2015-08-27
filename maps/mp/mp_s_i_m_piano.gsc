main()
{
keys = getentarray("piano_key","targetname");
for( i = 0 ; i < keys.size ; i++ )
keys[i] thread pianoThink();

dmg = getentarray("piano_damage","targetname");
for( i = 0 ; i < dmg.size ; i++ )
dmg[i] thread pianoDamageThink();
}

pianoThink()
{
note = "piano_" + self.script_noteworthy;

for (;;)
{
self waittill ("trigger");
self playsound (note);
//iprintln("playing piano sound");
}
}

pianoDamageThink()
{
note[0] = "large";
note[1] = "small";
for (;;)
{
self waittill ("trigger");
self playsound ("bullet_" + random(note) + "_piano", self.origin);
//iprintln("playing piano damage sound");
}
}

random (array)
{
return array [randomint (array.size)];
}