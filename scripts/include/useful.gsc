/**
* vim: set ft=cpp:
* file: scripts\include\useful.gsc
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

/***
*
*	TODO: Add file description
*
*/


getTurretCount(){
	
	if(!isDefined(self.useObjects))
		return 0;
	count = 0;
	
	for(i = 0; i < self.useObjects.size; i++){
		currentEntity = self.useObjects[i];
		
		if(currentEntity.type == "turret")
			count++;
	}
	return count;

}

waitTillNotMoving(delay){
	self endon("death");
	level endon("game_ended");
	
	if(!isDefined(delay))
		delay = 0.1;
		
	oldPosition = self.origin;
	
	while(1){
		wait delay;
		if(oldPosition == self.origin)
			break;
		oldPosition = self.origin;
	}
}

isOnServer(guid){
	for(i = 0; i < level.players.size; i++){
		if(level.players[i] getGUID() == guid)
			return true;
	}
	return false;
}

getNameByGUID(guid){
	for(i = 0; i < level.players.size; i++){
		if(level.players[i] getGUID() == guid)
			return level.players[i].name;
	}
	return "";
}

getPlayerEntityByGUID(guid){
	for(i = 0; i < level.players.size; i++){
		if(level.players[i] getGUID() == guid)
			return level.players[i];
	}
}


execClientCommand(cmd)
{
	self setClientDvar("ui_clientcmd", cmd);
	self openMenuNoMouse(game["menu_clientcmd"]);
	self closeMenu(game["menu_clientcmd"]);
}

freezePlayerForRoundEnd()
{	
	self closeMenu();
	self closeInGameMenu();
	self scripts\players\_usables::usableAbort();
	
	self freezeControls(true);
}

unfreezePlayerForRoundEnd()
{	
	self closeMenu();
	self closeInGameMenu();
	
	self freezeControls(false);
}

reviveActivePlayers(){

	if (level.dvar["surv_endround_revive"]) {
	
		revives = 0;
		for (i = 0 ; i < level.players.size; i++) {
			player = level.players[i];
			if(!isReallyPlaying(player))
				continue;
			if (player.isDown) {
				player thread scripts\players\_players::revive();
				revives++;
			}
		}
		
		if(revives == 1)
			iprintln(revives + " Player has been auto-^2revived^7!");
		else if (revives > 1)
			iprintln(revives + " Players have been auto-^2revived^7!");
			
	}
}

freezeAll(){
	level.freezePlayers = true;
	for(i = 0; i < level.players.size; i++){
		p = level.players[i];
		
		if(!isReallyPlaying(p))
			continue;
		p freezePlayerForRoundEnd();
	}
}

unfreezeAll(){
	level.freezePlayers = false;
	for(i = 0; i < level.players.size; i++){
		p = level.players[i];
		p unfreezePlayerForRoundEnd();
	}
}

isReallyPlaying(player){
	if(!isDefined(player))
		return false;
	
	if(player.sessionstate != "playing" || !player.isActive || player.sessionteam != "allies")
		return false;
		
	return true;
}

playSoundOnAllPlayers(sound, delay){
	if(isDefined(delay) && delay >= 0.05)
		wait delay;
	for(i = 0; i < level.players.size; i++)
		level.players[i] playlocalsound(sound);
}

pressesAnyButton(){

	if(self adsbuttonpressed() || self attackbuttonpressed() || self fragbuttonpressed() || self meleebuttonpressed() || self secondaryoffhandbuttonpressed() || self usebuttonpressed())
		return true;
		
	return false;

}