## Dockeriser une application React avec Nginx

Dockeriser une application React avec Nginx est une pratique courante pour déployer des applications web dans un environnement conteneurisé. Voici un guide pas à pas pour Dockeriser une application React en utilisant Nginx.

### Étape 1 : Préparer votre application React

Assurez-vous que votre application React est bien structurée et fonctionnelle.

### Étape 2 : Créer un Dockerfile

Créez un fichier `Dockerfile` à la racine de votre application React. Ce fichier définit comment votre application sera construite et exécutée dans un conteneur Docker.

```Dockerfile
# Utiliser l'image de base officielle de Node.js
FROM node:alpine as build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers package.json et package-lock.json dans le répertoire de travail
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier l'intégralité du code de l'application dans le conteneur
COPY . .

# Construire l'application React pour la production
RUN npm run build

# Utiliser Nginx comme serveur de production
FROM nginx:alpine

# Copier l'application React construite dans le répertoire du serveur web Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80 pour le serveur Nginx
EXPOSE 80

# Démarrer Nginx lorsque le conteneur s'exécute
CMD ["nginx", "-g", "daemon off;"]
```

### Étape 3 : Créer un fichier .dockerignore

Créez un fichier `.dockerignore` dans le même répertoire que votre `Dockerfile` pour exclure les fichiers et répertoires inutiles de l'image Docker.

```.dockerignore
node_modules
build
npm-debug.log
```

### Étape 4 : Construire l'image Docker

Ouvrez un terminal, placez-vous dans le répertoire racine de votre application React (là où se trouve le Dockerfile) et construisez l'image Docker avec la commande suivante :

```
docker build -t react-nginx-app .
```

Cette commande crée une image Docker nommée react-nginx-app. N'oubliez pas d'inclure le point . à la fin de la commande pour spécifier le contexte de construction.

### Étape 5 : Exécuter le conteneur Docker

Après avoir construit l'image Docker, vous pouvez exécuter le conteneur avec la commande suivante :

```
docker run --name react-nginx-app -p 8080:80 -d react-nginx-app
```

Cette commande exécute le conteneur en mode détaché (-d) et mappe le port 8080 de votre machine hôte au port 80 à l'intérieur du conteneur.

### Étape 6 : Accéder à votre application React

Vous pouvez maintenant accéder à votre application React en ouvrant un navigateur web et en naviguant à l'adresse `http://localhost:8080` ou à l'hôte et au port que vous avez spécifiés.

### Conclusion

Dockeriser une application React avec Nginx offre une méthode fiable pour déployer votre application dans divers environnements. Cette approche simplifie le déploiement et assure la cohérence sur différentes plateformes.
