import inspect

from sqlalchemy import create_engine
from sqlalchemy.schema import CreateTable

import basic_model as target_model

SQL_FILENAME = "schema.sql"

# Get all the classes aka tables from the target model
sql_model_classes = [
    cls
    for _, cls in inspect.getmembers(target_model, inspect.isclass)
    if hasattr(cls, "__table__") and getattr(cls, "__table__", None) is not None
]


engine = create_engine("mysql://", echo=False)
with open(SQL_FILENAME, "w") as f:
    for model in sql_model_classes:
        f.write(str(CreateTable(model.__table__).compile(engine)))
        f.write(";\n\n")

print(f"'{SQL_FILENAME}' has been generated.")
