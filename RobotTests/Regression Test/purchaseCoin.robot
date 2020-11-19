*** Settings ***
Library    XML
Library    AppiumLibrary
Library    OperatingSystem

*** Variables ***
${redmiDeviceName} =    8531905e7d25
${samsungDeviceName} =    435145414e553398    #version:9
${hauweiDeviceName} =    2DR4C19227004310    #version:9
${cataccount} =    20140002
${catpassword} =    20140002
${oldaccount} =    20160000
${oldpassword} =    20160000
${catUrl} =    https://mycat.tw/goadmin.php
${oldUrl} =    https://oldman.tw/goadmin.php
${logincatUrl} =    https://mycat.tw/goadmin.php
${loginoldUrl} =    https://oldman.tw/goadmin.php
${account} =    ${cataccount}
${password} =    ${catpassword}
${Url} =    ${catUrl}
${loginUrl} =    ${logincatUrl}
${taiwanNum} =    0
${userName} =    empty
${userID} =    empty
${searchName} =    empty
${EqualTo} =    False
${search} =    False
${foreign} =    False
${alreadyFriend} =    False
${errorType} =    0
${purchaseID} =    0
${appSwitchKey} =    187
${backKey} =    4
${homeKey} =    3
${taiwanSticker} =    0
${foreignSticker} =    0
${foreignTopic} =    0
${nextClientError} =    10
&{countryToVPN} =    日本=東京 #32    印尼=雅加達 #8    韓國=首爾 #25    美國=紐約 #18    泰國=曼谷 #2    馬來西亞=吉隆波 #10    新加坡=新加坡 #20
${slowNetPeriod} =    30s
${LineApplication} =    1

*** Test Cases ***
Oldman purchase LINE 16000 coin
    Open LINE App
    Go To The Coin Page
    Purchase 16000 Coin
    [Teardown]    Close All Application And Back To Home

*** Keywords ***
Open Chrome
    [Documentation]    Opens the calculator app with a new appium session.
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=9    alias=MyChrome1
    ...    deviceName=${hauweiDeviceName}    noReset=true    browserName=Chrome    automationName=uiautomator2
    Go To Url    https://oldman.tw/goadmin.php
    Switch To Context    NATIVE_APP

Open LINE App
    Open Chrome
    Press Keycode    ${homeKey}
    ${AppExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@class ='android.widget.TextView' and @text ='LINE']
    Run Keyword Unless    ${AppExist}    Swipe    400    300    100    300    500
    Click Element    //*[@class ='android.widget.TextView' and @text ='LINE']

Go To The Coin Page
    Click Element After It Is Visible    //*[@content-desc='設定 按鍵']//*[@resource-id='jp.naver.line.android:id/header_button_img']    timeout=10s    error=Setting button should be visible.
    Click Element After It Is Visible    //*[@class='android.widget.TextView' and @text='代幣']    timeout=10s    error=Coin field should be visible.

Purchase 16000 Coin
    FOR    ${i}    IN RANGE    20
        Purchase 800 coin
    END

Purchase 800 coin
    Click Element After It Is Visible    //*[@resource-id='jp.naver.line.android:id/header_button_text']    timeout=30s    error=Purchase button should be visible.
    Click Element After It Is Visible    //*[@resource-id='jp.naver.line.android:id/coin_purchase_row_btn_purchase' and @text='NT$390']    timeout=30s    error=NT$390 button should be visible.
    Click Element After It Is Visible    //*[@resource-id='com.android.vending:id/0_resource_name_obfuscated' and @text='一鍵購買']    timeout=30s    error='一鍵購買' button should be visible.
    Wait Until Element Is Visible On Page    //*[@text='付款成功']    timeout=30s    error=Purchase should be success.

Close All Application And Back To Home
    Open VPN App
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    Press Keycode    ${appSwitchKey}
    FOR    ${num}    IN RANGE    9999
        ${applicationExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='com.huawei.android.launcher:id/snapshot']    timeout=3s    error=
        Exit For Loop if    not ${applicationExist}
        Swipe    324    1500    324    468    500
    END
    Press Keycode    26
    Close All Applications
    sleep    1s

Connect Button Should Connect
    Wait Until Element Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']    timeout=5s

Open VPN App
    Press Keycode    ${homeKey}
    ${AppExist} =    Run Keyword And Return Status    FlyVPN Should Exist
    Run Keyword Unless    ${AppExist}    Swipe    400    300    100    300    500
    Click Element    //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']

FlyVPN Should Exist
    Wait Until Element Is Visible    //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']    timeout=3s

Click Element After It Is Visible
    [Arguments]    ${elementPath}    ${timeout}=5s    ${error}=Button should be visible.
    Wait Until Element Is Visible    ${elementPath}    timeout=${slowNetPeriod}    error=Clear application button should be visible.
    Click Element    ${elementPath}

Wait Until Element Is Visible On Page
    [Arguments]    ${locator}    ${timeout}    ${error}=default
    Wait Until Page Contains Element    ${locator}    ${timeout}    ${error}
    Wait Until Element Is Visible    ${locator}    ${timeout}    ${error}