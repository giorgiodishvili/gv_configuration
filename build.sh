#!/bin/bash

# Define the repositories and their directories
REPO1_URL="https://github.com/giorgiodishvili/order_management"
REPO2_URL="https://github.com/giorgiodishvili/user_management"
REPO1_DIR="../order_management"
REPO2_DIR="../user_management"

# Function to clone or pull a repository
update_repo() {
  local current_dir=$(pwd)
  echo $current_dir
  local repo_url=$1
  local repo_dir=$2

  if [ -d "$repo_dir" ]; then
    echo "Directory $repo_dir exists. Pulling latest changes..."
    cd "$repo_dir"
    git pull

  else
    echo "Directory $repo_dir does not exist. Cloning repository..."
    cd ..
    git clone "$repo_url"

  fi
  cd $current_dir
}

# Clone or pull repositories
update_repo "$REPO1_URL" "$REPO1_DIR"
echo "printing $(pwd) pwd "
update_repo "$REPO2_URL" "$REPO2_DIR"

# Run docker-compose up
echo "Running docker-compose up..."
docker-compose build --parallel
docker-compose up
