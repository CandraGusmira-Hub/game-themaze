# BEYOND THE WALL
## Technical Design Document

**Version:** 1.0.0  
**Engine:** Godot 4.x Stable  
**Language:** GDScript  
**Platform:** Windows PC

---

## 1. Technical Overview

Project menggunakan Godot 4.x dan GDScript.

Arsitektur harus modular agar setiap sistem dapat dikembangkan, diuji, dan diperbaiki secara terpisah.

Hindari membuat seluruh gameplay dalam satu script besar.

## 2. Technology Stack

| Component | Technology |
|---|---|
| Game Engine | Godot 4.x |
| Programming | GDScript |
| Rendering | Godot Forward+ or Mobile Renderer |
| Physics | Godot Physics |
| Navigation | Godot NavigationServer |
| Data Format | JSON / Godot Resources |
| Version Control | Git |
| Target Platform | Windows PC |

Pemilihan renderer harus mempertimbangkan perangkat target. Lakukan pengujian performa sejak awal.

## 3. Project Structure

Struktur direktori yang disarankan:

    Beyond-The-Wall/
    |
    ├── assets/
    │   ├── audio/
    │   ├── materials/
    │   ├── models/
    │   ├── textures/
    │   ├── animations/
    │   └── fonts/
    |
    ├── scenes/
    │   ├── main/
    │   ├── player/
    │   ├── world/
    │   ├── environment/
    │   ├── interactables/
    │   ├── items/
    │   ├── npcs/
    │   ├── enemies/
    │   └── ui/
    |
    ├── scripts/
    │   ├── player/
    │   ├── survival/
    │   ├── inventory/
    │   ├── crafting/
    │   ├── interaction/
    │   ├── world/
    │   ├── quests/
    │   ├── ai/
    │   └── utilities/
    |
    ├── resources/
    │   ├── items/
    │   ├── recipes/
    │   ├── quests/
    │   ├── dialogue/
    │   └── characters/
    |
    ├── data/
    ├── docs/
    ├── tests/
    ├── project.godot
    └── README.md

## 4. Architecture Principles

### 4.1 Modular Systems

Setiap sistem memiliki tanggung jawab sendiri.

Contoh:

- PlayerController: movement dan camera.
- SurvivalComponent: status kebutuhan pemain.
- InventoryComponent: penyimpanan item.
- CraftingSystem: validasi dan proses crafting.
- InteractionComponent: interaksi objek.
- QuestManager: progress quest.
- EnemyController: perilaku musuh.

### 4.2 Avoid Overusing Autoloads

Autoload hanya digunakan untuk sistem yang benar-benar membutuhkan akses global.

Autoload kandidat:

| Autoload | Responsibility |
|---|---|
| GameManager | Game state |
| WorldTimeManager | World time |
| SaveManager | Save/load |
| AudioManager | Global audio |

Inventory, survival, quest, dan maze logic tidak otomatis dijadikan singleton.

## 5. Player System

Node structure kandidat:

    Player (CharacterBody3D)
    |
    ├── CollisionShape3D
    ├── Head (Node3D)
    │   └── Camera3D
    ├── InteractionRay (RayCast3D)
    └── PlayerAudio

PlayerController bertanggung jawab terhadap:

- Movement.
- Camera rotation.
- Jump.
- Gravity.
- Sprint.
- Collision.

Gunakan CharacterBody3D sebagai dasar controller.

## 6. Interaction System

Sistem interaksi menggunakan RayCast3D dari kamera.

Objek yang dapat diinteraksikan menggunakan interface atau base class yang konsisten.

Contoh interaksi:

- Pickup item.
- Open container.
- Talk to NPC.
- Activate mechanism.
- Open door.

Semua interaksi harus memiliki pemeriksaan jarak dan kondisi.

## 7. Survival System

Data utama:

    health
    hunger
    thirst
    stamina

Semua nilai harus memiliki batas minimum dan maksimum.

Contoh aturan:

- Health: 0–100.
- Hunger: 0–100.
- Thirst: 0–100.
- Stamina: 0–100.

Nilai tersebut merupakan nilai awal untuk balancing dan dapat disesuaikan.

SurvivalComponent harus terpisah dari PlayerController.

## 8. Item and Inventory System

Gunakan Resource untuk definisi item statis.

Contoh ItemDefinition:

    class_name ItemDefinition
    extends Resource

    @export var item_id: String
    @export var display_name: String
    @export_multiline var description: String
    @export var icon: Texture2D
    @export var max_stack: int = 1
    @export var item_type: String

Inventory menyimpan data item berdasarkan ID dan jumlah.

Jangan menggunakan display_name sebagai identifier.

Contoh ID:

- wood
- cloth
- basic_torch
- bandage

## 9. Crafting System

Gunakan RecipeDefinition sebagai Resource.

Setiap resep memiliki:

- Recipe ID.
- Output item ID.
- Output quantity.
- Required materials.

Crafting harus melakukan validasi material sebelum mengurangi inventory.

Pastikan proses crafting bersifat konsisten agar item tidak hilang atau terduplikasi.

## 10. NPC and Quest System

NPC memiliki:

- Character ID.
- Display name.
- Dialogue definition.
- Quest references.

QuestDefinition menyimpan:

- Quest ID.
- Title.
- Description.
- Objectives.
- Rewards.

Quest progress disimpan menggunakan ID dan nilai progress.

Untuk MVP, cukup satu NPC dan satu quest.

## 11. Enemy AI

The Stalker menggunakan state machine sederhana.

States:

    PATROL
      |
      v
    DETECT
      |
      v
    CHASE
      |
      v
    ATTACK
      |
      v
    RETURN_TO_PATROL

Gunakan NavigationAgent3D jika diperlukan untuk pergerakan di area labirin.

Detection dapat menggunakan jarak dan pemeriksaan line of sight.

Untuk MVP, hindari AI yang terlalu kompleks.

## 12. Maze Mechanic

Maze Gate merupakan mekanisme perubahan jalur yang telah ditentukan.

Proses perubahan:

1. Check current state.
2. Check nearby actors.
3. Display warning.
4. Play gate animation.
5. Update collision.
6. Update navigation if required.
7. Validate player access.
8. Complete transition.

Jangan mengubah jalur jika pemain atau NPC berada pada posisi yang dapat menyebabkan mereka terjebak.

Untuk MVP, gunakan perubahan jalur terbatas, bukan procedural maze generation.

## 13. Save System

Save menggunakan JSON atau format data terstruktur yang sesuai.

Data yang disimpan:

    {
      "schema_version": 1,
      "player": {
        "position": [0, 0, 0],
        "health": 100,
        "hunger": 100,
        "thirst": 100,
        "stamina": 100
      },
      "inventory": [],
      "world_time": 0,
      "quest_progress": {},
      "maze_state": {}
    }

Contoh di atas merupakan gambaran struktur, bukan format implementasi final.

Rules:

- Gunakan schema version.
- Simpan ID, bukan referensi node runtime.
- Validasi data ketika loading.
- Tangani file yang rusak.
- Tangani file yang belum tersedia.
- Jangan menimpa save valid sebelum save baru berhasil dibuat.

## 14. Performance Guidelines

Target awal:

- 30 FPS stabil pada perangkat pengujian.
- Gunakan collision sederhana.
- Batasi dynamic shadows.
- Batasi transparansi.
- Gunakan LOD jika diperlukan.
- Gunakan texture resolution yang sesuai.
- Hindari terlalu banyak node aktif.
- Profile sebelum melakukan optimasi besar.

## 15. Testing Strategy

Player:

- Movement.
- Camera.
- Collision.
- Jump.
- Sprint.

Survival:

- Health boundaries.
- Hunger decrease.
- Thirst decrease.
- Stamina recovery.

Inventory:

- Pickup.
- Add item.
- Remove item.
- Stack.
- Use item.

Crafting:

- Valid recipe.
- Insufficient materials.
- Output validation.

Maze:

- Gate transition.
- Collision update.
- Player safety.
- NPC safety.

NPC:

- Dialogue.
- Quest acceptance.
- Quest completion.

Enemy:

- Patrol.
- Detection.
- Chase.
- Attack.
- Lost target.

Save:

- Save.
- Load.
- Missing file.
- Corrupt file.
- Schema version.

Build:

- Windows export.
- Startup.
- Gameplay.
- Save/load.

## 16. Version Control

Gunakan Git.

Simpan perubahan secara bertahap.

Jangan memasukkan file cache atau hasil build yang tidak diperlukan ke repository.

Gunakan `.gitignore` yang sesuai dengan Godot.

---

**Document:** TECHNICAL_DESIGN.md  
**Project:** Beyond The Wall  
**Version:** 1.0.0
