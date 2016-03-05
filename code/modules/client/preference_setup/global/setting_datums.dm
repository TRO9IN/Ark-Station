var/list/_client_preferences
var/list/_client_preferences_by_key
var/list/_client_preferences_by_type

/proc/get_client_preferences()
	if(!_client_preferences)
		_client_preferences = list()
		for(var/ct in subtypesof(/datum/client_preference))
			var/datum/client_preference/client_type = ct
			if(initial(client_type.description))
				_client_preferences += new client_type()
	return _client_preferences

/proc/get_client_preference_by_key(var/preference)
	if(!_client_preferences_by_key)
		_client_preferences_by_key = list()
		for(var/ct in get_client_preferences())
			var/datum/client_preference/client_pref = ct
			_client_preferences_by_key[client_pref.key] = client_pref
	return _client_preferences_by_key[preference]

/proc/get_client_preference_by_type(var/preference)
	if(!_client_preferences_by_type)
		_client_preferences_by_type = list()
		for(var/ct in get_client_preferences())
			var/datum/client_preference/client_pref = ct
			_client_preferences_by_type[client_pref.type] = client_pref
	return _client_preferences_by_type[preference]

/datum/client_preference
	var/description
	var/key
	var/enabled_by_default = TRUE
	var/enabled_description = "Yes"
	var/disabled_description = "No"

/datum/client_preference/proc/may_toggle(var/mob/preference_mob)
	return TRUE

/datum/client_preference/proc/toggled(var/mob/preference_mob, var/enabled)
	return

/*********************
* Player Preferences *
*********************/

/datum/client_preference/play_admin_midis
	description ="Play admin midis"
	key = "SOUND_MIDI"

/datum/client_preference/play_lobby_music
	description ="Play lobby music"
	key = "SOUND_LOBBY"

/datum/client_preference/play_lobby_music/toggled(var/mob/preference_mob, var/enabled)
	if(enabled)
		preference_mob << sound(ticker.login_music, repeat = 0, wait = 0, volume = 85, channel = 1)
	else
		preference_mob << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1)

/datum/client_preference/play_ambiance
	description ="Play ambience"
	key = "SOUND_AMBIENCE"

/datum/client_preference/play_ambiance/toggled(var/mob/preference_mob, var/enabled)
	if(!enabled)
		preference_mob << sound(null, repeat = 0, wait = 0, volume = 0, channel = 1)
		preference_mob << sound(null, repeat = 0, wait = 0, volume = 0, channel = 2)

/datum/client_preference/ghost_ears
	description ="Ghost ears"
	key = "CHAT_GHOSTEARS"
	enabled_description = "All Speech"
	disabled_description = "Nearby"

/datum/client_preference/ghost_sight
	description ="Ghost sight"
	key = "CHAT_GHOSTSIGHT"
	enabled_description = "All Emotes"
	disabled_description = "Nearby"

/datum/client_preference/ghost_radio
	description ="Ghost radio"
	key = "CHAT_GHOSTRADIO"
	enabled_description = "All Chatter"
	disabled_description = "Nearby"

/datum/client_preference/chat_tags
	description ="Chat tags"
	key = "CHAT_SHOWICONS"
	enabled_description = "Show"
	disabled_description = "Hide"

/datum/client_preference/show_typing_indicator
	description ="Typing indicator"
	key = "SHOW_TYPING"
	enabled_description = "Show"
	disabled_description = "Hide"

/datum/client_preference/show_typing_indicator/toggled(var/mob/preference_mob, var/enabled)
	if(!enabled)
		preference_mob.set_typing_indicator(0)

/datum/client_preference/show_ooc
	description ="OOC chat"
	key = "CHAT_OOC"
	enabled_description = "Show"
	disabled_description = "Hide"

/datum/client_preference/show_looc
	description ="LOOC chat"
	key = "CHAT_LOOC"
	enabled_description = "Show"
	disabled_description = "Hide"

/datum/client_preference/show_dsay
	description ="Dead chat"
	key = "CHAT_DEAD"
	enabled_description = "Show"
	disabled_description = "Hide"

/datum/client_preference/show_progress_bar
	description ="Progress Bar"
	key = "SHOW_PROGRESS"
	enabled_description = "Show"
	disabled_description = "Hide"

/********************
* Admin Preferences *
********************/
/datum/client_preference/admin/may_toggle(var/mob/preference_mob)
	return check_rights(R_ADMIN, 0, preference_mob)

/datum/client_preference/admin/show_attack_logs
	description = "Attack Log Messages"
	key = "CHAT_ATTACKLOGS"
	enabled_description = "Show"
	disabled_description = "Hide"
	enabled_by_default = FALSE

/datum/client_preference/admin/show_debug_logs
	description = "Debug Log Messages"
	key = "CHAT_DEBUGLOGS"
	enabled_description = "Show"
	disabled_description = "Hide"
	enabled_by_default = FALSE

/datum/client_preference/admin/show_chat_prayers
	description = "Chat Prayers"
	key = "CHAT_PRAYER"
	enabled_description = "Show"
	disabled_description = "Hide"

/datum/client_preference/holder/may_toggle(var/mob/preference_mob)
	return preference_mob && preference_mob.client && preference_mob.client.holder

/datum/client_preference/holder/play_adminhelp_ping
	description = "Adminhelps"
	key = "SOUND_ADMINHELP"
	enabled_description = "Hear"
	disabled_description = "Silent"
