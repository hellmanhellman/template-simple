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
