from selenium import webdriver  
import selenium.webdriver.support.ui as ui
import selenium
import time

browser = webdriver.Firefox()
wait = ui.WebDriverWait(browser,10)

thisurl = 'http://www.egyptindependent.com/subchannel/News%20features'
browser.get(thisurl)

time.sleep(10)
nextpage = [False]
all_links = []

while len(nextpage)>0:
    if nextpage[0]:
        nextpage[0].click()
        time.sleep(10)
    elems = browser.find_elements_by_xpath("//div[@class='view-content']/h3/a")
    for e in elems:
        all_links.append(e.get_attribute('href'))
    nextpage = browser.find_elements_by_xpath("//li[@class='pager-next last']/a")


alldata = []

for url in all_links:
    d = dict()
    d['url'] = url
    browser.get(url)
    time.sleep(10)
    textelems = browser.find_elements_by_xpath("//div[@class='panel-pane pane-node-body']")
    d['articletext'] = textelems[0].text
    authorelems = browser.find_elements_by_xpath("//div[@class='field field-type-nodereference field-field-source']")
    d['author'] = authorelems[0].text
    twitterbox = browser.find_elements_by_xpath("//iframe[@class='twitter-share-button twitter-count-horizontal']")[0]
    browser.switch_to_frame(twitterbox)
    twitterelems = browser.find_elements_by_xpath("//html")
    d['tweets'] = twitterelems[0].find_element_by_id('count').text
    alldata.append(d)
    
import json
f = open('egypt.json','w')
json.dump(alldata,f)
f.close()