*** Settings ***
Variables   ../../secrets_variables.py
Resource    ../../resources/variables.resource
Resource    ../../resources/common.resource
Resource    ../../pages/login_page.resource
Resource    ../../pages/project_page.resource
Resource    ../../pages/retrieval_page.resource

Suite Setup     Open Browser To App
Suite Teardown  Close All Browsers

*** Variables ***
${QUERY_QUESTION}             What is the name of the document I am querying?
${EXPECTED_RESPONSE}          ai-research-paper
${PROJECT_NAME_FOR_RETRIEVAL}    Test for Retrieval

*** Test Cases ***
User Queries A Document And Gets Correct Response
    [Documentation]    Verifies user can query ingested documents and receive accurate responses
    [Tags]    smoke    retrieval
    [Teardown]    Teardown Retrieval Test
    Login With Test User
    Click View Projects
    Click Project Card By Name    ${PROJECT_NAME_FOR_RETRIEVAL}
    Query Document    ${QUERY_QUESTION}    ${EXPECTED_RESPONSE}

*** Keywords ***
Teardown Retrieval Test
    Run Keyword And Ignore Error    Logout