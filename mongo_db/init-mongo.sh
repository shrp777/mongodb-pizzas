#!/bin/bash
set -e

## Option 1
## Création d'une Base de données et d'une collection avec une
# mongosh -- "$MONGO_INITDB_DATABASE" <<EOF
#     /*
#     var rootUser = '$MONGO_INITDB_ROOT_USERNAME';
#     var rootPassword = '$MONGO_INITDB_ROOT_PASSWORD';
#     var admin = db.getSiblingDB($MONGO_INITDB_DATABASE);
#     admin.auth(rootUser, rootPassword);

#     var user = '$MONGO_INITDB_USERNAME';
#     var passwd = '$MONGO_INITDB_PASSWORD';
#     db.createUser({user: user, pwd: passwd, roles: ["dbOwner"]});

#     var defaultCollection = '$MONGO_INITDB_COLLECTION'; 

#     db.createCollection(defaultCollection, {capped:false});
#     db.getCollection(defaultCollection).insertOne({message:"Hello, World!"});
#     */
# EOF

## Option 2
## Import de données à l'initialisation à partir d'un fichier JSON
mongoimport /tmp/import/data.json -d $MONGO_INITDB_DATABASE -c $MONGO_INITDB_COLLECTION --drop