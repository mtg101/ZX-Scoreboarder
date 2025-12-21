A POC of using the top border to display basic game info: lives, score, energy.

My idea is that someone who can actually write a game could use this as an engine to show the game status in the top border. 

My 'game' is just a sprite that moves around with qa keys (which is also new to me!) plus zx/ok/pl keys to adjust the scoreboard. 

Border resolution is only 11 columns, using OUTI to read directly from memory, rather than the maximum resolution of nearly 15 columns using self-modifying code as I did in my border demo: https://github.com/mtg101/Open-Borders -- this just makes things easier for someone to actually write a game around the scoreboarder engine. 

And to make things more complicated... I've added a horizon effect with clouds. My demo 'game' can afford to lose 32 rows of t-states for it. Others can use it if they can afford it, or just stick to the main scorboarder. 

One learning from this project is INCBIN. Allows including a binary file, which when ORG'd to screen memory shows as the screen. And I discovered Spectra image converter for creating those binary images: http://www.fruitcake.plus.com/Sinclair/Spectrum/Spectra/SpectraInterface_Software_ImageConverter.htm 

And... now I'm trying to add bottom border support using the floating bus trick -- which is much more complicated timings that change with what you do during the main game loop. 
If anyone actually wants to use the scoreboard, best just ignore the bottom border stuff so you don't have to care about timings in your game loop.
