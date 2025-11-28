*** Settings ***
Documentation  A test case for valid first file download.
Library     SeleniumLibrary

*** Test Cases ***
Verify Successful Download
    [Tags]      TC-1

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    # correct arguments for your selenium version
    Call Method    ${options}    add_argument    headless
    Call Method    ${options}    add_argument    disable-gpu
    Call Method    ${options}    add_argument    no-sandbox
    Call Method    ${options}    add_argument    disable-dev-shm-usage

    Open Browser    https://www.whoisds.com/newly-registered-domains    chrome    options=${options}
    Maximize Browser Window
    Log To Console    Browser opened in headless mode

    Wait Until Element Is Visible    xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button    timeout=15

    Click Element    xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button

    Sleep    20s
    Close All Browsers

