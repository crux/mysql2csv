**Notice: This is forked from https://github.com/robmiller/mysql2csv**

Rob's original implementation was a great start, but missing the option to use the ssh host just as a gateway to a database host behind it. So I added the `--ssh-host` opion:

    # host <---> ssh-host <---> database-host

    $ bundle exec bin/mysql2csv \
        ...\
        --ssh-user root --ssh-host ssh-host \
        --hostname database-host \
        ...
        database-name reports.yml

Without this option, `--hostname` would always define ssh host AND database host at the same time. See also example section below: _Connecting with a ssh host as gateway to a a remote mySQL server_.

On top of that I added saving to xlsx (Excel) files directly. For now, no extra command line options for that exists, it just saves an excel file next to the csv file.

Also I am not so happy with the design choice of having the script _calcluate_ some kind of output file name (`#{@output_dir}/#{name}.csv`) from the report and the database name somehow. I would prefere direct name and location control from the outside. Also I am not quite happy with having to transform pure SQL code into a yaml file for consumption. I will create some incompatible changes on that, therefor the fork.

# mysql2csv

I often need to run a series of exports for a client, an account
manager, or someone else. They want data in a spreadsheet, not locked
away in some database, and the process of getting those CSVs is quite
tedious.

mysql2csv can help, by automating everything but the writing of the SQL
— which means, if the queries are often the same, you might be able to
just point it at a database and run.

## Usage

Output from help:

    NAME
    mysql2csv

    SYNOPSIS
    mysql2csv database query-file [options]+

    PARAMETERS
    database (1 -> database)
        The name of the database on the live server
    query-file (1 -> query-file=./queries.yml)
        Path to a file containing SQL queries.
    --hostname=hostname, -H (0 ~> hostname=localhost)
        Hostname that mySQL is running on
    --port=port, -P (0 ~> int(port=))
        Port that mySQL runs on
    --user=user, -u (0 ~> user=root)
        mySQL username
    --password=password, -p (0 -> password)
        mySQL password
    --no-tunnel
        If true, will attempt to connect directly to mySQL rather than
        tunneling
    --ssh-user=ssh-user (0 ~> ssh-user=rob)
        Username to use when creating the SSH tunnel to the mySQL server
    --ssh-port=ssh-port (0 ~> int(ssh-port=22))
        Port to use when SSH tunneling
    --ssh-key=ssh-key (0 ~> ssh-key)
        Path to an SSH keyfile to use when creating the SSH tunnel
    --ssh-password=ssh-password (0 ~> ssh-password)
        Password to use when creating an SSH tunnel
    --zip
        If given, the CSV files outputted will also be placed into a single
        zip.
    --password-zip
        If given, a password will be generated and applied to the zip file.
    --help, -h

### Query file format

Queries should be stored in a YAML file; the key of each row will be
used as the filename of the CSV, and the value will be used as SQL.

So, for example:

    users: "SELECT * FROM users"
    posts: "SELECT * FROM posts ORDER BY id DESC LIMIT 10"

Would generate two CSV files; one called `users.csv`, containing the
results of the first query, and one called `posts.csv` containing the
results of the second.

### Connecting to a local mySQL server

If you don't want to tunnel over SSH to a remote server (see below),
then use the `--no-tunnel` option.

For example, to connect to a locally running mySQL server, using the
default socket, and extract information from the database `foo_db` using
the queries found in `queries.yml`:

    mysql2csv --user root -p foobar --no-tunnel foo_db queries.yml

To connect over TCP, rather than using a socket:

    mysql2csv --user root -p foobar -H 127.0.0.1 -P 3306 --no-tunnel foo_db queries.yml

### Connecting to a remote mySQL server via an SSH tunnel

Using a password:

    mysql2csv --user root -p foobar -H db.example.com -P 3306 --ssh-user alice --ssh-password foobarbaz foo_db queries.yml

Using a public key:

    mysql2csv --user root -p foobar -H db.example.com -P 3306 --ssh-user alice --ssh-key /path/to/key foo_db queries.yml

If you omit the username, password, and key, then the system defaults
will be used; that is, the username of the currently logged in user, and
the key in your `~/.ssh` directory.

If you can run `ssh db.example.com` and log in, in other words, you
should be safe not specifying any SSH-related options on the command
line:

    mysql2csv --user root -p foobar -H db.example.com -P 3306 foo_db queries.yml

### Connecting with a ssh host as gateway to a a remote mySQL server

All the options and examples from above with the ssh connection still apply but this time the database server is not the same host as which the ssh connection goes to. You use the ssh connection to connect to a database server which is only reachable from the ssh host you are connecting to, using it as a jump host. Use the --ssh-host option:

    mysql2csv --user root -p foobar -H db.example.com -P 3306 --ssh-host jump.example.com foo_db queries.yml


### Zipping or not zipping files

If you pass `--zip`, the files output will be placed into a zip file. If
you pass `--zip-password`, the zip will be password protected too.
