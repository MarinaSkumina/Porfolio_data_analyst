import requests
from bs4 import BeautifulSoup
import pandas as pd

def parser_public_private(url: str, univ_name: str):
    try:
        if 'index' not in url:
            res = requests.get(url=url, timeout=10)
            soup = BeautifulSoup(res.text, 'lxml')
            table1 = soup.find('table', class_='infobox vcard')

            if table1 is None:
                print(f"[INFO] Инфобокс не найден для: {univ_name}")
                return None

            headers = ["univ_name"]
            for i in table1.find_all('th'):
                title = i.text.strip()
                headers.append(title)

            text = [univ_name]
            for i in table1.find_all('td', class_='infobox-data'):
                title = i.text.strip()
                text.append(title)

            df_parse_result = pd.DataFrame([text], columns=headers)
            print(df_parse_result)

            if "Type" in headers:
                return df_parse_result["Type"]
            else:
                print(f"[INFO] Поле 'Type' отсутствует для: {univ_name}")
                return None
    except Exception as e:
        print(f"[ERROR] Ошибка при обработке {univ_name}: {e}")
        return None


df = pd.read_excel('./Type_parsing.xlsx', usecols=["Univ name", "url"])
df.rename(columns={"Univ name" : "univ_name"}, inplace=True)
df["Type"] = df.apply(lambda x: parser_public_private(x["url"], x["univ_name"]), axis=1)

df.to_excel('./Viki_parsing_result.xlsx')

#if __name__ == "__main__":
#    parser_public_private(url="https://en.wikipedia.org/wiki/Okinawa_Institute_of_Science_and_Technology")

