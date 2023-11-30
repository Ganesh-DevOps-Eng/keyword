*** Settings ***
Documentation  A test case for valid first file download.
Library     SeleniumLibrary

*** Test Cases ***
Verify Successful Download
    [Tags]      TC-1
    Open Browser                    https://www.whoisds.com/newly-registered-domains  Chrome
    Maximize Browser Window
    Wait Until Element Is Visible   xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button    timeout=5
    Click Element                   xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button
    Sleep               30s
    Log                 File downloaded
    Log To Console      File downloaded
    Close Browser
