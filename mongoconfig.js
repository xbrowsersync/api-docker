db.newsynclogs.createIndex( { "expiresAt": 1 }, { expireAfterSeconds: 0 } );
db.newsynclogs.createIndex( { "ipAddress": 1 } );
db.bookmarks.createIndex( { "lastAccessed": 1 }, { expireAfterSeconds: 21*86400 } );