*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot
Resource          variables.resource

*** Keywords ***
Open Browser To App
    Set Suite Metadata    Tester    ${TESTER_NAME}
    IF    '${HEADLESS}' == 'true'
        ${browser}=    Set Variable    headlesschrome
    ELSE
        ${browser}=    Set Variable    chrome
    END
    ${options}=    Set Variable    add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-gpu");add_argument("--user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
    Open Browser    ${BASE_URL}    ${browser}    options=${options}
    Set Selenium Timeout    ${WAIT_TIMEOUT}
    IF    '${HEADLESS}' != 'true'
        Maximize Browser Window
    END
    # Capture JavaScript errors
    Execute Javascript    window.__jsErrors = []; window.onerror = function(msg, url, line) { window.__jsErrors.push(msg + ' at ' + url + ':' + line); return false; };

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${WAIT_TIMEOUT}
    Click Element    ${locator}

Wait And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${WAIT_TIMEOUT}
    Input Text    ${locator}    ${text}
