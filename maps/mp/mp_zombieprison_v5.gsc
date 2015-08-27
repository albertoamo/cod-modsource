main() 
{
maps\mp\_load::main();

ambientPlay("ambient_mp_zp");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "winterlight";
game["german_soldiertype"] = "winterlight";

}