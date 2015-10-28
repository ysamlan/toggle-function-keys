tell application "System Preferences"
	set current pane to pane "com.apple.preference.keyboard"
end tell

tell application "System Events"
	-- If we don't have UI Elements enabled, then nothing is really going to work.
	if UI elements enabled then
		tell application process "System Preferences"
			get properties
			
			click radio button "Keyboard" of tab group 1 of window "Keyboard"
			click checkbox "Use all F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard"
			set messageToShow to "Function keys set to "
			if (value of checkbox "Use all F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard") as boolean then
				set messageToShow to messageToShow & "standard function keys."
			else
				set messageToShow to messageToShow & "media/hardware controls."
			end if
			
			display notification messageToShow
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.security"
			display dialog "UI element scripting is not enabled. Please activate this app under Privacy -> Accessibility so it can access the settings it needs."
		end tell
	end if
end tell