# Beyond The Wall

**Genre:** First-Person Survival Adventure  
**Engine:** Godot 4.x Stable  
**Language:** GDScript  
**Platform:** Windows PC  
**Mode:** Single-player

---

## Overview

The player wakes up alone in an abandoned settlement called The Glade. Outside its boundaries lies a vast, dangerous Maze. The player must survive, gather resources, interact with other survivors, and uncover the mystery of the world beyond the wall.

---

## Documentation

All project documentation is in the `docs/` folder:

| Document | Purpose |
|---|---|
| `docs/GDD.md` | Game Design Document — full game design |
| `docs/MVP.md` | Minimum Viable Product — scope and acceptance criteria |
| `docs/ROADMAP.md` | Development phases and milestones |
| `docs/TECHNICAL_DESIGN.md` | Architecture, systems, and technical decisions |
| `docs/ASSET_GUIDE.md` | Asset sources, licensing, and art direction |
| `docs/AGENTS.md` | Agent workflow rules and project conventions |

> **Read all documents before implementing any feature.**

---

## Project Structure

```
the-maze/
├── assets/          — Audio, materials, models, textures, animations, fonts
├── scenes/          — Godot scene files (.tscn)
│   ├── main/        — Entry point and test scenes
│   ├── player/      — Player scene
│   ├── world/       — World root scenes
│   ├── environment/ — Glade, Maze environment scenes
│   ├── interactables/ — Interactable objects
│   ├── items/       — Item world objects
│   ├── npcs/        — NPC scenes
│   ├── enemies/     — Enemy scenes (The Stalker)
│   └── ui/          — UI scenes
├── scripts/         — GDScript files
│   ├── player/      — PlayerController, etc.
│   ├── survival/    — SurvivalComponent
│   ├── inventory/   — InventoryComponent
│   ├── crafting/    — CraftingSystem
│   ├── interaction/ — Interactable base class
│   ├── world/       — Autoloads: GameManager, WorldTimeManager, SaveManager, AudioManager
│   ├── quests/      — QuestManager
│   ├── ai/          — Enemy AI state machine
│   └── utilities/   — Shared helpers
├── resources/       — Godot Resource definitions (.tres)
│   ├── items/       — ItemDefinition resources
│   ├── recipes/     — RecipeDefinition resources
│   ├── quests/      — QuestDefinition resources
│   ├── dialogue/    — Dialogue data
│   └── characters/  — Character definitions
├── data/            — JSON data files
├── docs/            — Project documentation (read-only)
└── tests/           — Test scenes and scripts
```

---

## Setup

### Requirements

- **Godot 4.x Stable** (Standard, non-.NET build)
  - Download: https://godotengine.org/download/windows/
- **Git** 2.x or later

### First-Time Setup

1. Install Godot 4.x and add it to your system PATH.
2. Clone or open this repository.
3. Open Godot Project Manager.
4. Click **Import** and select `D:\1.Prpject\2.game-project\the-maze`.
5. Open the project.
6. Set the renderer to **Forward+** if prompted.
7. Run `scenes/main/test_room.tscn` to verify the player controller.

---

## Development Rules

- Follow `docs/ROADMAP.md` development order.
- Follow `docs/MVP.md` scope strictly — no unapproved features.
- Use GDScript only.
- Test every system after implementation.
- Use placeholder assets until core gameplay is functional.
- Record all external asset sources and licenses.
- Use Git for every milestone.

---

## Git Workflow

```
main       — stable milestones only
develop    — integration branch
feature/*  — individual feature branches
```

Commit conventions:
```
feat: add first person controller
fix: correct player collision shape
refactor: separate survival from player script
docs: update technical design
chore: initialize project structure
```

---

**Project:** Beyond The Wall  
**Version:** Pre-production  
**Status:** Phase 1 — Project Foundation
