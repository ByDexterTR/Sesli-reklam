#include <sourcemod>
#include <sdktools>
#pragma semicolon 1
#pragma newdecls required
bool Kontrol[MAXPLAYERS];
int sayi = 1;
ConVar reklamsure = null, 
ses1 = null, 
ses2 = null, 
ses3 = null;
public Plugin myinfo = 
{
	name = "Sesli Reklam", 
	author = "phiso", 
	description = "Oyunculara belirlediğiniz sesleri belirlediğiniz saniyede dinletir.", 
	version = "1.0", 
	url = "www.forum.pluginmerkezi.com - phiso#5523"
};
public void OnMapStart()
{
	PrecacheSound("Plugin_Merkezi/ses1.mp3");
	PrecacheSound("Plugin_Merkezi/ses2.mp3");
	PrecacheSound("Plugin_Merkezi/ses3.mp3");
	AddFileToDownloadsTable("sound/Plugin_Merkezi/ses1.mp3");
	AddFileToDownloadsTable("sound/Plugin_Merkezi/ses2.mp3");
	AddFileToDownloadsTable("sound/Plugin_Merkezi/ses3.mp3");
	CreateTimer(reklamsure.FloatValue, reklam, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public void OnPluginStart()
{
	RegConsoleCmd("sm_seslireklam", seslireklam);
	reklamsure = CreateConVar("sm_seslireklam_sure", "180", "Sesli reklam süresi", FCVAR_NONE, true, 0.0, true, 1.0);
	ses1 = CreateConVar("sm_seslireklam_ses1", "1", "Birinci ses aktif olsun mu?", FCVAR_NONE, true, 0.0, true, 1.0);
	ses2 = CreateConVar("sm_seslireklam_ses2", "1", "İkinci ses aktif olsun mu?", FCVAR_NONE, true, 0.0, true, 1.0);
	ses3 = CreateConVar("sm_seslireklam_ses3", "1", "Üçüncü ses aktif olsun mu?", FCVAR_NONE, true, 0.0, true, 1.0);
	AutoExecConfig(true, "Sesli_Reklam", "phiso");
}
public Action seslireklam(int client, int args)
{
	if (Kontrol[client])
	{
		Kontrol[client] = false;
		PrintToChat(client, "[SM] \x02Sesli reklam \x04başarılı bir şekilde kapandı!");
	}
	else
	{
		Kontrol[client] = true;
		PrintToChat(client, "[SM] \x02Sesli reklam \x04başarılı bir şekilde açıldı!");
	}
}
public void OnClientPutInServer(int client)
{
	PrintToConsole(client, "★ Sunucuya girdiğiniz için sesli reklam aktifleşti.");
	Kontrol[client] = true;
}

public Action reklam(Handle Timer)
{
	if (sayi == 1)
	{
		if (ses1.BoolValue)
		{
			for (int i = 1; i <= MaxClients; i++)
			{
				if (IsClientInGame(i) && !IsFakeClient(i) && Kontrol[i])
				{
					EmitSoundToClient(i, "Plugin_Merkezi/ses1.mp3");
				}
			}
		}
		sayi = 2;
	}
	else if (sayi == 2)
	{
		if (ses2.BoolValue)
		{
			for (int i = 1; i <= MaxClients; i++)
			{
				if (IsClientInGame(i) && !IsFakeClient(i) && Kontrol[i])
				{
					EmitSoundToClient(i, "Plugin_Merkezi/ses2.mp3");
				}
			}
		}
		sayi = 3;
	}
	else if (sayi == 3)
	{
		if (ses3.BoolValue)
		{
			for (int i = 1; i <= MaxClients; i++)
			{
				if (IsClientInGame(i) && !IsFakeClient(i) && Kontrol[i])
				{
					EmitSoundToClient(i, "Plugin_Merkezi/ses3.mp3");
				}
			}
		}
		sayi = 1;
	}
} 