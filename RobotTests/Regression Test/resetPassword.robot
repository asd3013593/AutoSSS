*** Settings ***
Library    netify
Library    SeleniumLibrary
Suite Setup    Set Library Search Order  SeleniumLibrary  AppiumLibrary

*** Variables ***
${slowNetPeriod} =    30s


*** Test Cases ***

Change Password
    @{account} =    Get Account With Amount    已寄出    twnetify    100
    FOR    ${i}    IN    @{account}
        ${accountwithoutWebName} =    Evaluate    """${i}[key]""".replace("@twnetify.com","")
        Login Email Website    ${i}[key]
        ${resetMailexist} =    Verify Reset Email Exist
        Run Keyword Unless    ${resetMailexist}    Run Keywords    Move Account To New State    ${accountwithoutWebName}    已寄出    已註冊    twnetify    ${i}[value]
        ...                                                 AND    Close Browser
        ...                                                 AND    Continue For Loop
        Select Password Reset Requst Mail
        ${newPassword} =    Evaluate    """Netify"""+str(random.randrange(100,999))
        Input New Password    ${newPassword}
        Post New Password Request    ${accountwithoutWebName}    ${newPassword}
        Close Browser
    END

add
    @{account} =    Get Account With Amount    已寄出    twnetify    5
    @{pw} =    Set Variable    Netify800    Netify765    Netify479    Netify119    Netify460
    ${index} =    Set Variable    0
    FOR    ${i}    IN    @{account}
        ${a} =    Evaluate    """${i}[key]""".replace("@twnetify.com","")
        Delete Account With Key    已寄出    twnetify    ${a}
        # Update Account To New State    完成註冊    twnetify    ${a}    ${pw}[${index}]
        ${index} =    Evaluate    ${index}+1
        # Change Account To New State    完成註冊    eState    name    account    password
    END

# test
    # FOR    ${i}    IN RANGE    100
        # ${newPassword} =    Evaluate    """Netify"""+str(random.randrange(100,999))
        # Log To Console    ${newPassword}
    # END

*** Keywords ***
Verify Reset Email Exist
    Select Frame    right
    ${resetMailexist} =    Run Keyword And Return Status    Wait Until Element Is Visible On Page    xpath=(//*[@class='tblRowStyle']//*[contains(normalize-space(),'Complete your password reset request')]//a)[1]    timeout=10s
    Unselect Frame
    [Return]    ${resetMailexist}

Post New Password Request
    [Arguments]    ${account}    ${newPassword}
    Click Element After It Is Visible    //*[@id='btn-save']
    Wait Until Element Is Visible On Page    //*[@class='ui-message-contents' and normalize-space()='Your password has been changed.']    timeout=15s
    Change Account To New State    已寄出    完成註冊   twnetify    ${account}    ${newPassword}
    Log To Console    已更改密碼為:${newPassword}

Input New Password
    [Arguments]    ${newPassword}
    Input Text After It Is Visible    //*[@id='id_newPassword']    ${newPassword}
    Input Text After It Is Visible    //*[@id='id_confirmNewPassword']    ${newPassword}

Change Account To New State
    [Arguments]    ${fState}    ${eState}    ${name}    ${account}    ${password}
    Log To Console    \n將帳號'${account}'從'${fState}${name}'刪除，並新增至'${eState}${name}'
    Delete Account With Key    ${fState}    ${name}    ${account}
    Update Account To New State    ${eState}    ${name}    ${account}    ${password}

Login Email Website
    [Arguments]    ${account}
    Open Browser    url=https://mail.lure.tw/    browser=Chrome    #options=add_argument("--headless")
    Maximize Browser Window
    Input Text After It Is Visible    //*[@name='loginid']    ${account}
    Input Text After It Is Visible    //*[@name='loginpass']    Netify@99
    Click Element After It Is Visible    //*[@value='登入']

Select Password Reset Requst Mail
    Select Frame    right
    Click Element After It Is Visible    xpath=(//*[@class='tblRowStyle']//*[contains(normalize-space(),'Complete your password reset request')]/a)[1]    timeout=${slowNetPeriod}
    Unselect Frame
    Switch Window    locator=NEW
    Click Element After It Is Visible    //*[@class='button-link' and normalize-space()='RESET PASSWORD']    timeout=${slowNetPeriod}
    Wait Until Element Is Visible On Page  //*[normalize-space()='Change Password']    timeout=10s

Move Account To New State
    [Arguments]    ${account}    ${fState}    ${eState}    ${name}    ${password}
    Log To Console    將帳號'${account}'從'${fState}${name}'刪除，並新增至'${eState}${name}'
    Delete Account With Key    ${fState}    ${name}    ${account}
    Update Account To New State    ${eState}    ${name}    ${account}    ${password}

Click Element After It Is Visible
    [Arguments]    ${elementPath}    ${timeout}=${slowNetPeriod}    ${error}=Element should be visible before click.
    Wait Until Element Is Visible    ${elementPath}    timeout=${timeout}    error=${error}
    Click Element    ${elementPath}

Input Text After It Is Visible
    [Arguments]    ${elementPath}    ${text}    ${timeout}=5s    ${error}=Element should be visible before input text.
    Wait Until Element Is Visible    ${elementPath}   timeout=${timeout}    error=${error}
    Input Text    ${elementPath}    ${text}

Wait Until Element Is Visible On Page
    [Arguments]    ${locator}    ${timeout}    ${error}=default
    Wait Until Page Contains Element    ${locator}    ${timeout}    ${error}
    Wait Until Element Is Visible    ${locator}    ${timeout}    ${error}