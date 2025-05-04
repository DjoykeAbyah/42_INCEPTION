FROM debian:bookworm-slim

# update the package ensuring you're installing most current version.
# installs mariadb specific packages, auto accept prompt with -y (no manual interaction).
# server software handles data storage, retrieval, managment. Runs database service mysqld, manages connections, process database queries.
# client is a set of command tools (mysql, mysqldump) allows interaction with Mariadb server.
# removes package list (versions available, dependencies when installing etc) which are only essential during installation.

RUN apt-get update && \
	apt-get install -y mariadb-server mariadb-client && \
	rm -rf /var/lib/apt/lists/*

# copies custom MariaDB configuration file my.cnf from local build context ./conf directory host machine into container.
# MariaDB reads main configuration from my.cnf.
# my.cnf can control: server port, data directory, socket file path, allowed packet size, buffer size, memory limit, logging options etc.
# gives control over MariaDB's behaviour.

COPY ./conf/my.cnf /etc/mysql/my.cnf

# setting up directories and permission for MariaDB server to run.
# creating directory where it stores runtime files.
# -p ensures command does not fail if directory already exisrts plus creates missing parent directories.
# changes ownership to the mysql user and group.
# -R applies it recursively to all files and subdirectories.
# MariaDB runs as the mysql user and must have permissions to read/write in the directories.
# sets permissions to owner, group, others.
# mariaDB uses files like mysqld.sock, PID files and Temporary runtime files. If the files don't exist or not correct permissions MariaDB fails to start.

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
	chmod 755 /var/run/mysqld


# declares default data directory as docker volume.
# Ensures database data is persisted beyond the container lifecycle
# this directory has has all the database data (databases, tables, binary logs, transaction logs, user accounts etc).
# if this gets deleted the database is gone thats why its mounted as a volume.

VOLUME ["/var/lib/mysql"]

# informs docker that container listens on port 3306 (default port for MariaDB).
# Signals that the database server uses port 3306 for connections.

EXPOSE 3306

# sets default command the container runs when started.
# MariaDB server daemon, mysqld. this is the main process that keeps container running>
# if crashes or exits container will also stop.
# Tells Docker to run the MariaDB server when the container starts.

CMD ["mysqld"]
