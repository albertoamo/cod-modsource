/*
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

	Sniper[+]FIRE>>> Spawnable triggers script v1.0


To spawn a trigger:

	1. Build an array of 6 values. The first set of three
	defines one corner of the trigger. The second three
	define the opposite corner.

	2. Call spawnTrigger(), and pass in the array. an optional
	parameter is type, which determines the type of trigger.
	See extra settings. A new trigger entity is returned.

	Ex:
		trigger = spawnTrigger( volume_array, "multiple");
	This would spawn a trigger_multiple.


To monitor a trigger:

	Simply use:
		trigger waittill("trigger", player);
	This will only work on players.
	The player variable is optional.

	Also, you can check to see if an entity is touching it with:
		if( player isTouchingTrigger(trigger) )


Extra settings:

	Types of triggers supported:
		|- multiple
		|- use*
		|- hurt

	* - use triggers do not yet have icons that appear when able
		to be pushed.

	.delay - delay between triggering. Default: 0.05
	.dmg - dmg to do for hurt triggers. Default: 5
	._color - used in debug to change line color.


		-==Debug==-

		When developer_script is enabled and the "debugtriggers" dvar is set,
	boxes will be drawn around triggers to help determine the position.
	use ._color to change the color.


***Notes:

	1. Only rectangular prism shaped triggers will be made, with no rotation.
	2. Waittill("trigger") method only registers players. You can check to see
		if other entities are touching the trigger by: if( entity isTouchingTrigger(trigger) )


////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
*/

spawnTrigger(volume, type)
{
	trigger = spawnstruct();

	trigger.volume = volume;

	if(isdefined(type))
		trigger.type = type;
	else
		trigger.type = "multiple";

	if(type == "hurt")
		trigger.dmg = 5;

	trigger.delay = 0;

	trigger thread watchTrigger();

	return trigger;
}

watchTrigger()
{
	for(;;)
	{
		players = getentarray("player", "classname");

		for(i=0;i<players.size;i++)
		{
			player = players[i];

			if(!isPlayer(player) || player.sessionstate != "playing")
				continue;

			if(player isInVolume(self.volume))
			{
				if(self.type == "hurt")
					player maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(self, self, self.dmg, 0, "MOD_TRIGGER_HURT", "none", player.origin, (0,0,0), "none", 0);
				else if(self.type == "use" && !player usebuttonPressed())
					continue;

				self notify("trigger", player);

				if(self.delay > 0)
					wait(self.delay);
			}

		}

		wait(0.05);
		debugTrigger(self.volume);
	}
}

isTouchingTrigger(trigger)
{
	return self isInVolume(trigger.volume);
}

isInVolume(volume)
{
	max[0] = getVmax(volume, 0);
	max[1] = getVmax(volume, 1);
	max[2] = getVmax(volume, 2);
	min[0] = getVmin(volume, 0);
	min[1] = getVmin(volume, 1);
	min[2] = getVmin(volume, 2);

	for(axis=0;axis<3;axis++)
	{
		if(self.origin[axis] < min[axis] || self.origin[axis] > max[axis])
			return false;
	}
	return true;
}

getVmax(points, axis)
{
	max = undefined;

	for(i=0;i<points.size;i+=3)
	{
		if(!isdefined(max) || points[i+axis] > max)
		{
			max = points[i+axis];
		}
	}

	return max;
}

getVmin(points, axis)
{
	min = undefined;

	for(i=0;i<points.size;i+=3)
	{
		if(!isdefined(min) || points[i+axis] < min)
		{
			min = points[i+axis];
		}
	}

	return min;
}

debugTrigger(volume)
{
	if( getcvar("debugTriggers") == "")
		return;

	if(!isdefined(self._color))
		self._color = (1,1,1);

	max[0] = getVmax(volume, 0);
	max[1] = getVmax(volume, 1);
	max[2] = getVmax(volume, 2);
	min[0] = getVmin(volume, 0);
	min[1] = getVmin(volume, 1);
	min[2] = getVmin(volume, 2);

	line( (max[0], max[1], max[2]), (min[0], max[1], max[2]), self._color);
	line( (max[0], max[1], max[2]), (max[0], min[1], max[2]), self._color);
	line( (max[0], max[1], max[2]), (max[0], max[1], min[2]), self._color);

	line( (min[0], min[1], max[2]), (min[0], max[1], max[2]), self._color);
	line( (min[0], min[1], max[2]), (max[0], min[1], max[2]), self._color);
	line( (min[0], min[1], max[2]), (min[0], min[1], min[2]), self._color);

	line( (max[0], min[1], min[2]), (max[0], max[1], min[2]), self._color);
	line( (max[0], min[1], min[2]), (min[0], min[1], min[2]), self._color);
	line( (max[0], min[1], min[2]), (max[0], min[1], max[2]), self._color);

	line( (min[0], max[1], min[2]), (max[0], max[1], min[2]), self._color);
	line( (min[0], max[1], min[2]), (min[0], max[1], max[2]), self._color);
	line( (min[0], max[1], min[2]), (min[0], min[1], min[2]), self._color);
}