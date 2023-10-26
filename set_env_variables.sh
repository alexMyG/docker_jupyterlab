# Get the current user's UID, GID, and username
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)
CURRENT_USER=$(id -un)

# Update the .env file with the current values
sed -i "s/^UID=.*/UID=$CURRENT_UID/" .env
sed -i "s/^GID=.*/GID=$CURRENT_GID/" .env
sed -i "s/^USER=.*/USER=$CURRENT_USER/" .env

