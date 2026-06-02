from flask import Flask
import redis
app = Flask(__name__)
rdb = redis.Redis(host='rdb', port=6379, decode_responses=True)
@app.route('/')
def welcome():
    return "Welcome"

@app.route('/count')
def count():
    count = rdb.incr('count') 
    return str(count)
    
if  __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004)