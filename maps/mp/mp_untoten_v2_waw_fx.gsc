main()
{
	thread wawfx();
}

wawfx()
{
	level._effect["candle"] = loadfx("fx/props/glow_latern.efx");
	maps\mp\_fx::loopfx("candle",(2120,212,-216), .5);
	maps\mp\_fx::loopfx("candle",(1768,212,-216), .5);
	maps\mp\_fx::loopfx("candle",(1483,266,-216), .5);
	maps\mp\_fx::loopfx("candle",(1080,379,-120), .5);
}