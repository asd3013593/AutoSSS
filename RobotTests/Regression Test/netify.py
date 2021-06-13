from firebase import firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import db
from robot.api.deco import keyword
import sys
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from robot.api.deco import keyword
from distutils.core import setup
from PIL._imaging import draw
from lib2to3.tests.support import driver
from firebase import firebase
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import db
import firebase_admin
import sys

@keyword(name='Setup Application Driver')
def setup_application_driver():
    desired_caps = {}
    desired_caps['app'] = r"C:\Program Files\Privax\HMA VPN\Vpn.exe"
    desired_caps['platformName'] = "Windows"
    desired_caps['deviceName'] = "WindowsPC"
    driver = webdriver.Remote(
        command_executor='http://127.0.0.1:4723',
        desired_capabilities=desired_caps)
    return driver

@keyword(name='Connect Vpn To Turkey Implement')
def _connect_vpn_to_turkey(driver):
    _connect_vpn_to_turkey_implenment(driver)
    # _close_vpn_implement(driver)

@keyword(name='Reconnect Vpn To Turkey Implement')
def _reconnect_vpn_to_turkey(driver):
    _disconnect_vpn_implement(driver)
    _connect_vpn_to_turkey_implenment(driver)

@keyword(name='Disconnect Vpn Implement')
def _disconnect_vpn(driver):
    _disconnect_vpn_implement(driver)

@keyword(name='Close Vpn')
def _close_vpn(driver):
    closeButton = WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.NAME, "關閉"))).click()

def _connect_vpn_to_turkey_implenment(driver):
    try:
        WebDriverWait(driver, 5).until(EC.visibility_of_element_located((By.NAME, "連線")))
    except TimeoutException:
        _disconnect_vpn_implement(driver)
        WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.NAME, "Taiwan")))
    WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.NAME, "連線"))).click()
    WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.NAME, "Taiwan, Taipei")))

def _disconnect_vpn_implement(driver):
    unConnectButton = WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.NAME, "中斷連線"))).click()
    WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.NAME, "Taiwan")))


@keyword(name='Put Account')
def post(name, account):
    # 引用私密金鑰
    # path/to/serviceAccount.json 請用自己存放的路徑
    cred = credentials.Certificate('C:/Users/USER/Desktop/新增資料夾/AutoSSS/RobotTests/Regression Test/serviceAccount.json')
    # 初始化firebase，注意不能重複初始化
    firebase_admin.initialize_app(cred)
    # 初始化firestore
    database = firestore.client()
    url = "https://netify-c29d2-default-rtdb.firebaseio.com/"
    fb = firebase.FirebaseApplication(url,None)
    
    account = ["netifyasx", "netifyasy", "netifyasz", "netifyata", "netifyatb", "netifyatc", "netifyatd", "netifyate", "netifyatf", "netifyatg", "netifyath", "netifyati", "netifyatj", "netifyatk", "netifyatl", "netifyatm", "netifyatn", "netifyato", "netifyatp", "netifyatq", "netifyatr", "netifyats", "netifyatt", "netifyatu", "netifyatv", "netifyatw", "netifyatx", "netifyaty", "netifyatz", "netifyaua", "netifyaub", "netifyauc", "netifyaud", "netifyaue", "netifyauf", "netifyaug", "netifyauh", "netifyaui", "netifyauj", "netifyauk", "netifyaul", "netifyaum", "netifyaun", "netifyauo", "netifyaup", "netifyauq", "netifyaur", "netifyaus", "netifyaut", "netifyauu", "netifyauv", "netifyauw", "netifyaux", "netifyauy", "netifyauz", "netifyava", "netifyavb", "netifyavc", "netifyavd", "netifyave", "netifyavf", "netifyavg", "netifyavh", "netifyavi", "netifyavj", "netifyavk", "netifyavl", "netifyavm", "netifyavn", "netifyavo", "netifyavp", "netifyavq", "netifyavr", "netifyavs", "netifyavt", "netifyavu", "netifyavv", "netifyavw", "netifyavx", "netifyavy", "netifyavz", "netifyawa", "netifyawb", "netifyawc", "netifyawd", "netifyawe", "netifyawf", "netifyawg", "netifyawh", "netifyawi", "netifyawj", "netifyawk", "netifyawl", "netifyawm", "netifyawn", "netifyawo", "netifyawp", "netifyawq", "netifyawr", "netifyaws", "netifyawt", "netifyawu", "netifyawv", "netifyaww", "netifyawx", "netifyawy", "netifyawz", "netifyaxa", "netifyaxb", "netifyaxc"]
    doc = []
    for i in account:
      fb.put("/未註冊"+name , i, "Netify000")
    print("https://netify-c29d2-default-rtdb.firebaseio.com/")
    message = fb.get("/未註冊"+name, None)
    # for key in message:
    #   print(message[key]['message'])
    # # print(message)
    for i in message:
      print(i['message'], i['sender'])

@keyword(name="Get Account With Amount")
def _get_account_with_amount(state ,name, amount):
    accounts = []
    amount = int(amount)
    cred = credentials.Certificate('C:/Users/USER/Desktop/新增資料夾/AutoSSS/RobotTests/Regression Test/serviceAccount.json')
    firebase_admin.initialize_app(cred)
    url = "https://netify-c29d2-default-rtdb.firebaseio.com/"
    fb = firebase.FirebaseApplication(url,None)
    message = fb.get("/"+state+name, None)
    for key,value in message.items():
        if(key == 'address'):
            address = value
        elif(amount>0):
            accounts.append({'key':key+address, 'value':value})
            amount-=1
        else:
            break
    return accounts

@keyword(name="Delete Account With Key")
def _delete_account_with_key(state, name, account):
    cred = credentials.Certificate('C:/Users/USER/Desktop/新增資料夾/AutoSSS/RobotTests/Regression Test/serviceAccount.json')
#         firebase_admin.initialize_app(cred)
    url = "https://netify-c29d2-default-rtdb.firebaseio.com/"
    fb = firebase.FirebaseApplication(url,None)
    fb.delete("/"+state+name, account)

@keyword(name="Update Account To New State")
def _update_account_to_new_state(state, name, account, password):
#     if (not firebase_admin.get_app()):
#     cred = credentials.Certificate('C:/Users/pan/Desktop/StickerSender/AutoSSS/RobotTests/Regression Test/serviceAccount.json')
#     firebase_admin.initialize_app(cred)
    url = "https://netify-c29d2-default-rtdb.firebaseio.com/"
    fb = firebase.FirebaseApplication(url,None)
    fb.put("/"+state+name , account, password)
