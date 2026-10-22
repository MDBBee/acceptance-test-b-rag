*** Settings ***
Resource          ../resources/common.resource

*** Variables ***
${INPUT_FILE_UPLOAD}          css:input[type="file"]
${BTN_VECTORIZE}              //button[contains(., 'Vectorize')]

*** Keywords ***
Upload PDF File
    [Arguments]    ${file_path}
    Wait Until Page Contains Element    ${INPUT_FILE_UPLOAD}    ${WAIT_TIMEOUT}
    Make Element Visible    ${INPUT_FILE_UPLOAD}
    ${absolute_path}=    Evaluate    os.path.abspath('${file_path}')    os
    Choose File    ${INPUT_FILE_UPLOAD}    ${absolute_path}

Make Element Visible
    [Arguments]    ${locator}
    Execute Javascript    document.querySelector('${locator}'.replace('css:', '')).style.opacity = '1'

Click Vectorize Document Button
    Wait Until Page Contains Element   ${BTN_VECTORIZE}    ${WAIT_TIMEOUT}
    Wait Until Element Is Enabled      ${BTN_VECTORIZE}    ${WAIT_TIMEOUT}
    Click Element   ${BTN_VECTORIZE}

Wait For Vectorization To Complete
    [Arguments]    ${filename}
    Wait Until Page Contains    View Chunks    120s
    Wait Until Page Contains    Chunk 1    120s

Ingest Document
    [Arguments]    ${file_path}    ${filename}
    Upload PDF File    ${file_path}
    Wait Until Element Is Visible    ${BTN_VECTORIZE}    ${WAIT_TIMEOUT}
    Click Vectorize Document Button
    Wait For Vectorization To Complete    ${filename}