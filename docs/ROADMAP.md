# BEYOND THE WALL
## Development Roadmap

**Version:** 1.0.0  
**Estimated Duration:** 12–14 Weeks  
**Engine:** Godot 4.x

---

## 1. Development Strategy

Pengembangan dilakukan secara bertahap.

Setiap tahap harus menghasilkan sesuatu yang dapat diuji sebelum melanjutkan ke tahap berikutnya.

Gunakan placeholder dan greybox sebelum membuat aset final.

Jangan mengembangkan seluruh fitur secara bersamaan.

## 2. Phase 1 — Project Foundation

**Estimated Duration:** 2 Weeks

Tasks:

- Install Godot 4.x stable.
- Create project.
- Configure rendering settings.
- Configure input mapping.
- Create folder structure.
- Initialize Git repository.
- Create main scene.
- Implement first-person controller.
- Implement camera movement.
- Implement gravity and collision.
- Implement interaction raycast.

Milestone:

Pemain dapat bergerak, melihat sekeliling, melompat, dan berinteraksi dengan objek sederhana.

Exit Criteria:

- Controller stabil.
- Collision berfungsi.
- Tidak ada bug movement yang kritis.
- Project dapat dijalankan tanpa error.

## 3. Phase 2 — Environment Greybox

**Estimated Duration:** 2 Weeks

Tasks:

- Create The Glade greybox.
- Create The Maze greybox.
- Add basic terrain.
- Add walls and corridors.
- Add Maze Gate.
- Add collision.
- Create environmental landmarks.
- Test navigation.

Milestone:

Pemain dapat menjelajahi The Glade dan satu segmen The Maze.

Exit Criteria:

- Area dapat dijelajahi.
- Tidak ada lubang atau collision kritis.
- Batas level bekerja.
- Performa awal dapat diterima.

## 4. Phase 3 — Survival and Inventory

**Estimated Duration:** 2 Weeks

Tasks:

- Implement Health.
- Implement Hunger.
- Implement Thirst.
- Implement Stamina.
- Create item definitions.
- Implement inventory data.
- Implement pickup interaction.
- Implement consumables.
- Create inventory UI.

Milestone:

Pemain dapat mengumpulkan dan menggunakan item serta mengelola kebutuhan hidup.

Exit Criteria:

- Status survival berjalan.
- Inventory menyimpan item dengan benar.
- Consumables bekerja.
- UI menampilkan data yang benar.

## 5. Phase 4 — Crafting and World Systems

**Estimated Duration:** 2 Weeks

Tasks:

- Create recipe definitions.
- Implement crafting validation.
- Implement crafting UI.
- Add Basic Torch.
- Add Bandage.
- Add Storage Box.
- Implement day/night cycle.
- Implement Maze Gate change.
- Test collision and navigation after gate change.

Milestone:

Pemain dapat melakukan crafting dan mengalami perubahan waktu serta jalur labirin.

Exit Criteria:

- Crafting berjalan.
- Day/night berjalan.
- Gate dapat berubah.
- Perubahan gate tidak menjebak pemain.

## 6. Phase 5 — NPC and Quest

**Estimated Duration:** 1–2 Weeks

Tasks:

- Create NPC scene.
- Implement NPC interaction.
- Create dialogue data.
- Implement dialogue UI.
- Create one quest.
- Implement quest progress.
- Implement quest completion.

Milestone:

Pemain dapat berbicara dengan NPC dan menyelesaikan satu quest.

Exit Criteria:

- Dialog berjalan.
- Quest dapat diterima.
- Objective dapat diselesaikan.
- Progress dapat disimpan.

## 7. Phase 6 — Enemy AI

**Estimated Duration:** 1–2 Weeks

Tasks:

- Create The Stalker placeholder.
- Implement patrol.
- Implement detection.
- Implement chase.
- Implement attack.
- Implement lost-target behavior.
- Add basic enemy audio.
- Test navigation.

Milestone:

The Stalker dapat mengejar dan menyerang pemain.

Exit Criteria:

- Patrol bekerja.
- Detection bekerja.
- Chase bekerja.
- Attack bekerja.
- Enemy dapat kehilangan target.
- AI tidak mengalami pathfinding failure yang kritis.

## 8. Phase 7 — Integration and Polish

**Estimated Duration:** 1–2 Weeks

Tasks:

- Create Main Menu.
- Complete HUD.
- Complete Pause Menu.
- Implement Save/Load.
- Add ambience.
- Add sound effects.
- Optimize environment.
- Test all systems together.
- Export Windows build.

Milestone:

MVP dapat dimainkan dari awal sampai akhir.

Exit Criteria:

- Tidak ada bug kritis.
- Save/load bekerja.
- UI berfungsi.
- Performa memenuhi target pengujian.
- Windows build dapat dijalankan.

## 9. Development Rules

1. Jangan menambahkan fitur di luar MVP sebelum MVP selesai.
2. Gunakan Git untuk setiap milestone.
3. Test setiap sistem setelah implementasi.
4. Gunakan placeholder sebelum final assets.
5. Hindari script yang terlalu besar.
6. Hindari premature optimization.
7. Catat bug dan solusi.
8. Jangan mengubah struktur project secara besar-besaran tanpa alasan.

## 10. Suggested Git Workflow

Branch:

- main
- develop
- feature/player-controller
- feature/survival-system
- feature/inventory
- feature/crafting
- feature/npc
- feature/enemy-ai

Contoh commit:

- feat: add first person controller
- feat: implement hunger system
- fix: correct player collision
- refactor: separate inventory logic
- docs: update technical design

## 11. Future Development

Setelah MVP:

- Expand The Glade.
- Expand The Maze.
- Add more NPCs.
- Add more quests.
- Add additional enemy types.
- Introduce The Underground.
- Expand environmental storytelling.
- Add advanced survival mechanics.

---

**Document:** ROADMAP.md  
**Project:** Beyond The Wall  
**Version:** 1.0.0
