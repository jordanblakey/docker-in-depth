# import redis
from flask import Flask

app = Flask(__name__)
# cache = redis.Redis(host='redis', port=6379)

count = 0


def get_hit_count(count):
    count += 1
    return count
    # retries = 5
    # while True:
    #     try:
    #         return cache.incr('hits')
    #     except redis.exceptions.ConnectionError as exc:
    #         if retries == 0:
    #             raise exc
    #         retries -= 1
    #         time.sleep(0.5)


@app.route("/")
def hello():
    globals()["count"] = get_hit_count(globals()["count"])
    return "Hello from Docker! I have been seen {} times.\n".format(
        globals()["count"]
    )
