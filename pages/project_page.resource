*** Settings ***
Resource          ../resources/common.resource

*** Variables ***
${INPUT_PROJECT_NAME}         id=name
${INPUT_PROJECT_DESC}         id=description
${BTN_CREATE_PROJECT}         //button[contains(., 'Create Project')]
${BTN_VIEW_PROJECTS}          //button[normalize-space()='View Projects']
${BTN_PROJECT_CARD}           //div[@class='flex items-start justify-between mb-3']
${BTN_ALL_PROJECTS}           //button[contains(., 'All Projects')]
${BTN_DELETE_PROJECT}         //button[contains(., 'Delete project') and not(contains(., 'Cancel'))]
${HEADING_DELETE_CONFIRM}     //h2[contains(., 'Delete project?')]
${URL_PROJECTS}               ${BASE_URL}/projects

*** Keywords ***
Fill Project Name
    [Arguments]    ${name}
    Wait And Input Text    ${INPUT_PROJECT_NAME}    ${name}

Fill Project Description
    [Arguments]    ${description}
    Wait And Input Text    ${INPUT_PROJECT_DESC}    ${description}

Click Create Project Button
    Wait And Click    ${BTN_CREATE_PROJECT}

Create Project
    [Arguments]    ${name}    ${description}
    Fill Project Name    ${name}
    Fill Project Description    ${description}
    Click Create Project Button

Click View Projects
    Wait And Click    ${BTN_VIEW_PROJECTS}

Click Project Card
    Wait And Click    ${BTN_PROJECT_CARD}

Navigate To Projects List
    Go To    ${URL_PROJECTS}
    Wait Until Page Contains    All Projects    ${WAIT_TIMEOUT}

Delete Project By Name
    [Arguments]    ${project_name}
    ${delete_btn}=    Set Variable    //a[.//h3[contains(., '${project_name}')]]//button[2]
    Wait And Click    ${delete_btn}
    Wait Until Page Contains Element    ${HEADING_DELETE_CONFIRM}    ${WAIT_TIMEOUT}
    Wait And Click    ${BTN_DELETE_PROJECT}
    Wait Until Page Contains    All Projects    ${WAIT_TIMEOUT}
