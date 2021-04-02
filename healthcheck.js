const http = require('http');

const response = http.request(
  {
    host: '0.0.0.0',
    method: 'GET',
    path: '/info',
    port: 8080,
    timeout: 2000,
  },
  (res) => {
    let body = '';
    res.setEncoding('utf8');

    res.on('data', (chunk) => {
      body += chunk;
    });

    res.on('end', () => {
      if (res.statusCode === 200) {
        const payload = JSON.parse(body);
        switch (payload.status) {
          case 1:
          case 3:
            console.log('HEALTHCHECK: online');
            process.exit(0);
          case 2:
          default:
            console.log('HEALTHCHECK: offline');
        }
      } else {
        console.log('HEALTHCHECK: offline');
      }
      process.exit(1);
    });
  }
);

response.on('error', function (err) {
  console.log('HEALTHCHECK: offline');
  process.exit(1);
});

response.end();
