import subprocess
from flask import Flask, Response

app = Flask(__name__)

# This will store the output of the command
output = ""

def run_sshx_command():
    global output
    try:
        # Run the command and capture its output
        result = subprocess.run("curl -sSf https://sshx.io/get | sh", shell=True, capture_output=True, text=True)
        output = result.stdout + result.stderr  # Combine stdout and stderr
    except Exception as e:
        output = str(e)

# Run the SSHX command when the application starts
run_sshx_command()

@app.route("/")
def show_output():
    return Response(output, mimetype="text/plain")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
