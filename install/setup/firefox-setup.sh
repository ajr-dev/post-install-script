#!/bin/bash

# TODO fix this
#[ -f "$HOME/.mozilla/firefox/*.default/prefs.js" ]  &&  \
#  grep browser.startup.homepage ~/.mozilla/firefox/*.default/prefs.js | \
#  awk '{print $2}' | sed '1 s/\"*www*\"/\"www.google.com\"/'

echo "Manual Firefox Configuration
============================================================================
1. Change default search engine
https://www.linuxmint.com/searchengines.php

2. Change homepage
============================================================================
1) Write about:config in address bar
2) Accept the risk
3) Search the string \"keyword.URL\"
4) Change the value to: https://www.google.com/#safe=active&output=search&sclient=psy-ab&q=
# https://support.mozilla.org/en-US/questions/968367
# http://unix.stackexchange.com/questions/93795/how-to-set-firefox-homepage-from-terminal
# grep browser.startup.homepage .mozilla/firefox/*.default/prefs.js
# user_pref(\"browser.startup.homepage\", \"http://www.google.com\");

3. Change country code and region of the search engine about:config
============================================================================
1) browser.search.countryCode;EN
2) browser.search.region;EN

4. Search a webpage from the address bar
============================================================================
https://support.mozilla.org/en-US/kb/how-search-from-address-bar
# http://www.wordreference.com/tools/Firefox-search-shortcut.aspx
# youtube yt
# wordreference wr es en fr esen esfr enes enfr fres fren
# amazon a
# wikipedia wk wkes
# facebook fb"

read -n 1 -p "\nContinue?"
