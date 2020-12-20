*** Settings ***
Library    XML
Library    AppiumLibrary
Library    OperatingSystem
Resource    purchaseCoin.txt
# Suite Setup    Run Keywords    Set Library Search Order  AppiumLibrary  SeleniumLibrary
# ...                     AND    Login Oldman Magnage Interface
# Suite Teardown    Close All Application And Back To Home

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
&{countryToVPN} =    日本=東京 #31    印尼=雅加達 #8    韓國=首爾 #26    美國=紐約 #18    泰國=曼谷 #2    馬來西亞=吉隆波 #10    新加坡=新加坡 #20
${currentLocation} =    台灣
${slowNetPeriod} =    30s
${LineApplication} =    1
${stickerName} =    Empty

*** Test Cases ***
Automatically send taiwan sticker oldman
    [Setup]    Run Keywords    Unlock Processing Permission
    ...                 AND    Open Taiwan Stciker Sending Page
    Run Sending Template By Sticker Number    ${taiwanSticker}
    Wait Until Page Does Not Contain Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView    timeout=60s    error=LINE sticker should not be visible.

Automatically send foreign sticker oldman
    [Setup]    Run Keywords    Click Element   //*[@resource-id='com.android.chrome:id/url_bar']
    ...                 AND    Input Text   //*[@class='android.widget.EditText']    https://oldman.tw/goadmin.php
    ...                 AND    Press Keycode    66
    ...                 AND    Get Processing Sticker
    ...                 AND    Get Foreing Sticker Number
    FOR    ${num}    IN RANGE    ${foreignSticker}
        Run Keyword If    ${num}==0    Open Foreign Stciker Sending Page
        ${clientExist} =    Run Keyword And Return Status    Verify Is There Still Client Exist
        Exit For Loop if    not ${clientExist}
        Log To Console    \nNo${num}.Client
        Run Sending Template By For Circle
    END
    Wait Until Page Does Not Contain Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView    timeout=60s    error=LINE sticker should not be visible.

Automatically send foreign topic oldman
    [Setup]    Run Keywords    Click Element   //*[@resource-id='com.android.chrome:id/url_bar']
    ...                 AND    Input Text   //*[@class='android.widget.EditText']    https://oldman.tw/goadmin.php
    ...                 AND    Press Keycode    66
    ...                 AND    Get Processing Sticker
    ...                 AND    Get Foreing Topic Number
    FOR    ${num}    IN RANGE    ${foreignTopic}
        Run Keyword If    ${num}==0    Open Foreign Topic Sending Page
        ${clientExist} =    Run Keyword And Return Status    Verify Is There Still Client Exist
        Exit For Loop if    not ${clientExist}
        Log To Console    \nNo${num}.Client
        Run Sending Template By For Circle
    END
    Wait Until Page Does Not Contain Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView    timeout=60s    error=LINE sticker should not be visible.

Automatically purchase oldman LINE coin when coin less than 10000
    ${isCoinNotEnough} =    Is Coin Not Enough    oldman
    Run keyword If    ${isCoinNotEnough}    Run Keywords    Close VPN Connect And Close Apps
    ...                                              AND    Oldman purchase LINE 16000 coin

*** Keywords ***
Get Name If Change Computer
    Press Keycode    ${appSwitchKey}
    Switch To Context    NATIVE_APP
    Wait Until Element Is Visible    //*[@class='android.widget.FrameLayout' and @content-desc='LINE']    timeout=${slowNetPeriod}    error=LINE application.
    Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='LINE']
    FOR    ${num}    IN RANGE    99999
        ${getname}    Get Text    //*[@class='android.widget.FrameLayout'and @index='2']//*[@class='android.widget.LinearLayout' and @index='0']//*[@class='android.widget.TextView']
        Log To Console    ${getname}
        Swipe    540    1900    540    1800    500
        ${repeat} =    Search    ${getname}
        Run Keyword Unless    ${repeat}    Write    ${getname}
    END

Close Previous App And Go Back To Chrome
    Press Keycode    ${appSwitchKey}
    sleep    1s    #fix me
    Swipe    450    1500    450    468    500
    Click Element After It Is Visible   //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']    timeout=${slowNetPeriod}    error=Chrome app should be visible on switch page.

Switch VPN If Is Sending Foreign Sticker
    ${globalArea} =    Set Variable     全球
    ${country} =     Run Keyword If    ${foreign}    Wait Until Keyword Succeeds     5s    0.5s    Get Text    //*[@class='android.view.View' and @index='5']//*[@class='android.view.View' and @index ='1']
    ${isGlobalArea} =    Run Keyword And Return Status     Should Be Equal As Strings    ${globalArea}    ${country}
    ${isConnected} =    Run Keyword And Return Status     Should Be Equal As Strings    ${currentLocation}    ${country}
    Run Keyword If    ${isGlobalArea} or ${isConnected}    Return From Keyword
    Run Keyword If    ${foreign}    Run keywords    Close Previous App And Go Back To Chrome
    ...                                      AND    Switch Network With VPN    ${country}
    ...                                      AND    Switch App To Chrome

Switch Network With VPN
    [Arguments]    ${country}
    Open VPN App
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    Click Element    //*[contains(@text, '當前伺服器：')]
    Click Element After It Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/search_button']    timeout=${slowNetPeriod}    error=Serach should be visible.
    Input Text    com.fvcorp.flyclient:id/search_src_text    ${countryToVPN.${country}}
    Click Element After It Is Visible    //*[@resource-id='com.fvcorp.flyclient:id/textServerRowTitle']    timeout=${slowNetPeriod}    error=Country should be visible.
    ${successConnect} =     Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${successConnect}    Set Global Variable    ${currentLocation}    ${country}

Connect Button Should Connect
    Wait Until Element Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']    timeout=5s

FlyVPN Should Exist
    Wait Until Element Is Visible    //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']    timeout=3s



Login Oldman Magnage Interface
    Open Chrome
    Go To Url    https://oldman.tw/goadmin.php
    Switch To Context    NATIVE_APP
    Wait Until Element Is Visible    //*[@class='android.widget.EditText' and @password ='false']    timeout=30s    error=Password input should be visible.
    Input Text   //*[@class='android.widget.EditText' and @password ='false']    20160000
    Input Text    //*[@text='登入密碼']    20160000
    AppiumLibrary.Click Element    //*[@resource-id='submit']
    Wait Until Element Is Visible    xpath=//*[contains(@text, '解除鎖定')]    timeout=${slowNetPeriod}    error=Web should be login.

Verify User Should Not Be Found
    ${notFoundlabel} =     Run Keyword And Return Status   Wait Until Element Is Visible    //*[@class='android.widget.TextView' and contains(@text,'無法找到該用戶')]    timeout=5s    error=Not found label should be visible.
    Run Keyword If    ${notFoundlabel}    Set Global Variable   ${errorType}    4
    ...       ELSE    Run Keywords    Set Global Variable    ${errorType}    ${nextClientError}
    ...                        AND    Close LINE To Go Back After Change The Name

Verify User Should Be A Friend
    ${buttonJoinOrNot} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='加入']    timeout=3s
    Run Keyword If    ${buttonJoinOrNot}    Run keywords   Click Add Friend Button
    ...                                              AND   Set Global Variable    ${alreadyFriend}    False
    ...       ELSE    Set Global Variable    ${alreadyFriend}    True


Select User By Name When Users
    Wait Until Element Is Visible        //*[@class='android.view.View' and @text='${userName}' and @index='0' and not(./following-sibling::*)]    timeout=10s    error=Friends list should be visible.
    ${reNameUsers} =    Get Matching Xpath Count    //*[@class='android.view.View' and @text='${userName}' and @index='0' and not(./following-sibling::*)]
    Run Keyword If    ${reNameUsers}>1    Fail    Users are repeated, please handle it.
    ...       ELSE    Click Element    //*[@class='android.view.View' and @text='${userName}' and @index='0' and not(./following-sibling::*)]

Count User Number And Return Type
    Wait Until Page Contains Element    //*[@class='android.widget.ListView' and @index='1']/android.view.View   timeout=10s    error=Friend List View Should Be Visible. 
    ${count}    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='1']/android.view.View
    # Log To Console    ${count}
    # ${name} =    Run Keyword If    ${count}==1    Set Variable    1
    # ${name} =    Run Keyword If    not(${count}==1)    Set Variable    2
    Log To Console    name=${count}
    [Return]    ${count}

Open Sticker Link
    Wait Until Element Is Visible   xpath=//*[@text= '開啟連結' and @index='0']     timeout=${slowNetPeriod}    error=Url open button should be visible.
    ${name} =    Get Text    //*[@class='android.view.View' and @index='8']//*[@class='android.view.View' and @index='1']
    Set Global Variable    ${stickerName}    ${name}
    Click Element    xpath=//*[@text= '開啟連結' and @index='0']

Send Gift By Select User With ID
    ${enable} =    Run Keyword And Return Status    Wait Until Element Is Visible   xpath=//*[contains(@text, '贈送禮物') and @enabled='true']     timeout=10s    error=Send gift button should be visible.
    ${disable} =    Run Keyword Unless    ${enable}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[contains(@text, '贈送禮物') and @enabled='false']    timeout=5s    error=Send gift button should be disable.
    Run Keyword Unless    ${enable}    Run Keywords    Run Keyword If    ${disable}    Set Global Variable    ${errorType}    3
    ...                                                          ELSE    Set Global Variable    ${errorType}    ${nextClientError}
    ...                                AND    Close LINE To Go Back After Change The Name
    ...                                AND    Return From Keyword
    AppiumLibrary.Click Element    xpath=//*[contains(@text, '贈送禮物')]
    Input Text After Click    //*[@resource-id='jp.naver.line.android:id/searchbar_input_text']    ${userId}
    ${getName} =    Get Text    //*[@resource-id='jp.naver.line.android:id/row_user_bg']//*[@class='android.widget.TextView']
    ${searchClientNumber} =    Get Matching Xpath Count    //*[@resource-id='jp.naver.line.android:id/row_user_bg']
    Wait Until Page Contains Element    //*[@resource-id='jp.naver.line.android:id/row_user_bg']//*[@resource-id='jp.naver.line.android:id/widget_friend_row_checkbox']    timeout=${slowNetPeriod}    error=Client's checkbox should be visible.
    Run Keyword If    ${searchClientNumber} == 1    Click Element    //*[@resource-id='jp.naver.line.android:id/row_user_bg']//*[@resource-id='jp.naver.line.android:id/widget_friend_row_checkbox']
    ...       ELSE    Run Keywords    Hide Keyboard
    Run Keyword If    not (${searchClientNumber} == 1)    Swipe To Client
    Click Element    //*[@resource-id='jp.naver.line.android:id/header_button_text']
    #could be error
    ${sendSuccess}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']    timeout=10s
    Run Keyword If    ${sendSuccess}    Click OK Button To Send Gift To User
    ...       ELSE    Occur Error When Send Gift To User

Click OK Button To Send Gift To User
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']    timeout=${slowNetPeriod}    error=Purchase button should be visible.
    ${price} =    Get Text    //*[@resource-id='jp.naver.line.android:id/line_coin_price_text_view' and @index='1']
    Click Element    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']    timeout=${slowNetPeriod}    error=OK button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']
    ${sendSuccess}    Run Keyword And Return Status    Wait Until Page Contains Element    //*[@resource-id='jp.naver.line.android:id/chathistory_message_list']    timeout=60s    error=Message page should be visible after sending sticker success.
    ${secondSendSuccess} =    Run keyword If    not ${sendSuccess}    Run Keyword And Return Status    Occur Error After Click Purchase OK Button
    Run Keyword If    not ${secondSendSuccess} and not ${secondSendSuccess}==${None}    Run Keywords    Set Global Variable    ${errorType}    ${nextClientError}
    ...                                                    AND    Return From Keyword
    Log To Console    sticker = ${stickerName} price = ${price}
    ${area} =    Run Keyword If    ${foreign}    Set Variable    Foreign
    ...                    ELSE    Set Variable    Taiwan
    priceRecord    oldmanPrice    ${area}    ${price}    ${userId}   ${stickerName}
    Write Coin Record    oldman    -${price}
    [Teardown]    Close LINE To Go Back After Change The Name

Occur Error After Click Purchase OK Button
    Run Keyword And Ignore Error    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='確定']    timeout=10s    error=Error button should be visible.
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']    timeout=${slowNetPeriod}    error=Purchase button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']    timeout=${slowNetPeriod}    error=OK button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']
    Wait Until Page Contains Element    //*[@resource-id='jp.naver.line.android:id/chathistory_message_list']    timeout=60s    error=Message page should be visible after sending sticker success.




    # Press Keycode To Go Back

Occur Error When Send Gift To User
    ${sendError}    Run Keyword And Return Status    Verify User Already Have Sticker
    Run Keyword If     ${sendError}    Set Global Variable    ${errorType}    1
    ...       ELSE    Set Global Variable    ${errorType}    5
    Click Element    xpath=//*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']
    Wait Until Element Is Visible     //*[@resource-id='jp.naver.line.android:id/header_button_text']
    [Teardown]    Close LINE To Go Back After Change The Name

Verify User Already Have Sticker
    Wait Until Element Is Visible    xpath=//*[@resource-id='jp.naver.line.android:id/common_dialog_content_text' and contains(@text,'已擁有')]    timeout=${slowNetPeriod}    error=User should not have the sticker.

Verify Is There Still Client Exist
     Wait Until Element Is Visible On Page   //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView     timeout=30s    error=LINE open button should be visible.

Go Back To Management Page From Gift Page
    FOR     ${i}    IN RANGE    5
         Press Keycode    ${backKey}
         ${result} =    Run Keyword And Return Status    Verify If Back To Sending Page    //*[@text='訂單']/following-sibling::*
         Exit For Loop If    ${result}
    END

Go Back To Management Page From Chat Page
    FOR     ${i}    IN RANGE    5
         Press Keycode    ${backKey}
         ${result} =    Run Keyword And Return Status    Verify If Back To Sending Page    //*[@text='訂單']/following-sibling::*
         Exit For Loop If    ${result}
    END

Fix Go Back Error
    Wait Until Element Is Visible    xpath=//*[@text= '送 出' ]    timeout=${slowNetPeriod}    error=Finish button should be visible.



Select Error Message
    Wait Until Element Is Visible    //*[@resource-id='SendStatus']
    Click Element    //*[@resource-id='SendStatus']
    Wait Until Element Is Visible    //*[@resource-id='android:id/text1' and @index='${errorType}']    timeout=10s    error=Select error msg should be visible.
    Click Element    //*[@resource-id='android:id/text1' and @index='${errorType}']

Close LINE To Go Back After Change The Name
    Press Keycode    ${appSwitchKey}
    sleep    1s    #fix me
    Swipe    900    1500    900    468    500
    sleep    1s
    Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']

    # Press Keycode    ${appSwitchKey}
    # sleep    1s    #fix me
    # Swipe    188    700    400    700    500
    # sleep    1s
    # Click Element    //*[@resource-id='com.android.systemui:id/title' and @text='Chrome']

Switch App To Chrome
    Press Keycode    ${appSwitchKey}
    Switch To Context    NATIVE_APP
    # sleep    1s    #fix me
    # Swipe    900    1500    900    468    500
    # Wait Until Page Contains Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*    timeout=${slowNetPeriod}    error=
    # Click Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*
    Wait Until Element Is Visible    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']    timeout=${slowNetPeriod}    error=
    Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']

    # Press Keycode    ${appSwitchKey}
    # Switch To Context    NATIVE_APP
    # # Wait Until Page Contains Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*    timeout=${slowNetPeriod}    error=
    # # Click Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*
    # Wait Until Element Is Visible    //*[@resource-id='com.android.systemui:id/title' and @text='Chrome']    timeout=${slowNetPeriod}    error=
    # Click Element    //*[@resource-id='com.android.systemui:id/title' and @text='Chrome']

Unlock Permission
    Wait Until Page Contains Element    xpath=//*[contains(@text, '解除鎖定')]    timeout=${slowNetPeriod}    error=Password input should be visible.
    AppiumLibrary.Click Element    xpath=//*[contains(@text, '解除鎖定')]
    AppiumLibrary.Click Element    xpath=//*[contains(@text, '解除處理中')]

Open Chrome
    [Documentation]    Opens the calculator app with a new appium session.
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=9    alias=MyChrome1
    ...    deviceName=${hauweiDeviceName}    noReset=true    browserName=Chrome    automationName=uiautomator2
    # ${app2} =    Open Application    http://localhost:4725/wd/hub    platformName=Android    platformVersion=8.1.0    alias=MyChrome2
    # ...    deviceName=${redmiDeviceName}    noReset=true    browserName=Chrome    automationName=uiautomator2
    # appPackage=com.android.chrome     appActivity=com.google.android.apps.chrome.Main


    # Wait Until Element Is Visible On Page    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']    timeout=${slowNetPeriod}    error=Taiwanese sticker should be visible.
    # ${num}    Get Text    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']
    # Set Global Variable    ${taiwanNum}    ${num}

Get User Information
    ${name} =    Get Text    xpath=//*[@resource-id='jp.naver.line.android:id/addfriend_name']
    Set Global Variable    ${userName}    ${name}
    ${id} =    Get Text    xpath=//*[@class='android.widget.EditText']
    Set Global Variable    ${userId}    ${id}
    Log To Console    name:${name} id:${id}

Click Add Friend Button
    Click Element    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='加入']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='聊天']    timeout=${slowNetPeriod}    error=Chat button should be visible.

Delete All User By Open LINE
    ${AppExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@class ='android.widget.TextView' and @text ='LINE']
    Run Keyword Unless    ${AppExist}    Swipe    400    300    100    300    500
    Click Element    //*[@class ='android.widget.TextView' and @text ='LINE']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/home_tab_title_name' and @class='android.widget.TextView' and contains(@text, '好友')]    timeout=10s
    Click Element    //*[@resource-id='jp.naver.line.android:id/home_tab_title_name' and @class='android.widget.TextView' and contains(@text, '好友')]
    Wait Until Element Is Visible    xpath=(//*[@class='android.view.ViewGroup' @resource-id='jp.naver.line.android:id/bg']//*[@resource-id='jp.naver.line.android:id/name'])[1]    timeout=10s
    ${name1} =    Get Text    xpath=(//*[@class='android.view.ViewGroup' and @resource-id='jp.naver.line.android:id/bg']//*[@resource-id='jp.naver.line.android:id/name'])[1]
    Long Press    xpath=(//*[@class='android.view.ViewGroup' and @resource-id = 'jp.naver.line.android:id/bg'])[1]
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_item' and @text='刪除']
    Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_item' and @text='刪除']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn' and @text='刪除']
    Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn' and @text='刪除']
    Log To Console    ${name1}
    FOR    ${i}    IN RANGE    9999
        Wait Until Page Does Not Contain Element    //*[@resource-id='jp.naver.line.android:id/bg']//*[@resource-id='jp.naver.line.android:id/name' and @text='${name1}']    timeout=10s
        ${FriendExist} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[@class='android.view.ViewGroup' and @resource-id='jp.naver.line.android:id/bg']    timeout=3s
        Exit For Loop if    not ${FriendExist}
        ${name1} =    Get Text    xpath=(//*[@class='android.view.ViewGroup' and @resource-id='jp.naver.line.android:id/bg']//*[@resource-id='jp.naver.line.android:id/name'])[1]
        Log To Console    ${name1}
        Long Press    xpath=(//*[@class='android.view.ViewGroup' and @resource-id = 'jp.naver.line.android:id/bg'])[1]
        Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_item' and @text='刪除']
        Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_item' and @text='刪除']
        Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn' and @text='刪除']
        Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn' and @text='刪除']
    END
    Press Keycode    ${appSwitchKey}
    FOR    ${num}    IN RANGE    9999
        ${applicationExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='com.huawei.android.launcher:id/snapshot']    timeout=5s    error=
        Exit For Loop if    not ${applicationExist}
        Swipe    324    1500    324    468    500
    END

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
    # Delete All User By Open LINE
    Press Keycode    ${homeKey}
    Press Keycode    26
    Close All Applications
    sleep    1s
    # Press Keycode    ${appSwitchKey}
    # FOR    ${num}    IN RANGE    9999
        # ${applicationExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='com.android.systemui:id/title']    timeout=5s    error=
        # Exit For Loop if    not ${applicationExist}
        # &{location} =    Get Location    //*[@resource-id='com.android.systemui:id/title']
        # Swipe    ${location.x}    ${location.y}    719    ${location.y}    200
    # END
    # Press Keycode    ${homeKey}
    # Press Keycode    26
    # Close All Applications
    # sleep    1s

Log Sending Status To Console
    [Arguments]    ${type}
    Run Keyword If    ${type}==0    Log To Console    Send Correctly
    ...    ELSE IF    ${type}==1    Log To Console    Purchase Repeatedly
    ...    ELSE IF    ${type}==4    Log To Console    Error & Unpublic ID
    ...    ELSE IF    ${type}==5    Log To Console    Old Version

Swipe To Client
    FOR    ${index}    IN RANGE    9999
        ${findClient} =    Run Keyword And Return Status    Click Element    //*[@class='android.widget.LinearLayout' and @clickable='true' and .//*[@class='android.widget.TextView' and @text='${userId}']]//*[@resource-id='jp.naver.line.android:id/widget_friend_row_checkbox']
        ${isNotBottom} =    Run Keyword If    not ${findClient}   Swipe To Bottom    300    500    300    700    300
        Run Keyword If    ${findClient}    Return From Keyword    True
    ...        ELSE IF    not ${isNotBottom}    Fail    message=Client should be found
    END

Choose Line Application    #雙開選擇帳號 現已用不到
    Wait Until Element Is Visible    //*[@resource-id='com.huawei.android.internal.app:id/resolver_grid']//*[@class ='android.widget.LinearLayout' and @index ='0']    timeout=10s    error=First Line App should be visible.
    Run Keyword If    ${LineApplication}==1    Click Element    //*[@resource-id='com.huawei.android.internal.app:id/resolver_grid']//*[@class ='android.widget.LinearLayout' and @index ='0']
    ...    ELSE IF    ${LineApplication}==2    Click Element    //*[@resource-id='com.huawei.android.internal.app:id/resolver_grid']//*[@class ='android.widget.LinearLayout' and @index ='1']
