*** Settings ***
Force Tags    mycat
Library    XML
Library    AppiumLibrary
Library    OperatingSystem
Resource    purchaseCoin.txt
Resource    ./mycat.txt
Suite Setup    Run Keywords    Set Library Search Order  AppiumLibrary  SeleniumLibrary
...                     AND    Login Mycat Magnage Interface
Suite Teardown    Close All Application And Back To Home

*** Variables ***
${redmiDeviceName} =    8531905e7d25
${samsungDeviceName} =    435145414e553398    #version:9
${hauweiDeviceName} =    2DR4C19227004310    #version:9
${redmiDeviceName2} =    26c490cb7d24
${emulator} =    127.0.0.1:52001
${cataccount} =    20140002
${catpassword} =    20140002
${oldaccount} =    20160000
${oldpassword} =    20160000
${catUrl} =    https://mycat.tw/goadmin.php
${oldUrl} =    https://oldman.tw/goadmin.php
${logincatUrl} =    https://mycat.tw/goadmin.php
${loginoldUrl} =    https://oldman.tw/goadmin.php
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
&{countryToVPN} =    日本=東京 #46    印尼=雅加達 #8    韓國=首爾 #26    美國=紐約 #18    泰國=曼谷 #5    馬來西亞=吉隆波 #10    新加坡=新加坡 #20    香港=香港 #129
${slowNetPeriod} =    30s
${LineApplication} =    2
${stickerName} =    Empty

*** Test Cases ***
Automatically send taiwan sticker mycat
    [Setup]    Run Keywords    Get Processing Sticker
    ...                 AND    Get Taiwan Sticker Number
    FOR    ${num}    IN RANGE    ${taiwanSticker}
        Run Keyword If    ${num}==0    Open Taiwan Stciker Sending Page
        ${clientExist} =    Run Keyword And Return Status    Verify Is There Still Client Exist
        Exit For Loop if    not ${clientExist}
        Log To Console    \nNo${num}.Client
        Run Sending Template By For Circle
    END
    AppiumLibrary.Wait Until Page Does Not Contain Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView    timeout=60s    error=LINE sticker should not be visible.

Automatically send foreign sticker mycat
    [Setup]    Run Keywords    AppiumLibrary.Click Element   //*[@resource-id='com.android.chrome:id/url_bar']
    ...                 AND    AppiumLibrary.Input Text   //*[@class='android.widget.EditText']    https://mycat.tw/goadmin.php
    ...                 AND    Press Keycode    66
    ...                 AND    Get Processing Sticker
    ...                 AND    Get Foreing Sticker Number
    Set Global Variable    ${LineApplication}    1    #FIXME
    FOR    ${num}    IN RANGE    ${foreignSticker}
        Run Keyword If    ${num}==0    Open Foreign Stciker Sending Page
        ${clientExist} =    Run Keyword And Return Status    Verify Is There Still Client Exist
        Exit For Loop if    not ${clientExist}
        Log To Console    \nNo${num}.Client
        Run Sending Template By For Circle
    END
    AppiumLibrary.Wait Until Page Does Not Contain Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView    timeout=60s    error=LINE sticker should not be visible.

Automatically send foreign topic mycat
    [Setup]    Run Keywords    AppiumLibrary.Click Element   //*[@resource-id='com.android.chrome:id/url_bar']
    ...                 AND    AppiumLibrary.Input Text   //*[@class='android.widget.EditText']    https://mycat.tw/goadmin.php
    ...                 AND    Press Keycode    66
    ...                 AND    Get Processing Sticker
    ...                 AND    Get Foreing Topic Number
    Set Global Variable    ${LineApplication}    1    #FIXME
    FOR    ${num}    IN RANGE    ${foreignTopic}
        Run Keyword If    ${num}==0    Open Foreign Topic Sending Page
        ${clientExist} =    Run Keyword And Return Status    Verify Is There Still Client Exist
        Exit For Loop if    not ${clientExist}
        Log To Console    \nNo${num}.Client
        Run Sending Template By For Circle
    END
    AppiumLibrary.Wait Until Page Does Not Contain Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView    timeout=60s    error=LINE sticker should not be visible.

# Automatically purchase oldman LINE coin when coin less than 10000
    # ${noPurchasing} =    Check No Account Purchasing Coin
    # ${isCoinNotEnough} =    Is Coin Not Enough    mycat
    # Run keyword If    ${isCoinNotEnough} and ${noPurchasing}    Run Keywords    Make Purchase CheckFile
    # ...                                                                  AND    Close Mycat VPN Connect And Close Apps
    # ...                                                                  AND    Mycat purchase LINE 4000 coin