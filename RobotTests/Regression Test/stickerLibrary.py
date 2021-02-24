from os import getcwd
from AppiumLibrary import AppiumLibrary
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
import ast
import subprocess
from unicodedata import normalize
from selenium.webdriver.remote.webelement import WebElement
from lib2to3.fixer_util import String
import time
import csv
import os
import codecs

@keyword(name='Search')
def _search(self, name):
    """search txt"""
    name_str = name.encode('utf-8')
#         space ="\n".encode('utf_8')
    with open("C:/Users/pan/Desktop/mixture.txt",'a+') as f:
        f.seek(0)
        txt=f.readlines()
        for i in txt:
            print("txt:"+i,end='')
            print(str(name_str)+"\n",end='')
            if i == str(name_str)+"\n":
                return True
        return False

@keyword(name='Write')
def _write(self,name):
    name_str = name.encode('utf-8')
    with open("C:/Users/pan/Desktop/mixture.txt",'a') as f:
        f.write(str(name_str)+"\n")

def _getWebPrice(self,data):
    for i in range (-1,-100,-1):
        if(data[i] == ' '):
            return data[i+1:-1]
    return 0 

@keyword(name='priceRecord')
def _priceRecord(self,folderName,country,price,userid,stickerName):
    mark = ' '
    today = str(time.strftime('%Y-%m-%d', time.localtime()))
    now = str(time.strftime('%H:%M', time.localtime()))
    folderpath = "D:/priceLog/{}".format(str(folderName))
    fileExist = os.path.isfile("{}/{}.txt".format(folderpath,today))
    with codecs.open("{}/{}.txt".format(folderpath,today),'a+',encoding='utf-8') as f:
        if(not(fileExist)):
            f.write("{:<6}{:7}{:9}{:7}{:20}{}\n".format("No.", "Time", "Area", "Price", "UserID", "StickerName"))
        read = open("{}/{}.txt".format(folderpath,today),'r',encoding='utf-8')
        f.seek(0)
        fileLine = len(f.readlines())
        if (self._getWebPrice(stickerName) != price):
            mark = '*'
        f.write("{:<6}{:7}{:9}{:7}{:20}{}\n".format(fileLine,now,country,price+mark,userid,stickerName))

@keyword(name='UnlockScreen')
def _lockScreen(self):
    self.unlock()

@keyword(name='Is Swipe To Bottom')
def _is_swipe_to_bottom(self, start_x, start_y, offset_x, offset_y, duration=1000):
    driver = self._current_application()
#       before_swipe = self._get_text("//*[@resource-id='jp.naver.line.android:id/choosemember_listview']//*[@class='android.widget.LinearLayout' and @index='1']//*[@resource-id='jp.naver.line.android:id/widget_friend_row_name']")
    before_swipe = self._get_text("//*[@resource-id='jp.naver.line.android:id/bg' and @index='6']/android.widget.TextView")
    driver.swipe(start_x, start_y, offset_x, offset_y, duration)
    after_swipe = self._get_text("//*[@resource-id='jp.naver.line.android:id/bg' and @index='6']/android.widget.TextView")
    if before_swipe == after_swipe:
        Swiped = True
    else:
        Swiped = False
    return Swiped

@keyword(name='Get Location')
def _get_bounds(self, locator):
    element = self._element_find(locator, True, False)
    if element is not None:
        return element.location
    return None
@keyword(name='Unlock')
def _unlock(self):
    cmd = 'adb shell input keyevent KEYCODE_POWER'
    subprocess.call(cmd)
    cmd = 'adb shell input swipe 400 800 400 400 300'
    subprocess.call(cmd)

@keyword(name='Write Coin Record')
def _coin_record(self, user, price):
    currentMonth = time.strftime('%m',time.localtime())
    localDate = time.strftime('%m/%d',time.localtime())
    localTime = time.strftime('%H:%M:%S', time.localtime())
    filepath = "D:/priceLog/{}CoinRecord.txt".format(user)
    operator = ''
    if (int(price)>0): operator ='+'
    readCoin = open(filepath, 'r')
    data = readCoin.readlines()
    originCoin = data[0].replace('\n','')
    newCoin = int(originCoin) + int(price)
    data [0]  = str(newCoin)+'\n'
    data.append("{:<6}{} {:>5}{}{:<4} = {:<5}\n".format(localDate, localTime, originCoin, operator,price, str(newCoin)))
    writeCoin = open(filepath, 'w')
    writeCoin.writelines(data)
    readCoin.close()
    writeCoin.close()

@keyword(name='Purchase Coin Record')
def _purchase_coin_record(self, user, price):
    currentMonth = time.strftime('%Y-%m',time.localtime())
    localDate = time.strftime('%m/%d',time.localtime())
    localTime = time.strftime('%H:%M:%S', time.localtime())
    filepath = "D:/priceLog/coinRecord/{}.csv".format(str(currentMonth))
    fileExist = os.path.isfile(filepath)
    header = ['日期','時間','代幣']
    record = [localDate,localTime,str(price)]
    with open(filepath, 'a+', newline='') as csvfile:
        writer = csv.writer(csvfile)
        if(not(fileExist)):
            writer.writerow(header)
        writer.writerow(record)
        self._coin_record(user, price)

@keyword(name='Is Coin Not Enough')
def _is_coin_not_enough(self, user):
    filepath = "D:/priceLog/{}CoinRecord.txt".format(user)
    readCoin = open(filepath, 'r')
    coin = readCoin.readline()
    if (int(coin) < 4000):
        return True
    return False

@keyword(name='Is Coin Same To Sticker')
def _is_coin_same_to_sticker(self, price):
    error = "購買代幣不符(0)，請檢查"
    if (error in str(price)):
        return False
    return True

@keyword(name='Record Index')
def _write_record(self, stickerIndex,index):
    filepath = "D:/aaa.txt"
    with open(filepath,'w',encoding='utf-8') as f:
        record = str(stickerIndex) + '\n' + str(index)
        f.write(record)

@keyword(name='Read Index')
def _read_record(self):
    filepath = "D:/aaa.txt"
    with open(filepath,'r',encoding='utf-8') as f:
        friend = f.readline()
        sticker = f.readline()
        data = [int(friend),int(sticker)]
        return  data