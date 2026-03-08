# iOS app (native)

This folder is reserved for the **native iOS** Mountainr app.

## Tooling
- Xcode 15+ (Swift 5.9+)
- SwiftUI for UI
- CoreLocation for GPS / background tracking
- Mapbox Maps SDK for iOS (via Swift Package Manager)

## Create the Xcode project
1. Open Xcode → **File → New → Project…**
2. Choose **iOS → App**
3. Product Name: `Mountainr`
4. Interface: **SwiftUI**
5. Language: **Swift**
6. Save it into `apps/ios/`.

## Mapbox setup
- Create a Mapbox access token: https://console.mapbox.com/account/access-tokens/
- Add it to your iOS app **Info.plist** (recommended pattern):
  - Key: `MBXAccessToken`
  - Value: your token

Add Mapbox as an SPM dependency:
- Xcode → **File → Add Package Dependencies…**
- Add Mapbox Maps SDK for iOS

## Background location setup (CoreLocation)
You will need:
- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysAndWhenInUseUsageDescription`
- `UIBackgroundModes` → `location`

Notes:
- iOS background tracking will stop if the user force-quits the app.
- Persist track points incrementally to SQLite while recording.

## Data storage (offline-first)
A GRDB + migrations starter is included in this repo as a local Swift package:
- `apps/ios/MountainrCore`

Canonical schema reference:
- `docs/db/schema-v1.sql`

## Next file to implement
- `LocationRecorder` service (CoreLocation)
- `TrackStore` (SQLite)
- `MapView` screen (Mapbox) with recorded polyline rendering
