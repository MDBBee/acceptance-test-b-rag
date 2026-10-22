*** Settings ***
Variables   ../../secrets_variables.py
Resource    ../../resources/variables.resource
Resource    ../../resources/common.resource
Resource    ../../pages/login_page.resource
Resource    ../../pages/project_page.resource
Resource    ../../pages/ingestion_page.resource

Suite Setup     Open Browser To App
Suite Teardown  Close All Browsers

*** Test Cases ***
User Ingests A PDF Document
    [Documentation]    Verifies user can upload and vectorize a PDF document
    [Tags]    smoke    ingestion
    [Teardown]    Teardown Ingestion Test
    Login With Test User
    Page Should Contain    Knowledge that
    Click New Project Button
    Create Project    Ingestion Test Project    Test project for ingestion smoke test
    Ingest Document    ${TEST_PDF_PATH}    attension-paper.pdf

*** Keywords ***
Teardown Ingestion Test
    Sleep   2s
    Navigate To Projects List
    Run Keyword And Ignore Error    Delete Project By Name    Ingestion Test Project
    Run Keyword And Ignore Error    Logout
