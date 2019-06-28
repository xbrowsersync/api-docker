# xBrowserSync
## API for Docker

![](https://img.shields.io/docker/pulls/xbrowsersync/api.svg) 
![](https://img.shields.io/docker/stars/xbrowsersync/api.svg)

xBrowserSync is a free tool for syncing browser data between different browsers and devices, built for privacy and anonymity. For full details, see [www.xbrowsersync.org](https://www.xbrowsersync.org/).

This repository contains the Docker files required to get your own [xBrowserSync API service](https://github.com/xbrowsersync/api) up and running in moments, either by running the API image alone or by orchestrating a production-ready HTTPS service with database and reverse proxy.

## Running the API image

Running the API image alone requires that you have a MongoDB instance and (ideally) a web server to reverse proxy the API behind.

  1. Create a file named `settings.json` and include any required custom [settings](https://github.com/xbrowsersync/api#3-modify-configuration-settings) values, such as those for connecting to your MongoDB instance. For example, if you are running Docker and MongoDB on a windows server, you would point the service at the MongoDB instance running on the host using the following settings:

      ```
      {
        "db": {
          "host": "host.docker.internal"
        }
      }
      ```
  
  2. (Optionally) create the following environment variables on your host to store the username and password required to access the xBrowserSync database on your MongoDB instance:

      - XBROWSERSYNC_DB_USER
      - XBROWSERSYNC_DB_PWD

  3. Run the following command to start an API container, providing the actual path to the `settings.json` file created in step 1. The service will be exposed via port 8080. If you did not create the environment variables in step 2, you will need to provide the actual username and password values in line, i.e. `-e XBROWSERSYNC_DB_USER=YourDatabaseUsername -e XBROWSERSYNC_DB_PWD=YourDatabasePassword`:

      ```
      $ sudo docker run --name xbs-api -p 8080:8080 -e XBROWSERSYNC_DB_USER -e XBROWSERSYNC_DB_PWD -v /path/to/settings.json:/usr/src/api/config/settings.json -d xbrowsersync/api
      ```

      You can now access your xBrowserSync API service at http://127.0.0.1:8080.

## Running a production-ready service

If you do not already have a MongoDB instance or are intending to expose your xBrowserSync service over the internet then it is recommended to use the provided [`docker-compose.yml`](https://github.com/xbrowsersync/api-docker/blob/master/docker-compose.yml) which will create fully configured containers for a MongoDB database, the xBrowserSync API and a [traefik](https://traefik.io/) reverse proxy web server to run in front of the API. Traefik automatically acquires and updates SSL certificates from [Let's Encrypt](https://letsencrypt.org/) so that your xBrowserSync API service will run securely over HTTPS.

  1. Clone the [api-docker](https://github.com/xbrowsersync/api-docker/) GitHub repo:

      ```
      $ git clone https://github.com/xbrowsersync/api-docker.git
      ```
  
  2. Secure the [`acme.json`](https://github.com/xbrowsersync/api-docker/blob/master/acme.json) file as per traefik's requirements:

      ```
      $ sudo chmod 600 acme.json
      ```

  3. Open the [`.env`](https://github.com/xbrowsersync/api-docker/blob/master/.env) file in a text editor and update the `XBS_API_HOSTNAME` value to correspond to the host name that the API service will be exposed over (ensure you have configured your DNS provider to point the desired host name to your host's IP address). Also, change the `XBS_DB_USERNAME` and `XBS_DB_PASSWORD` values to any of your choosing.

  4. Open the [`traefik.toml`](https://github.com/xbrowsersync/api-docker/blob/master/traefik.toml) file in a text editor and update the `email` value on [line 18](https://github.com/xbrowsersync/api-docker/blob/master/traefik.toml#L18) to your own email address in order to successfully acquire an SSL certificate from [Let's Encrypt](https://letsencrypt.org/).

  5. (Optionally) open the [`settings.json`](https://github.com/xbrowsersync/api-docker/blob/master/settings.json) file and include any custom [settings](https://github.com/xbrowsersync/api#3-modify-configuration-settings) values you wish to run on your service. Important: do not change the `db.host` value.
  
  6. Run the following command to start the containers:

      ```
      $ sudo docker-compose up -d
      ```

      You can now access your xBrowserSync API service over HTTPS at the value of `XBS_API_HOSTNAME` defined in the [`.env`](https://github.com/xbrowsersync/api-docker/blob/master/.env) file.

## Issues and feature requests

Please log Docker-related issues in the [api-docker Issues list](https://github.com/xbrowsersync/api-docker/issues), if you have found an issue with the xBrowserSync API itself or wish to request a new feature, do so in the [api Issues list](https://github.com/xbrowsersync/api/issues/).
