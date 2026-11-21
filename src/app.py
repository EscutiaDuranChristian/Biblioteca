import textwrap
from flask import Flask, Response, render_template, send_from_directory

app = Flask(__name__)

PALETTE = [
    ("#2e7d32", "#a5d63a"), ("#0d47a1", "#42a5f5"),
    ("#b71c1c", "#ff8a65"), ("#4a148c", "#ba68c8"),
    ("#e65100", "#ffd54f"), ("#006064", "#4dd0e1"),
    ("#263238", "#90a4ae"), ("#880e4f", "#f48fb1"),
]
BOOKS = [
    "Carrera Nocturna", "Cazadores del Alba", "Fuerza Galáctica",
    "Reino Oculto", "Mundo Turbo", "Abismo Azul",
    "Código Sombra", "Fiesta Pixel",
]

@app.route("/")
def index():
    return render_template("index.html", books=BOOKS
)

@app.route("/cover/<int:i>.svg")
def cover(i):
    c1, c2 = PALETTE[i % len(PALETTE)]
    svg = render_template(
        "cover.svg",
        lines=textwrap.wrap(BOOKS
    [i % len(BOOKS
    )], 11),
        c1=c1, c2=c2,
    )
    return Response(svg, mimetype="image/svg+xml")

if __name__ == '__main__':
    app.run(debug = True)