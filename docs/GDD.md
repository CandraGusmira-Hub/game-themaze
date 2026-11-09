# BEYOND THE WALL
## Game Design Document (GDD)

**Version:** 1.0.0  
**Status:** Pre-production  
**Engine:** Godot 4.x  
**Language:** GDScript  
**Platform:** Windows PC  
**Genre:** First-Person Survival Adventure  
**Mode:** Single-player  
**Visual Style:** Semi-realistic

---

## 1. Game Overview

Beyond The Wall adalah game survival adventure first-person yang berfokus pada eksplorasi, misteri, dan bertahan hidup di lingkungan yang dikelilingi labirin raksasa.

Pemain terbangun sendirian di sebuah area bernama The Glade. Tempat tersebut terlihat seperti bekas permukiman manusia yang telah lama ditinggalkan.

Di luar area aman terdapat sebuah labirin besar yang menyimpan berbagai sumber daya, jalur tersembunyi, dan ancaman berbahaya.

Pemain harus menjelajahi lingkungan, mengumpulkan sumber daya, mengelola kebutuhan hidup, serta mencari tahu alasan dirinya berada di tempat tersebut.

Game ini menggunakan tema survival dan misteri sebagai inspirasi umum. Seluruh karakter, cerita, lokasi, monster, desain, dan aset Beyond The Wall merupakan IP original.

## 2. Core Concept

Pemain harus mempersiapkan diri sebelum memasuki labirin, mencari sumber daya, menghadapi ancaman, kemudian kembali ke tempat aman untuk bertahan hidup dan melanjutkan eksplorasi.

### Core Gameplay Loop

1. Prepare at The Glade.
2. Enter The Maze.
3. Explore the environment.
4. Collect resources.
5. Avoid or survive threats.
6. Return to The Glade.
7. Recover and craft equipment.
8. Unlock new exploration opportunities.

## 3. Game Setting

### 3.1 The Glade

The Glade merupakan area awal sekaligus tempat perlindungan pemain.

Lokasi ini dulunya digunakan oleh sekelompok penyintas yang dikenal sebagai The Remnants.

Fasilitas yang direncanakan:

- Main Camp
- Player Shelter
- Workshop
- Storage Area
- Water Source
- Medical Corner
- Maze Gate
- Abandoned Buildings

Fungsi utama The Glade:

- Tempat beristirahat.
- Tempat menyimpan sumber daya.
- Tempat melakukan crafting.
- Tempat berinteraksi dengan NPC.
- Tempat mempersiapkan perjalanan.

### 3.2 The Maze

The Maze adalah area eksplorasi utama yang terdiri dari koridor besar, persimpangan, jalan buntu, dan berbagai landmark.

Karakteristik:

- Struktur labirin yang besar.
- Jalur tertentu dapat berubah.
- Sumber daya terbatas.
- Pencahayaan yang tidak selalu stabil.
- Area berbahaya.
- Keberadaan The Stalker.

### 3.3 The Underground

The Underground merupakan fasilitas tersembunyi yang memiliki hubungan dengan misteri dunia Beyond The Wall.

Area ini direncanakan untuk pengembangan berikutnya dan tidak termasuk dalam MVP.

Petunjuk keberadaannya dapat diperkenalkan melalui:

- Dokumen lama.
- Pintu fasilitas terkunci.
- Simbol misterius.
- Rekaman audio.
- Struktur bangunan yang tidak biasa.

## 4. Story Concept

Pemain terbangun di The Glade tanpa mengingat bagaimana dirinya tiba di tempat tersebut.

Tidak ada seorang pun yang terlihat di sekitar area tersebut.

Bangunan-bangunan terlihat terbengkalai, beberapa fasilitas rusak, dan persediaan makanan hampir habis.

Pemain mulai menemukan berbagai catatan yang ditinggalkan oleh kelompok penyintas sebelumnya.

Melalui eksplorasi, pemain akan menemukan petunjuk mengenai:

- Identitas kelompok penyintas.
- Alasan The Glade ditinggalkan.
- Asal-usul The Maze.
- Keberadaan The Stalker.
- Hubungan The Glade dengan The Underground.

Cerita disampaikan secara bertahap melalui environmental storytelling.

## 5. Main Characters

### 5.1 The Player

Karakter utama yang dikendalikan pemain.

Informasi identitas karakter belum diketahui pada awal permainan.

### 5.2 The Remnants

Kelompok penyintas yang sebelumnya tinggal di The Glade.

Karakter yang direncanakan:

| Character | Role | Description |
|---|---|---|
| Elias | Leader | Pemimpin kelompok penyintas. |
| Mira | Medic | Bertanggung jawab terhadap kesehatan kelompok. |
| Rowan | Engineer | Mengelola peralatan dan fasilitas. |
| Kaia | Scout | Ahli eksplorasi dan pengamatan. |
| Finn | Gatherer | Mengumpulkan makanan dan sumber daya. |

Untuk MVP, hanya satu NPC aktif yang diperlukan.

NPC yang direkomendasikan adalah Elias atau Kaia.

### 5.3 The Stalker

The Stalker merupakan ancaman utama di area labirin.

The Stalker adalah makhluk original yang memiliki perilaku berburu berdasarkan suara dan keberadaan pemain.

Karakteristik:

- Berpatroli di area tertentu.
- Mendeteksi pemain berdasarkan jarak.
- Mengejar pemain ketika target terdeteksi.
- Menyerang ketika berada dalam jangkauan.
- Kehilangan target ketika pemain berhasil menjauh atau bersembunyi.

Desain visual dan perilakunya harus dikembangkan secara original.

## 6. Gameplay Systems

### 6.1 First-Person Controller

Kontrol utama:

| Input | Action |
|---|---|
| W | Move Forward |
| S | Move Backward |
| A | Move Left |
| D | Move Right |
| Mouse | Look Around |
| Shift | Sprint |
| Space | Jump |
| E | Interact |
| Tab | Inventory |
| Esc | Pause Menu |

### 6.2 Survival System

Pemain memiliki empat kebutuhan utama:

- Health
- Hunger
- Thirst
- Stamina

Hunger dan thirst akan berkurang seiring waktu.

Stamina digunakan untuk aktivitas seperti berlari.

Health akan berkurang akibat serangan musuh atau kondisi berbahaya.

### 6.3 Inventory System

Pemain dapat:

- Mengambil item.
- Menyimpan item.
- Menggunakan item.
- Menjatuhkan item.
- Melihat informasi item.

### 6.4 Crafting System

Crafting dilakukan menggunakan sumber daya yang ditemukan pemain.

Contoh resep:

| Item | Materials |
|---|---|
| Basic Torch | Wood + Cloth |
| Bandage | Cloth |
| Storage Box | Wood |

### 6.5 Day and Night Cycle

Dunia memiliki siklus siang dan malam.

Perubahan waktu memengaruhi:

- Pencahayaan.
- Visibilitas.
- Suasana lingkungan.
- Tingkat risiko eksplorasi.

### 6.6 Maze Mechanic

Sebagian struktur labirin dapat berubah.

Untuk MVP, cukup implementasikan satu mekanisme perubahan jalur yang telah ditentukan.

Perubahan harus dilakukan dengan aman agar tidak menjebak pemain atau NPC.

### 6.7 NPC Interaction

Pemain dapat berinteraksi dengan NPC melalui dialog sederhana.

NPC MVP memiliki:

- Satu interaksi dialog.
- Satu quest.
- Satu tujuan yang dapat diselesaikan pemain.

### 6.8 Enemy AI

The Stalker memiliki sistem perilaku:

1. Patrol.
2. Detect.
3. Chase.
4. Attack.
5. Return to Patrol.

### 6.9 Save System

Game harus mendukung penyimpanan progres dasar.

Data yang disimpan:

- Player position.
- Player health.
- Hunger.
- Thirst.
- Inventory.
- World time.
- Quest progress.
- Maze state.

## 7. Visual Direction

Gaya visual: Semi-realistic.

### The Glade

- Natural green.
- Weathered wood.
- Earth tones.
- Vegetation.
- Abandoned structures.

### The Maze

- Weathered concrete.
- Moss.
- Dark grey materials.
- Overgrown vegetation.
- Environmental damage.

### The Underground

- Industrial architecture.
- Metallic surfaces.
- Artificial lighting.
- Restricted facilities.

## 8. Audio Direction

Audio digunakan untuk meningkatkan atmosfer permainan.

Jenis audio:

- Environmental ambience.
- Wind.
- Footsteps.
- Water.
- Wildlife.
- Maze ambience.
- Enemy sounds.
- Interaction sounds.
- Background music.

## 9. Target Platform

Platform utama adalah Windows PC.

Target performa awal:

- Minimum target: 30 FPS stabil pada perangkat pengujian yang ditentukan.
- Optimasi untuk laptop kelas menengah.
- Hindari penggunaan efek visual yang terlalu berat.
- Gunakan collision sederhana.
- Batasi dynamic lighting dan shadow yang tidak diperlukan.

## 10. Development Scope

Pengembangan dibagi menjadi dua kategori:

### MVP

- Small Glade.
- One Maze Segment.
- First-Person Controller.
- Survival System.
- Inventory.
- Basic Crafting.
- Day/Night Cycle.
- One Maze Mechanic.
- One NPC.
- One Quest.
- One Enemy.
- HUD.
- Save/Load.

### Future Development

- The Underground.
- More NPCs.
- More enemy types.
- Expanded Maze.
- Advanced crafting.
- More quests.
- Advanced survival mechanics.
- Additional story chapters.

## 11. Design Principles

1. Exploration must feel rewarding.
2. Survival must feel challenging but fair.
3. The environment should tell the story.
4. Player decisions should have consequences.
5. Performance must remain a priority.
6. Gameplay systems must be modular.
7. All characters and world elements must remain original.

---

**Document:** GDD.md  
**Project:** Beyond The Wall  
**Version:** 1.0.0
