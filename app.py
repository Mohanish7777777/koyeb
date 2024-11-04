import subprocess
from flask import Flask, Response

app = Flask(__name__)

@app.route("/")
def run_and_show_output():
    try:
        # Execute the downloaded script and capture its output
        result = subprocess.run("/sshx_script.sh", shell=True, capture_output=True, text=True)
        # Save the output to a file
        with open("/app/output.txt", "w") as file:
            file.write(result.stdout + result.stderr)
        # Return the content of the output file
        return Response(result.stdout + result.stderr, mimetype="text/plain")
    except Exception as e:
        return str(e), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
