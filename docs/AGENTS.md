# AGENTS.md — Beyond The Wall

## 1. Project Identity

Project: Beyond The Wall

Genre: First-Person Survival Adventure
Engine: Godot 4.x Stable
Language: GDScript
Platform: Windows PC
Mode: Single-player
Visual Style: Semi-realistic

## 2. Source of Truth

Read and follow these documents before implementing anything:

- docs/GDD.md
- docs/MVP.md
- docs/ROADMAP.md
- docs/TECHNICAL_DESIGN.md
- docs/ASSET_GUIDE.md

These documents are the authoritative project specifications.

Do not silently change their requirements.

If two requirements appear inconsistent, report the conflict
and ask before making a decision.

## 3. Development Rules

- Follow the MVP scope.
- Follow the development order in ROADMAP.md.
- Use modular GDScript architecture.
- Use Godot 4.x APIs only.
- Use clear and consistent naming.
- Avoid unnecessary dependencies.
- Avoid giant scripts and tightly coupled systems.
- Use placeholder assets before final assets.
- Prefer simple and maintainable implementations.
- Do not implement future features unless explicitly requested.

## 4. Agent Workflow

For every task:

1. Inspect relevant project files.
2. Read relevant documentation.
3. Explain the implementation plan.
4. List files that will be created or modified.
5. Wait for approval before major changes.
6. Implement only the approved task.
7. Check for syntax and reference errors.
8. Run available validation or tests.
9. Report modified files and test results.
10. Explain any remaining issues.

## 5. File Safety

- Never delete project documentation.
- Never overwrite unrelated files.
- Never remove existing functionality without approval.
- Never replace a working system unnecessarily.
- Never modify project-wide settings without explaining why.
- Do not perform destructive terminal commands without approval.

## 6. Game Design Rules

- Keep all characters and creatures original.
- Do not copy copyrighted characters, monsters,
  locations, stories, or assets from other franchises.
- The Stalker must follow the original enemy design
  and behavior described in the project documents.
- The Maze must not trap the player or NPC.

## 7. Asset Rules

- Use free assets only.
- Verify the license of every external asset.
- Record approved assets in the asset license register.
- Do not assume free means commercially usable.
- Use placeholders until gameplay systems work.

## 8. Performance

- Target stable 30 FPS on the selected mid-range test hardware.
- Avoid unnecessary high-poly assets.
- Use simple collision shapes.
- Avoid excessive real-time lights and shadows.
- Profile before attempting complex optimization.

## 9. Completion Criteria

A task is not complete merely because code was generated.

It must be:
- Implemented.
- Integrated.
- Checked for errors.
- Tested in Godot where applicable.
- Consistent with project documentation.

Never claim a test passed if it was not actually executed.
