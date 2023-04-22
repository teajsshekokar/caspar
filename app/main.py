import os
from flask import Flask
# import redis
# import psycopg

app = Flask(__name__)

# Redis config
REDIS_HOST = os.getenv("REDIS_HOST")
REDIST_PORT = os.getenv("REDIST_PORT")
REDIS_PASSWRD = os.getenv("REDIS_PASSWRD")

# Postgres config
PGDB_HOST = os.getenv("REDIS_HOST")
PGDB_USER = os.getenv("PGDB_USER")
PGDB_DBNAME = os.getenv("PGDB_DBNAME")
PGDB_PASS = os.getenv("PGDB_PASS")


def postgres_test():
    try:
        conn = psycopg.connect(f"dbname='{PGDB_DBNAME}' user='${PGDB_USER}' host='{PGDB_HOST}'" +
                               f" password='{PGDB_PASS}' connect_timeout=1 ")
        conn.close()
        return True
    except:
        return False


def redis_test():
    try:
        r = redis.Redis(
            host=REDIS_HOST,
            port=REDIST_PORT,
            password=REDIS_PASSWRD)
        r.ping()
        return True
    except:
        return False


@app.route("/")
def main():
    is_redis_ready = redis_test()
    is_postgres_ready = postgres_test()
    if is_redis_ready and is_postgres_ready:
        return "All backend services are up and running..."
    return "<p>Somthing went wrong...</p>"


if __name__ == '__main__':
    app.run(port=5000)