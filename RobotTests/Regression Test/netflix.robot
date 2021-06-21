*** Settings ***
Library    XML
Library    AppiumLibrary
Library    OperatingSystem
Library    netify
Suite Setup    Switch To Turkey VPN
Suite Teardown    Close All Applications

*** Variables ***
${device} =    127.0.0.1:62001
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
    ${temp} =    Set Variable    0
    @{account} =    Get Account With Amount    未註冊    lure    11
    FOR    ${i}    IN    @{account}
        Register Netflix Account    ${i}[key]    ${temp}
    END
    # [Teardown]    Close All Applications

# test
    # [Setup]    Run Keywords    Press Keycode    ${homeKey}
    # ...                 AND    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    # 112
    # ${c} =    Get Contexts
    # Log To Console    ${c}
    # Switch To Context    CHROMIUM
    # ${url} =    execute script  return window.top.location.href.toString()
    # # ${a} =    Wait Until Page Loading
    # Log To Console    ${url}
    # Close All Applications
    # # Log To Console    123

Post Change Password
    [Setup]    Open Browser And Go To Netflix
    @{account} =    Get Account With Amount    已註冊    twnetify    7
    ${temp} =    Set Variable    0
    FOR    ${i}    IN    @{account}
        # Sign In Exist Account
        Run Keyword If    ${temp}==0    Switch VPN To Other Turkey Server
        Verify If Account Password Be Changed    ${i}[key]    ${i}[value]
        ${temp} =    Evaluate    (${temp}+1)%5
    END

add
    @{account} =    Set Variable
    ...    netifyact
    ...    netifyacu
    ...    netifyacv
    FOR    ${i}    IN    @{account}
        # Delete Account With Key    已寄出    mycat    ${i}
        Update Account To New State    已註冊    twnetify    ${i}    Netify000
        # delete account to new state    已寄出    已註冊    lure    ${i}    Netify000
    END
    # @{account} =    Get Account With Amount    已註冊    lure    9
    # Log To Console    ${account}

*** Keywords ***
Register Netflix Account
    [Arguments]    ${account}    ${temp}
    Log To Console    \n${account} 執行中
    Go To Netflix
    Register Account    ${account}
    ${temp1} =    Evaluate    (${temp}+1) % 5
    Set Global Variable    ${temp}    ${temp1}
    Run KeyWord If    ${temp}==0    Switch VPN To Other Turkey Server

Sign In Exist Account
    Sign In Netflix Account    netifyasy@mycat.tw    Netify000
    # ${signIn} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[@class='android.widget.TextView' and @text='Sign Out']    timeout=30s
    ${signIn} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[contains(@text, 'Please try again')]    timeout=7s
    Run KeyWord If    ${signIn}    Run Keywords    Switch VPN To Other Turkey Server
    ...                                         AND    Click Element After It Is Visible    //android.view.View[@content-desc="Netflix"]/android.widget.Image
    ...                                         AND    Sign In Exist Account
    ...       ELSE    Run Keywords    Wait Until Page Loading
    ...                        AND    Swipe    300    300    300    900    500
    ...                        AND    Sleep    1s
    ...                        AND    Wait Until Element Is Visible On Page    //*[@class='android.widget.TextView' and @text='Sign Out']    timeout=10s
    ...                        AND    Wait Until Page Loading
    ...                        AND    Click Element After It Is Visible    //*[@class='android.widget.TextView' and @text='Sign Out']

Switch VPN To Other Turkey Server
    ${next} =    Evaluate    (${vpnIni}+1) % 5
    Set Global Variable    ${vpnIni}    ${next}
    Swith VPN With Server   ${country}[${vpnIni}]
    Press Keycode    ${homeKey}
    Click Element After It Is Visible     //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    Wait Until Page Does Not Contain    //*[@class ='android.widget.TextView' and @content-desc ='FlyVPN']    timeout=3s
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

Go To Netflix
    Click Element After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']
    Input Text After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']    https://www.netflix.com/
    Press Keycode    ${enterKey}
    Wait Until Page Contains Element    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Wait Until Page Loading

Register Account
    [Arguments]    ${account}
    Wait Until Element Is Visible On Page    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Input Text After It Is Visible    //*[@resource-id='id_email_hero_fuji']    ${account}
    Click Element After It Is Visible    //*[@class='android.view.View' and @text='Get Started']
    Wait Until Element Is Visible On Page    //*[@class='android.widget.Button' and @text='Continue']    timeout=100s
    Wait Until Page Loading
    ${field} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    //*[@class='android.widget.EditText' and @resource-id='id_password']    timeout=5s
    Run Keyword If    not ${field}    Run Keywords    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Continue']
    ...                                        AND    Wait Until Page Loading
    Input Text After It Is Visible    //*[@class='android.widget.EditText' and @resource-id='id_password']    Netify000
    Click Element After It Is Visible    //*[@class='android.widget.Button' and @text='Continue']
    Wait Until Element Is Visible On Page    //*[contains(@text, 'STEP 2 OF 3')]    timeout=100s
    Wait Until Page Loading
    ${account} =    Evaluate    """${account}""".replace("@lure.tw","")
    delete account to new state    ${account}    未註冊    已註冊    lure    Netify000
    Click Element After It Is Visible    //*[@class='android.widget.TextView' and @text='Sign Out']
    Wait Until Element Is Visible On Page    //*[contains(@text, 'Sign In')]    timeout=100s

Verify If Account Password Be Changed
    [Arguments]    ${account}    ${password}
    ${account2} =    Evaluate    """${account}""".replace("@twnetify.com", "")
    Send Forgot Password Mail    ${account}
    Send Forgot Password Mail    ${account}
    Send Forgot Password Mail    ${account}
    Send Forgot Password Mail    ${account}
    delete account to new state    ${account2}    已註冊    已寄出    twnetify    ${password}
    

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

Open Browser And Go To Netflix
    Press Keycode    ${homeKey}
    Click Element After It Is Visible   //*[@class ='android.widget.TextView' and @content-desc ='Chrome']
    Click Element After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']
    Input Text After It Is Visible    //*[@resource-id='com.android.chrome:id/url_bar']    https://www.netflix.com/
    Press Keycode    ${enterKey}
    Wait Until Page Contains Element    //*[@resource-id='id_email_hero_fuji']    timeout=30s
    Wait Until Page Loading

Send Forgot Password Mail
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
    Click Element After It Is Visible    //*[@resource-id='bxid_resetPasswordChoice_email']
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
    ...                                                       AND    Wait Until Page Loading
    ...                                                       AND    Open Browser And Go To Netflix
    ...                                                       AND    Send Forgot Password Mail    ${account}