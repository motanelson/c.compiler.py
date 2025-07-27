printf "\033c\033[43;30m\n"
curl $1 > /tmp/web.tmp
cat /tmp/web.tmp | python3 web.py
