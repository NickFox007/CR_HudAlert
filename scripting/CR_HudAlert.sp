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
	version = "0.1",
	url = "https://vk.com/nf_dev"
}

#define WEBHOST ""
char g_sText[1024];

public void OnPluginStart()
{
	
}



public void CR_OnRoundStart(KeyValues Kv)
{
	g_sText[0] = 0;
	
	if(Kv)
	{
		Kv.GetSectionName(g_sText, sizeof(g_sText));
		Format(g_sText, sizeof(g_sText), "<font class='fontSize-x'><font color='#ff5555'>%s </font></font>", g_sText);
		if(Kv.GetNum("only_head")) AddHS();
		if(Kv.GetNum("no_zoom")) AddNZ();
		//Format(g_sText, sizeof(g_sText), "%s</pre>", g_sText);
		
		HC_ShowPanelStatus(-1, g_sText, 3);
	}
}

void AddHS()
{
	Format(g_sText, sizeof(g_sText), "%s ХЕДЫ", g_sText);
}

void AddNZ()
{
	Format(g_sText, sizeof(g_sText), "%s БЕЗ ПРИЦЕЛОВ", g_sText);
}

