# JJK Deckbuilder 

Developed by **DangerWorks !nteractive** for the **Hack Club Terra** event!

![Gameplay Overview](Screenshot%202026-11-05%20234320.jpg)

---

## Why I Made This

I created **JJK Deckbuilder** for the **Hack Club Terra** event. Working within a tight 3-day window of coding time, my goal was to build a fully functional, interactive 2D card battler game loop from scratch using the **Godot 4.x** engine and GDScript. 

---

## Development Process & Technical Challenges

Building this project involved setting up the entire architecture, managing node hierarchies, and tackling tricky game logic roadblocks:

- **Project Structure & Setup:** Initialized the Git repository, structured the Godot project folders, and created base scripts and variables for the player character, enemy types, and initial card assets.
- **Card Design & UI:** Designed custom card frames, stat icons, and layout slots for actions like "Punch" and "Energy Strike".

  ![Card Design in Godot](Screenshot%202026-10-17%20133321.png)

- **Drag-and-Drop Mechanics & Bugfixing:** Experimented with a linear interpolation (`lerp`) approach to make cards smoothly follow the cursor. During development, cards would occasionally get permanently "stuck" to the mouse cursor and refuse to release on click-up. I tracked down the bug: an improperly nested conditional check separated `cursor_on_card` from `event.pressed` in the input event function. Fixing the `if` statement logic successfully resolved the dragging and releasing behavior.
- **Combat & Game Loop Implementation:** Added dynamic health bars, block calculations, damage absorption, turn tracking, and a custom hand layout system where players can select and play cards against enemies.

  ![Battle Setup & UI](Screenshot%202026-10-28%230157.png)

---

## How to Download & Play

1. Head over to the project page on **itch.io** and download the latest `.zip` release archive.
2. **Extract (Unzip) the folder:** Right-click the downloaded `.zip` file and select **Extract All...** (or use your preferred extraction tool).
   > **Important:** Do not try to run the game directly from inside the zipped folder! If you do not extract the folder first, the game data packs (`.pck` files) and assets won't load properly, causing the game to crash.
3. Open the newly extracted folder and double-click **JJKDECKBUILDER.exe** to start playing!

---

## Built With

- **Engine:** Godot 4.x (GDScript)
- **Studio:** DangerWorks !nteractive

Images in a folder in git hub because they wont lik correctly in here
