init()
{
      precacheShader("zemine@hud");
      precacheShader("medpack");
      precacheShader("specialpower");
      precacheShader("cross_third"); 
      precacheShader("nvision");  
      precacheShader("nboz");
      precacheShader("nvg");
      precacheShader("zomevision");
      precacheShader("box_icon");
      precacheShader("znationlogo"); 
      precacheShader("medpack_hicon");
      precacheShader("objpoint_question");
      precacheString(&"^3Mine Planted");
      precacheString(&"Time dressed left: ");
      precacheString(&"^1MELEE ^7to add more power ^4| ^1ATTACK ^7to cancel ^4| ^1F ^7to confirm");
      precacheString(&"^7Give ^1");
      precacheString(&"^7Power Away To ");
      precacheshellshock("default");
      //precacheModel("xmodel/predator_pluxy");
      //precacheModel("xmodel/pluxy_alien");
      //precacheModel("xmodel/ammobag");
      precacheModel("xmodel/health_large");
      precacheModel("xmodel/grasstuftgroup_test");
      precacheModel("xmodel/prop_tombstone1");
      precacheModel("xmodel/prop_tombstone2");
      precacheModel("xmodel/prop_tombstone3");
      precacheModel("xmodel/prop_tombstone4");
      precacheModel("xmodel/prop_tombstone5");
      precacheModel("xmodel/health_medium");
      precacheModel("xmodel/bubble1");
	//precacheModel("xmodel/pluxy_zombie3");
 	level._effect["20mm_tracer_flash"] = loadfx ("fx/un/20mm_tracer_flash.efx");
	level._effect["20mm_wallexplode"] = loadfx("fx/explosions/20mm_wallexplode.efx");
	level._effect["radioexplosion"] = loadfx("fx/explosions/grenadeExp_blacktop.efx");
 	precacheModel("xmodel/turretbase");
	precacheModel("xmodel/turretmain");
	precacheModel("xmodel/turretcannon");

	if(game["allies"] == "american")
		game["radio_model"] = "xmodel/military_german_fieldradio_green_nonsolid";
	else if(game["allies"] == "british")
		game["radio_model"] = "xmodel/military_german_fieldradio_tan_nonsolid";
	else if(game["allies"] == "russian")
		game["radio_model"] = "xmodel/military_german_fieldradio_grey_nonsolid";
	assert(isdefined(game["radio_model"]));

	precacheModel(game["radio_model"]);
 
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
      //game["menu_quickactions"] = "quickactions";

	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);
      //precacheMenu(game["menu_quickactions"]);
      //precacheMenu(game["menu_zquickactions"]);
	precacheHeadIcon("talkingicon");
      precacheModel("xmodel/infected_mine");
      precacheModel("xmodel/prop_bear");

     //game["flashlight"]["light"]= loadfx("fx/misc/flashlight.efx");

     //game["splats"]["zom"]= loadfx("fx/misc/splats.efx");

     game["respawn"]["light"]= loadfx("fx/misc/respawn_effect.efx");

     //game["acid"]["effect"]= loadfx("fx/misc/acid_effect.efx");

     game["respawn"]["light2"]= loadfx("fx/misc/respawn_effect2.efx");

     game["vomit"]["effect"]= loadfx("fx/misc/vomit.efx");

     game["mineEffect"]["explode"]	= loadfx("fx/explosions/default_explosion.efx");

     game["zom"]["explode"]= loadfx("fx/misc/zom_explode.efx");
     game["bubble"]["create"]= loadfx("fx/misc/bubble_create.efx");
     //game["bubble"]["hit"]= loadfx("fx/misc/bubble_hit.efx");

     game["chose_medpack"] = "chose_medpack";
     precacheMenu(game["chose_medpack"]);

     level.plantedmines = [];
}


quickcommands(response)
{
	self endon("disconnect");

	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "US_mp_cmd_followme";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "US_mp_cmd_movein";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "US_mp_cmd_fallback";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "US_mp_cmd_suppressfire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "US_mp_cmd_attackleftflank";
				saytext = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
				//saytext = "Attack left flank!";
				break;

			case "6":
				soundalias = "US_mp_cmd_attackrightflank";
				saytext = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
				//saytext = "Attack right flank!";
				break;

			case "7":
				soundalias = "US_mp_cmd_holdposition";
				saytext = &"QUICKMESSAGE_HOLD_THIS_POSITION";
				//saytext = "Hold this position!";
				break;

			default:
				assert(response == "8");
				soundalias = "US_mp_cmd_regroup";
				saytext = &"QUICKMESSAGE_REGROUP";
				//saytext = "Regroup!";
				break;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "UK_mp_cmd_followme";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "UK_mp_cmd_movein";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "UK_mp_cmd_fallback";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "UK_mp_cmd_suppressfire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "UK_mp_cmd_attackleftflank";
				saytext = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
				//saytext = "Attack left flank!";
				break;

			case "6":
				soundalias = "UK_mp_cmd_attackrightflank";
				saytext = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
				//saytext = "Attack right flank!";
				break;

			case "7":
				soundalias = "UK_mp_cmd_holdposition";
				saytext = &"QUICKMESSAGE_HOLD_THIS_POSITION";
				//saytext = "Hold this position!";
				break;

			default:
				assert(response == "8");
				soundalias = "UK_mp_cmd_regroup";
				saytext = &"QUICKMESSAGE_REGROUP";
				//saytext = "Regroup!";
				break;
			}
			break;

		default:
			assert(game["allies"] == "russian");
			switch(response)		
			{
			case "1":
				soundalias = "RU_mp_cmd_followme";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "RU_mp_cmd_movein";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "RU_mp_cmd_fallback";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "RU_mp_cmd_suppressfire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "RU_mp_cmd_attackleftflank";
				saytext = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
				//saytext = "Attack left flank!";
				break;

			case "6":
				soundalias = "RU_mp_cmd_attackrightflank";
				saytext = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
				//saytext = "Attack right flank!";
				break;

			case "7":
				soundalias = "RU_mp_cmd_holdposition";
				saytext = &"QUICKMESSAGE_HOLD_THIS_POSITION";
				//saytext = "Hold this position!";
				break;

			default:
				assert(response == "8");
				soundalias = "RU_mp_cmd_regroup";
				saytext = &"QUICKMESSAGE_REGROUP";
				//saytext = "Regroup!";
				break;
			}
			break;
		}
	}
	else
	{
		assert(self.pers["team"] == "axis");
		switch(game["axis"])
		{
		default:
			assert(game["axis"] == "german");
			switch(response)		
			{
			case "1":
				soundalias = "GE_mp_cmd_followme";
				saytext = &"QUICKMESSAGE_FOLLOW_ME";
				//saytext = "Follow Me!";
				break;

			case "2":
				soundalias = "GE_mp_cmd_movein";
				saytext = &"QUICKMESSAGE_MOVE_IN";
				//saytext = "Move in!";
				break;

			case "3":
				soundalias = "GE_mp_cmd_fallback";
				saytext = &"QUICKMESSAGE_FALL_BACK";
				//saytext = "Fall back!";
				break;

			case "4":
				soundalias = "GE_mp_cmd_suppressfire";
				saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
				//saytext = "Suppressing fire!";
				break;

			case "5":
				soundalias = "GE_mp_cmd_attackleftflank";
				saytext = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
				//saytext = "Attack left flank!";
				break;

			case "6":
				soundalias = "GE_mp_cmd_attackrightflank";
				saytext = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
				//saytext = "Attack right flank!";
				break;

			case "7":
				soundalias = "GE_mp_cmd_holdposition";
				saytext = &"QUICKMESSAGE_HOLD_THIS_POSITION";
				//saytext = "Hold this position!";
				break;

			default:
				assert(response == "8");
				soundalias = "GE_mp_cmd_regroup";
				saytext = &"QUICKMESSAGE_REGROUP";
				//saytext = "Regroup!";
				break;
			}
			break;
		}			
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 4;
	self restoreHeadIcon();	
	self.spamdelay = undefined;
}

quickstatements(response)
{
	self endon("disconnect");

	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;
	
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "US_mp_stm_enemyspotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "US_mp_stm_enemydown";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "US_mp_stm_iminposition";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "US_mp_stm_areasecure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "US_mp_stm_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "US_mp_stm_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "US_mp_stm_needreinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			default:
				assert(response == "8");
				soundalias = "US_mp_stm_holdyourfire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "UK_mp_stm_enemyspotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "UK_mp_stm_enemydown";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "UK_mp_stm_iminposition";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "UK_mp_stm_areasecure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "UK_mp_stm_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "UK_mp_stm_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "UK_mp_stm_needreinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			default:
				assert(response == "8");
				soundalias = "UK_mp_stm_holdyourfire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;

		default:
			assert(game["allies"] == "russian");
			switch(response)		
			{
			case "1":
				soundalias = "RU_mp_stm_enemyspotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "RU_mp_stm_enemydown";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "RU_mp_stm_iminposition";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "RU_mp_stm_areasecure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "RU_mp_stm_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "RU_mp_stm_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "RU_mp_stm_needreinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			default:
				assert(response == "8");
				soundalias = "RU_mp_stm_holdyourfire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;
		}
	}
	else
	{
		assert(self.pers["team"] == "axis");
		switch(game["axis"])
		{
		default:
			assert(game["axis"] == "german");
			switch(response)		
			{
			case "1":
				soundalias = "GE_mp_stm_enemyspotted";
				saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
				//saytext = "Enemy spotted!";
				break;

			case "2":
				soundalias = "GE_mp_stm_enemydown";
				saytext = &"QUICKMESSAGE_ENEMY_DOWN";
				//saytext = "Enemy down!";
				break;

			case "3":
				soundalias = "GE_mp_stm_iminposition";
				saytext = &"QUICKMESSAGE_IM_IN_POSITION";
				//saytext = "I'm in position.";
				break;

			case "4":
				soundalias = "GE_mp_stm_areasecure";
				saytext = &"QUICKMESSAGE_AREA_SECURE";
				//saytext = "Area secure!";
				break;

			case "5":
				soundalias = "GE_mp_stm_grenade";
				saytext = &"QUICKMESSAGE_GRENADE";
				//saytext = "Grenade!";
				break;

			case "6":
				soundalias = "GE_mp_stm_sniper";
				saytext = &"QUICKMESSAGE_SNIPER";
				//saytext = "Sniper!";
				break;

			case "7":
				soundalias = "GE_mp_stm_needreinforcements";
				saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
				//saytext = "Need reinforcements!";
				break;

			default:
				assert(response == "8");
				soundalias = "GE_mp_stm_holdyourfire";
				saytext = &"QUICKMESSAGE_HOLD_YOUR_FIRE";
				//saytext = "Hold your fire!";
				break;
			}
			break;
		}			
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 4;
	self restoreHeadIcon();
	self.spamdelay = undefined;
}

quickresponses(response)
{
	self endon("disconnect");

	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;

	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])		
		{
		case "american":
			switch(response)		
			{
			case "1":
				soundalias = "US_mp_rsp_yessir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "US_mp_rsp_nosir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "US_mp_rsp_onmyway";
				saytext = &"QUICKMESSAGE_IM_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "US_mp_rsp_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "US_mp_rsp_greatshot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "US_mp_rsp_tooklongenough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";
				break;

			default:
				assert(response == "7");
				soundalias = "US_mp_rsp_areyoucrazy";
				saytext = &"QUICKMESSAGE_ARE_YOU_CRAZY";
				//saytext = "Are you crazy?";
				break;
			}
			break;

		case "british":
			switch(response)		
			{
			case "1":
				soundalias = "UK_mp_rsp_yessir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "UK_mp_rsp_nosir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "UK_mp_rsp_onmyway";
				saytext = &"QUICKMESSAGE_IM_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "UK_mp_rsp_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "UK_mp_rsp_greatshot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "UK_mp_rsp_tooklongenough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";
				break;

			default:
				assert(response == "7");
				soundalias = "UK_mp_rsp_areyoucrazy";
				saytext = &"QUICKMESSAGE_ARE_YOU_CRAZY";
				//saytext = "Are you crazy?";
				break;
			}
			break;

		default:
			assert(game["allies"] == "russian");
			switch(response)		
			{
			case "1":
				soundalias = "RU_mp_rsp_yessir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "RU_mp_rsp_nosir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "RU_mp_rsp_onmyway";
				saytext = &"QUICKMESSAGE_IM_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "RU_mp_rsp_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "RU_mp_rsp_greatshot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "RU_mp_rsp_tooklongenough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";
				break;

			default:
				assert(response == "7");
				soundalias = "RU_mp_rsp_areyoucrazy";
				saytext = &"QUICKMESSAGE_ARE_YOU_CRAZY";
				//saytext = "Are you crazy?";
				break;
			}
			break;
		}
	}
	else
	{
		assert(self.pers["team"] == "axis");
		switch(game["axis"])
		{
		default:
			assert(game["axis"] == "german");
			switch(response)		
			{
			case "1":
				soundalias = "GE_mp_rsp_yessir";
				saytext = &"QUICKMESSAGE_YES_SIR";
				//saytext = "Yes Sir!";
				break;

			case "2":
				soundalias = "GE_mp_rsp_nosir";
				saytext = &"QUICKMESSAGE_NO_SIR";
				//saytext = "No Sir!";
				break;

			case "3":
				soundalias = "GE_mp_rsp_onmyway";
				saytext = &"QUICKMESSAGE_IM_ON_MY_WAY";
				//saytext = "On my way.";
				break;

			case "4":
				soundalias = "GE_mp_rsp_sorry";
				saytext = &"QUICKMESSAGE_SORRY";
				//saytext = "Sorry.";
				break;

			case "5":
				soundalias = "GE_mp_rsp_greatshot";
				saytext = &"QUICKMESSAGE_GREAT_SHOT";
				//saytext = "Great shot!";
				break;

			case "6":
				soundalias = "GE_mp_rsp_tooklongenough";
				saytext = &"QUICKMESSAGE_TOOK_LONG_ENOUGH";
				//saytext = "Took long enough!";				
				break;

			default:
				assert(response == "7");
				soundalias = "GE_mp_rsp_areyoucrazy";
				saytext = &"QUICKMESSAGE_ARE_YOU_CRAZY";
				//saytext = "Are you crazy?";
				break;
			}
			break;
		}			
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 4;
	self restoreHeadIcon();
	self.spamdelay = undefined;
}

quicksounds(response)
{
	self endon("disconnect");

	if(response == "open")
	{
		self thread maps\mp\gametypes\_basic::LoadQuickActionsCvars("quicksounds");	
		return;
	}

	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;
	
	self.spamdelay = true;

	price = maps\mp\gametypes\_basic::GetActionPrices();
	price = price["sounds"][response];

	soundalias = "awwcrap";
	saytext = undefined;
	saytext2 = "Aww Crap";
	time = 1.5;

	if(isDefined(price) && self.power >= price)
	{
		if(response != "9")
			self maps\mp\gametypes\_basic::updatePower(price * -1);

		switch(response)		
		{
			case "1":
				soundalias = "lolwut";
				saytext = undefined;
				saytext2 = "Lolwut";
				time = 6;
				break;

			case "2":
				soundalias = "badboys";
				saytext = undefined;
				saytext2 = "Bad Boys";
				time = 5.5;
				break;

			case "3":
				soundalias = "muhaha";
				saytext = undefined;
				saytext2 = "Muhaha";
				time = 2;
				break;

			case "4":
				soundalias = "awwcrap";
				saytext = undefined;
				saytext2 = "Aww Crap";
				time = 1.5;
				break;

			case "5":
				soundalias = "adios";
				saytext = undefined;
				saytext2 = "Adios";
				time = 1.5;
				break;

			case "6":
				soundalias = "woohoo";
				saytext = undefined;
				saytext2 = "Woohoo";
				time = 1.5;				
				break;


			case "7":
				soundalias = "noobs";
				saytext = undefined;
				saytext2 = "Noobs";
				time = 2;				
				break;


			case "8":
				soundalias = "bennyhill";
				saytext = undefined;
				saytext2 = "Benny Hill";
				time = 19;				
				break;

			case "9":
				soundalias = undefined;
				saytext = undefined;
				saytext2 = undefined;
				self thread maps\mp\gametypes\_musicvote::voteMusic(price);
				break;

			default:
				soundalias = "awwcrap";
				saytext = undefined;
				saytext2 = "Aww Crap";
				time = 1.5;
				break;
		}

		self saveHeadIcon();
		if(isDefined(saytext2)) self iprintln(&"ZMESSAGES_PLAYINGNOW", saytext2);
		
		if(isDefined(soundalias)) self doQuickMessage(soundalias, saytext);
		wait time;

		self restoreHeadIcon();
	}
	else if(isDefined(price))
         	self iprintlnbold(&"ZMESSAGES_NOTENOUGHPOWER");

	self.spamdelay = undefined;
}

doQuickMessage(soundalias, saytext)
{
	if(self.sessionstate != "playing")
		return;

	if(isdefined(level.QuickMessageToAll) && level.QuickMessageToAll)
	{
		self.headiconteam = "none";
		self.headicon = "talkingicon";

		self playSound(soundalias);
		if(isDefined(saytext)) self sayAll(saytext);
	}
	else
	{
		if(self.sessionteam == "allies")
			self.headiconteam = "allies";
		else if(self.sessionteam == "axis")
			self.headiconteam = "axis";
		
		self.headicon = "talkingicon";

		self playSound(soundalias);
		if(isDefined(saytext)) self sayTeam(saytext);
		self pingPlayer();
	}
}

removeWayPoint()
{
	if(isDefined(self.waypoint_box))
		self.waypoint_box Destroy();
}

addWayPoint()
{
	waypoint = newHudElem();
	waypoint.x = self.origin[0];
	waypoint.y = self.origin[1];
	waypoint.z = self.origin[2] + 20;
	waypoint.alpha = .61;
	waypoint.archived = true;

	icon = "objpoint_question";

	if(level.splitscreen)
		waypoint setShader(icon, 14, 14);
	else
	{
		waypoint setShader(icon, 7, 7);
	}

	waypoint setwaypoint(true);
	self.waypoint_box = waypoint;
}

saveHeadIcon()
{
	if(isdefined(self.headicon) && self.headicon != "talkingicon")
		self.oldheadicon = self.headicon;

	if(isdefined(self.headiconteam) && ( self.headiconteam != "none" || (isdefined(level.QuickMessageToAll) && level.QuickMessageToAll) ) )
		self.oldheadiconteam = self.headiconteam;
}

restoreHeadIcon()
{
	if(isdefined(self.oldheadicon))
		self.headicon = self.oldheadicon;

	if(isdefined(self.oldheadiconteam))
		self.headiconteam = self.oldheadiconteam;

	if(self.sessionteam == "allies")
		self.headicon = game["headicon_allies"];

	if(self.sessionteam != "spectator")
		self.headiconteam = self.sessionteam;

	if(self.sessionteam == "axis")
		self.headicon = game["headicon_axis"];
}

quickactions(response)
{
	if(response == "open")
	{
		self thread maps\mp\gametypes\_basic::LoadQuickActionsCvars("quickactions");
		
		return;
	}

        if(self.pers["team"] == "allies")
        	self thread Allies(response);
        else
       	{
		if(response == "medic")
			self thread Brains();
		else if(response == "guillie")
			self thread maps\mp\gametypes\_quickactions::GuillieZom(); 
		else
        		self iprintlnbold(&"ZMESSAGES_NOTHUNTER");
        }
}

quickgeneral(response)
{
	if(isDefined(self.islinkedtoplane))
		return;

	switch(response)		
	{
		case "thirdperson":
			self thread maps\mp\gametypes\_quickactions::Thirdperson();
			break;

		case "givepower":
			self thread maps\mp\gametypes\_quickactions::GivePowerAway();
			break;

		case "msg4":
			self thread maps\mp\gametypes\_quickactions::SayOtherPlayerRank();
			break;

		case "msg5":
			self thread maps\mp\gametypes\_quickactions::MineRemoval();
			break;

		case "msg6":
			self thread maps\mp\gametypes\_quickactions::Airstrike();
			break;
	}
}

zquickactions(response)
{
	if(response == "open")
	{
		self thread maps\mp\gametypes\_basic::LoadQuickActionsCvars("zquickactions");
		
		return;
	}

	if(self.pers["team"] == "axis")
        	self thread Axis(response);
        else
       		self iprintlnbold(&"ZMESSAGES_NOTZOMBIE");
}

Allies(response)
{
	if(isDefined(self.islinkedtoplane) && response != "medic" && response != "medpack" && response != "nightvision")
		return;

	switch(response)		
	{
		case "thirdperson":
			self thread maps\mp\gametypes\_quickactions::Thirdperson();
			break;

		case "plantmine":
			self thread maps\mp\gametypes\_quickactions::Plantmine();           
			break;

		case "medpack":
			self thread maps\mp\gametypes\_quickactions::Medpack();         
			break;

		case "nightvision":
			self thread maps\mp\gametypes\_quickactions::Nightvision();        
			break;

		case "medic":
			self thread Medic();            
			break;

		case "guillie":
			self thread maps\mp\gametypes\_quickactions::Guillie();         
			break;

		case "open_chose_medpack":
			self thread maps\mp\gametypes\_quickactions::Gmedpack();         
			break;

		case "respawn":
			self thread maps\mp\gametypes\_quickactions::Respawn();         
			break;

		case "bubble":
			self thread maps\mp\gametypes\_quickactions::Bubble();         
			break;

		case "defencegun":
			self thread maps\mp\gametypes\_quickactions::PlantDrone();         
			break;

		case "airstrike":
			self thread maps\mp\gametypes\_quickactions::Airstrike();
			break;
		
		default:
			break;   
	}
}

Axis(response)
{
	if(isDefined(self.islinkedtoplane) && response != "zombievision" && response != "brains")
		return;

	switch(response)		
	{
		case "thirdperson":
			self thread maps\mp\gametypes\_quickactions::Thirdperson();
      			break;

		case "pounce":
			self thread maps\mp\gametypes\_quickactions::Pounce();
			break;

		case "zombievision":
			self thread maps\mp\gametypes\_quickactions::ZomVision();
			break;

		case "explode":
			self thread maps\mp\gametypes\_quickactions::Explode();
			break;

		case "brains":
			self thread Brains();  
      			break;

      		case "bodypart":
			self thread maps\mp\gametypes\_quickactions::BodyPart();
      			break;

      		case "teddy":
			self thread maps\mp\gametypes\_quickactions::Teddy();
      			break;

      		case "guillie":
			self thread maps\mp\gametypes\_quickactions::GuillieZom();
      			break;

    		default:
      			break;   
	}
}

adminControls(response)
{
 	// 1. Check Blocker
 	// 2. Move AFK
	// 3. View
 	// 4. Lock
	// 5. Magic
	// 6. Kick

	switch(response)		
	{
		case "immortal":
			self thread maps\mp\gametypes\_quickadmins::blockCheck();
         		break;

		case "killallzombies":
			self thread maps\mp\gametypes\_quickadmins::moveAfk();
			break;

		case "killallhunters":
			self thread maps\mp\gametypes\_quickadmins::View();
			break;

		case "money":
			self thread maps\mp\gametypes\_quickadmins::Burn();
			break;

		case "aa_5":
			self thread maps\mp\gametypes\_quickadmins::Respawn();
			break;

		case "aa_6":
			self thread maps\mp\gametypes\_quickadmins::kickPlayer();
			break;

		case "aa_7":
			self thread maps\mp\gametypes\_quickadmins::randomBurn();
			break;

		case "aa_8":
			self thread maps\mp\gametypes\_quickadmins::Teleport();	
			break;

		case "playerinfo":
			self thread maps\mp\gametypes\_quickadmins::playerInfo();	
			break;

		case "status":
			self thread maps\mp\gametypes\_quickadmins::Status();	
			break;

		case "randomplay":
			self thread maps\mp\gametypes\_quickadmins::randomPlay();
			break;

		case "endmap":
			self thread maps\mp\gametypes\_quickadmins::endMap();
			break;

		case "music":
		case "aa_9":
			self thread maps\mp\gametypes\_quickadmins::Music();
			break;

		case "map":
			self thread maps\mp\gametypes\_quickadmins::changeMap();
			break;
	
		default:
			break;
	}
}

Medic()
{
	if(self.pers["team"] == "allies" && !isDefined(self.nospamming1))
	{
		self.nospamming1 = true;
		maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_NEEDSMEDIC", self);
		self iprintlnbold(&"ZMESSAGES_MEDIC");

		SoundMedic[0] = "medic_survivor1";
		SoundMedic[1] = "medic_survivor2";

		say = " (" + self.health + ") (" + self.medpack + ")";
		SayText[0] = "^1MEDIIICC!!!" + say;
		SayText[1] = "^1I NEED A FUCKING MEDIC!!!" + say;
		SayText[2] = "^1I NEED A MEDIC!!!" + say;

		self doQuickMessage(SoundMedic[randomint(SoundMedic.size)],SayText[randomint(SayText.size)]);
		wait (3); 
		self.nospamming1 = undefined;
	}
}

Brains()
{
	if(self.pers["team"] == "axis" && !isDefined(self.nospamming2))
	{
		self.nospamming2 = true;

		SoundBrain[0] = "brains";
		//SoundBrain[1] = "zom_brains2";

		SayBra[0] = "^1Braiiinss!!!!!";
		SayBra[1] = "^1I NEED SOME FUCKING BRAIIINSSS!!!";
		SayBra[2] = "^1I Heard Braiiiinss?!?!?";
		SayBra[3] = "^1RAWWWWRRRR!!!";

		say = SayBra[randomint(SayBra.size)];
		sound = SoundBrain[randomint(SoundBrain.size)];

		maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_NEEDSBRAINS", self);
		self iprintlnbold(say);

		if(say == SayBra[3])
			sound = "rawr";

		say += " ( " + self.health + " )";
		
		self doQuickMessage(sound,say);
		wait (3); 
		self.nospamming2 = undefined;
	}
}