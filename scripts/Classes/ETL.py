import pandas as pd
from scripts.Common.DB_Utils import DB_instance


path=r"data/raw/Classes/Classes.xlsx"


df=pd.read_excel(path, index_col=False, header=0, sheet_name="Disciplinas")

print(df)