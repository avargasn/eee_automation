*** Settings ***
Library    SSHLibrary

*** Variables ***
@{HOSTS}  
    ...    10.0.137.1    #BB1
    ...    10.0.137.2    #BB2
    ...    10.0.137.3    #BB3
    ...    10.0.137.4    #BB4
    ...    10.0.137.5    #BB5
    ...    10.0.137.6    #BB6
    ...    10.0.137.7    #M7
    ...    10.0.137.8    #M8
    ...    10.0.137.9    #M9
    ...    10.0.137.10   #M10
    ...    10.0.137.11   #M11
    ...    10.0.137.12   #M12
${USERNAME}    admin
${PASSWORD}    admin
${DEVICE_TYPE}    arista_eos
${JUMPSERVER}    192.168.86.3

*** Keywords ***
Open Connection and Log In
    [Arguments]    ${HOST}
    Open Connection    ${HOST}
    Login              ${USERNAME}    ${PASSWORD}    proxy_cmd=ssh -l root -i ~/.ssh/id_rsa -W ${HOST}:22 ${JUMPSERVER}

Verify Isis Neighboring
    ${SHOW_ISIS_NEIGHBORS}=    Execute Command    show isis neighbors
    ${SHOW_ISIS_INTERFACE_BRIEF}=    Execute Command    show isis interface brief
    ${COUNT_ISIS_NEIGHBORS}=    Get Count    ${SHOW_ISIS_NEIGHBORS}    UP
    ${COUNT_ISIS_INTERFACES}=   Get Count    ${SHOW_ISIS_INTERFACE_BRIEF}    point-to-point
    Should Be Equal    ${COUNT_ISIS_NEIGHBORS}    ${COUNT_ISIS_INTERFACES}

Verify Bgp Sessions
    ${SHOW_BGP_NEIGHBORS}=    Execute Command    show bgp neighbors
    ${COUNT_BGP_NEIGHBORS}=    Get Count    ${SHOW_BGP_NEIGHBORS}    BGP neighbor is
    ${COUNT_BGP_ESTABLISHED}=   Get Count    ${SHOW_BGP_NEIGHBORS}    TCP state is ESTABLISHED
    Should Be Equal    ${COUNT_BGP_NEIGHBORS}    ${COUNT_BGP_ESTABLISHED}

*** Test Cases ***
Validate Routing Protocols Status
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Verify Isis Neighboring
        Run Keyword And Continue On Failure    Verify Bgp Sessions
        Close All Connections
    END
