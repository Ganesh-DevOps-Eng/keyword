*** Settings ***
Documentation  A test case for valid first file download.
Library     SeleniumLibrary

*** Test Cases ***
Verify Successful Download
    [Tags]      TC-1
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Open Browser    https://www.whoisds.com/newly-registered-domains    browser=chrome    options=${options}
    Maximize Browser Window

    # Additional debug log
    Log To Console    Browser opened in headless mode

    # Wait Until Element Is Visible
    Wait Until Element Is Visible    xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button    timeout=5

    # Click Element
    Click Element    xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button

    # Sleep
    Sleep    20s

    # Rest of your script...

    Close All Browsers
