from firebase import firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import db
from robot.api.deco import keyword
import sys

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
    # cred = credentials.Certificate('C:/Users/USER/Desktop/新增資料夾/AutoSSS/RobotTests/Regression Test/serviceAccount.json')
    # firebase_admin.initialize_app(cred)
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
    # cred = credentials.Certificate('C:/Users/USER/Desktop/新增資料夾/AutoSSS/RobotTests/Regression Test/serviceAccount.json')
    url = "https://netify-c29d2-default-rtdb.firebaseio.com/"
    fb = firebase.FirebaseApplication(url,None)
    fb.delete("/"+state+name, account)

@keyword(name="Update Account To New State")
def _update_account_to_new_state(state, name, account, password):
    url = "https://netify-c29d2-default-rtdb.firebaseio.com/"
    fb = firebase.FirebaseApplication(url,None)
    fb.put("/"+state+name , account, password)
