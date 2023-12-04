# File Stashes

A simple file sharing app allows users to upload and share files.

## Features

1. A user can upload and share files.
2. Sharing links are randomly generated.
3. Sharing links will expire in 1 hour.

### Architecture

![Architecture Diagram](public/file-stashes-architecture.png)

## Prerequisites

The following tools are developed basd on the following versions. Other versions may work but not tested.

* Ruby version: 3.2.2
* Rails version: 7.1.2

### Notice

1. Starting from Rails 7, `vips` becomes the default variant processor. If you are using MacOS, you may need to install `vips` manually. See [this issue](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#active-storage-default-variant-processor-changed-to-vips) and [refence](https://stackoverflow.com/questions/70849182/could-not-open-library-vips-42-could-not-open-library-libvips-42-dylib)

    ```bash
    brew install vips
    ```

2. To show preview of PDF and video files, you need to install `poppler` and `ffmpeg` manually. See [reference](https://api.rubyonrails.org/classes/ActiveStorage/Preview.html)

    ```bash
    brew install poppler ffmpeg
    ```

## Getting Started

1. Check out the repository

    ```bash
    git clone git@github.com:absoluteyl/file-stashes.git
    ```

2. Install dependencies

    ```bash
    bundle install
    ```

3. Generate master key and credentials

    ```bash
    # Generate master key
    EDITOR=echo rails credentials:edit
    ```

4. We use [dotenv](<https://github.com/motdotla/dotenv>) to manage environment variables. Copy `.env` from example and fill in required values for your own environment.

    ```bash
    cp .env.example .env
    ```

5. Create and setup the database

    ```bash
    rails db:setup
    ```

6. Start the Rails server

    ```bash
    rails s
    ```

## Run the app using Docker

1. Build docker image. This step is optional, you can skip this step to use the pre-build image from [Docker Hub](https://hub.docker.com/r/absoluteyl/file-stashes)

    ```bash
    docker build -t file-stashes:latest .
    ```

2. Generate self-signed ssl certificate using [mkcert](https://github.com/FiloSottile/mkcert)

    ```bash
    # If it's the firt install of mkcert, run
    mkcert -install

    # Generate certificate for domain "docker.localhost" and their sub-domains
    mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "docker.localhost" "*.docker.localhost"
    ```

3. Copy `docker-compose.yml` from example

    ```bash
    cp docker-compose.yml.example docker-compose.yml
    ```

4. Run docker containers

    ```bash
    # (Optional) add -d to run in background
    docker-compose up
    ```
