# RobloxScript

Lamduck's Roblox script hub. One universal loader detects the game you are in and runs the matching obfuscated script.

## Loader

```lua
loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/loader.lua"))()
```

- Auto-detects the game via `game.GameId` and runs the right script.
- Sources with fallback: GitHub Pages -> raw.githubusercontent -> jsDelivr CDN.
- In any other game the loader opens a selector UI to run a script manually.
- The loader is auto-executed by the key system (`lamduck.vercel.app`).

[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/y6PSbZmUAk)
[![YouTube](https://img.shields.io/badge/YouTube-@lamduck2005-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@lamduck2005)
[![rscripts](https://img.shields.io/badge/rscripts-@lamduck-20b26c?style=for-the-badge)](https://rscripts.net/@lamduck)
[![Telegram](https://img.shields.io/badge/Telegram-@lamduck-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/lamduck)

## Supported games

| Game | Script |
|---|---|
| Unbox ASMR | `UnboxASMR.luau` |
| Build A Ring Farm | `BuildARingFarm.luau` |
| Build A Ring Farm 2 | `BuildARingFarm2.luau` |
| Build A Ring Farm Lite | `BuildARingFarmLite.luau` |
| Build A Fruit Farm | `BuildAFruitFarm.luau` |
| Build A Beehive | `BuildABeehive.luau` |
| Beeface! | `Beeface.luau` |
| Chicken Farm | `ChickenFarm.luau` |
| Grow A Chicken Fighter | `GrowAChickenFighter.luau` |
| Cut Grass Adventure | `CutGrassAdventure.luau` |
| Sell Lemon | `SellLemon.luau` |
| Storage Hunters | `StorageHunters.luau` |
| Dungeon Lootr | `DungeonLootr_Dungeon.luau` (lobby: `DungeonLootr_Lobby.luau`) |
| BAB Steal | `BABSteal.luau` |

Direct load (bypass the loader), replace `<File>`:

```lua
loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/<File>"))()
```

## Library

- [Fluent-Renewed-Plus](https://github.com/lamduck2005/Fluent-Renewed-Plus) - the UI library used by every script (`Fluent.luau`, `ExtraSetting.luau`, SaveManager, InterfaceManager).

## Notes

- All scripts here are obfuscated CI builds from the private source repo. Raw sources are not public.
- Directory listing: <https://lamduck2005.github.io/RobloxScript/>

## Contact

- Discord server: <https://discord.gg/y6PSbZmUAk>
- rscripts profile: <https://rscripts.net/@lamduck>
- YouTube: <https://www.youtube.com/@lamduck2005>
- Telegram: <https://t.me/lamduck>
- Discord (personal): <https://discordapp.com/users/869155306314268672>
