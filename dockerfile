FROM node:10.14.2-alpine

# Set environment variables
ENV XBROWSERSYNC_API_VERSION 1.1.6
ENV XBROWSERSYNC_API_PORT 8080

WORKDIR /usr/src/api

# Download release and unpack
RUN wget -q -O release.tar.gz https://github.com/xBrowserSync/api/archive/v$XBROWSERSYNC_API_VERSION.tar.gz \
	&& tar -C . -xzf release.tar.gz \
	&& rm release.tar.gz \
	&& mv api-$XBROWSERSYNC_API_VERSION/* . \
	&& rm -rf api-$XBROWSERSYNC_API_VERSION/

# Install dependencies
RUN npm install --only=production

# Expose port and start api
EXPOSE $XBROWSERSYNC_API_PORT
CMD [ "node", "dist/api.js"]