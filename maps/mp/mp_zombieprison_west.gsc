main()
{
	//setCullFog(0, 8000, 0.32, 0.36, 0.40, 0);
	//setExpFog(0.001, 0.32, 0.36, 0.40, 0);
	
	precacheShader("black"); 
	precacheShader("camera_lockon"); 
	game["menu_clientcmd"] = "clientcmd";
	precacheMenu(game["menu_clientcmd"]);
	
	maps\mp\_load::main();
	self thread gateCameras();

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");
    
}

gateCameras()
{
	trig_cameras = getent("trig_zp_cameras","targetname");
	gate_right = getent("zp_gate_right","targetname");
	gate_left = getent("zp_gate_left","targetname");
	camera_left = getent("zp_camera_left","targetname");
	camera_right = getent("zp_camera_right","targetname");
	cameraOrg = camera_right GetOrigin();
	rotateang = 270;
	
	while(1)
	{
		trig_cameras waittill("trigger",player);
		
		origin = player GetOrigin();
		player.anglesize = player.angles;
		player freezeControls( true );
		
		wait 0.2;
		camera_right moveto(origin,0.1);
		
		wait 0.2;
		player setModel("");
		player detachAll();
		player LinkTo(camera_right);
		player thread CameraHuds(player);
		
		wait 0.2;
		player iprintlnbold("Use Left or Right mouse to camera position");
		player iprintlnbold("Use Shift + Left mouse to open or close the gate");
		camera_right moveto(cameraOrg,0.1);
		player SetPlayerAngles(camera_right.angles);
		player thread CameraAction(cameraOrg, rotateang, origin, camera_right, player, gate_left, gate_right);
		player setClientCvar( "cg_drawgun", "0" );
	}
	
}
	
CameraAction(cameraOrg,rotateang,origin,camera_right,player, gate_left, gate_right)
{
	player endon("disconnect");

	if(!isDefined(level.gatesopen)) level.gatesopen = false;
	
	player execclientcommand( "bind MOUSE2 +melee_breath" );
	wait 0.01;

	livecamera = true;
	currenttime = -1;
	
	if(player.pers["team"] == "allies" && getCvar("g_gametype") == "zom") 
		currenttime = getTime() * 15000; // + 15 s

	player thread CameraActionOnDisconnect();

	while(livecamera == true)
	{		
		if(rotateang <=340 && player AttackButtonPressed())
		{
			player SetPlayerAngles((35,rotateang,0));
			rotateang = rotateang + 1;
		}
		else if(rotateang >=200 && player meleeButtonPressed())
		{
			player SetPlayerAngles((35,rotateang,0));
			rotateang = rotateang - 1;
		}

		if(player useButtonPressed() || (getTime() >= currenttime && currenttime != -1))
		{
			player.camerahud setShader("black", 640, 480);
			player iprintlnbold("Exit Camera");
			camera_right moveto(origin,0.1);
			wait 0.15;
			player SetPlayerAngles(player.anglesize);
			player unlink();
			player freezeControls( false );
			camera_right moveto(cameraOrg,0.1);
			wait 0.1;
			player.camerahud.alpha = 0;
			livecamera = false;
			player.camerahud destroy();
		    	player setClientCvar( "cg_drawgun", "1" );
			player execclientcommand( "bind MOUSE2 toggleads" );
			player maps\mp\gametypes\_teams::model();
			player notify("camera_action");
		}

		if(player meleeButtonPressed() && player AttackButtonPressed())
		{
			wait 0.05;

			if(!(player meleeButtonPressed() && player AttackButtonPressed()))
				continue;

			if(level.gatesopen == false)
				level thread OpenGate(gate_left, gate_right);
			else if(level.gatesopen == true)
				level thread CloseGate(gate_left, gate_right);
		}
		else
			wait 0.05;
	}
		
	
}

CameraActionOnDisconnect()
{
	self endon("camera_action");
	self waittill("disconnect");
	if(isDefined(self.camerahud)) self.camerahud destroy();
}

CloseGate(left, right)
{
	if(isDefined(level.gatesbusy))
		return;
	level.gatesbusy = true;

	right movey(-140,4,1,1);
	left movey(140,4,1,1);
	iprintlnbold("Gate Closing");
	left waittill ("movedone");
	level.gatesopen = false;
	level.gatesbusy = undefined;
}

OpenGate(left, right)
{
	if(isDefined(level.gatesbusy))
		return;
	level.gatesbusy = true;

	right movey(140,4,1,1);
	left movey(-140,4,1,1);
	iprintlnbold("Gate Opening");
	left waittill ("movedone");
	level.gatesopen = true;

	level.gatesbusy = undefined;
}

CameraHuds(player)
{
	player.camerahud = NewClientHudElem(player);
	player.camerahud.x = 0; 
	player.camerahud.y = 0; 
	player.camerahud.horzAlign = "fullscreen";
	player.camerahud.vertAlign = "fullscreen";
	player.camerahud.alpha = 1;
	player.camerahud.sort = 0;
	player.camerahud setShader("black", 640, 480);
	wait 0.4;
	player.camerahud setShader("camera_lockon", 640, 480);
	
	return player.camerahud;

}

ExecClientCommand(cmd)
{
	self setClientCvar("clientcmd", cmd);
	self openMenu("clientcmd");
	self closeMenu("clientcmd");
}