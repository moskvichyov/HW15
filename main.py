import json
import sqlite3
from flask import Flask, jsonify

DB_PATH = 'animal.db'
app = Flask(__name__)


def load_data(query, db):
    with sqlite3.connect(db) as connection:
        cursor = connection.cursor()
        cursor.row_factory = sqlite3.Row
        try:
            result = cursor.execute(query)
            result = cursor.fetchall()
            result = [dict(ix) for ix in result]
            if len(result) > 0:
                return result
            else:
                return "нет данных для вывода"
        except (sqlite3.error, sqlite3.warning) as er:
            return "error"


@app.route('/animals/<idx>')
def run_data(idx):
    query = f"""select *
                   From animal_norm left join outcomes o on animal_norm.animal_id = o.animal_id
                   where animal_norm.id={idx}
                   """
    result = load_data(query, DB_PATH)
    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True)