FROM node:alpine as build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier package.json et package-lock.json dans le répertoire de travail
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier l'ensemble du code de l'application dans le conteneur
COPY . .

# Construire l'application React pour la production
RUN npm run build

# Utiliser Nginx comme serveur de production
FROM nginx:alpine

# Copier l'application React construite dans le répertoire du serveur web de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80 pour le serveur Nginx
EXPOSE 80

# Démarrer Nginx lorsque le conteneur est lancé
CMD ["nginx", "-g", "daemon off;"]
