const express = require('express');
const api = require('./routes/api');

const app = express();
const PORT = 80;

app.use('/', api);

app.use(express.json());

app.get('/', (req,  res) => {
  res.json({message: 'server up'});
});

// As our server to listen for incoming connections
app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));