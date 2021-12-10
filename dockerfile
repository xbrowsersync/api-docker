FROM node:fermium-alpine

# Set environment variables

WORKDIR /usr/src/api

# Download release and unpack
RUN apk update && apk add grep curl
RUN XBROWSERSYNC_API_VERSION="$(curl --silent "https://api.github.com/repos/xbrowsersync/api/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')" \ 
	&& echo $XBROWSERSYNC_API_VERSION \
	&& wget -q -O release.tar.gz https://github.com/xBrowserSync/api/archive/$XBROWSERSYNC_API_VERSION.tar.gz \
	&& tar -C . -xzf release.tar.gz \
	&& rm release.tar.gz \
	&& XBROWSERSYNC_API_VERSION="${XBROWSERSYNC_API_VERSION:1}" \
	&& mv api-$XBROWSERSYNC_API_VERSION/* . \
	&& rm -rf api-$XBROWSERSYNC_API_VERSION/

# Install dependencies
RUN apk add python2 python3 make
RUN npm install --only=production

# Expose port and start api
EXPOSE 8080
CMD [ "node", "dist/api.js"]