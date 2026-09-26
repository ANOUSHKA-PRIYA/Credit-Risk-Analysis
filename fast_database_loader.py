import pandas as pd
import mysql.connector
from mysql.connector import Error

print("Connecting directly to your background MySQL Local Server Engine...")

config = {
    'user': 'YOUR_MYSQL_USER',
    'password': 'YOUR_MYSQL_PASSWORD',
    'host': '127.0.0.1',
    'port': '3306',
    'database': 'central_credit_db',
    'allow_local_infile': True
}

try:
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()
    
    print("Reading credit_risk_cleaned.csv...")
    df = pd.read_csv("notebook/credit_risk_cleaned.csv")
    df = df.where(pd.notnull(df), None)
    
    # Check kitne columns hain aur pehle 12 columns select kar lo
    if df.shape[1] >= 12:
        df = df.iloc[:, :12]
    
    print(f"Streaming all {len(df)} rows straight into the database table...")
    
    insert_query = """
    INSERT INTO credit_risk (
        person_age, person_income, person_home_ownership, person_emp_length,
        loan_intent, loan_grade, loan_amnt, loan_int_rate, loan_status,
        loan_percent_income, cb_person_default_on_file, cb_person_cred_hist_length
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    
    records = [tuple(x) for x in df.values]
    cursor.executemany(insert_query, records)
    conn.commit()
    
    print("Success! Database fully populated without any KeyError!")

except Error as e:
    print(f"Database Error: {e}")
except Exception as e:
    print(f"Error: {e}")
finally:
    if 'conn' in locals() and conn.is_connected():
        cursor.close()
        conn.close()