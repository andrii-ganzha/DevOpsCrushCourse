from flask import Flask
app = Flask (__name__)
@app.route("/")
def hi():
    return "Hi from the Python APP!"
if __name__ == "__index__":
    app.run(host="0.0.0.0", port=int("5000"), debug=True)
