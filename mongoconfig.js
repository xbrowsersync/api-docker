db.newsynclogs.createIndex( { "expiresAt": 1 }, { expireAfterSeconds: 0 } );
db.newsynclogs.createIndex( { "ipAddress": 1 } );