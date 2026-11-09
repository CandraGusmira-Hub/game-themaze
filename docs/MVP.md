# BEYOND THE WALL
## Minimum Viable Product (MVP)

**Version:** 1.0.0  
**Status:** Pre-production

---

## 1. MVP Objective

MVP bertujuan menghasilkan versi awal Beyond The Wall yang sudah dapat dimainkan dari awal hingga akhir dalam satu sesi permainan sederhana.

MVP digunakan untuk membuktikan bahwa sistem utama permainan dapat bekerja bersama.

Prioritas bukan jumlah konten, melainkan kualitas dan stabilitas gameplay inti.

## 2. MVP Gameplay Flow

1. Pemain memulai permainan.
2. Pemain terbangun di The Glade.
3. Pemain mempelajari kontrol dasar.
4. Pemain menemukan NPC.
5. NPC memberikan satu quest.
6. Pemain mempersiapkan kebutuhan.
7. Pemain memasuki The Maze.
8. Pemain mengumpulkan sumber daya.
9. Pemain menghadapi The Stalker.
10. Pemain menyelesaikan objective.
11. Pemain kembali ke The Glade.
12. Pemain menyelesaikan quest.

## 3. Features Included

### 3.1 Player Controller

- First-person camera.
- WASD movement.
- Mouse look.
- Walking.
- Sprinting.
- Jumping.
- Gravity.
- Collision detection.
- Interaction raycast.

Acceptance Criteria:

- Pemain dapat bergerak dengan lancar.
- Kamera tidak dapat berputar secara tidak wajar.
- Pemain tidak dapat menembus dinding.
- Interaksi hanya terjadi ketika objek berada dalam jangkauan.

### 3.2 Environment

The Glade:

- Satu area utama.
- Satu tempat berlindung.
- Satu workshop.
- Satu storage.
- Satu Maze Gate.

The Maze:

- Satu segmen labirin.
- Beberapa persimpangan.
- Jalan buntu.
- Satu landmark.
- Satu area sumber daya.

Acceptance Criteria:

- Pemain dapat menjelajahi kedua area.
- Tidak ada collision utama yang rusak.
- Pemain tidak dapat keluar dari batas level.

### 3.3 Survival

Status:

- Health.
- Hunger.
- Thirst.
- Stamina.

Acceptance Criteria:

- Nilai status memiliki batas minimum dan maksimum.
- Hunger dan thirst berkurang sesuai waktu.
- Sprint mengonsumsi stamina.
- Stamina dapat pulih.
- Pemain menerima peringatan ketika kebutuhan kritis.

### 3.4 Inventory

Fitur:

- Item pickup.
- Item storage.
- Item use.
- Item drop.
- Inventory UI.

Acceptance Criteria:

- Item dapat diambil.
- Item masuk ke inventory.
- Jumlah item diperbarui dengan benar.
- Item konsumsi dapat digunakan.
- Item tidak dapat digunakan ketika jumlahnya nol.

### 3.5 Crafting

Resep MVP:

| Recipe | Requirement |
|---|---|
| Basic Torch | Wood + Cloth |
| Bandage | Cloth |
| Storage Box | Wood |

Acceptance Criteria:

- Resep ditampilkan di UI.
- Material diperiksa sebelum crafting.
- Material dikurangi setelah crafting berhasil.
- Item hasil crafting masuk ke inventory.

### 3.6 Day/Night

Fitur:

- Time progression.
- Lighting transition.
- Day/night ambience.

Acceptance Criteria:

- Waktu berjalan secara konsisten.
- Pencahayaan berubah secara bertahap.
- Perubahan waktu tidak menyebabkan penurunan performa yang besar.

### 3.7 Maze Mechanic

MVP hanya menggunakan satu perubahan jalur yang telah dirancang.

Acceptance Criteria:

- Jalur berubah sesuai kondisi yang ditentukan.
- Pemain tidak tertutup oleh objek yang bergerak.
- Collision diperbarui.
- Jalur penting tetap dapat diakses.

### 3.8 NPC

NPC aktif: Elias atau Kaia.

Fitur:

- NPC dapat ditemukan di The Glade.
- Interaksi dialog.
- Satu quest.
- Objective completion.

Acceptance Criteria:

- NPC dapat diinteraksikan.
- Dialog muncul dengan benar.
- Quest dapat diterima.
- Quest dapat diselesaikan.
- Progress tersimpan.

### 3.9 Enemy AI

Enemy: The Stalker.

Behavior:

- Patrol.
- Detect.
- Chase.
- Attack.
- Return to Patrol.

Acceptance Criteria:

- Musuh bergerak mengikuti patrol.
- Musuh dapat mendeteksi pemain.
- Musuh mengejar pemain setelah terdeteksi.
- Musuh menyerang dalam jarak tertentu.
- Musuh berhenti mengejar setelah kehilangan target.

### 3.10 UI

UI MVP:

- Main Menu.
- HUD.
- Health indicator.
- Hunger indicator.
- Thirst indicator.
- Stamina indicator.
- Interaction prompt.
- Inventory.
- Crafting.
- Quest information.
- Pause Menu.

### 3.11 Save/Load

Acceptance Criteria:

- Pemain dapat menyimpan progres.
- Data dapat dimuat kembali.
- File save menggunakan format yang konsisten.
- Save yang rusak ditangani dengan aman.
- Versi struktur save dicatat.

### 3.12 Audio

- Footsteps.
- Ambient sound.
- Interaction sound.
- Enemy sound.
- Basic background music.

## 4. Features Excluded

Fitur berikut tidak termasuk MVP:

- Multiplayer.
- Large open world.
- Full procedural maze generation.
- Multiple playable characters.
- Complex NPC schedules.
- NPC relationship system.
- Multiple enemy types.
- Advanced combat.
- Complex base building.
- Farming.
- Advanced weather simulation.
- Underground playable level.
- Advanced fatigue simulation.
- Full cinematic story sequences.

## 5. MVP Development Priority

Priority 1:
- Project setup.
- Player controller.
- Environment greybox.
- Collision.
- Interaction.

Priority 2:
- Survival.
- Inventory.
- Item pickup.
- Consumables.

Priority 3:
- Crafting.
- Day/night.
- Maze mechanic.

Priority 4:
- NPC.
- Dialogue.
- Quest.
- Enemy AI.

Priority 5:
- UI.
- Save/load.
- Audio.
- Optimization.

## 6. MVP Completion Criteria

MVP dinyatakan selesai apabila:

- Game dapat dijalankan pada Windows.
- Pemain dapat bergerak dan berinteraksi.
- The Glade dapat dijelajahi.
- The Maze dapat dimasuki.
- Survival system berjalan.
- Inventory bekerja.
- Crafting berjalan.
- Day/night berjalan.
- Maze mechanic bekerja.
- NPC dapat memberikan quest.
- The Stalker dapat mendeteksi dan mengejar pemain.
- Save/load berfungsi.
- Tidak terdapat bug kritis yang menghalangi penyelesaian gameplay.

---

**Document:** MVP.md  
**Project:** Beyond The Wall  
**Version:** 1.0.0
