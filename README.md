# GTAV_Toxic_Players_List

## Purpose
Q: I can just block their joins and so they are not able to join?
A: You can but what if you don't have them added in first place or they use alts to get back? This list prevents that from happening as we collect more and more users throughout the time!
Q: What players will be added to this list?
A: That depends, for now we have crashers but you may consider griefers as well, or those that ruin your experience in GTA 😊

## Usage in mod menus
1. Make sure you got a json lib installed so you can iterate through the list accordingly.
    - on Stand Mod Menu simply go to Repository and choose "pretty.json" under the "Dependencies" section!
    - on other menus either do the same if that's a possibility or just download a json-lib from the internet I guess 😊
2. To make this work efficiently you should iterate through the list when the event "on_join" occures and also check, whether you're the host or not. By the time you've kicked that person as non-host the whole lobby might have already been crashed. Obviously this only is the case with the crashers. Other players might be added to different categories soon!

## Contribution
To keep yourself and other users of this json file save, you may open an issue. Every input from you is very welcome and highly appreciated to keep malicious people out of sessions :3 