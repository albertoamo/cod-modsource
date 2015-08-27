main()
{
	precacheFX();
	ambientFX();	
	
}

precacheFX()
{
	

	//ambient FX                            		                                                      																																																																																
	
	level._effect["thin_light_smoke_S"]				= loadfx ("fx/smoke/thin_light_smoke_S.efx");         																																								
                     
}

ambientFX()
{


maps\mp\_fx::loopfx("thin_light_smoke_S", (612,152,-409), 0.7);


}