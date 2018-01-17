#!/bin/bash

# Start Chrome
/usr/bin/dumb-init -- java -jar /opt/selenium/selenium-server-standalone.jar &

# Run any additional commands
COMMAND=$@
echo "running $COMMAND"

bash -c "$COMMAND"
