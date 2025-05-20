from bs4 import BeautifulSoup
import requests

res = requests.get(url="https://en.wikipedia.org/w/index.php?search=Okinawa+Institute+of+Science+%26+Technology&title=Special%3ASearch&ns0=1")
soup = BeautifulSoup(res.text, 'lxml')

#url_container = soup.find('ul', class_='mw-search-results')
url_cont = soup.find("div", class_="searchResultImage-thumbnail")
url = url_cont.find_next().get("href")
print(url)