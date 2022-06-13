'''
    item kind scraper
'''
import pprint
import requests
from bs4 import BeautifulSoup

URL = "https://sanderfrenken.github.io/Universal-LPC-Spritesheet-Character-Generator/#?body=Humanlike_white&sex=male&shadow=none"

html = requests.get(URL)

soup = BeautifulSoup(html.text, "html.parser")

section = soup.find("section", { "id": "chooser" })

result = list(map(lambda v: { "name": v.text, "kind": {} }, section.find_all('h3')))

elements = section.select('section > ul')

for index, element in enumerate(elements, 0):
    for element2 in element.select('section > ul > li'):
            kind2 = element2.find('span').get_text()
            result[index]['kind'][kind2] = {}
            for element3 in element2.select('ul > li'):
                try:
                    kind3 = element3.find('span').get_text()
                    count = len(element3.select('ul > li'))
                    if count == 0: continue
                    result[index]['kind'][kind2][kind3] = count
                except:
                    continue
            if not result[index]['kind'][kind2]:
                result[index]['kind'][kind2] = len(element.select('section > ul > li > ul > li > label'))


pprint.pprint(result)




'''
import pprint
import requests
from bs4 import BeautifulSoup

URL = "https://sanderfrenken.github.io/Universal-LPC-Spritesheet-Character-Generator/#?body=Humanlike_white&sex=male&shadow=none"

html = requests.get(URL)

soup = BeautifulSoup(html.text, "html.parser")

section = soup.find("section", { "id": "chooser" })

result = []

for span in section.find_all('span'):
    kind = span.get_text()
    item = {
        kind: {}
    }
    try:
        for kind_one in span.find_next_sibling().select('section > ul > li'):
            kind2 = kind_one.find('span').get_text()
            item[kind][kind2] = {}
            for kind_two in kind_one.select('ul > li'):
                try:
                    kind3 = kind_two.find('span').get_text()
                    count = len(kind_two.select('ul > li'))
                    if count == 0: continue
                    item[kind][kind2][kind3] = count
                except:
                    continue
            if not item[kind][kind2]:
                item[kind][kind2] = len(section.select('section > ul > li > ul > li > label'))
        result.append(item)

    except:
        continue
'''