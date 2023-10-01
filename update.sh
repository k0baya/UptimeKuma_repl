wget -O kuma.zip https://github.com/louislam/uptime-kuma/archive/refs/tags/1.21.3.zip && unzip kuma.zip
mv -b uptime-kuma-1.21.3/* ./ && mv -b uptime-kuma-1.21.3/.[^.]* ./ && rm -rf *~ && rm -rf uptime-kuma-1.21.3 && rm -rf README.md
npm ci --production && npm run download-dist
echo 'require("./server/server.js");' > index.js
