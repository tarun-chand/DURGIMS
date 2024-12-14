from openpyxl import load_workbook
import psycopg2 
conn = psycopg2.connect(host="localhost",database='durg_ims_dev',user='postgres',password='123')
cursor =conn.cursor()
path = 'myworkshop/productHelth.xlsx'
wb_obj = load_workbook(path)
sheet_obj = wb_obj.active
max_row = len(sheet_obj['A'])
try:
    max_col =196
    for r in range(1,max_row+1):    
        q = "insert into inventory_healthstatusdetails(health_id,product_healthy,health_remarks,product_status,status_date,product_id) values(%s,%s,%s,%s,%s,%s)"
        val = (r,"Yes","New Product","Working","2024-04-23",r)        
        cursor.execute(q,val)
        conn.commit()        
except Exception as e:
        print("Exception -- ",e.message)    
finally:
   cursor.close()
# truncate table store_transactiondetails RESTART IDENTITY CASCADE ;