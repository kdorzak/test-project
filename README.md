# Mountainr

Mobile mountaineering / hiking diary focused on **geo-tracking**, **trail maps**, and **gamified personal achievements**.

## What this repo is (right now)
This repository is intentionally scaffolded to support multiple mobile stacks (React Native / Flutter / native). Once we pick the stack and map SDK, we’ll generate the actual mobile app project under `apps/mobile/`.

## Planned core features
- **Activity recording**: start/pause/stop GPS tracking; store track + stats (distance, ascent/descent, time).
- **Maps**: render recorded tracks; import trails (GPX) and show them as layers.
- **Gamification**:
  - “Paint trails by walking them” (coverage/progress over known trails).
  - Peak/range challenges (reach a set of peaks).
  - Milestones (distance, elevation gain, step count, streaks).

## Docs
- `docs/project-blueprint.md` — technical blueprint (architecture, constraints)
- `docs/decisions-needed.md` — decisions required to generate the real app skeleton
- `docs/domain-model.md` — initial local data model

## Repo layout
```
.
├─ apps/
│  └─ mobile/
│     └─ README.md
└─ docs/
   ├─ project-blueprint.md
   ├─ decisions-needed.md
   └─ domain-model.md
```

## Next step
Pick the options in `docs/decisions-needed.md` (mobile stack, map SDK, platforms). After that, we’ll scaffold the chosen project (e.g., `expo init`, `flutter create`, or native Xcode/Gradle projects) and wire up location tracking + local storage.
