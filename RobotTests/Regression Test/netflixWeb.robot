*** Settings ***
Library    SeleniumLibrary
Library    netflixLibrary

*** Variables ***
${presetPassword} =    Netify000
${shorPeriodTime} =    5s

*** Test Cases ***
Register Account
    [Setup]    Run Keywords    Connect Vpn To Turkey
    ...                 AND    Login Turkey Netflix Website
    @{account} =    Get Account With Amount    未註冊    twnetify    7
    FOR    ${i}    IN    @{account}
        Log To Console    \n${i}[key]:${i}[value]執行中
        Set Global Variable    ${presetPassword}    ${i}[value]
        Register Netflix Account    ${i}[key]    ${presetPassword}
    END
    [Teardown]    Disconnect Vpn
    # Wait Until Elemnet Is Visible On Page    xpath    timeout    

Send forgot password mail
    @{account} =    Get Account With Amount    已註冊    lure    1
    FOR    ${i}    IN    @{account}
        Log To Console    \n${i}[key]執行中
        Send Forgot Password Mail    ${i}[key]
    END

update account to firebase
    @{account} =    Set Variable
    ...    netifyadv
    ...    netifyadw
    ...    netifyadx
    ...    netifyady
    ...    netifyadz
    ...    netifyaea
    ...    netifyaeb
    FOR    ${i}    IN    @{account}
        # Dnt With Key    已寄出    mycat    ${i
        ${password} =    Maker Random Password
        Update Account To New State    未註冊    twnetify    ${i}    ${password}
        # delete account to new state    已寄出    已註冊    lure    ${i}    Netify000
    END

*** Keywords ***
Login Turkey Netflix Website
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    # Call Method    ${options}    add_argument    headless
    Create WebDriver    Chrome    chrome_options=${options}
    Go To Turkey Netflix
    Maximize Browser Window

Go To Turkey Netflix
    Go To    https://www.netflix.com/
    ${turkey} =    Set Variable    https://www.netflix.com/tr-en/
    ${url} =    Get Location 
    Should Be Equal As Strings    ${url}    ${turkey}

Register Netflix Account
    [Arguments]    ${account}    ${password}
    Wait Until Keyword Succeeds    2x    5s    Input Text Fail When Get Started Open New Browser    //*[@id='id_email_hero_fuji']    ${account}    //*[@id='id_email_hero_fuji' and @value='${account}']    timeout=${shorPeriodTime}    error1=Get Started input should be visible.    error2=Get Started input field should be ${account}.
    If Click Element Fail When Register Netflix Account Switch Turkey Vpn    ${account}    xpath=(//*[@class='cta-btn-txt' and normalize-space()='Get Started'])[1]    timeout=${shorPeriodTime}    error=Get Started button should be visible.
    ${step1_1} =    Run Keyword And Return Status     Wait Until Elemnet Is Visible On Page    //*[contains(normalize-space(), 'Finish setting up your account')]    timeout=${shorPeriodTime}    error="Finish setting up your account." should be visible.
    Run Keyword If    ${step1_1}    Click Element After It Is Visible On Page    //*[@class='submitBtnContainer']//button[normalize-space()='Continue']    timeout=${shorPeriodTime}    error=Continue button should be visible.
    Input Text And Wait Until Value Is Correct    //*[@id='id_password']    ${password}    //*[@id='id_password' and @value='${password}']    timeout=${shorPeriodTime}    error1=Add a Password field should be visible.    error2=Password field should be input.
    Click Element After It Is Visible On Page    //*[@class='submitBtnContainer']//button[normalize-space()='Continue']    timeout=${shorPeriodTime}    error=Continue button should be visible.
    Wait Until Elemnet Is Visible On Page    //*[@class='stepIndicator' and contains(normalize-space(), '2')]    timeout=${shorPeriodTime}    error=Step 2 Of 3 should be visible.
    Click Element After It Is Visible On Page    //a[contains(@class, 'signupBasicHeader') and normalize-space()='Sign Out']    timeout=${shorPeriodTime}    error=Sign Up button should be visible.
    Wait Until Elemnet Is Visible On Page    //a[contains(@class, 'signupBasicHeader') and normalize-space()='Sign In']    timeout=${shorPeriodTime}    error=Sign In button should be visible.
    ${account2} =    Evaluate    """${account}""".replace("@twnetify.com","")
    Move Account To New State    ${account2}    未註冊    已註冊    twnetify    ${password}
    Log To Console    註冊密碼為:${password}
    [Teardown]    Go To Turkey Netflix

Send Forgot Password Mail
    [Arguments]    ${account}
    Wait Until Keyword Succeeds    2x    5s        Input Text Fail When Get Started Open New Browser    //*[@id='id_email_hero_fuji']    ${account}    //*[@id='id_email_hero_fuji' and @value='${account}']    timeout=${shorPeriodTime}    error1=Get Started input should be visible.    error2=Get Started input field should be ${account}.
    If Click Element Fail When Send Forgot Password Mail Switch Turkey Vpn    ${account}    xpath=(//*[@class='cta-btn-txt' and normalize-space()='Get Started'])[1]    timeout=${shorPeriodTime}    error=Get Started button should be visible.
    Click Element After It Is Visible On Page    //*[@class='link-forgot-password']    timeout=${shorPeriodTime}    error=Forgot your password button should be visible.
    Input Text And Wait Until Value Is Correct    //*[@id='forgot_password_input']    ${account}    //*[@id='forgot_password_input' and @value='${account}']    timeout=${shorPeriodTime}    error1=Forgot password input field should be visible.    error2=Forgot password field should be input.
    If Click Element Fail When Send Forgot Password Mail Switch Turkey Vpn    ${account}    //*[contains(@class, 'forgot-password-action-button') and normalize-space()='Email Me']    timeout=${shorPeriodTime}    error=Email Me button should be visible.
    Wait Until Elemnet Is Visible On Page    //*[normalize-space()='Email Sent']    timeout=${shorPeriodTime}    error=Email should be sent.
    [Teardown]    Go To Turkey Netflix

Input Text And Wait Until Value Is Correct
    [Arguments]    ${xpath1}    ${text}    ${xpath2}    ${timeout}    ${error1}=error    ${error2}=error
    Input Text After It Is Visible On Page    ${xpath1}    ${text}    timeout=${timeout}    error=${error1}
    Run Keyword And Return Status    Wait Until Elemnet Is Visible On Page     ${xpath2}    ${timeout}    error=${error2}

Input Text Fail When Get Started Open New Browser
    [Arguments]    ${xpath1}    ${text}    ${xpath2}    ${timeout}    ${error1}=error    ${error2}=error
    Input Text After It Is Visible On Page    ${xpath1}    ${text}    timeout=${timeout}    error=${error1}
    ${correct} =    Run Keyword And Return Status    Wait Until Elemnet Is Visible On Page     ${xpath2}    ${timeout}    error=${error2}
    Run Keyword If    not ${correct}    Run Keywords    Close Browser
    ...                                    AND    Login Turkey Netflix Website
    ...                                    AND    Fail    Input Text Fail

If Click Element Fail When Register Netflix Account Switch Turkey Vpn
    [Arguments]    ${account}    ${xpath}    ${timeout}    ${error}=error
    Click Element After It Is Visible On Page    ${xpath}    timeout=${timeout}    error=${error}
    ${error} =    Run Keyword And Return Status   Wait Until Elemnet Is Visible On Page    //*[contains(normalize-space(), 'Please try again')]    timeout=${shorPeriodTime}    error=Error message should be visible.
    Run Keyword If    ${error}    Run Keywords    Reconnect Vpn To Turkey
    ...                                    AND    Go To Turkey Netflix
    ...                                    AND    Register Netflix Account    ${account}    ${presetPassword}

If Click Element Fail When Send Forgot Password Mail Switch Turkey Vpn
    [Arguments]    ${account}    ${xpath}    ${timeout}    ${error}=error
    Click Element After It Is Visible On Page    ${xpath}    timeout=${timeout}    error=${error}
    ${error} =    Run Keyword And Return Status   Wait Until Elemnet Is Visible On Page    //*[contains(normalize-space(), 'Please try again')]    timeout=${shorPeriodTime}    error=Error message should be visible.
    Run Keyword If    ${error}    Run Keywords    Reconnect Vpn To Turkey
    ...                                    AND    Go To Turkey Netflix
    ...                                    AND    Send Forgot Password Mail    ${account}

Move Account To New State
    [Arguments]    ${account}    ${fState}    ${eState}    ${name}    ${password}
    Log To Console    將帳號'${account}'從'${fState}${name}'刪除，並新增至'${eState}${name}'
    Delete Account With Key    ${fState}    ${name}    ${account}
    Update Account To New State    ${eState}    ${name}    ${account}    ${password}

Connect Vpn To Turkey
    ${driver} =    Setup Application Driver
    Connect Vpn To Turkey Implement    ${driver}
    [Teardown]    Close Vpn    ${driver}

Reconnect Vpn To Turkey
    ${driver} =    Setup Application Driver
    Reconnect Vpn To Turkey Implement    ${driver}
    [Teardown]    Close Vpn    ${driver}

Disconnect Vpn
    ${driver} =    Setup Application Driver
    Disconnect Vpn Implement    ${driver}
    [Teardown]    Close Vpn    ${driver}

Wait Until Elemnet Is Visible On Page
    [Arguments]    ${xpath}    ${timeout}    ${error}=error
    Wait Until Page Contains Element    ${xpath}    timeout=${timeout}    error=${error}
    Wait Until Element Is Visible    ${xpath}    timeout=${timeout}    error=${error}

Click Element After It Is Visible On Page
    [Arguments]    ${xpath}    ${timeout}    ${error}=error
    Wait Until Elemnet Is Visible On Page    ${xpath}    ${timeout}    ${error}
    Sleep    .432s
    Click Element    ${xpath}

Input Text After It Is Visible On Page
    [Arguments]    ${xpath}    ${text}    ${timeout}    ${error}=error
    Wait Until Elemnet Is Visible On Page    ${xpath}    ${timeout}    ${error}
    Sleep    .432s
    Input Text    ${xpath}    ${text}