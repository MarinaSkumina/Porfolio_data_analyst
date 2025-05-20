import pandas as pd

# Загрузка из файла столбцов с названием университета и типом
df = pd.read_excel('./profiles_Data_250425.xlsx', \
                          sheet_name="from base", usecols=["Univ name", "Type"])
# Просмотр значений
print(df.groupby("Type")[["Univ name"]].count())
# Замена ошибочного значения 1973 на нулевое
df.loc[df["Type"] == 1973, "Type"] = None
df.loc[df["Type"] == 'Некоммерческое акционерное общество', "Type"] = None
# Удаление лишних пробелов в название типа университета
df["Type"] = df["Type"].str.replace("\t", "")
df["Type"] = df["Type"].str.lstrip()
print(df.groupby("Type")[["Univ name"]].count())
# Формирование выборки для парсинга (нулевые значения)
df_parse = df.loc[df["Type"].isna()]
# Запись названий университетов для парсинга в файл
df_parse.to_excel('./Type_parsing.xlsx')
