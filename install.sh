#!/usr/bin/env bash

declare -A PROFILES_PATH=(
	[1]=".var/app/org.mozilla.firefox"
	[2]="Library/Application Support/Firefox/Profiles"
)

MAIN_FILE="customChrome.css"
TOOLBAR_FILE="mergedToolbar.css"
NOTABS_FILE="noTabsbar.css"

echo "Select OS:"
echo "	1. Linux"
echo "	2. MacOS"
read -p "> " operating_system

DESTINATION=${PROFILES_PATH[$operating_system]}

case $operating_system in
	1);;&
	2)
		echo "Files will be placed in $DESTINATION";;
	*)
		echo "invalid response";
		exit 1;;
esac

tabs_visible=false

echo ""
echo "If you use an extension (such as Sidebery) to manage your tabs, you can hide firefox default horizontal tab bar."
echo "Hide the default tabs bar ? (y/n)"
read -p "> " tabs_choice

case $tabs_choice in
	y)
		echo "Tabs will be hidden.";;
	n)
		echo "Tabs will be shown.";
		tabs_visible=true;;
	*)
		echo "invalid response";
		exit 1;;
esac


CHROME_PATH=$(ls -d ~/"$DESTINATION"/* | grep .default-release | head -n 1)/chrome/
USERCHROME_FILE="$CHROME_PATH"userChrome.css

# ensure chrome directory and css files exist
mkdir -p "$CHROME_PATH"
touch "$CHROME_PATH""$MAIN_FILE"
touch "$USERCHROME_FILE"
cp ./*.css "$CHROME_PATH"

function prepend () {
	echo "$1" > "$2".new
	cat "$2" >> "$2".new
	mv "$2".new "$2"
}

# prepend import at the start of the userChrome.css
if ! grep -q "@import \"$MAIN_FILE\"" "$USERCHROME_FILE"; then
	echo Adding customChrome.css import to userChrome.css.
	prepend "@import \"$MAIN_FILE\"" "$USERCHROME_FILE"
fi

if (! $tabs_visible); then
	echo @import \""$NOTABS_FILE"\"";" >> "$CHROME_PATH""$MAIN_FILE"
fi


