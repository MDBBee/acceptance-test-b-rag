*** Settings ***
Resource          ../resources/common.resource

*** Variables ***
${BTN_NEW_CONVERSATION}       //span[normalize-space()='New conversation']
${INPUT_CHAT}                 //textarea[@placeholder='Ask about your documents...']

*** Keywords ***
Click New Conversation
    Wait And Click    ${BTN_NEW_CONVERSATION}
    Wait Until Page Contains Element    ${INPUT_CHAT}    ${WAIT_TIMEOUT}

Enter Chat Message
    [Arguments]    ${message}
    Wait And Click    ${INPUT_CHAT}
    Wait Until Element Is Visible    ${INPUT_CHAT}    ${WAIT_TIMEOUT}
    Input Text    ${INPUT_CHAT}    ${message}

Send Chat Message
    Press Keys    ${INPUT_CHAT}    ENTER

Wait For Chat Response
    [Arguments]    ${expected_text}
    Wait Until Page Contains    ${expected_text}    40s

Query Document
    [Arguments]    ${question}    ${expected_text}
    Click New Conversation
    Enter Chat Message    ${question}
    Send Chat Message
    Wait For Chat Response    ${expected_text}
