# BEYOND THE WALL
## Asset and Art Direction Guide

**Version:** 1.0.0  
**Visual Style:** Semi-realistic  
**Engine:** Godot 4.x

---

## 1. Purpose

Dokumen ini menjadi panduan penggunaan dan pengelolaan aset untuk Beyond The Wall.

Semua aset harus mendukung identitas visual game dan tidak boleh melanggar lisensi atau hak kekayaan intelektual pihak lain.

## 2. Art Direction

Gaya visual utama adalah semi-realistic.

Target visual:

- Natural.
- Atmospheric.
- Weathered.
- Believable.
- Consistent.

Hindari penggunaan aset yang memiliki gaya visual terlalu berbeda.

## 3. Environment Art

### 3.1 The Glade

Visual direction:

- Natural green vegetation.
- Weathered wood.
- Earth tones.
- Old buildings.
- Handmade structures.
- Natural sunlight.
- Signs of abandonment.

Asset requirements:

- Wooden buildings.
- Wooden fences.
- Storage boxes.
- Workbenches.
- Vegetation.
- Rocks.
- Water sources.
- Old furniture.

### 3.2 The Maze

Visual direction:

- Weathered concrete.
- Moss.
- Dark grey materials.
- Overgrown plants.
- Damaged structures.
- Deep shadows.
- Atmospheric fog where appropriate.

Asset requirements:

- Concrete walls.
- Maze gates.
- Structural pillars.
- Damaged surfaces.
- Vegetation.
- Rocks.
- Environmental debris.
- Lighting fixtures.

### 3.3 The Underground

Future development only.

Visual direction:

- Industrial architecture.
- Metal structures.
- Concrete corridors.
- Artificial lighting.
- Restricted facilities.
- Scientific equipment.

## 4. Character Assets

Character style harus konsisten dengan dunia permainan.

The Remnants:

- Practical clothing.
- Worn fabric.
- Utility accessories.
- Natural color palette.
- Functional equipment.

The Stalker:

- Original creature design.
- Distinct silhouette.
- Believable movement.
- Consistent material design.
- Recognizable visual identity.

Jangan menyalin desain karakter atau monster dari game, film, atau franchise lain.

## 5. Asset Sources

Sumber aset yang dapat dipertimbangkan:

### Godot Asset Library

https://godotengine.org/asset-library/

Digunakan untuk mencari plugin, tools, dan aset yang kompatibel dengan Godot.

### Kenney

https://kenney.nl/assets

Digunakan untuk mencari aset game gratis.

### Poly Haven

https://polyhaven.com/

Digunakan untuk mencari:

- Textures.
- HDRIs.
- 3D Models.

### ambientCG

https://ambientcg.com/

Digunakan untuk mencari material dan texture PBR.

### OpenGameArt

https://opengameart.org/

Digunakan untuk mencari berbagai aset game.

Catatan:

Tidak semua aset dari sumber tersebut memiliki lisensi yang sama. Periksa lisensi masing-masing aset sebelum digunakan.

## 6. License Management

Setiap aset eksternal harus dicatat.

Gunakan tabel Asset License Register:

| Asset ID | Asset Name | Creator | Source URL | License | Attribution | Status |
|---|---|---|---|---|---|---|
| ENV-001 | Example Tree | Creator | URL | CC0 | No | Pending |
| ENV-002 | Example Wall | Creator | URL | CC-BY | Yes | Pending |

Status:

- Pending: Belum diverifikasi.
- Approved: Lisensi sudah diperiksa.
- Rejected: Tidak boleh digunakan.

Jangan menggunakan aset jika lisensinya tidak jelas.

## 7. 3D Asset Guidelines

Pertimbangkan:

- Scale consistency.
- Polygon count.
- Texture resolution.
- Material complexity.
- Collision complexity.
- LOD requirements.
- Import settings.

Gunakan collision sederhana untuk objek lingkungan jika memungkinkan.

Jangan menggunakan mesh visual yang terlalu kompleks sebagai collision tanpa alasan.

## 8. Texture Guidelines

Gunakan texture sesuai kebutuhan.

Jenis texture:

- Albedo.
- Normal.
- Roughness.
- Metallic.
- Ambient Occlusion.

Pastikan ukuran texture sesuai dengan jarak pandang dan kebutuhan objek.

Hindari penggunaan texture resolusi tinggi secara berlebihan.

## 9. Lighting Guidelines

The Glade:

- Natural sunlight.
- Soft shadows.
- Warm atmosphere.

The Maze:

- Darker atmosphere.
- Limited light sources.
- Strong environmental contrast.

The Underground:

- Artificial lighting.
- Industrial ambience.
- Restricted visibility.

Lighting harus mempertimbangkan performa perangkat kelas menengah.

## 10. Audio Assets

Jenis audio:

- Wind.
- Forest ambience.
- Footsteps.
- Water.
- Environmental debris.
- Creature sounds.
- UI interactions.
- Background music.

Gunakan audio yang mendukung suasana dan tidak mengganggu gameplay.

Periksa lisensi audio sama seperti aset visual.

## 11. Placeholder First

Selama tahap awal pengembangan:

- Gunakan primitive meshes.
- Gunakan material sederhana.
- Gunakan placeholder audio.
- Gunakan karakter sementara.
- Gunakan UI sederhana.

Jangan menghabiskan terlalu banyak waktu mencari aset final sebelum gameplay utama berfungsi.

## 12. Asset Quality Checklist

Sebelum aset digunakan:

- [ ] Lisensi telah diperiksa.
- [ ] Sumber aset dicatat.
- [ ] Gaya visual sesuai.
- [ ] Skala sesuai.
- [ ] Material berfungsi.
- [ ] Collision sesuai.
- [ ] Performa telah diuji.
- [ ] Attribution telah disiapkan jika diperlukan.

## 13. Originality Rules

Beyond The Wall harus memiliki identitas visual dan desain original.

Dilarang:

- Menggunakan karakter dari franchise lain.
- Menyalin desain monster dari franchise lain.
- Menggunakan logo atau nama yang dilindungi.
- Menyalin lokasi ikonik secara identik.
- Menggunakan aset tanpa izin.
- Menganggap semua aset gratis otomatis boleh digunakan secara komersial.

---

**Document:** ASSET_GUIDE.md  
**Project:** Beyond The Wall  
**Version:** 1.0.0
