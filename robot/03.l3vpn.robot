*** Settings ***
Library    SSHLibrary

*** Variables ***
@{HOSTS}  
    ...    10.0.137.2    #BB2
    ...    10.0.137.8    #M8
    ...    10.0.137.11   #M11
${USERNAME}    admin
${PASSWORD}    admin
${DEVICE_TYPE}    arista_eos
${JUMPSERVER}    192.168.86.3
${VRF_NAME}    L3VPN

*** Keywords ***
Open Connection and Log In
    [Arguments]    ${HOST}
    Open Connection    ${HOST}
    Login              ${USERNAME}    ${PASSWORD}    proxy_cmd=ssh -l root -i ~/.ssh/id_rsa -W ${HOST}:22 ${JUMPSERVER}

Verify Bgp Sessions
    ${show_bgp_neighbors}=    Execute Command    show bgp neighbors
    ${count_bgp_neighbors}=    Get Count    ${show_bgp_neighbors}    BGP neighbor is
    ${count_bgp_established}=   Get Count    ${show_bgp_neighbors}    TCP state is ESTABLISHED
    Should Be Equal    ${count_bgp_neighbors}    ${count_bgp_established}

*** Test Cases ***
Validate Routing Protocols Status on VRF ${VRF_NAME} (L3VPN Service)
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Verify Bgp Sessions
        Close All Connections
    END
