# Mobile app placeholder

Once the stack is chosen (see `docs/decisions-needed.md`), generate the actual mobile project in this folder.

## React Native (Expo managed)
```bash
cd apps/mobile
npx create-expo-app@latest .
```

## React Native (bare)
```bash
cd apps
npx react-native init mobile
```

## Flutter
```bash
cd apps
flutter create mobile
```

## Native
- iOS: create Xcode project under `apps/mobile/ios`
- Android: create Gradle project under `apps/mobile/android`

## Notes
- Background geo-tracking generally requires careful OS configuration (iOS background modes, Android foreground service).
- Decide on the map SDK before wiring up map rendering and offline tiles.
