*** Settings ***
Documentation  A test case for valid first file download.
Library        SeleniumLibrary

*** Variables ***
${DOWNLOAD_DIR}    /var/lib/jenkins/workspace/Keyword/downloads

*** Test Cases ***
Verify Successful Download
    [Tags]    TC-1

    # Create Chrome options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    # Headless browser and other options
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    # Set default download directory
    ${prefs}=    Create Dictionary    download.default_directory=${DOWNLOAD_DIR}    download.prompt_for_download=False
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}

    # Open the browser with options
    Open Browser    https://www.whoisds.com/newly-registered-domains    chrome    options=${options}
    Maximize Browser Window
    Log To Console    Browser opened in headless mode

    # Wait for download button and click it
    Wait Until Element Is Visible    xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button    timeout=15
    Click Element    xpath=//*[@id="content-wrapper"]/div/div/div/div[1]/div[2]/div/table/tbody/tr[1]/td[4]/a/button

    # Wait for download to complete
    Sleep    20s

    Close All Browsers

