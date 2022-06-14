import json
import requests
from bs4 import BeautifulSoup

'''
    item kind scraper 22.06.14
'''

config = {
    'URL': 'https://sanderfrenken.github.io/Universal-LPC-Spritesheet-Character-Generator',
    'OUT_FILE': 'items.json'
}

html = requests.get(config.get('URL'))
soup = BeautifulSoup(html.text, 'html.parser')

section = soup.find('section', { 'id': 'chooser' })

result = {}

for kind0 in section.find_all('h3'):
    kind0_text = kind0.text
    result[kind0_text] = {}
    for kind1 in kind0.find_next_sibling('ul').select('section > ul > li'):
        kind1_text = kind1.find('span').get_text()
        result[kind0_text][kind1_text] = {}
        for kind2 in kind1.select('ul > li'):
            try:
                kind2_text = kind2.find('span').get_text()
                kind3_count = len(kind2.select('ul > li'))
                if kind3_count == 0: continue
                result[kind0_text][kind1_text][kind2_text] = kind3_count
            except:
                continue
        if not result[kind0_text][kind1_text]:
            result[kind0_text][kind1_text] = len(kind1.select('section > ul > li > ul > li > label'))
        
f = open(config.get('OUT_FILE'), 'w')
json.dump(result, f, indent=2)
f.close()