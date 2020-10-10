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
Restore Mycat LINE
    Open Chrome
    Delete All User By Open LINE
    [Teardown]    Close All Application And Back To Home

*** Keywords ***
Open Chrome
    [Documentation]    Opens the calculator app with a new appium session.
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=9    alias=MyChrome1
    ...    deviceName=${hauweiDeviceName}    noReset=true    browserName=Chrome    automationName=uiautomator2
    Go To Url    https://mycat.tw/goadmin.php
    Switch To Context    NATIVE_APP
    Wait Until Element Is Visible    //*[@class='android.widget.EditText' and @password ='false']    timeout=30s    error=Password input should be visible.
    Input Text   //*[@class='android.widget.EditText' and @password ='false']    20140002
    Input Text    //*[@text='登入密碼']    20140002
    AppiumLibrary.Click Element    //*[@resource-id='submit']
    # ${app2} =    Open Application    http://localhost:4725/wd/hub    platformName=Android    platformVersion=8.1.0    alias=MyChrome2
    # ...    deviceName=${redmiDeviceName}    noReset=true    browserName=Chrome    automationName=uiautomator2
    # appPackage=com.android.chrome     appActivity=com.google.android.apps.chrome.Main

Delete All User By Open LINE
    Press Keycode    ${homeKey}
    ${AppExist} =    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=(//*[@class ='android.widget.TextView' and @text ='LINE'])[2]
    Run Keyword Unless    ${AppExist}    Swipe    400    300    100    300    500
    Click Element    xpath=(//*[@class ='android.widget.TextView' and @text ='LINE'])[2]
    Wait Until Page Contains Element    //*[@resource-id='jp.naver.line.android:id/home_tab_title_name' and @class='android.widget.TextView' and contains(@text, '好友')]
    Sleep    2s
    Click Element    //*[@resource-id='jp.naver.line.android:id/home_tab_title_name' and @class='android.widget.TextView' and contains(@text, '好友')]
    Wait Until Element Is Visible    xpath=(//*[@class='android.view.ViewGroup' and @resource-id='jp.naver.line.android:id/bg']//*[@resource-id='jp.naver.line.android:id/name'])[1]    timeout=10s
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