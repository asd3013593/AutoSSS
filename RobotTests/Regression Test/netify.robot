*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${男} =    1
${女} =    0
${prefix} =    netifya
${regisWeb} =    https://mail.lure.tw/registerform.html

# @{accounts} =



@{check} =
...  netifyayw  netifyayx  netifyayy  netifyayz  netifyaza
...  netifyazb  netifyazc  netifyazd  netifyaze  netifyazf  netifyazg  netifyazh  netifyazi  netifyazj  netifyazk
...  netifyazl  netifyazm  netifyazn  netifyazo  netifyazp  netifyazq  netifyazr  netifyazs  netifyazt  netifyazu
...  netifyazv  netifyazw  netifyazx  netifyazy  netifyazz

*** Test Cases ***
Check
    Login Netify Mail Website
    FOR    ${account}    IN    @{Check}
        Login To Check Account Is Registered    ${account}
        Log To Console    ${account} login success.
    END

test
    FOR    ${account}    IN    @{accounts}
        Register Account    ${account}
        Log To Console    ${account} register success.
    END
    # Input Sex    1
    # Input Birthday    2000    02    04
    # Input Address    桃園市敬三街
    # Input Phone Nubmer    0912345789
    # Input Education    大學
    # Input Vocation    學生
    # Input Email    asd30135931@gmail.com
    # Reload Page


*** Keywords ***
Register Account
    [Arguments]    ${account}
    Register Netify Mail Website
    Input Account    ${account}
    # Sleep    0.5s
    Input Password1    Netify@99
    # Sleep    0.5s
    Input Password2    Netify@99
    # Sleep    0.5s
    Input Name    ${account}
    # Sleep    1s
    Register    ${account}

Register Netify Mail Website
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Call Method    ${options}    add_argument    headless
    Create WebDriver    Chrome    chrome_options=${options}
    Go To    ${regisWeb}
    Maximize Browser Window

Login Netify Mail Website
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Call Method    ${options}    add_argument    headless
    Create WebDriver    Chrome    chrome_options=${options}
    Go To    https://mail.lure.tw/
    Maximize Browser Window

Input Account
    [Arguments]    ${account}
    Input Text After It Is Visible    //*[@name='account']    ${account}

Input Password1
    [Arguments]    ${password}
    Input Text After It Is Visible    //*[@name='password1']    ${password}

Input Password2
    [Arguments]    ${password}
    Input Text After It Is Visible    //*[@name='password2']    ${password}

Input Name
    [Arguments]    ${name}
    Input Text After It Is Visible    //*[@name='fullname']    ${name}

Input Sex
    [Arguments]    ${sex}
    Click Element After It Is Visible    //*[@name='sex' and @value='${sex}']

Input Birthday
    [Arguments]    ${year}    ${month}    ${day}
    Input Text After It Is Visible    //*[@name='year']    ${year}
    Click Element After It Is Visible    //*[@name='month']
    Click Element After It Is Visible    //*[@name='month']//*[@value='${month}']
    Click Element After It Is Visible    //*[@name='day']
    Click Element After It Is Visible    //*[@name='day']//*[@value='${day}']

Input Address
    [Arguments]    ${address}
    Input Text After It Is Visible    //*[@name='address']    ${address}

Input Phone Nubmer
    [Arguments]    ${phoneNumber}
    Input Text After It Is Visible    //*[@name='tel']    ${phoneNumber}

Input Education
    [Arguments]    ${education}
    Click Element After It Is Visible    //*[@name='education']
    Click Element After It Is Visible    //*[@value='${education}']

Input Vocation
    [Arguments]    ${vocation}
    Input Text After It Is Visible    //*[@name='vocation']    ${vocation}
    
Input Email
    [Arguments]    ${email}
    Input Text After It Is Visible    //*[@name='email']    ${email}

Register
    [Arguments]    ${account}
    Click Element After It Is Visible    //*[@name='senddata']
    ${success} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[normalize-space()='申請帳號成功']    timeout=1.5s
    Run Keyword If    not ${success}    Run Keywords    Close Browser
    ...                                          AND    Register Account    ${account}
    # Run Keyword If    not ${success}    Run Keywords    Close Browser
    # ...                                          AND    Sleep    10s
    # ...                                          AND    Login Netify Mail Website
    # ...                                          AND    Input Account    ${account}
    # ...                                          AND    Input Password1    Netify@99
    # ...                                          AND    Input Password2    Netify@99
    # ...                                          AND    Input Name    ${account}
    # ...                                          AND    Sleep    3s
    # ...                                          AND    Click Element After It Is Visible    //*[@name='senddata']
    # ...                                          AND    Wait Until Element Is Visible    //*[normalize-space()='申請帳號成功']
    Close Browser
    # Close Browser
    # Sleep    1s

Login To Check Account Is Registered
    [Arguments]    ${account}
    Input Text After It Is Visible    //*[@name='loginid']    ${account}
    Input Text After It Is Visible    //*[@name='loginpass']    Netify@99
    Click Element After It Is Visible    //*[@value='登入']
    Select Frame    right
    Wait Until Element Is Visible  //*[@value='切換選取']
    Sleep    0.5s
    Unselect Frame
    Go Back

Click Element After It Is Visible
    [Arguments]    ${path}    ${timeout}=5s    ${error}=Element should be visible before click.
    Wait Until Page Contains Element    ${path}    timeout=${timeout}    error=${error}
    Wait Until Element Is Visible    ${path}    timeout=${timeout}    error=${error}
    Click Element    ${path}

Input Text After It Is Visible
    [Arguments]    ${path}    ${text}    ${timeout}=5s    ${error}=Element should be visible before input.
    Wait Until Page Contains Element    ${path}    timeout=${timeout}    error=${error}
    Wait Until Element Is Visible    ${path}    timeout=${timeout}    error=${error}
    Input Text    ${path}    ${text}