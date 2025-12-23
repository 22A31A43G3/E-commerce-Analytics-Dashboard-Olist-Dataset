import pandas as pd
from sqlalchemy import create_engine
import urllib.parse

# --------------------------------------------
# CSV File Path
# --------------------------------------------
file_path = r"C:\Users\vamsi\Downloads\olist_geolocation_dataset.csv"

# Read CSV
df = pd.read_csv(file_path, encoding="latin1")

# --------------------------------------------
# MySQL Connection
# --------------------------------------------
user = "root"
password = urllib.parse.quote_plus("vamsi@100")  # Encode special characters
host = "127.0.0.1"
port = 3305
database = "olist"

engine = create_engine(
    f"mysql+mysqlconnector://{user}:{password}@{host}:{port}/{database}"
)

# --------------------------------------------
# Load Data into MySQL
# --------------------------------------------
df.to_sql(
    name="geo",
    con=engine,
    if_exists="replace",
    index=False
)

print("CSV has been imported successfully into MySQL.")
