#!/bin/bash

# Variables
SRC="/var/www/html/blog"
DEST="/backup/xfusioncorp_blog.zip"
REMOTE_USER="clint"
REMOTE_HOST="stbkp01"
REMOTE_DIR="/backup"

# Create backup
echo "Creating backup..."
zip -r "$DEST" "$SRC" > /dev/null

# Check zip success
if [ $? -ne 0 ]; then
  echo "❌ Failed to create zip archive."
  exit 1
else
  echo "✅ Zip created at $DEST"
fi

# Copy to Backup Server
echo "Copying to Backup Server..."
scp "$DEST" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# Check scp success
if [ $? -ne 0 ]; then
  echo "❌ Failed to copy to backup server."
  exit 2
else
  echo "✅ Successfully copied to Backup Server"
fi
