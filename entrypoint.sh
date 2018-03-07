#!/bin/bash


# printf "# Each time the docker starts these will be overwritten\n\n" > /home/server/lgsm/config-lgsm/fctrserver/common.cfg

# printf "ip="%s"\n" "$IP" >> /home/server/lgsm/config-lgsm/fctrserver/common.cfg
# printf "rconpassword="%s"\n" "$RCON_PASSWORD" >> /home/server/lgsm/config-lgsm/fctrserver/common.cfg
# printf "branch="%s"\n" "$BRANCH" >> /home/server/lgsm/config-lgsm/fctrserver/common.cfg


# Install is actuall install or update
function install() {
  if [ "$FCT_UPDATE" == "1" ]; then
      ./fctrserver update-lgsm
      ./fctrserver update
  fi
  
  if [ "$FCT_FORCE_UPDATE" == "1" ]; then
      ./fctrserver update-lgsm
      ./fctrserver force-update
  fi

  if [ ! -d ./serverfiles ]; then
    ./fctrserver update-lgsm
    ./fctrserver auto-install
  fi
}


function start() {
  if [ ! -d ./serverfiles ]; then
    install
  else
     # trap exit signals
    trap stop INT SIGINT SIGTERM
    ./fctrserver start
    sleep 10
    running
  fi
}

# stop the planet zombiod server
function stop() {
  echo "Stopping Server"
  ./fctrserver stop
  # just to be sure wait 10 seconds
  sleep 10
  exit 0
}

# validate and update scripts and server
function update() {
	./fctrserver update-functions
	./fctrserver update
}

# running is for when running the docker to keep the image and server going
function running() {
  # attach to the tmux session
  # tmux set -g status off && tmux attach 2> /dev/null

  # if something fails while attaching to the tmux session then just wait
  while : ; do
    update
    sleep 3600
  done
}

if [ "$1" != "" ]; then
  if [ "$1" == "start" ]; then
    start
  fi
  if [ "$1" == "shell" ]; then
    /bin/bash
  fi
else
  install
fi