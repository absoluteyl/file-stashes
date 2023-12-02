# File Stashes

A simple file sharing app allows users to upload and share files.

## Prerequisites

The following tools are developed basd on the following versions. Other versions may work but not tested.

* Ruby version: 3.2.2
* Rails version: 7.1.2

## Getting Started

1. Check out the repository

  ```bash
  git clone git@github.com:absoluteyl/file-stashes.git
  ```

2. We use [dotenv](<https://github.com/motdotla/dotenv>) to manage environment variables. Copy `.env` from example and fill in required values for your own environment.

  ```bash
  cp .env.example .env
  ```

3. Install dependencies

  ```bash
  bundle install
  ```

4. Create and setup the database

  ```bash
  rails db:setup
  ```

5. Start the Rails server

  ```bash
  rails s
  ```
