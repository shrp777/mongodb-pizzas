# Docker + MongoDB Starter Kit

## Connexion à la db

```SH
mongosh admin -u <user> -p <password>
```

<https://www.mongodb.com/docs/manual/reference/method/db.auth/>

## Création d'un dump de MongoDB

```SH
docker exec mongo_db sh -c 'exec mongodump -d <database_name> --archive' > /all-collections.archive
```

--

!["Logotype Shrp"](https://shrp.dev/images/shrp.png)

__Alexandre Leroux__  
_Enseignant / Formateur_  
_Développeur logiciel web & mobile_

Nancy (Grand Est, France)

<https://shrp.dev>
