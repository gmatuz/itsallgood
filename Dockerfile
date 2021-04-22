FROM node:buster-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -yq \
      gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
      libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
      libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
      libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
      ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libdrm-dev libgbm-dev git \
    && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone -b 3.1.0 --depth 1 https://github.com/GoogleChrome/rendertron.git /rendertron && \
    rm -rf /rendertron/.git
WORKDIR /rendertron

RUN npm ci --prefer-online && \
    npm cache clean --force
RUN npm run build
