/**
* vim: set ft=cpp:
* file: maps\mp\mp_killhouse.gsc
*
* authors: Luk, 3aGl3, Bipo, Etheross
* team: SOG Modding
*
* project: RotU - Revolution
* website: http://survival-and-obliteration.com/
*
* Reign of the Undead - Revolution by Luk and 3aGl3
* You may modify this code to your liking or reuse it, as long as you give credit to those who wrote it
* Based on Reign of the Undead 2.1 created by Bipo and Etheross
*/

#include maps\mp\_zombiescript;
main()
{
    maps\mp\mp_killhouse_fx::main();
	maps\mp\mp_killhouse_navmesh::main();

    maps\createart\mp_killhouse_art::main();
    maps\mp\_load::main();

    maps\mp\_compass::setupMiniMap("compass_map_mp_killhouse");

    ambientPlay("ambient_overgrown_day");

    game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

    setdvar("r_specularcolorscale", "1");
    setdvar("r_glowbloomintensity0",".25");
    setdvar("r_glowbloomintensity1",".25");
    setdvar("r_glowskybleedintensity0",".3");
    setdvar("compassmaxrange","2200");

//  thread maps\mp\mp_killhouse_waypoints::load_waypoints();
    thread maps\mp\mp_killhouse_tradespawns::load_tradespawns();
	
	waittillStart();
	
	buildSurvSpawnByClassname("mp_dm_spawn");
	startSurvWaves();
}
