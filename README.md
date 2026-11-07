i am making this game not only for myself but for the Hack Club Terra event for the 3 days of this week that i was able to code for i set up the repo, the file structures for my godot project, the basic variables for the player character enemy character and first card, and i also attempted to make a drag-able card using a lerp thing  and the code was something like  if cursor on card AND cursor clicked  global postion of cursor lerp = cards position but it didn't work so i need to ask one of my friends hwat i did wrong



so last time i said that i had a problem where the cards stuck to the cursor and wouldnt come off when i let go of the card that was because under the function \_on\_area\_2d\_input\_event there is an if and statement that was layed out incorrectly with cursor\_on\_card as a separate if statement where event.pressed was meant to be and that created a sticking effect where the card got stuck to the cursor and wouldn't unstick when you let go



How to download \& Play



1\. Click the download button on itch.io to get the `.zip` file.

2\. Extract (Unzip) the folder: Right-click the downloaded `.zip` file and select Extract All... (or use your preferred extraction tool). 

&#x20;  >Important: Do not try to run the game directly from inside the zipped folder, or the game assets won't load properly!

3\. Open the newly extracted folder and double-click `JJKDECKBUILDER.exe` to start playing.

