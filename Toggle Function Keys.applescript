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
			
			tell application "GrowlHelperApp"
				-- Make a list of all the notification types 
				-- that this script will ever send:
				set the allNotificationsList to {"Function Keys Toggled"}
				-- Make a list of the notifications 
				-- that will be enabled by default.      
				-- Those not enabled by default can be enabled later 
				-- in the 'Applications' tab of the growl prefpane.
				set the enabledNotificationsList to {"Function Keys Toggled"}
				-- Register our script with growl.
				register as application "Toggle Function Keys" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Script Editor"
				-- Send a Notification...
				notify with name "Function Keys Toggled" title "Function Keys Toggled" description messageToShow application name "Toggle Function Keys"
			end tell
		end tell
		tell application "System Preferences" to quit
	else
		-- GUI scripting not enabled.  Display an alert
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.universalaccess"
			display dialog "UI element scripting is not enabled. Please activate \"Enable access for assistive devices\""
		end tell
	end if
end tell