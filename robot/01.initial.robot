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
    ${show_isis_neighbors}=    Execute Command    show isis neighbors
    ${show_isis_interface_brief}=    Execute Command    show isis interface brief
    ${count_isis_neighbors}=    Get Count    ${show_isis_neighbors}    UP
    ${count_isis_interfaces}=   Get Count    ${show_isis_interface_brief}    point-to-point
    Should Be Equal    ${count_isis_neighbors}    ${count_isis_interfaces}

Verify Bgp Sessions
    ${show_bgp_neighbors}=    Execute Command    show bgp neighbors
    ${count_bgp_neighbors}=    Get Count    ${show_bgp_neighbors}    BGP neighbor is
    ${count_bgp_established}=   Get Count    ${show_bgp_neighbors}    TCP state is ESTABLISHED
    Should Be Equal    ${count_bgp_neighbors}    ${count_bgp_established}

*** Test Cases ***
Validate Routing Protocols Status
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Verify Isis Neighboring
        Run Keyword And Continue On Failure    Verify Bgp Sessions
        Close All Connections
    END
