*** Settings ***
Library    SeleniumLibrary
Library    dctSeleniumLibrary
Test Setup    On The High Speed Rail Page
Test Teardown    Close Browser

*** Test Cases ***
123
    Arrange Your Trip
    
    Click Element    //*[@id='SubmitButton']
    Wait Until Element Is Visible    //*[@value='確認車次']
    Wait Until Element Is Visible    //*[@class='section_title']
    Input Text    //*[@name='idInputRadio:idNumber']    text
    Input Text    //*[@name='eaiPhoneCon:phoneInputRadio:mobilePhone']    text

*** Keywords ***
On The High Speed Rail Page
    Open Browser    https://irs.thsrc.com.tw/IMINT/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class='JCon']//*[@class='action']
    Click Element    //*[@class='JCon']//*[@class='action']

Arrange Your Trip
    Click Element    //*[@name='selectStartStation']
    Click Element    //*[@name='selectStartStation']//*[normalize-space()='台北']
    Click Element    //*[@name='selectDestinationStation']
    Click Element    //*[@name='selectDestinationStation']//*[normalize-space()='台中']
    Input Text    //*[@id='toTimeInputField']    2020/10/10
    Click Element    //*[@name='toTimeTable']
    Click Element    //*[@name='toTimeTable']//*[normalize-space()='12:00']