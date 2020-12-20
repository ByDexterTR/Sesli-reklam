#include <sourcemod>
#include <sdktools>
#include <emitsoundany>

#pragma semicolon 1
#pragma newdecls required

bool Kontrol[MAXPLAYERS] =  { true, ... };
ConVar reklamsure = null, ses1 = null, ses2 = null, ses3 = null;
int Sessayi = 0;

public Plugin myinfo = 
{
	name = "Sesli Reklam", 
	author = "phiso, ByDexter", 
	description = "Oyunculara belirlediğiniz sesleri belirlediğiniz saniyede dinletir.", 
	version = "1.2", 
	url = "www.forum.pluginmerkezi.com - phiso#5523"
};

public void OnMapStart()
{
	Sessayi = 0;
	CreateTimer(reklamsure.FloatValue, reklam, _, TIMER_FLAG_NO_MAPCHANGE | TIMER_REPEAT);
	PrecacheSoundAny("Plugin_Merkezi/ses1.mp3");
	AddFileToDownloadsTable("sound/Plugin_Merkezi/ses1.mp3");
	PrecacheSoundAny("Plugin_Merkezi/ses2.mp3");
	AddFileToDownloadsTable("sound/Plugin_Merkezi/ses2.mp3");
	PrecacheSoundAny("Plugin_Merkezi/ses3.mp3");
	AddFileToDownloadsTable("sound/Plugin_Merkezi/ses3.mp3");
}

public void OnPluginStart()
{
	RegConsoleCmd("sm_seslireklam", seslireklam, "Sesli reklamları aktifleştirip/kapatır");
	reklamsure = CreateConVar("sm_seslireklam_sure", "180.0", "Sesli reklam süresi ( Harita değiştiğinde güncellenir süre )", 0, true, 0.0, true, 1.0);
	ses1 = CreateConVar("sm_seslireklam_ses1", "1", "Birinci ses aktif olsun mu?", 0, true, 0.0, true, 1.0);
	ses2 = CreateConVar("sm_seslireklam_ses2", "1", "İkinci ses aktif olsun mu?", 0, true, 0.0, true, 1.0);
	ses3 = CreateConVar("sm_seslireklam_ses3", "1", "Üçüncü ses aktif olsun mu?", 0, true, 0.0, true, 1.0);
	AutoExecConfig(true, "Sesli_Reklam", "phiso");
}

public Action seslireklam(int client, int args)
{
	Kontrol[client] = !Kontrol[client];
	PrintToChat(client, "[SM] %s", Kontrol[client] ? "Sesli reklamlar \x07kapatıldı!":"Sesli reklamlar \x04açıldı!");
	return Plugin_Handled;
}

public void OnClientPostAdminCheck(int client)
{
	if (IsClientInGame(client) && IsClientConnected(client))
	{
		PrintToChat(client, "[SM] Sesli reklamlar aktif, \x04sm_seslireklam \x01komutu ile kapatabilirsiniz.");
		Kontrol[client] = true;
	}
}

public Action reklam(Handle timer, any data)
{
	Sessayi++;
	if (Sessayi == 1)
	{
		if (ses1.BoolValue)
		{
			for (int i = 1; i <= MaxClients; i++)if (IsClientInGame(i) && IsClientConnected(i) && !IsFakeClient(i) && Kontrol[i])
			{
				EmitSoundToClientAny(i, "Plugin_Merkezi/ses1.mp3", SOUND_FROM_PLAYER, 1, SNDLEVEL_NORMAL);
			}
		}
	}
	else if (Sessayi == 2)
	{
		if (ses2.BoolValue)
		{
			for (int i = 1; i <= MaxClients; i++)if (IsClientInGame(i) && IsClientConnected(i) && !IsFakeClient(i) && Kontrol[i])
			{
				EmitSoundToClientAny(i, "Plugin_Merkezi/ses2.mp3", SOUND_FROM_PLAYER, 1, SNDLEVEL_NORMAL);
			}
		}
	}
	else if (Sessayi == 3)
	{
		if (ses3.BoolValue)
		{
			for (int i = 1; i <= MaxClients; i++)if (IsClientInGame(i) && IsClientConnected(i) && !IsFakeClient(i) && Kontrol[i])
			{
				EmitSoundToClientAny(i, "Plugin_Merkezi/ses3.mp3", SOUND_FROM_PLAYER, 1, SNDLEVEL_NORMAL);
			}
		}
		Sessayi = 0;
	}
}
