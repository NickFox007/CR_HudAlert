#include <sourcemod>
#include <hudcore>
#include <sdktools_stringtables>
#include <custom_rounds>

#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo =
{
	name = "[CR] Hud Alert",
	author = "NickFox",
	description = "Hud alret on custom round.",
	version = "1.0",
	url = "https://vk.com/nf_dev"
}

#define SOURCE_PATH "file://{images}/"

char g_sText[1024];

public void CR_OnRoundStart(KeyValues Kv_0)
{
	g_sText[0] = 0;	
	
	if(Kv_0)
	{
		Kv_0.Rewind();
		KeyValues Kv = new KeyValues(".");
		KvCopySubkeys(Kv_0, Kv);		
		Kv.Rewind();
		Kv_0.GetSectionName(g_sText, sizeof(g_sText));
		Format(g_sText, sizeof(g_sText), "<font class='fontSize-x'><font color='#ff7070'>%s </font></font>", g_sText);		
		
		if(Kv.JumpToKey("Weapons"))
		{
			bool isNext;
			
			do
			{
				char sWeapon[128];
				Kv.GetString("give", sWeapon, sizeof(sWeapon), NULL_STRING);
				if(sWeapon[0] != NULL_STRING[0]){
					AddWeapon(sWeapon);
					KvDeleteKey(Kv, "give");
					isNext = true;
					
				}
				else isNext = false;
			} while (isNext); 
		}		
		Kv.Rewind();
		if(Kv.GetNum("only_head")) AddHS();
		if(Kv.GetNum("no_zoom")) AddNZ();
		HC_ShowPanelStatus(-1, g_sText, 3);
	}
}

void AddHS()
{
	Format(g_sText, sizeof(g_sText), "%s <font><img src='%shud/deathnotice/icon-headshot.png'/></font>", g_sText, SOURCE_PATH);
}

void AddNZ()
{
	Format(g_sText, sizeof(g_sText), "%s <font><img src='%shud/deathnotice/noscope.svg'/></font>", g_sText, SOURCE_PATH);
}

void AddWeapon(const char[] sWeapon)
{
	Format(g_sText, sizeof(g_sText), "%s <font><img src='%sicons/equipment/%s.svg'/></font>", g_sText, SOURCE_PATH, sWeapon[7]);
}


