# xBrowserSync-clean-docker
## xBrowserSync API for Docker

Hi, this is custom version of the [official xBrowserSync Docker](https://github.com/xbrowsersync/api-docker).
I made it to simplify my personal deployment and fit my personal needs.

## Changes made
- [healthcheck.js](healthcheck.js) and [settings.json](settings.json) are going to be copied inside the container by the [dockerfile](dockerfile); so it will not longer be necessary to be mounted as volumes in [docker-compose.yml](docker-compose.yml) unless needed.
- [dockerfile](dockerfile) will build from latest alpine
- [dockerfile](dockerfile) will get latest version of [xBrowserSync API](https://github.com/xbrowsersync/api)
- [docker-compose.yml](docker-compose.yml) will fetch latest version of the image.
- Removed caddy, so you can integrate the containers with an existing proxy like Traefik or Jwilder's proxy.

## Running a production-ready service

  1. Clone the [this repo](https://github.com/Steccas/api-docker):

      ```
      git clone https://github.com/Steccas/api-docker.git
      ```
  
  2. Open the [`.env`](.env) file in a text editor and update the `API_HOSTNAME` value to correspond to the host name that the API service will be exposed over (ensure you have configured your DNS provider to point the desired host name to your host's IP address). Also, change the `DB_USERNAME` and `DB_PASSWORD` values to any of your choosing.

  3. (Optionally) open the [`settings.json`](settings.json) file and include any custom [settings](https://github.com/xbrowsersync/api#3-modify-configuration-settings) values you wish to run on your service. Important: do not change the `db.host` value. And remember in this case to uncomment the volume mounting in [docker-compose.yml](docker-compose.yml).
  
  4. Run the following command to start the containers:

      ```
      docker-compose up -d
      ```

      You can now access your xBrowserSync API service at the value of `API_HOSTNAME` defined in the [`.env`](.env) file.

## Issues and feature requests
Please cosnider that this is just a fork, so if the problem doesn't exists just in this implementation please log Docker-related issues directly in the [api-docker Issues list](https://github.com/xbrowsersync/api-docker/issues), if you have found an issue with the xBrowserSync API itself or wish to request a new feature, do so in the [api Issues list](https://github.com/xbrowsersync/api/issues/).
