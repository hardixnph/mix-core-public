#include <amxmodx>
#include <amxmisc>

#define MAX_GROUPS 4
#define tagstaff "Staff Online"

new g_groupNames[MAX_GROUPS][] = {
	"Administrator MiX-AREA",
	"Manager MiX-AREA",
	"Moderator MiX-AREA",
	"Admin MiX-AREA",
}

new g_groupFlags[MAX_GROUPS][] = {
	"acdefghikl",
	"cdefgi",
	"cdefi",
	"cefi",
}

new g_groupFlagsValue[MAX_GROUPS];

public plugin_init() {

	register_plugin("Staff Online", "1.0", "github.com/hardixnph")
	register_concmd("amx_who", "cmdWho", 0);
	register_concmd("admin_who", "cmdWho", 0);

	for(new i = 0; i < MAX_GROUPS; i++) {
		g_groupFlagsValue[i] = read_flags(g_groupFlags[i])
	}
}

public cmdWho(id) { // Verificam daca userul este online, daca nu... ne oprim din executie

	if(!is_user_connected(id)) { return PLUGIN_HANDLED; }

	new players[32], inum, player, name[32], i, a;
	get_players(players, inum);
	console_print(id, "=== %s ===", tagstaff);
	for(i = 0; i < MAX_GROUPS; i++) {
		console_print(id, "------ [%d] %s ------", i+1, g_groupNames[i])
		for(a = 0; a < inum; ++a) {
			player = players[a]
			get_user_name(player, name, 31);
			if(get_user_flags(player) == g_groupFlagsValue[i]) {
				console_print(id, ">> %s", name);
			}
		}
	}

	console_print(id, "=== MiX-AREA ===")

	return PLUGIN_HANDLED

}
