git clone https://github.com/louislam/uptime-kuma.git && mv -b uptime-kuma/* ./ && mv -b uptime-kuma/.[^.]* ./ && rm -rf *~ && rm -rf uptime-kuma && rm -rf README.md && rm -rf .git && npm ci --production && npm run download-dist && echo 'require("./server/server.js");' > index.js && sed -i 's/.*/require(".\/server\/server.js");/' index.js
