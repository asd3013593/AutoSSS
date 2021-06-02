*** Settings ***
Library    XML
Library    AppiumLibrary
Library    OperatingSystem
Library    netify
Suite Setup    Switch To Turkey VPN
Suite Teardown    Close All Applications

*** Variables ***
${device} =    127.0.0.1:62025
${hauweiDeviceName} =    2DR4C19227004310
${slowNetPeriod} =    5s
${homeKey} =    3
${enterKey} =    66
${appSwitchKey} =    187
${vpnIni} =    0
${password} =    Netify000
@{country} =    伊斯坦布爾 #10    伊斯坦布爾 #16    伊斯坦布爾 #2    伊斯坦布爾 #3    伊斯坦布爾 #4    伊斯坦布爾 #5

*** Test Cases ***
test vpn
    [Setup]    Run Keywords    Press Keycode    ${homeKey}
    ...                 AND    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    ${temp} =    Set Variable    0ㄐ
    # @{account} =    Get Account With Amount    mycat    9
    FOR    ${i}    IN    @{account}
        Log To Console    \n${i}[key] 執行中
        112
        113    ${i}[key]
        ${temp} =    Evaluate    (${temp}+1) % 5
        Run KeyWord If    ${temp}==0    Switch VPN To Other Turkey Server
        # delete account to new state    ${i}    未註冊    已註冊    mycat    Netify000
    END
    Close All Applications
    # Log To Console    ${accoount}
    # Post
    # 115
    # Delete Account With Key    " asd"    netifyasy
test
    [Setup]    Run Keywords    Press Keycode    ${homeKey}
    ...                 AND    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    112
    ${c} =    Get Contexts
    Log To Console    ${c}
    Switch To Context    CHROMIUM
    ${url} =    execute script  return window.top.location.href.toString()
    # ${a} =    Wait Until Page Loading
    Log To Console    ${url}
    Close All Applications
    # Log To Console    123

Change Password
    @{account} =    Get Account With Amount    已註冊    mycat    5
    FOR    ${i}    IN    @{account}
        Go To Netifx
        Sign In Exist Account
        Verify If Account Password Be Changed    ${i}[key]    ${i}[value]
    END

test1
    ${account} =    Set Variable    netifyauf
    FOR    ${i}    IN    ${account}
        delete account to new state    ${i}    未註冊    已註冊    mycat   Netify000
    END

test2
    ${temp} =    Set Variable    0
    FOR    ${i}    IN RANGE    9
        Log To Console    \n完成
        # 112
        # 113    ${i}[key]
        ${temp} =    Evaluate    (${temp}+1) % 5
        Run KeyWord If    ${temp}==0   Log To Console    更換    
        # delete account to new state    ${i}    未註冊    已註冊    mycat    Netify000
    END
*** Keywords ***
# Verify If Need To Switch VPN
    

Sign In Exist Account
    Sign In Netflix Account    netifyasy@mycat.tw    Netify000
    # ${signIn} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[@class='android.widget.TextView' and @text='Sign Out']    timeout=30s
    ${signIn} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[contains(@text, 'Please try again')]    timeout=15s
    Run KeyWord If    ${signIn}    Run Keywords    Switch VPN To Other Turkey Server
    ...                                         AND    Click Element After It Is Visible    //android.view.View[@content-desc="Netflix"]/android.widget.Image
    ...                                         AND    Sign In Exist Account
    ...       ELSE    Run Keywords    Wait Until Page Loading
    ...                        AND    Click Element After It Is Visible    //*[@class='android.widget.TextView' and @text='Sign Out']

Switch VPN To Other Turkey Server
    ${next} =    Evaluate    (${vpnIni}+1) % 5
    Set Global Variable    ${vpnIni}    ${next}
    Swith VPN With Server   ${country}[${vpnIni}]
    Press Keycode    ${homeKey}
    Click Element After It Is Visible     //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    # Press Keycode    ${appSwitchKey}
    # sleep    1s    #fix me
    # Click Element    //*[@class='android.widget.FrameLayout' and @content-desc='Chrome']

102
    Press Keycode    ${homeKey}
    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Firefox']
    Click Element After It Is Visible    //*[@resource-id='org.mozilla.firefox:id/toolbar']
    Input Text After It Is Visible    //*[@resource-id='org.mozilla.firefox:id/mozac_browser_toolbar_edit_url_view']    https://www.netflix.com/
    Press Keycode    ${enterKey}
    Wait Until Element Is Visible On Page    //*[@resource-id='com.android.chrome:id/infobar_icon']    timeout=15s

103
    Wait Until Element Is Visible On Page    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Input Text After It Is Visible    //*[@resource-id='id_email_hero_fuji']    netifyasx@mycat.tw
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='Get Started']
    Wait Until Element Is Visible On Page    //*[@class='android.widget.Button' and @text='Continue']    timeout=30s

112
    
    Click Element After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']
    Input Text After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']    https://www.netflix.com/
    Press Keycode    ${enterKey}
    Wait Until Page Contains Element    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Wait Until Page Loading
    Log To Console    finish
    # Wait Until Element Is Visible On Page    //*[@resource-id='com.android.chrome:id/infobar_icon']    timeout=100s
    # sleep    2s
    # ${sign} =    Run Keyword And Return Status    Wait Until Page Contains Element    //*[@content-desc='Sign Out']
    # Run Keyword If    ${sign}    Run Keywords    Click Element After It Is Visible    //*[@content-desc='Sign Out']
    # ...                                   AND    Click Element After It Is Visible    //android.view.View[@content-desc="Netflix"]/android.widget.Image
    # ...                                   AND    Wait Until Element Is Visible On Page    //*[@resource-id='com.android.chrome:id/infobar_icon']    timeout=100s

113
    [Arguments]    ${account}
    Wait Until Element Is Visible On Page    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Input Text After It Is Visible    //*[@resource-id='id_email_hero_fuji']    ${account}
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='Get Started']
    # Wait Until Page Contains Element    //*[@class='android.view.View' and @text='Get Started']    timeout=15s
    # Wait Until Element Is Visible On Page    //*[@resource-id='com.android.chrome:id/infobar_icon']    timeout=100s
    # sleep    10s
    Wait Until Element Is Visible On Page    //*[@class='android.widget.Button' and @text='Continue']    timeout=100s
    Wait Until Page Loading
    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Continue']
    Input Text After It Is Visible    //*[@class='android.widget.EditText' and @resource-id='id_password']    Netify000
    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Continue']
    Wait Until Element Is Visible On Page    //*[@text='STEP 2 OF 3 Choose your plan.']    timeout=100s
    Wait Until Page Loading
    ${account} =    Evaluate    """${account}""".replace("@mycat.tw","")
    delete account to new state    ${account}    未註冊    已註冊    mycat    Netify000
    Click Element After It Is Visible    //*[@class='android.widget.TextView' and @text='Sign Out']
    Wait Until Element Is Visible On Page    //*[@text='Sign In']    timeout=100s
    # Input Text After It Is Visible    //*[@resource-id='forgot_password_input']    netifyasx@mycat.tw
    # Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Email Me']
    # Wait Until Element Is Visible On Page    //*[@text='Email Sent']    timeout=${slowNetPeriod}

Verify If Account Password Be Changed
    [Arguments]    ${account}    ${password}
    Sign In Netflix Account    ${account}    ${password}
    ${account2} =    Evaluate    """${account}""".replace("@mycat.tw","")
    ${a1} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[contains(@text, 'Please try again')]    timeout=15s
    Run Keyword If    ${a1}    Run Keywords    Click Element After It Is Visible    //android.view.View[@content-desc="Netflix"]/android.widget.Image
    ...                                 AND    Wait Until Page Contains Element    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    ...                                 AND    Wait Until Page Loading
    ...                                 AND    114    ${account}
    ...                                 AND    114    ${account}
    ...                                 AND    114    ${account}
    ...                                 AND    delete account to new state    ${account2}    已註冊    已寄出    mycat    ${password}

Sign In Netflix Account
    [Arguments]    ${account}    ${password}
    Wait Until Page Contains Element    //*[@class='android.widget.TextView' and @text='Sign In']    timeout=30s
    Wait Until Page Loading
    Click Element After It Is Visible    //*[@class='android.widget.TextView' and @text='Sign In']
    Wait Until Page Contains Element    //*[@class='android.view.View' and @text='Sign In']    timeout=30s
    Wait Until Page Loading
    Click Element After It Is Visible    //*[@class='android.widget.EditText' and @resource-id='id_userLoginId']
    Input Text After It Is Visible    //*[@class='android.widget.EditText' and @resource-id='id_userLoginId']    ${account}
    Click Element After It Is Visible    //*[@resource-id='bxid_rememberMe_true']
    Click Element After It Is Visible    //*[@class='android.widget.EditText' and @resource-id='id_password']
    Input Text After It Is Visible    //*[@class='android.widget.EditText' and @resource-id='id_password']    ${password}
    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Sign In']

delete account to new state
    [Arguments]    ${account}    ${fState}    ${eState}    ${name}    ${password}
    Log To Console    將帳號'${account}'從'${fState}${name}'刪除，並新增至'${eState}${name}'
    Delete Account With Key    ${fState}    ${name}    ${account}
    Update Account To New State    ${eState}    ${name}    ${account}    ${password}

Go To Netifx
    Press Keycode    ${homeKey}
    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    Click Element After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']
    Input Text After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']    https://www.netflix.com/
    Press Keycode    ${enterKey}
    Wait Until Page Contains Element    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Wait Until Page Loading

114
    [Arguments]    ${account}
    Input Text After It Is Visible    //*[@resource-id='id_email_hero_fuji']    ${account}
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='Get Started']
    ${forgot}=    Run Keyword And Return Status   Wait Until Page Contains Element    //*[@class ='android.widget.TextView' and @text ='Forgot your password?']    timeout=30s
    If Not Visible Switch VPN And Refresh Browser    ${forgot}    ${account}
    Wait Until Page Loading
    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @text ='Forgot your password?']
    Wait Until Page Contains Element    //*[@class ='android.view.View' and @text ='Forgot Email/Password']    timeout=30s
    Wait Until Page Loading
    Click Element After It Is Visible    //*[@resource-id='forgot_password_input']
    Input Text After It Is Visible    //*[@resource-id='forgot_password_input']    ${account}
    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Email Me']
    ${send}=    Run Keyword And Return Status    Wait Until Page Contains Element    //*[@class='android.view.View' and @text='Email Sent']    timeout=30s
    If Not Visible Switch VPN And Refresh Browser    ${send}    ${account}
    Wait Until Page Loading
    Click Element After It Is Visible    //android.view.View[@content-desc="Netflix"]/android.widget.Image
    Wait Until Page Contains Element    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Wait Until Page Loading

115
    Press Keycode    ${homeKey}
    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']    #FIXME
    Click Element After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']
    Input Text After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']    https://mail.mycat.tw/
    Press Keycode    ${enterKey}
    Input Text After It Is Visible    //*[@resource-id='login-name']    netifyasx@mycat.tw
    Input Text After It Is Visible    //*[@resource-id='login-pass']    Netify@99
    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='登入']
    Wait Until Element Is Visible On Page    //*[@class ='android.widget.TextView' and @text='Complete your password reset request']    timeout=${slowNetPeriod}
    Click Element After It Is Visible    //*[@class ='android.widget.TextView' and @text='Complete your password reset request']
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='RESET PASSWORD']
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='New password (4-60 characters)']
    Input Text After It Is Visible    //*[@resource-id='id_newPassword']    Netify123    #FIXME要改隨機
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='Confirm new password']
    Input Text After It Is Visible    //*[@resource-id='id_confirmNewPassword']    Netify123
    Click Element After It Is Visible    //*[@resource-id='btn-save']
    Wait Until Element Is Visible On Page    //*[@text='Your password has been changed.']    timeout=${slowNetPeriod}
    # Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']

Switch To Turkey VPN
    Open Application    http://localhost:4725/wd/hub    platformName=Android    platformVersion=5.1.1    alias=MyChrome1
    ...    deviceName=${device}    noReset=true    browserName=Chrome    automationName=uiautomator2
    Go To Url    https://oldman.tw/goadmin.php
    Switch To Context    NATIVE_APP
    Swith VPN With Server    ${country}[${vpnIni}]
    # Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']
    # ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    # Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    # Click Element    //*[contains(@text, '當前伺服器：') or contains(@text, '當前線路：')]
    # Click Element After It Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/search_button' or @resource-id='com.fvcorp.flyclient:id/layoutSearch']    timeout=${slowNetPeriod}    error=Serach should be visible.
    # Input Text After It Is Visible    //*[@resource-id='com.fvcorp.flyclient:id/textSearchKeyword']    ${country}[4]
    # Click Element After It Is Visible    //*[@resource-id='com.fvcorp.flyclient:id/textServerRowTitle']    timeout=${slowNetPeriod}    error=Country should be visible.
    # ${successConnect} =     Run Keyword And Return Status    Connect Button Should Connect

Swith VPN With Server
    [Arguments]    ${server}
    Press Keycode    ${homeKey}
    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']
    # ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    # Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    # Click Element After It Is Visible   //*[contains(@text, '當前伺服器：')]
    # Click Element After It Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/search_button']    timeout=${slowNetPeriod}    error=Serach should be visible.
    # Input Text    com.fvcorp.flyclient:id/search_src_text    ${server}
    # Click Element After It Is Visible    //*[@resource-id='com.fvcorp.flyclient:id/textServerRowTitle']    timeout=${slowNetPeriod}    error=Country should be visible.
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    Click Element    //*[contains(@text, '當前伺服器：') or contains(@text, '當前線路：')]
    Click Element After It Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/search_button' or @resource-id='com.fvcorp.flyclient:id/layoutSearch']    timeout=${slowNetPeriod}    error=Serach should be visible.
    Input Text After It Is Visible   //*[@resource-id='com.fvcorp.flyclient:id/textSearchKeyword']    ${server}
    Click Element After It Is Visible    //*[@resource-id='com.fvcorp.flyclient:id/textServerRowTitle']    timeout=${slowNetPeriod}    error=Country should be visible.
    Connect Button Should Connect

Connect Button Should Connect
    Wait Until Element Is Visible    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']    timeout=15s

Click Element After It Is Visible
    [Arguments]    ${elementPath}    ${timeout}=${slowNetPeriod}    ${error}=Element should be visible before click.
    AppiumLibrary.Wait Until Element Is Visible    ${elementPath}    timeout=${timeout}    error=${error}
    AppiumLibrary.Click Element    ${elementPath}

Wait Until Element Is Visible On Page
    [Arguments]    ${locator}    ${timeout}    ${error}=default
    AppiumLibrary.Wait Until Page Contains Element    ${locator}    ${timeout}    ${error}
    AppiumLibrary.Wait Until Element Is Visible    ${locator}    ${timeout}    ${error}

Input Text After It Is Visible
    [Arguments]    ${elementPath}    ${text}    ${timeout}=5s    ${error}=Element should be visible before input text.
    Wait Until Element Is Visible    ${elementPath}   timeout=${timeout}    error=${error}
    Input Text    ${elementPath}    ${text}

Open VPN App
    Press Keycode    ${homeKey}
    Click Element After It Is Visible    //*[@content-desc ='FlyVPN']

Close All Application And Back To Home
    Open VPN App
    ${connectButton} =    Run Keyword And Return Status    Connect Button Should Connect
    Run Keyword If    ${connectButton}    Click Element    //*[@resource-id ='com.fvcorp.flyclient:id/imageButtonConnected']
    Press Keycode    ${appSwitchKey}
    FOR    ${num}    IN RANGE    9999
        ${applicationExist} =    Run Keyword And Return Status    Wait Until Page Contains Element    //*[@resource-id ='com.android.systemui:id/task_view_content']    timeout=5s    error=
        Exit For Loop if    not ${applicationExist}
        ${close} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[contains(@content-desc,'關閉')]
        Run Keyword If    ${close}    Click Element    xpath=(//*[contains(@content-desc,'關閉')])[1]
    END
    # Delete All User By Open LINE
    Press Keycode    ${homeKey}
    # Press Keycode    26
    Close All Applications
    sleep    1s

If Not Visible Switch VPN And Refresh Browser
    [Arguments]    ${boolean}    ${account}
    ${a1} =    Run Keyword If    not ${boolean}    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[contains(@text, 'Please try again')]    timeout=15s
    Run Keyword If    not ${boolean}    Run Keywords    Switch VPN To Other Turkey Server
    Run Keyword If    not ${boolean} and not ${a1}   Run Keywords    Swipe    300    300    300    900    500
    ...                                                       AND    Go To Netifx
    ...                                                       AND    114    ${account}