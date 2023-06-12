mkdir -p background && cd background

repo="alist-org/alist"

tag=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | grep -o '"tag_name": ".*"' | sed 's/"tag_name": "//;s/"//')

download_url="https://github.com/$repo/releases/download/$tag/alist-linux-amd64.tar.gz"

wget "$download_url" -O manager.tar.gz

mkdir -p program && mkdir -p tempupdate

tar -xzf manager.tar.gz -C tempupdate && rm -f manager.tar.gz && mv -f tempupdate/* program/manager && rm -rf tempupdate && cd program && chmod +x manager && cd /home/runner/${REPL_SLUG}

if [ -s main.sh ]; then
    sed -i '1s/.*/output=$(.\/background\/program\/manager admin) \&\& username=$(echo "$output" | grep -oP '\''username: \\K\\S+'\'') \&\& password=$(echo "$output" | grep -oP '\''password: \\K\\S+'\'') \&\& echo "username: $username" > user_info.txt \&\& echo "password: $password" >> user_info.txt \&\& nohup .\/background\/program\/manager >\/dev\/null 2>\&1/' main.sh
else
    echo 'output=$(./background/program/manager admin) && username=$(echo "$output" | grep -oP '\''username: \\K\\S+'\'') && password=$(echo "$output" | grep -oP '\''password: \\K\\S+'\'') && echo "username: $username" > user_info.txt && echo "password: $password" >> user_info.txt && nohup ./background/program/manager >/dev/null 2>&1' > main.sh
fi
