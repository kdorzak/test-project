# OSM trail discovery via Overpass API

## Why Overpass
Overpass is a read-only query API for OpenStreetMap data. It’s useful to prototype:
- “Find hiking trails around me”
- “Show nearby footpaths and tracks”

## Constraints
- Strict rate limits and load-shedding.
- Network variability in mountains.

**Implication:** cache results locally and consider a server/proxy for production.

## Suggested Overpass QL query (nearby hiking ways)
```overpass
[out:json][timeout:25];
(
  way(around:RADIUS_M,LAT,LON)[highway~"path|footway|track"]; 
);
out tags geom;
```

## Interpreting tags (pragmatic)
- `highway=path|footway|track`: base filter for likely trails
- Optional refinements:
  - `sac_scale=*` (Swiss Alpine Club hiking scale)
  - `trail_visibility=*`
  - `surface=*`
  - `access`, `foot` restrictions

## Data to cache
- `way id`
- `tags`
- `geometry` (polyline)

## Next step
When you’re ready, we can add a shared spec for the cached trail format (JSON schema) so iOS and Android store the same logical structure.
