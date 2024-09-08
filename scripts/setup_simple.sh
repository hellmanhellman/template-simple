#!/bin/bash

# Create root directory
if [[ -z "$1" || -d "./$1" ]]; then
  echo "Please provide a (unique) project name."
  exit
fi


mkdir $1
cd $1


git init
# Add content to .gitignore
cat << EOF > .gitignore
node_modules
npm-debug.log
.dockerignore
EOF
node -v > .nvmrc
git add .


# Update package.json
cat << EOF > package.json
{
  "name": "$1",
  "version": "1.0.0",
  "description": "A simple Node.js HTMX project with Tailwind CSS and Docker",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "concurrently \"npm run watch:css\" \"nodemon server.js\"",
    "watch:css": "tailwindcss -i ./public/css/input.css -o ./public/css/output.css --watch",
    "build:css": "tailwindcss -i ./public/css/input.css -o ./public/css/output.css",
    "docker:build": "docker build -t nodejs-htmx-app .",
    "docker:run": "docker run -p 3000:3000 -d nodejs-htmx-app"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
  },
  "devDependencies": {
  }
}
EOF

# Install packages with pnpm
dep="express htmx.org"
devdep="tailwindcss nodemon postcss autoprefixer concurrently"

npm i $dep
npm i --save-dev $devdep
npx tailwindcss init -p




# Create Tailwind CSS input file
mkdir -p public/css
cat << EOF > public/css/input.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Update tailwind.config.js
cat << EOF > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./public/**/*.{html,js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF
# Update server.js to serve CSS
cat << EOF > server.js
const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

app.use(express.static('public'));
app.use('/css', express.static(path.join(__dirname, 'public/css')));
app.use('/node_modules', express.static(path.join(__dirname, 'node_modules')));

app.get('/hello', (req, res) => {
  res.send('<h1 class="text-2xl text-green-600">Hello, HTMX with Tailwind CSS!</h1>');
});

app.listen(port, () => {
  console.log('Server running at http://localhost:', port);
});
EOF


echo 'module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}' > postcss.config.js



# Update public/index.html
cat << EOF > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTMX Demo with Tailwind CSS</title>
    <script src="/node_modules/htmx.org/dist/htmx.min.js"></script>
    <link href="/css/output.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">
    <h1 class="text-3xl font-bold mb-4">HTMX Demo with Tailwind CSS</h1>
    <button hx-get="/hello" hx-target="#result" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Click me
    </button>
    <div id="result" class="mt-4"></div>
</body>
</html>
EOF


# Update Dockerfile
cat << EOF > Dockerfile
FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build:css

EXPOSE 3000

CMD ["npm", "start"]
EOF

# Add content to .dockerignore
cat << EOF > .dockerignore
node_modules
npm-debug.log
EOF

# Build/Run Docker image
# Build CSS
npm run build:css

# Build Docker image
npm run docker:build


echo "Project structure created successfully."
echo "Run with npm run docker:run or npm run dev"