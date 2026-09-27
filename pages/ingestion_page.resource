*** Settings ***
Resource          ../resources/common.resource

*** Variables ***
${INPUT_FILE_UPLOAD}          css:input[type="file"]
${BTN_VECTORIZE}              //button[contains(., 'Vectorize')]
${BTN_CHOOSE_FILES}           //button[contains(., 'Choose files')]
${HEADING_ADD_SOURCES}        //h3[contains(., 'Add sources')]

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
    Sleep     3s
    Wait And Click    ${BTN_VECTORIZE}

Wait For Vectorization To Complete
    [Arguments]    ${filename}
    # Wait for vectorization to complete - look for chunk indicators
    ${chunk_locator}=    Set Variable    xpath=//button[.//p[contains(., 'Attention Is All You Need')]]
    Wait Until Page Contains Element    ${chunk_locator}    60s

Ingest Document
    [Arguments]    ${file_path}    ${filename}
    Upload PDF File    ${file_path}
    Sleep    3s
    Click Vectorize Document Button
    Wait For Vectorization To Complete    ${filename}
