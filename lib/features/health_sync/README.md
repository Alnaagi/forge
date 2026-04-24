# Health Sync

Health Connect read/sync is now implemented for:
- steps
- heart rate
- sleep sessions
- body weight

Current rules:
- Health Connect is an external source, not the source of truth
- imported records are stored in local Drift tables
- repeat syncs dedupe by external record id
- body weight imports can mirror into progress when they do not collide with an existing local log

Still deferred:
- write-back to Health Connect
- broader data types
- background sync
