FROM node:14.16.0-alpine

# Set environment variables
ENV XBROWSERSYNC_API_VERSION 1.1.13

WORKDIR /usr/src/api

# Download release and unpack
RUN wget -q -O release.tar.gz https://github.com/xBrowserSync/api/archive/v$XBROWSERSYNC_API_VERSION.tar.gz \
	&& tar -C . -xzf release.tar.gz \
	&& rm release.tar.gz \
	&& mv api-$XBROWSERSYNC_API_VERSION/* . \
	&& rm -rf api-$XBROWSERSYNC_API_VERSION/
        && adduser --disabled-password --gecos "" xbs \
        && chown -R xbs:xbs . \
        && mkdir -p /var/log/xBrowserSync/ \
        && chown -R xbs:xbs /var/log/xBrowserSync/.

# Continue in newly created xbs user
USER xbs

# Install dependencies
RUN npm install --only=production

# Expose port and start api
EXPOSE 8080
CMD [ "node", "dist/api.js"]