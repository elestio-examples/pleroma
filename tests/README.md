<a href="https://elest.io">
  <img src="https://upload.wikimedia.org/wikipedia/commons/5/52/Lemmy_logo.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Pleroma, verified and packaged by Elestio

[Pleroma](https://git.pleroma.social/pleroma/pleroma) is a microblogging server software that can federate (= exchange messages with) other servers that support ActivityPub. What that means is that you can host a server for yourself or your friends and stay in control of your online identity, but still exchange messages with people on larger servers. Pleroma will federate with all servers that implement ActivityPub, like Friendica, GNU Social, Hubzilla, Mastodon, Misskey, Peertube, and Pixelfed.

<img src="https://github.com/elestio-examples/pleroma/raw/main/pleroma.png" alt="pleroma" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/pleroma">fully managed pleroma</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you are interested in exploring a decentralized and community-oriented approach to online content.

[![deploy](https://github.com/elestio-examples/pleroma/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?soft=pleroma)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/pleroma.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:3226`

## Docker-compose

Here are some example snippets to help you get started creating a container.

  version: "3.3"

  services:
    pleroma:
      user: 0:0
      image: elestio4test/pleroma:${SOFTWARE_VERSION_TAG}
      restart: always
      hostname: "pleroma"
      labels:
        - "org.label-schema.group=pleroma"
      env_file: ./.env
      depends_on:
        - pleroma-db
      ports:
        - "172.17.0.1:3226:4000"
      volumes:
        - ./storage/pleroma//uploads:/data/uploads
        - ./storage/pleroma//static:/data/static
        - ./config.exs:/data/config.exs

    pleroma-db:
      image: elestio/postgres:15
      restart: always
      hostname: "pleroma-db"
      labels:
        - "com.centurylinklabs.watchtower.enable=False"
        - "org.label-schema.group=pleroma"
      env_file: ./.env
      ports:
        - "172.17.0.1:57249:5432"
      volumes:
        - ./storage/pleroma-db/pgdata:/var/lib/postgresql/data

    pgadmin4:
      image: dpage/pgadmin4:latest
      restart: always
      environment:
        PGADMIN_DEFAULT_EMAIL: ${ADMIN_EMAIL}
        PGADMIN_DEFAULT_PASSWORD: ${ADMIN_PASSWORD}
        PGADMIN_LISTEN_PORT: 8080
      ports:
        - "172.17.0.1:55871:8080"
      volumes:
        - ./servers.json:/pgadmin4/servers.json


### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
|  POSTGRES_PASSWORD   |    password     |
|    POSTGRES_USER     |    user-name    |
|     POSTGRES_DB      |     db-name     |
|     ADMIN_EMAIL      |     your-email  |
|     ADMIN_PASSWORD   |     your-pass   |
|     DB_USER          |     user-name   |
|     DB_PASS          |     db-name     |
|     DB_HOST          |     db-host     |
|     DB_PORT          |     5432        |
|     DB_NAME          |     pleroma     |
|     INSTANCE_NAME    |     Pleroma     |
|     DOMAIN           |     db-name     |


# Maintenance

## Logging

The Elestio Pleroma Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://git.pleroma.social/pleroma/pleroma">Pleroma Github repository</a>

- <a target="_blank" href="https://docs-develop.pleroma.social/">Pleroma documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/pleroma">Elestio/pleroma Github repository</a>
