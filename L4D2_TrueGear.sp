#include <sourcemod>
#include <sdktools_functions>
#include <sdktools_engine>

public Plugin myinfo =
{
	name = "L4D2_TrueGear",
	author = "HuangLY",
	description = "TrueGear Mod For L4D2",
	version = "1.0",
	url = ""
};


public void OnPluginStart()
{	
	HookEvent("weapon_fire", Event_WeaponFire);	
	HookEvent("player_death", Event_PlayerDeath,EventHookMode_Pre);
	HookEvent("player_hurt", Event_PlayerHurt);
	HookEvent("player_jump", Event_PlayerJump);
	HookEvent("player_falldamage", Event_PlayerFallDamage,EventHookMode_Pre);
	HookEvent("ammo_pickup", Event_AmmoPickup);
	HookEvent("item_pickup", Event_ItemPickup);
	HookEvent("golden_crowbar_pickup", Event_GoldenCrowbarPickup);
	HookEvent("weapon_pickup", Event_WeaponPickup);
	HookEvent("heal_success", Event_HealSuccess);
	HookEvent("pills_used", Event_PillsUsed);
	HookEvent("revive_success", Event_ReviveSuccess);
	HookEvent("defibrillator_used", Event_DefibrillatorUsed);
	HookEvent("ability_use", Event_AbilityUse);
	HookEvent("adrenaline_used", Event_AdrenalineUsed);
	HookEvent("entity_shoved", Event_EntityShoved);

	PrintToServer("TrueGear mod is loaded!");
}

//////////////////////////////////////////////////////////////////////////////////////

public void Event_EntityShoved(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("attacker");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    // PrintToConsole(client,"Event_EntityShoved , userid :%d , clientid :%d ",userid,client);
	PrintToConsole(client,"[TrueGear]:{PlayerShoved}");
}



public void Event_AdrenalineUsed(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    // PrintToConsole(client,"Event_AdrenalineUsed , userid :%d , clientid :%d ",userid,client);
	PrintToConsole(client,"[TrueGear]:{AdrenalineUsed}");
}

public void Event_AbilityUse(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	char ability[64]; 
	event.GetString("ability", ability, sizeof(ability));
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    // PrintToConsole(client,"Event_AbilityUse , userid :%d , clientid :%d , ability :%s",userid,client,ability);
	PrintToConsole(client,"[TrueGear]:{AbilityUse}");
}

public void Event_DefibrillatorUsed(Event event, const char[] name, bool dontBroadcast)
{
	int subjectid = event.GetInt("subject");
	int subjectClient = GetClientOfUserId(subjectid);
	int userid = event.GetInt("userid");
	int userClient = GetClientOfUserId(userid);
	if(subjectClient > 1)
	{
    	// PrintToConsole(subjectClient,"-------------------------------------------");
    	PrintToConsole(subjectClient,"[TrueGear]:{DefibrillatorHelped}");
	}
	if(userClient > 1)
	{
    	// PrintToConsole(userClient,"-------------------------------------------");
    	PrintToConsole(userClient,"[TrueGear]:{DefibrillatorUsed}");
	}
}

public void Event_ReviveSuccess(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
	PrintToConsole(client,"[TrueGear]:{ReviveSuccess}");
}


public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
	int bot = event.GetInt("bot");
	if(bot == 1)
	{
		return;
	}
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	int weaponID = event.GetInt("weaponid");
    // PrintToConsole(client,"-------------------------------------------");
	if(weaponID == 23 || weaponID == 15)
	{
    	return;
	}
	else if(weaponID == 19 || weaponID == 20)
	{
		PrintToConsole(client,"[TrueGear]:{Melee}");
	}
	else if(weaponID == 3 || weaponID == 4 || weaponID == 8 || weaponID == 11 || weaponID == 6 || weaponID == 10 || weaponID == 54 || weaponID == 35 || weaponID == 36 || weaponID == 21)
	{
		PrintToConsole(client,"[TrueGear]:{ShotgunShoot}");
	}
	else if(weaponID == 5 || weaponID == 9 || weaponID == 34 || weaponID == 26 || weaponID == 37 || weaponID == 7 || weaponID == 2)
	{
		PrintToConsole(client,"[TrueGear]:{RifleShoot}");
	}
	else if(weaponID == 16)
	{
		PrintToConsole(client,"[TrueGear]:{Underfeed}");
	}
	else
	{
		PrintToConsole(client,"[TrueGear]:{PistolShoot}");
	}
    // PrintToConsole(client,"UserID : %d , WeaponID : %d , client : %d, count : %d ,time :%f",userid,weaponID,client,event.GetInt("count"),GetEngineTime());
}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client == 0)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
	PrintToConsole(client,"[TrueGear]:{PlayerDeath}");
}

public float GetDamageAngle(float playerPos[3],float playerAngle[3],float enemyPos[3])
{
	float toEnemy[3];
	toEnemy[0] = enemyPos[0] - playerPos[0];
	toEnemy[1] = enemyPos[1] - playerPos[1];
	toEnemy[2] = enemyPos[2] - playerPos[2];

	float enemyAngle[3];
	GetVectorAngles(toEnemy, enemyAngle);

	float angleToEnemy = enemyAngle[1] - playerAngle[1];

	if (angleToEnemy > 180.0) {
	    angleToEnemy -= 360.0;
	} else if (angleToEnemy <= -180.0) {
	    angleToEnemy += 360.0;
	}
	if (angleToEnemy < 0.0) {
	    angleToEnemy = 360.0 + angleToEnemy;
	}

	return angleToEnemy;
}

public void Event_PlayerHurt(Event event, const char[] name, bool dontBroadcast)
{	
	if(event.GetInt("dmg_health") <= 0)
	{
		return;
	}
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	float playerPos[3];
	float playerAng[3];
	GetClientEyePosition(client, playerPos);
	GetClientEyeAngles(client, playerAng);
	int attackType = event.GetInt("type");
    // PrintToConsole(client,"-------------------------------------------");
	if(attackType == 265216 || attackType == 263168)
	{
		PrintToConsole(client,"[TrueGear]:{PoisonDamage}");
	}
	else if(attackType == 8 || attackType == 2056)
	{		
		PrintToConsole(client,"[TrueGear]:{FireDamage}");
	}
	else if(attackType == 131072)
	{
		PrintToConsole(client,"[TrueGear]:{IncapacitatedDamage}");
	}
	else if(attackType == 32)
	{
		PrintToConsole(client,"[TrueGear]:{FallDamage}");
	}
	else if(attackType == 134217792)
	{
		PrintToConsole(client,"[TrueGear]:{ExplosionDamage}");
	}
	else
	{
		if(attacker > 0)
		{
			float enemyPos[3];
			GetClientEyePosition(attacker, enemyPos);
			PrintToConsole(client,"[TrueGear]:{DefaultDamage,%f,0}",GetDamageAngle(playerPos,playerAng,enemyPos));
		}
		else
		{ 			
			int attackerentid = event.GetInt("attackerentid");	
			if(attackerentid < 0)
			{
				return;
			}
			float enemyPos[3];
			GetEntPropVector(attackerentid, Prop_Data, "m_vecOrigin", enemyPos);
			PrintToConsole(client,"[TrueGear]:{DefaultDamage,%f,0}",GetDamageAngle(playerPos,playerAng,enemyPos));
		}
	}
	
	// PrintToConsole(client,"userid :%d,attackerid :%d,attackerclient :%d,type :%d",userid,event.GetInt("attacker"),attacker,event.GetInt("type"));
	// PrintToConsole(client,"health :%d,dmg_health :%d,attackerclient :%d,armor :%d,dmg_armor :%d",event.GetFloat("health"),event.GetInt("dmg_health"),attacker,event.GetInt("armor"),attacker,event.GetInt("dmg_armor"));
}

public void Event_PlayerJump(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{Jump}");
}

public void Event_PlayerFallDamage(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{FallDamage}");
}

public void Event_AmmoPickup(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{PickupItem}");
}

public void Event_ItemPickup(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{PickupItem}");
}

public void Event_GoldenCrowbarPickup(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{PickupItem}");
}

public void Event_WeaponPickup(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{PickupItem}");
}

public void Event_HealSuccess(Event event, const char[] name, bool dontBroadcast)
{
    int userid = event.GetInt("subject");
	int client = GetClientOfUserId(userid);
	if(client < 1)
	{
		return;
	}
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{Healing}");
}

public void Event_PillsUsed(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	int client = GetClientOfUserId(userid);
    // PrintToConsole(client,"-------------------------------------------");
    PrintToConsole(client,"[TrueGear]:{Healing}");
}

