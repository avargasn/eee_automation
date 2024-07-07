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
@{EXPECTED_ROUTES}    10.0.16.0/24    10.0.17.0/24    10.0.18.0/24

*** Keywords ***
Open Connection and Log In
    [Arguments]    ${HOST}
    Open Connection    ${HOST}
    Login              ${USERNAME}    ${PASSWORD}    proxy_cmd=ssh -l root -i ~/.ssh/id_rsa -W ${HOST}:22 ${JUMPSERVER}

Verify Bgp Sessions
    ${SHOW_BGP_NEIGHBORS}=    Execute Command    show bgp neighbors
    ${COUNT_BGP_NEIGHBORS}=    Get Count    ${SHOW_BGP_NEIGHBORS}    BGP neighbor is
    ${COUNT_BGP_ESTABLISHED}=   Get Count    ${SHOW_BGP_NEIGHBORS}    TCP state is ESTABLISHED
    Should Be Equal    ${COUNT_BGP_NEIGHBORS}    ${COUNT_BGP_ESTABLISHED}

Verify Bgp Routing Table
    [Documentation]    It grabs the BGP RIB from the VRF L3VPN and checks if the routes announced by the CE exist on that output

    ${SHOW_IP_BGP}=    Execute Command    show ip bgp vrf L3VPN
    FOR    ${ROUTE}    IN    @{EXPECTED_ROUTES}
        Should Contain    ${SHOW_IP_BGP}    ${ROUTE}
    END

*** Test Cases ***
Validate Routing Protocols Status on VRF ${VRF_NAME} (L3VPN Service)
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Verify Bgp Sessions
        Run Keyword And Continue On Failure    Verify Bgp Routing Table
        Close All Connections
    END
