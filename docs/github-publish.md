# Publish current state to GitHub

This repo already contains a `.git` directory, so the remaining work is typically:
- stage changes
- commit
- push to your GitHub remote

## 1) Verify remotes
```bash
git remote -v
```

If no remote exists:
```bash
git remote add origin https://github.com/<org>/<repo>.git
```

## 2) Stage changes
```bash
git status
git add -A
```

## 3) Commit
```bash
git commit -m "Scaffold native iOS/Android apps + add DB schema (v1)"
```

## 4) Push
```bash
git push -u origin main
```

If your default branch is `master`, replace `main` with `master`.

## Notes
- Do not commit secrets (Mapbox tokens). Prefer `local.properties` (Android) and local Xcode build settings / non-checked-in plist entries.
- If you want CI, we can add GitHub Actions for linting/tests once the native projects are generated.
