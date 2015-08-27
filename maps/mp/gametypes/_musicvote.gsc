init()
{
	game["votesonghud"] = &"^7VOTE(^1&&1^7) Song:^7";
	game["votesonghud2"] = &"^7YES:^7 ^1&&1^7, NO:^7 ^1";
	game["votesonghud3"] = &"^7YES(^1F1^7): ^1&&1^7, NO(^1F2^7): ^1";
	precacheString(game["votesonghud"]);
	precacheString(game["votesonghud2"]);
	precacheString(game["votesonghud3"]);
}

voteMusic(price)
{
	song = self maps\mp\gametypes\_admin::MusicHud();

	if(!isDefined(song))
		return;

	if(isDefined(level.votesonghud) && !isDefined(level.musicvotes))
		self iprintln("New vote cannot be called yet.");
	else if(isDefined(level.votesonghud))
		self iprintln("Vote already in progress.");
	else if(isDefined(self.rank) && self.rank < 50)
		self iprintln("Vote cannot be called under rank ^150^7.");
	else
	{
		self maps\mp\gametypes\_basic::updatePower(price * -1);
		self thread main(song["name"], song["soundalias"], song["text"]);
	}
}

main(song, soundalias, text)
{
	if(isDefined(level.votesonghud))
		return;

	if(getCvarInt("scr_musicvote_time") == 0)
		setCvar("scr_musicvote_time", 30);

	level.musicvotes = [];
	level.musicvotes[0] = 1; // yes
	level.musicvotes[1] = 0; // no
	level.musicvotes[2] = level.totalplayersnum["axis"] + level.totalplayersnum["allies"];

	iprintln(self.name + " ^7called a vote.");
	self.usedMusicVote = true;

	votetime = getCvarInt("scr_musicvote_time");
	createHUD(votetime, song);
	thread countDown(votetime);
	thread showVote();
	level waittill("endmusicvote");
	if(level.musicvotes[0] > level.musicvotes[1] && level.musicvotes[0]+level.musicvotes[1] > int(level.musicvotes[2]/2))
	{
		if(song == &"STOP")
		{
			MusicStop( 3 );
			iprintln("Stopping current song.");
		}
		else if(isDefined(soundalias))
		{
			MusicStop( 0 );
			MusicPlay( soundalias );

			if(isDefined(text))	
				iprintln(&"ZMESSAGES_PLAYINGNOW", text);
		}	
	}
	else
		iprintln("Vote failed.");		

	thread CleanUp();
}

CleanUp()
{
	level.votesonghud[0] Destroy();
	level.votesonghud[1] Destroy();
	level.votesonghud[0] = undefined;
	level.votesonghud[1] = undefined;
	level.musicvotes = undefined;

	players = getentarray("player", "classname");
	
	for(i=0;i<players.size;i++)
	{
		player = players[i];

		if(!isPlayer(player) || !isDefined(player))
			continue;

		player.usedMusicVote = undefined;

		if(isDefined(player.votesonghud))
		{
			if(isDefined(player.votesonghud[0])) player.votesonghud[0] Destroy();
			if(isDefined(player.votesonghud[1])) player.votesonghud[1] Destroy();
		}

		player.votesonghud = undefined;
		player thread maps\mp\gametypes\_basic::execClientCmd("bind f1 vote yes;bind f2 vote no");
	}

	if(getCvarInt("scr_musicvote_delay") == 0)
		setCvar("scr_musicvote_delay", 15);

	if(getCvarInt("scr_musicvote_delay") < 1)
		setCvar("scr_musicvote_delay", 1);

	delay = getCvarInt("scr_musicvote_delay");

	wait delay; // delay next vote

	level.votesonghud = undefined;
}

showVote()
{
	players = getentarray("player", "classname");
	
	for(i=0;i<players.size;i++)
	{
		player = players[i];
		player thread onUpdateVote();
	}
}

doVote(vote)
{
	level endon("endmusicvote");

	if(!isPlayer(self))
		return;

	if(isDefined(self.usedMusicVote))
		return;

	if(!isDefined(level.votesonghud))
		return;

	if(!isDefined(level.musicvotes))
		return;

	choice = 1;

	if(vote == "yes")
		choice = 0;

	level.musicvotes[choice]++;
	self.usedMusicVote = choice;

	level notify("updateVotes");
	self iprintln("Vote saved.");

	if(level.musicvotes[0] + level.musicvotes[1] == level.musicvotes[2])
	{
		wait(5);
		level notify("endmusicvote");
	}
}

onUpdateVote()
{
	self endon("disconnect");
	level endon("endmusicvote");

	self thread maps\mp\gametypes\_basic::execClientCmd("bind f1 openscriptmenu vote yes;bind f2 openscriptmenu vote no");
	self thread updateVote();
	self thread CleanonDisconnect();

	for(;;)
	{
		level waittill("updateVotes");
		self thread updateVote();
	}
}

CleanonDisconnect()
{
	level endon("endmusicvote");
	self waittill("disconnect");

	if(isDefined(self.usedMusicVote))
		level.musicvotes[self.usedMusicVote]--;

	level.musicvotes[2]--;

	if(isDefined(self.votesonghud[0])) self.votesonghud[0] Destroy();
	if(isDefined(self.votesonghud[1])) self.votesonghud[1] Destroy();
}

updateVote()
{
	x = 60;
	y = -40;
	i = 0;
	text = game["votesonghud3"];
	length = 88;

	if(isDefined(self.usedMusicVote))
	{
		text = game["votesonghud2"];
		length = 51;
	}

	if(!isDefined(self.votesonghud))
		self.votesonghud = [];

	if(!isDefined(self.votesonghud[i]))
	{
		self.votesonghud[i] = NewClientHudElem(self);
		self.votesonghud[i].horzAlign = "left";
		self.votesonghud[i].alignX = "left";
		self.votesonghud[i].vertAlign = "middle";
		self.votesonghud[i].x = x;
		self.votesonghud[i].y = y;
		self.votesonghud[i].fontScale = 1;
		self.votesonghud[i].alpha = 1;
	}

	self.votesonghud[i].label = text;
	self.votesonghud[i] setValue(level.musicvotes[0]);
	i++;

	if(!isDefined(self.votesonghud[i]))
	{
		self.votesonghud[i] = NewClientHudElem(self);
		self.votesonghud[i].horzAlign = "left";
		self.votesonghud[i].alignX = "left";
		self.votesonghud[i].vertAlign = "middle";
		self.votesonghud[i].y = y;
		self.votesonghud[i].color = (1,0,0);
		self.votesonghud[i].fontScale = 1;
		self.votesonghud[i].alpha = 1;
	}

	self.votesonghud[i].x = x + length + maps\mp\gametypes\_quickactions::digit_length(level.musicvotes[0]) * 3;
	self.votesonghud[i] setValue(level.musicvotes[1]);
}

countDown(time)
{
	level endon("endmusicvote");

	while(time > 0)
	{
		wait(1);
		time--;
		level.votesonghud[0] setValue(time);
		level.votesonghud[1].x = 60 + 68 + int(maps\mp\gametypes\_quickactions::digit_length(time) * 3);

		if(level.musicvotes[2] == 1)
			break;
	}

	level notify("endmusicvote");
}

createHUD(votetime, song)
{
	x = 60;
	y = -60;
	i = 0;

	level.votesonghud = [];
	level.votesonghud[i] = NewHudElem();
	level.votesonghud[i].horzAlign = "left";
	level.votesonghud[i].alignX = "left";
	level.votesonghud[i].vertAlign = "middle";
	level.votesonghud[i].x = x;
	level.votesonghud[i].y = y;
	level.votesonghud[i].fontScale = 1;
	level.votesonghud[i].alpha = 1;
	level.votesonghud[i].label = game["votesonghud"];
	level.votesonghud[i] setValue(votetime);
	i++;
	level.votesonghud[i] = NewHudElem();
	level.votesonghud[i].horzAlign = "left";
	level.votesonghud[i].alignX = "left";
	level.votesonghud[i].vertAlign = "middle";
	level.votesonghud[i].x = x + 68 + int(maps\mp\gametypes\_quickactions::digit_length(votetime) * 3);
	level.votesonghud[i].y = y;
	level.votesonghud[i].fontScale = 1;
	level.votesonghud[i].alpha = 1;
	level.votesonghud[i] setText(song);
}