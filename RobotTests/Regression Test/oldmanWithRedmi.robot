*** Settings ***
Force Tags    oldmanWithRedmi
Library    XML
Library    AppiumLibrary
Library    OperatingSystem
Resource    purchaseCoin.txt
Suite Setup    Run Keywords    Set Library Search Order  AppiumLibrary  SeleniumLibrary
...                     AND    Login Oldman Magnage Interface
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
&{countryToVPN} =    日本=東京 #46    印尼=雅加達 #8    韓國=首爾 #26    美國=紐約 #18    泰國=曼谷 #5    馬來西亞=吉隆波 #10    新加坡=新加坡 #20    香港=香港 #160
${slowNetPeriod} =    30s
${LineApplication} =    2
${stickerName} =    Empty

*** Test Cases ***
Automatically send taiwan sticker oldman
    [Setup]    Run Keywords    Get Processing Sticker
    ...                 AND    Get Taiwan Sticker Number
    FOR    ${num}    IN RANGE    ${taiwanSticker}
        Run Keyword If    ${num}==0    Open Taiwan Stciker Sending Page
        ${clientExist} =    Run Keyword And Return Status    Verify Is There Still Client Exist
        Exit For Loop if    not ${clientExist}
        Log To Console    \nNo${num}.Client
        Run Sending Template By For Circle
    END
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
    ${noPurchasing} =    Check No Account Purchasing Coin
    ${isCoinNotEnough} =    Is Coin Not Enough    mycat
    Run keyword If    ${isCoinNotEnough} and ${noPurchasing}    Run Keywords    Make Purchase CheckFile
    ...                                                                  AND    Close Mycat VPN Connect And Close Apps
    ...                                                                  AND    Mycat purchase LINE 4000 coin
*** Keywords ***
Close LINE And Go Back After Sending Fininsh
    Run Keyword If    ${foreign}   Turn Off VPN Connect
    Press Keycode    ${appSwitchKey}
    sleep    1s    #fix me
    Swipe    900    1500    900    468    500
    sleep    1s
    Run Keyword If     ${foreign}    Run Keywords    Swipe    850    1500    850    468    500
    ...                                       AND    sleep    1s    #fix me
    Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']

Turn Off VPN Connect
    Open VPN App
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']

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

Get Taiwan Sticker Number
    ${X} =    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']
    Wait Until Element Is Visible    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']    timeout=${slowNetPeriod}    error=Taiwan sticker number should be visible.
    ${sticker} =    Get Text    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']
    Set Global Variable    ${taiwanSticker}    ${sticker}
    Log To Console    ${taiwanSticker}

Get Foreing Sticker Number
    ${X} =    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='3']
    Wait Until Element Is Visible    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='3']    timeout=${slowNetPeriod}    error=Foreign sticker number should be visible.
    ${sticker} =    Get Text    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='3']
    Set Global Variable    ${foreignSticker}    ${sticker}

Get Foreing Topic Number
    ${X} =    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='5']
    Wait Until Element Is Visible    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='5']    timeout=${slowNetPeriod}    error=Foreign topic number should be visible.
    ${topic} =    Get Text    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='5']
    Set Global Variable    ${foreignTopic}    ${topic}

Switch VPN If Is Sending Foreign Sticker
    ${globalArea} =    Set Variable     全球
    ${country} =     Run Keyword If    ${foreign}    Wait Until Keyword Succeeds     5s    0.5s    Get Text    //*[@class='android.view.View' and @index='5']//*[@class='android.view.View' and @index ='1']
    ${isGlobalArea} =    Run Keyword And Return Status     Should Be Equal As Strings    ${globalArea}    ${country}
    Run Keyword If    ${isGlobalArea}    Return From Keyword
    Run Keyword If    ${foreign}    Run keywords    Switch Network With VPN    ${country}
    ...                                      AND    Switch App To Chrome

Switch Network With VPN
    [Arguments]    ${country}
    Open VPN App
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    Click Element    //*[contains(@text, '當前伺服器：') or contains(@text, '當前線路：')]
    Click Element After It Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/search_button' or @resource-id='com.fvcorp.flyclient:id/layoutSearch']    timeout=${slowNetPeriod}    error=Serach should be visible.
    Input Text    //*[@resource-id='com.fvcorp.flyclient:id/textSearchKeyword']    ${countryToVPN.${country}}
    Click Element After It Is Visible    //*[@resource-id='com.fvcorp.flyclient:id/textServerRowTitle']    timeout=${slowNetPeriod}    error=Country should be visible.
    Connect Button Should Connect

Connect Button Should Connect
    Wait Until Element Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']    timeout=5s

Open VPN App
    Press Keycode    ${homeKey}
    ${AppExist} =    Run Keyword And Return Status    FlyVPN Should Exist
    Run Keyword Unless    ${AppExist}    Press Keycode    ${homeKey}
    Click Element After It Is Visible    //*[@content-desc ='FlyVPN']

FlyVPN Should Exist
    #android.widget.ImageView
    Wait Until Element Is Visible    //*[@class ='android.widget.ImageView' and @content-desc ='FlyVPN']    timeout=3s
    # Wait Until Element Is Visible    //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']    timeout=3s

Run Sending Template By For Circle
    Open LINE Add Friend Page
    Run Keyword If    ${errorType}==4    ID Is Not Public Or Not Correct Then Turn Back
    ...    ELSE IF    ${errorType}==0    ID Can Be Searched Then Continue To Work
    Run Keyword If    ${errorType}==${nextClientError}    Switch To Next Client By Refresh Browser
    ...       ELSE    Finish Order After Choose Sending Status

Login Oldman Magnage Interface
    Open Chrome
    Go To Url    https://oldman.tw/goadmin.php
    Switch To Context    NATIVE_APP
    Wait Until Element Is Visible    //*[@class='android.widget.EditText' and @password ='false']    timeout=30s    error=Password input should be visible.
    Input Text   //*[@class='android.widget.EditText' and @password ='false']    20160000
    Input Text    //*[@text='登入密碼']    20160000
    AppiumLibrary.Click Element    //*[@resource-id='submit']
    Wait Until Element Is Visible    xpath=//*[contains(@text, '解除鎖定')]    timeout=${slowNetPeriod}    error=Web should be login.

Choose Line Application
    Wait Until Element Is Visible    //*[@resource-id='com.huawei.android.internal.app:id/resolver_grid']//*[@class ='android.widget.LinearLayout' and @index ='0']    timeout=10s    error=First Line App should be visible.
    Run Keyword If    ${LineApplication}==1    Click Element    //*[@resource-id='com.huawei.android.internal.app:id/resolver_grid']//*[@class ='android.widget.LinearLayout' and @index ='0']
    ...    ELSE IF    ${LineApplication}==2    Click Element    //*[@resource-id='com.huawei.android.internal.app:id/resolver_grid']//*[@class ='android.widget.LinearLayout' and @index ='1']

Open LINE Add Friend Page
    ${id}    Get Text    //*[@text='訂單']/following-sibling::*
    Log To Console    ${id}
    Set Global Variable    ${purchaseID}    ${id}
    Click Element    //android.view.View[@content-desc="LINE開啟"]/android.widget.TextView
    # Choose Line Application
    ${correctID}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[@resource-id='jp.naver.line.android:id/addfriend_name']    timeout=10s    error=UserName should be visible.
    Run Keyword If    ${correctID}    Run Keywords    Hide Keyboard
    ...                                        AND    Get User Information
    ...                                        AND    Verify User Should Be A Friend
    ...       ELSE    Verify User Should Not Be Found

Verify User Should Not Be Found
    ${notFoundlabel} =     Run Keyword And Return Status   Wait Until Element Is Visible    //*[@class='android.widget.TextView' and contains(@text,'無法找到該用戶')]    timeout=5s    error=Not found label should be visible.
    Run Keyword If    ${notFoundlabel}    Run KeyWords    Search Correct ID
    ...                                            AND    Set Global Variable   ${errorType}    4
    ...       ELSE    Run Keywords    Set Global Variable    ${errorType}    ${nextClientError}
    ...                        AND    Close LINE To Go Back After Change The Name

Verify User Should Be A Friend
    ${buttonJoinOrNot} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='加入']    timeout=3s
    Run Keyword If    ${buttonJoinOrNot}    Run keywords   Click Add Friend Button
    ...                                              AND   Set Global Variable    ${alreadyFriend}    False
    ...       ELSE    Set Global Variable    ${alreadyFriend}    True

Search Correct ID
    ${correctID} =    Set Variable    schoolgrass433331
    Input Text After It Is Visible    //*[@resource-id='jp.naver.line.android:id/addfriend_by_userinfo_search_text']    ${correctID}
    Click Element After It Is Visible    //*[@resource-id='jp.naver.line.android:id/addfriend_by_userid_search_button_image']
    Wait Until Element Is Visible    xpath=//*[@resource-id='jp.naver.line.android:id/addfriend_name']

Change User Name To ID
    ${chatButton} =        Set Variable    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='聊天']
    ${backButton} =        Set Variable    //android.widget.LinearLayout[@content-desc="返回"]/android.widget.ImageView
    ${homePageButton} =    Set Variable    //*[@resource-id='jp.naver.line.android:id/bnb_button_text' and @text='主頁']
    ${searchBar} =         Set Variable    //*[@resource-id='jp.naver.line.android:id/main_tab_search_bar_hint_text']
    ${searchInput} =       Set Variable    //*[@resource-id='jp.naver.line.android:id/input_text']
    ${friendButton} =      Set Variable    //*[@class='android.widget.Button' and @text='好友']
    Click Element After It Is Visible    ${chatButton}    timeout=${slowNetPeriod}    error=Chat button should be visible.
    Click LINE Back Button After It is Visible    ${backButton}    timeout=${slowNetPeriod}    error=Back button should be visible.
    Click Element After It Is Visible    ${homePageButton}    timeout=${slowNetPeriod}    error=Home button should be visible.
    Click Element After It Is Visible    ${searchBar}    timeout=${slowNetPeriod}    error=Search bar should be visible.
    Input Text After It Is Visible    ${searchInput}    ${userName}    timeout=${slowNetPeriod}    error=Search input should be visible.
    Click Element After It Is Visible    ${friendButton}    timeout=${slowNetPeriod}    error=Friend button should be visible.
    ${count} =    Count User Number And Return Type
    Run Keyword If    ${count}>1    Select User By Name When Users
    ...    ELSE IF    ${count} == 1    Click Element    //*[@class='android.widget.ListView' and @index='1']/android.view.View
    Wait Until Element Is Visible     //*[@resource-id='jp.naver.line.android:id/user_profile_edit_name']    timeout=${slowNetPeriod}    error=Edit name button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/user_profile_edit_name']
    Wait Until Element Is Visible     //*[@resource-id='android:id/edit']    timeout=${slowNetPeriod}    error=User name bar button should be visible.
    Input Text    //*[@resource-id='android:id/edit']    ${userId}
    Wait Until Element Is Visible    //*[@resource-id='android:id/edit' and @text='${userId}']    timeout=${slowNetPeriod}    error=User name should be input.
    Click Element    //*[@resource-id='jp.naver.line.android:id/save_button']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/user_profile_name']    timeout=${slowNetPeriod}    error=User name should be edited.
    Write    ${userID}
    [Teardown]    Close LINE To Go Back After Change The Name

Click LINE Back Button After It is Visible
    [Arguments]    ${backButton}    ${timeout}=${slowNetPeriod}    ${error}=Back button should be visible.
    ${X} =    Wait Until Keyword Succeeds     5s    0.5s    Get Matching Xpath Count    ${backButton}
    Wait Until Page Contains Element    ${backButton}    timeout=${slowNetPeriod}    error=Back button should be exist.
    Wait Until Keyword Succeeds     5s    0.5s    Click Element    ${backButton}

Select User By Name When Users
    ${user} =    Set Variable    //*[@class='android.view.View' and @text='${userName}' and @index='0' and not(./following-sibling::*)]
    ${backButton} =    Set Variable    //android.widget.ImageButton[@content-desc="返回"]
    ${userNotShown} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${user}    timeout=10s    error=Friends searching list should be visible.
    ${reNameUsers} =    Run Keyword If    ${userNotShown}    Get Matching Xpath Count    ${user}
    Run Keyword If    ${reNameUsers}!=None and ${reNameUsers}>1    Fail    Users are repeated, please handle it.
    ...    ELSE IF    ${reNameUsers}==None    Run Keywords    Click LINE Back Button After It is Visible    ${backButton}
    ...                                                AND    Open Friend List On Home Page
    ...                                                AND    Select User By Name On Home Page
    ...    ELSE       Click Element    ${user}

Open Friend List On Home Page
    ${userIndex6} =    Set Variable    //*[@resource-id='jp.naver.line.android:id/bg' and @index='6']
    ${friendList} =    Set Variable    //*[@resource-id='jp.naver.line.android:id/home_tab_title_container' and .//*[contains(@text, '好友')]]
    ${isOpenFriendList} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    ${userIndex6}    timeout=1s    error=User with index 6 should be visible.
    Run Keyword If   not ${isOpenFriendList}    Click Element After It Is Visible    ${friendList}    timeout=5s    error=Friend list should be visible.
    Wait Until Element Is Visible On Page    ${userIndex6}    timeout=5s    error=User with index 10 should be visible after open friend list.

Select User By Name On Home Page
    ${user} =    Set variable    //*[@resource-id='jp.naver.line.android:id/name' and @text='${userName}']
    Swipe To Bottom Until User Is Visible    ${user}
    Click ELement   ${user}

Swipe To Bottom Until User Is Visible
    [Arguments]    ${user}
    FOR    ${index}    IN RANGE    9999
        ${findClient} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    ${user}    timeout=0.5s    error=User is not found when change name.
        Run Keyword If    ${findClient}    Run Keywords    Double Check Is Not Repeated Users    ${user}
        ...                                         AND    Return From Keyword    True
        ${isBottom} =    Is Swipe To Bottom    300    1200    300    500    1000
        Run Keyword If    ${isBottom}    Fail    message=Client should be found
    # ...        ELSE IF    not ${isNotBottom}    Fail    message=Client should be found
    END

Double Check Is Not Repeated Users
    [Arguments]    ${user}
    ${userNotShown}    Get Matching Xpath Count    ${user}
    Run Keyword If    ${userNotShown}>1    Fail    Users are repeated, please handle it.

Count User Number And Return Type
    Wait Until Page Contains Element    //*[@class='android.widget.ListView' and @index='1']/android.view.View   timeout=10s    error=Friend List View Should Be Visible.
    Wait Until Keyword Succeeds    5    500ms    User Friend List Is Empty
    ${count}    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='1']/android.view.View
    Log To Console    name=${count}
    [Return]    ${count}

User Friend List Is Empty
    ${count}    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='1']/android.view.View
    Run Keyword If    ${count}==0    Fail

Open Sticker Link
    Wait Until Element Is Visible   xpath=//*[@text= '開啟連結' and @index='0']     timeout=${slowNetPeriod}    error=Url open button should be visible.
    ${name} =    Get Text    //*[@class='android.view.View' and @index='8']//*[@class='android.view.View' and @index='1']
    Set Global Variable    ${stickerName}    ${name}
    Click Element    xpath=//*[@text= '開啟連結' and @index='0']
    # Choose Line Application

Send Gift By Select User With ID
    ${enable} =    Run Keyword And Return Status    Wait Until Element Is Visible   xpath=//*[contains(@text, '贈送禮物') and @enabled='true']     timeout=10s    error=Send gift button should be visible.
    ${disable} =    Run Keyword Unless    ${enable}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[contains(@text, '贈送禮物') and @enabled='false']    timeout=5s    error=Send gift button should be disable.
    Run Keyword Unless    ${enable}    Run Keywords    Run Keyword If    ${disable}    Set Global Variable    ${errorType}    3
    ...                                                          ELSE    Set Global Variable    ${errorType}    ${nextClientError}
    ...                                AND    Close LINE To Go Back After Change The Name
    ...                                AND    Return From Keyword
    Click Element    xpath=//*[contains(@text, '贈送禮物')]
    Input Text After Click    //*[@resource-id='jp.naver.line.android:id/searchbar_input_text']    ${userId}
    Click Element After It Is Visible    //*[@resource-id='jp.naver.line.android:id/widget_friend_row_name' and @text='${userId}']
    Wait Until Element Is Visible On Page    //*[@resource-id='jp.naver.line.android:id/widget_friend_row_name' and @content-desc='${userId}, 已選擇核取方塊']    timeout=${slowNetPeriod}    error=${userId} should be selected.
    # Run Keyword If    not (${searchClientNumber} == 1)    Swipe To Client
    Click Element    //*[@resource-id='jp.naver.line.android:id/header_button_text']
    ${sendSuccess}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']    timeout=10s
    Run Keyword If    ${sendSuccess}    Click OK Button To Send Gift To User
    ...       ELSE    Occur Error When Send Gift To User

Click OK Button To Send Gift To User
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']    timeout=${slowNetPeriod}    error=Purchase button should be visible.
    ${price} =    Get Text    //*[@resource-id='jp.naver.line.android:id/line_coin_price_text_view' and @index='1']
    Click Element    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']    timeout=${slowNetPeriod}    error=OK button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']
    #Go Back To Management Page From Chat Page
    ${sendSuccess}    Run Keyword And Return Status    Wait Until Page Contains Element    //*[@resource-id='jp.naver.line.android:id/chathistory_message_list']    timeout=60s    error=Message page should be visible after sending sticker success.
    ${secondSendSuccess} =    Run keyword If    not ${sendSuccess}    Run Keyword And Return Status    Occur Error After Click Purchase OK Button
    Run Keyword If    not ${secondSendSuccess} and not ${secondSendSuccess}==${None}    Run Keywords    Set Global Variable    ${errorType}    ${nextClientError}
    ...                                                    AND    Return From Keyword
    Log To Console    sticker = ${stickerName} price = ${price}
    ${area} =    Run Keyword If    ${foreign}    Set Variable    Foreign
    ...                    ELSE    Set Variable    Taiwan
    priceRecord    mycatPrice    ${area}    ${price}    ${userId}    ${stickerName}
    Write Coin Record    mycat    -${price}
    [Teardown]    Close LINE To Go Back After Change The Name

Occur Error After Click Purchase OK Button
    Run Keyword And Ignore Error    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='確定']    timeout=10s    error=Error button should be visible.
    Switch Network With VPN And Go Back To LINE
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']    timeout=${slowNetPeriod}    error=Purchase button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/present_purchase_button']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']    timeout=${slowNetPeriod}    error=OK button should be visible.
    Click Element    //*[@resource-id='jp.naver.line.android:id/common_dialog_ok_btn']
    Wait Until Page Contains Element    //*[@resource-id='jp.naver.line.android:id/chathistory_message_list']    timeout=60s    error=Message page should be visible after sending sticker success.

Switch Network With VPN And Go Back To LINE
    Switch Network With VPN    ${globalCountry}
    Press Keycode    ${appSwitchKey}
    Click Element After It Is Visible    //*[@resource-id='com.android.systemui:id/title' and @text='LINE']    timeout=5s    error=LINE app should be visible on switch app page.

Press Keycode To Go Back
    Press Keycode    ${backKey}

ID Can Be Searched Then Continue To Work
    If Name Is Not Equal To ID Change Name To ID
    Switch VPN If Is Sending Foreign Sticker
    Open Sticker Link
    Send Gift By Select User With ID

ID Is Not Public Or Not Correct Then Turn Back
    Press Back Key Until Back To Sending Page
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
    # ${X} =    Get Matching Xpath Count    //android.widget.LinearLayout[@content-desc="返回"]/android.widget.ImageView
    # Wait Until Element Is Visible On Page    //android.widget.LinearLayout[@content-desc="返回"]/android.widget.ImageView    timeout=${slowNetPeriod}    error=Back button should be visible.
    # Press Keycode To Go Back
    # Wait Until Element Is Visible On Page    //*[@resource-id='jp.naver.line.android:id/bnb_button_text' and @text='主頁']    timeout=${slowNetPeriod}    error=1
    # Press Keycode To Go Back
    # ${waitFinishButton} =    Run Keyword And Return Status    Fix Go Back Error
    # Run Keyword Unless    ${waitFinishButton}
    # ...    Run Keywords    Wait Until Element Is Visible On Page    //android.widget.LinearLayout[@content-desc="返回"]/android.widget.ImageView    timeout=${slowNetPeriod}    error=2
    # ...             AND    Press Keycode To Go Back

Press Back Key Until Back To Sending Page
    FOR     ${i}    IN RANGE    5
         Press Keycode    ${backKey}
         ${result} =    Run Keyword And Return Status    Verify If Back To Sending Page    //*[@text='訂單']/following-sibling::*
         Exit For Loop If    ${result}
    END

Fix Go Back Error
    Wait Until Element Is Visible    xpath=//*[@text= '送 出' ]    timeout=${slowNetPeriod}    error=Finish button should be visible.

Finish Order After Choose Sending Status
    Run Keyword IF   not ${errorType}==0    Select Error Message
    Run Keyword If   ${errorType}==0 or ${errorType}==4    Wait Until Element Is Visible    xpath=//*[@text= '送 出' ]    timeout=${slowNetPeriod}    error=Dialog "確定" button should be visible.
    Click Element    //*[@text= '送 出']
    Wait Until Element Is Visible    //*[not(@text='${purchaseID}')]    timeout=${slowNetPeriod}    error='${purchaseID}' should not be visible.
    Log Sending Status To Console    ${errorType}
    Set Global Variable    ${errorType}    0

Switch To Next Client By Refresh Browser
    Wait Until Element Is Visible    //*[@text='訂單']/following-sibling::*    timeout=5s    error=Switch to next client's page should be visible
    Swipe    300    300    300    900    500
    Set Global Variable    ${errorType}    0

Select Error Message
    Wait Until Element Is Visible    //*[@resource-id='SendStatus']
    Click Element    //*[@resource-id='SendStatus']
    Wait Until Element Is Visible    //*[@resource-id='android:id/text1' and @index='${errorType}']
    Click Element    //*[@resource-id='android:id/text1' and @index='${errorType}']

Verify User Name Should Be Equal To ID
    Should Be Equal As Strings    ${userName}    ${userId}

If Name Is Not Equal To ID Change Name To ID
    ${equalTo}    Run Keyword And Return Status    Verify User Name Should Be Equal To ID
    Run Keyword If    not(${equalTo})    Change User Name To Id
    ...       ELSE    Press Back Key Until Back To Sending Page
    # ${searchName} =    Search    ${userName}
    # Set Global Variable    ${search}    ${searchName}
    # Run Keyword if    ${search} and (not ${equalTo}) and (not ${alreadyFriend})    Run keyword    Change User Name To Id
    # ...       ELSE    Run Keywords    Run keyword if    not ${equalTo} and not ${alreadyFriend}    Write    ${userName}    #已發過再發一次會加入
    # ...                        AND    Press Back Key Until Back To Sending Page

Close LINE To Go Back After Change The Name
    # Press Keycode    ${appSwitchKey}
    # sleep    1s    #fix me
    # Swipe    900    1500    900    468    500
    # sleep    1s
    # Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']

    Press Keycode    ${appSwitchKey}
    sleep    1s    #fix me
    Swipe    188    700    400    700    500
    sleep    1s
    Click Element    //*[@resource-id='com.android.systemui:id/title' and @text='Chrome']

Switch App To Chrome
    # Press Keycode    ${appSwitchKey}
    # Switch To Context    NATIVE_APP
    # # Wait Until Page Contains Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*    timeout=${slowNetPeriod}    error=
    # # Click Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*
    # Wait Until Element Is Visible    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']    timeout=${slowNetPeriod}    error=
    # Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']

    Press Keycode    ${appSwitchKey}
    # Wait Until Page Contains Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*    timeout=${slowNetPeriod}    error=
    # Click Element    //*[@resource-id='com.sec.android.app.launcher:id/icon']/preceding-sibling::*
    Wait Until Element Is Visible    //*[@resource-id='com.android.systemui:id/title' and @text='Chrome']    timeout=${slowNetPeriod}    error=
    Click Element    //*[@resource-id='com.android.systemui:id/title' and @text='Chrome']

Input Text After Click
    [Arguments]    ${xpath}    ${text}
    Wait Until Page Contains Element    ${xpath}    timeout=${slowNetPeriod}    error=Input text should be visible.
    Click Element    ${xpath}
    Wait Until Page Contains Element    ${xpath}
    Input Text    ${xpath}    ${text}

Unlock Permission
    Wait Until Page Contains Element    xpath=//*[contains(@text, '解除鎖定')]    timeout=${slowNetPeriod}    error=Password input should be visible.
    AppiumLibrary.Click Element    xpath=//*[contains(@text, '解除鎖定')]
    AppiumLibrary.Click Element    xpath=//*[contains(@text, '解除處理中')]

Open Chrome
    [Documentation]    Opens the calculator app with a new appium session.
    Open Application    http://localhost:4724/wd/hub    platformName=Android    platformVersion=8.1.0    alias=MyChrome1
    ...    deviceName=${redmiDeviceName2}    noReset=true    browserName=Chrome    automationName=uiautomator2
    # ${app2} =    Open Application    http://localhost:4725/wd/hub    platformName=Android    platformVersion=8.1.0    alias=MyChrome2
    # ...    deviceName=${redmiDeviceName}    noReset=true    browserName=Chrome    automationName=uiautomator2
    # appPackage=com.android.chrome     appActivity=com.google.android.apps.chrome.Main

Get Processing Sticker
    ${X} =    Get Matching Xpath Count    //*[@class='android.widget.ListView' and @index='15']//*[@class='android.view.View' and @index='7']//*[@class='android.widget.TextView']
    Wait Until Page Contains Element    //*[@class='android.widget.ListView' and @index='15']//*[@class='android.view.View' and @index='7']//*[@class='android.widget.TextView']    timeout=${slowNetPeriod}    error=Taiwanese sticker should be visible.
    ${processing} =    Wait Until Keyword Succeeds     5s    0.5s    Get Text    //*[@class='android.widget.ListView' and @index='15']//*[@class='android.view.View' and @index='7']//*[@class='android.widget.TextView']
    Run keyword if    ${processing}!=0    Refresh Management Page After Unlock Permission
    # Wait Until Element Is Visible On Page    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']    timeout=${slowNetPeriod}    error=Taiwanese sticker should be visible.
    # ${num}    Get Text    //*[@class='android.widget.ListView' and @index='13']//*[@class='android.view.View' and @index='1']
    # Set Global Variable    ${taiwanNum}    ${num}

Get User Information
    ${name} =    Get Text    xpath=//*[@resource-id='jp.naver.line.android:id/addfriend_name']
    Set Global Variable    ${userName}    ${name}
    ${id} =    Get Text    xpath=//*[@class='android.widget.EditText']
    Set Global Variable    ${userId}    ${id}
    Log To Console    name:${name} id:${id}

Wait Until Element Is Visible On Page
    [Arguments]    ${locator}    ${timeout}    ${error}=default
    Wait Until Page Contains Element    ${locator}    ${timeout}    ${error}
    Wait Until Element Is Visible    ${locator}    ${timeout}    ${error}

Input Text After It Is Visible
    [Arguments]    ${elementPath}    ${text}    ${timeout}=5s    ${error}=Element should be visible before input text.
    Wait Until Element Is Visible    ${elementPath}   timeout=${timeout}    error=${error}
    Input Text    ${elementPath}    ${text}

Click Add Friend Button
    Click Element    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='加入']
    Wait Until Element Is Visible    //*[@resource-id='jp.naver.line.android:id/addfriend_add_button' and @text='聊天']    timeout=${slowNetPeriod}    error=Chat button should be visible.

Delete All User By Open LINE
    ${AppExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=(//*[@class ='android.widget.TextView' and @text ='LINE'])[2]
    Run Keyword Unless    ${AppExist}    Swipe    400    300    100    300    500
    Click Element    xpath=(//*[@class ='android.widget.TextView' and @text ='LINE'])[2]
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
        &{location} =    Get Location    //*[@resource-id='com.android.systemui:id/title']
        Swipe    ${location.x}    ${location.y}    719    ${location.y}    200
    END

Close All Application And Back To Home
    Open VPN App
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    # Press Keycode    ${appSwitchKey}
    # FOR    ${num}    IN RANGE    9999
        # ${applicationExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='com.huawei.android.launcher:id/snapshot']    timeout=3s    error=
        # Exit For Loop if    not ${applicationExist}
        # Swipe    324    1500    324    468    500
    # END
    # # Delete All User By Open LINE
    # Press Keycode    ${homeKey}
    # Press Keycode    26
    # Close All Applications
    # sleep    1s
    Press Keycode    ${appSwitchKey}
    FOR    ${num}    IN RANGE    9999
        ${applicationExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@resource-id='com.android.systemui:id/title']    timeout=5s    error=
        Exit For Loop if    not ${applicationExist}
        &{location} =    Get Location    //*[@resource-id='com.android.systemui:id/title']
        Swipe    ${location.x}    ${location.y}    719    ${location.y}    200
    END
    Press Keycode    ${homeKey}
    Press Keycode    26
    Close All Applications
    # sleep    1s

Click Element After It Is Visible
    [Arguments]    ${elementPath}    ${timeout}=5s    ${error}=Button should be visible.
    Wait Until Element Is Visible    ${elementPath}    timeout=${slowNetPeriod}    error=Clear application button should be visible.
    Click Element    ${elementPath}

Open Taiwan Stciker Sending Page
    Click Element    xpath=//*[contains(@text, '鎖定發圖資料')]
    Wait Until Element Is Visible    xpath=//*[contains(@text, '新版發圖')]    timeout=${slowNetPeriod}    error=Taiwan Sticker button should be visible.
    Click Element    xpath=//*[contains(@text, '新版發圖')] 
    Set Global Variable    ${foreign}    False

Open Foreign Stciker Sending Page
    Click Element    xpath=//*[contains(@text, '鎖定發圖資料')]
    Wait Until Element Is Visible    xpath=//*[contains(@text, '跨區貼圖')]    timeout=${slowNetPeriod}    error=Foreign Sticker button should be visible.
    Click Element    xpath=//*[contains(@text, '跨區貼圖')] 
    Set Global Variable    ${foreign}    True

Open Foreign Topic Sending Page
    Click Element    xpath=//*[contains(@text, '鎖定發圖資料')]
    Wait Until Element Is Visible    //android.view.View[@content-desc="跨區主題"]/android.widget.TextView    timeout=${slowNetPeriod}    error=Foreign Topic button should be visible.
    Click Element    //android.view.View[@content-desc="跨區主題"]/android.widget.TextView
    Set Global Variable    ${foreign}    True

Refresh Management Page After Unlock Permission
    Unlock Permission
    sleep    3s
    Swipe    300    300    300    900    500
    Wait Until Element Is Visible    //*[@class='android.widget.ListView' and @index='15']//*[@class='android.view.View' and @index='7']//*[@class='android.widget.TextView' and @text='0']    timeout=${slowNetPeriod}

Verify If Back To Sending Page
    [Arguments]    ${waitObject}
    Wait Until Element Is Visible    ${waitObject}    timeout=${slowNetPeriod}

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