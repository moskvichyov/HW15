import json
import sqlite3
from flask import Flask, jsonify, abort
from typing import Optional, Dict

DB_PATH = 'animal.db'
app = Flask(__name__)


def load_data(query, db) -> Optional[Dict[str, any]]:
    with sqlite3.connect(db) as connection:
        cursor = connection.cursor()
        cursor.row_factory = sqlite3.Row
        cursor.execute(query)
        result = cursor.fetchone()
        if result:
            return dict(result)



@app.route('/animals/<int:idx>')
def run_data(idx):
    query = f"""select *
                   From animal_norm 
                   left join outcomes on animal_norm.animal_id = outcomes.animal_id
                   where animal_norm.id={idx}
                   """
    result = load_data(query, DB_PATH)
    if result:
        return jsonify(result)
    else:
        abort(404)


if __name__ == '__main__':
    app.run(debug=True)