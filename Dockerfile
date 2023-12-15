# Usa una imagen de Node.js como base para la aplicación de React
FROM node:latest as react-builder

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos necesarios para la aplicación de React
COPY . .

# Instala las dependencias
RUN npm install
RUN npm install chart.js

# Construye la aplicación React para producción
RUN npm run build

# ------------------------------------------------------

# Cambiamos a una nueva imagen base para la parte de Node.js
FROM node:14

# Establece el directorio de trabajo para la aplicación Node.js
WORKDIR /usr/src/app

# Copia el archivo package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias para la aplicación Node.js
RUN npm install
RUN npm install faker
RUN npm install csv-parser fast-csv
RUN npm install body-parser

# Copia los archivos necesarios para la aplicación Node.js
COPY . .

# Ejemplo de configuración de variable de entorno en el Dockerfile
ENV FRANKFURTER_API_URL https://api.frankfurter.app

# Expone el puerto 3000 para ambas aplicaciones
EXPOSE 3000
EXPOSE 80

# Comando para ejecutar la aplicación Node.js
CMD ["node", "app.js"]
