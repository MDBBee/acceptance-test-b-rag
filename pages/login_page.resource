*** Settings ***
Resource          ../resources/common.resource

*** Variables ***
${BTN_NEW_PROJECT_SIDEBAR}      (//button[contains(., 'New Project')])[1]
${BTN_NEW_PROJECT_MAIN}         //button[normalize-space()='New Project' and not(ancestor::aside)]
${BTN_TEST}                     //button[contains(text(), 'T') and not(contains(text(), 'Toggle'))]
${MODAL_HEADING}                //h2[contains(., 'Sign in')]
${INPUT_CODE_0}                 id=code-0
${INPUT_CODE_1}                 id=code-1
${INPUT_CODE_2}                 id=code-2
${INPUT_CODE_3}                 id=code-3
${INPUT_CODE_4}                 id=code-4
${INPUT_CODE_5}                 id=code-5
${BTN_VERIFY_CODE}              //button[contains(., 'Verify Code')]
${AUTH_BACKDROP}                xpath=//div[contains(@class, 'fixed inset-0 z-50')]
${BTN_USER_NAME}                //span[@class='text-xs text-on-surface-variant truncate max-w-[120px]']
${DROPDOWN_MENU}                id=base-ui-_r_m_
${MENU_LOGOUT}                  //button[contains(., 'Log out')]
${BTN_SIGN_IN}                  //button[contains(., 'Sign In')]
${BTN_NEW_PROJECT}              //button[contains(text(),'New Project')]


*** Keywords ***
Click New Project Button
    Wait And Click    ${BTN_NEW_PROJECT}

Click Sign In Button
    Wait And Click    ${BTN_SIGN_IN}

Click Test Button
    Wait Until Element Is Visible    ${BTN_TEST}    10s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${BTN_TEST}
    IF    not ${clicked}
        Execute Javascript    document.evaluate("//button[contains(text(), 'T') and not(contains(text(), 'Toggle'))]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue?.click()
    END

Enter Verification Code
    [Arguments]    ${code}
    Wait And Input Text    ${INPUT_CODE_0}    ${code}[0]
    Wait And Input Text    ${INPUT_CODE_1}    ${code}[1]
    Wait And Input Text    ${INPUT_CODE_2}    ${code}[2]
    Wait And Input Text    ${INPUT_CODE_3}    ${code}[3]
    Wait And Input Text    ${INPUT_CODE_4}    ${code}[4]
    Wait And Input Text    ${INPUT_CODE_5}    ${code}[5]

Click Verify Code Button
    Wait And Click    ${BTN_VERIFY_CODE}

Wait For Auth Overlay To Close
    Wait Until Element Is Not Visible    ${AUTH_BACKDROP}    ${WAIT_TIMEOUT}

Login With Test User
    Click Sign In Button
    Wait Until Element Is Visible    ${MODAL_HEADING}    10s
    Click Test Button
    Enter Verification Code    ${TEST_CODE}
    Click Verify Code Button
    Wait For Auth Overlay To Close

Logout
    Scroll Element Into View    ${BTN_USER_NAME}
    Wait And Click    ${BTN_USER_NAME}
    Wait Until Page Contains Element    ${DROPDOWN_MENU}    15s
    Click Element    ${MENU_LOGOUT}
