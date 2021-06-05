*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${男} =    1
${女} =    0
${prefix} =    netifya
${regisWeb} =    https://mail.mycat.tw/registerform.html

@{accounts} =
...    netifyawe  netifyawf  netifyawg  netifyawh  netifyawi
...    netifyawj  netifyawk  netifyawl  netifyawm  netifyawn  netifyawo  netifyawp  netifyawq  netifyawr  netifyaws
...    netifyawt  netifyawu  netifyawv  netifyaww  netifyawx  netifyawy  netifyawz  netifyaxa  netifyaxb



# @{check} =    netifyapl  netifyapm  netifyapn  netifyapo  netifyapp  netifyapq  netifyapr  netifyaps  netifyapt  netifyapu
# ...    netifyapv  netifyapw  netifyapx  netifyapy  netifyapz  netifyaqa  netifyaqb  netifyaqc  netifyaqd  netifyaqe
# ...    netifyaqf  netifyaqg  netifyaqh  netifyaqi  netifyaqj  netifyaqk  netifyaql  netifyaqm  netifyaqn  netifyaqo
# ...    netifyaqp  netifyaqq  netifyaqr  netifyaqs  netifyaqt  netifyaqu  netifyaqv  netifyaqw  netifyaqx  netifyaqy
# ...    netifyaqz  netifyara  netifyarb  netifyarc  netifyard  netifyare  netifyarf  netifyarg  netifyarh  netifyari
# ...    netifyarj  netifyark  netifyarl  netifyarm  netifyarn  netifyaro  netifyarp  netifyarq  netifyarr  netifyars
# ...    netifyart  netifyaru  netifyarv  netifyarw  netifyarx  netifyary  netifyarz  netifyasa  netifyasb  netifyasc
# ...    netifyasd  netifyase  netifyasf  netifyasg  netifyash  netifyasi  netifyasj  netifyask  netifyasl  netifyasm
# ...    netifyasn  netifyaso  netifyasp  netifyasq  netifyasr  netifyass  netifyast  netifyasu  netifyasv  netifyasw
# ...    netifyasx  netifyasy  netifyasz  netifyata  netifyatb  netifyatc  netifyatd  netifyate  netifyatf  netifyatg
# ...    netifyath  netifyati  netifyatj  netifyatk  netifyatl  netifyatm  netifyatn  netifyato  netifyatp  netifyatq
# ...    netifyatr  netifyats  netifyatt  netifyatu  netifyatv  netifyatw  netifyatx  netifyaty  netifyatz

@{check} =     netifyaua
...    netifyaub  netifyauc  netifyaud  netifyaue  netifyauf  netifyaug  netifyauh  netifyaui  netifyauj  netifyauk
...    netifyaul  netifyaum  netifyaun  netifyauo  netifyaup  netifyauq  netifyaur  netifyaus  netifyaut  netifyauu
...    netifyauv  netifyauw  netifyaux  netifyauy  netifyauz  netifyava  netifyavb  netifyavc  netifyavd  netifyave
...    netifyavf  netifyavg  netifyavh  netifyavi  netifyavj  netifyavk  netifyavl  netifyavm  netifyavn  netifyavo
...    netifyavp  netifyavq  netifyavr  netifyavs  netifyavt  netifyavu  netifyavv  netifyavw  netifyavx  netifyavz
...    netifyawa  netifyawb  netifyawc  netifyawd  
# ...       netifyaht       netifyahu       netifyahv       netifyahw       netifyahx       netifyahy       netifyahz       netifyaia
# ...       netifyaib       netifyaic       netifyaid       netifyaie       netifyaif       netifyaig       netifyaih       netifyaii
# ...       netifyaij    netifyaik       netifyail       netifyaim       netifyain       netifyaio       netifyaip       netifyaiq
# ...       netifyair       netifyais       netifyait       netifyaiu       netifyaiv       netifyaiw       netifyaix       netifyaiy       netifyaiz
# ...       netifyaja        netifyajb       netifyajc       netifyajd
# ...       netifyaje       netifyajf       netifyajg       netifyajh       netifyaji
# ...       netifyajj       netifyajk       netifyajl       netifyajm       netifyajn       netifyajo       netifyajp       netifyajq    netifyajr
# ...       netifyajs       netifyajt       netifyaju       netifyajv       netifyajw       netifyajx       netifyajy       netifyajz       netifyaka
# ...       netifyakb       netifyakc       netifyakd       netifyake       netifyakf       netifyakg   netifyakh        netifyaki       netifyakj
# ...       netifyakk       netifyakl       netifyakm       netifyakn       netifyako       netifyakp       netifyakq       netifyakr       netifyaks
# ...       netifyakt       netifyaku       netifyakv       netifyakw       netifyakx    netifyaky       netifyakz       netifyala       netifyalb
# ...       netifyalc       netifyald       netifyale       netifyalf       netifyalg       netifyalh       netifyali       netifyalj       netifyalk
# ...       netifyall       netifyalm       netifyaln   netifyalo    netifyalp       netifyalq    netifyalr       netifyals       netifyalt
# ...       netifyalu       netifyalv       netifyalw       netifyalx       netifyaly       netifyalz       netifyama       netifyamb       netifyamc
# ...       netifyamd       netifyame    netifyamf       netifyamg       netifyamh       netifyami       netifyamj       netifyamk       netifyaml
# ...       netifyamm       netifyamn       netifyamo       netifyamp       netifyamq       netifyamr       netifyams       netifyamt       netifyamu
# ...       netifyamv        netifyamw       netifyamx       netifyamy       netifyamz       netifyana       netifyanb       netifyanc       netifyand
# ...       netifyane       netifyanf       netifyang       netifyanh       netifyani       netifyanj       netifyank       netifyanl    netifyanm
# ...       netifyann       netifyano       netifyanp       netifyanq       netifyanr       netifyans       netifyant       netifyanu       netifyanv
# ...       netifyanw       netifyanx       netifyany       netifyanz       netifyaoa       netifyaob   netifyaoc        netifyaod


# ...   netifyadw      netifyadx       netifyady       netifyadz       netifyaea       netifyaeb    netifyaec       netifyaed       netifyaee       netifyaef       netifyaeg
# ...   netifyaeh      netifyaei       netifyaej       netifyaek       netifyael       netifyaem    netifyaen       netifyaeo       netifyaep       netifyaeq       netifyaer
# ...   netifyaes      netifyaet       netifyaeu       netifyaev       netifyaew       netifyaex    netifyaey       netifyaez       netifyafa       netifyafb       netifyafc
# ...   netifyafd      netifyafe       netifyaff       netifyafg       netifyafh       netifyafi    netifyafj       netifyafk       netifyafl       netifyafm       netifyafn
# ...   netifyafo      netifyafp       netifyafq       netifyafr       netifyafs       netifyaft    netifyafu       netifyafv       netifyafw       netifyafx       netifyafy
# ...   netifyafz      netifyaga       netifyagb       netifyagc       netifyagd       netifyage    netifyagf       netifyagg       netifyagh       netifyagi       netifyagj
# ...   netifyagk      netifyagl       netifyagm       netifyagn       netifyago       netifyagp    netifyagq       netifyagr       netifyags       netifyagt       netifyagu
# ...   netifyagv      netifyagw       netifyagx       netifyagy       netifyagz       netifyaha    netifyahb       netifyahc       netifyahd       netifyahe       netifyahf
# ...   netifyahg      netifyahh       netifyahi       netifyahj       netifyahk       netifyahl    netifyahm       netifyahn       netifyaho       netifyahp       netifyahq
# ...   netifyahr

# ...    netifyaau    netifyaav    netifyaaw    netifyaax    netifyaay    netifyaaz    netifyaba
# ...    netifyabb    netifyabc    netifyabd    netifyabe    netifyabf    netifyabg    netifyabh    netifyabi    netifyabj    netifyabk    netifyabl    netifyabm    netifyabn    netifyabo
# ...    netifyabp    netifyabq    netifyabr    netifyabs    netifyabt    netifyabu    netifyabv    netifyabw    netifyabx    netifyaby    netifyabz    netifyaca    netifyacb    netifyacc
# ...    netifyacd    netifyace    netifyacf    netifyacg    netifyach    netifyaci    netifyacj    netifyack    netifyacl    netifyacm    netifyacn    netifyaco    netifyacp    netifyacq
# ...    netifyacr    netifyacs    netifyact    netifyacu    netifyacv    netifyacw    netifyacx    netifyacy    netifyacz    netifyada    netifyadb    netifyadc    netifyadd    netifyade
# ...    netifyadf    netifyadg    netifyadh    netifyadi    netifyadj    netifyadk    netifyadl    netifyadm    netifyadn    netifyado    netifyadp    netifyadq    netifyadr    netifyads
# ...    netifyadt    netifyadu    netifyadv

# ...   netifyahs       netifyaht       netifyahu       netifyahv       netifyahw    netifyahx       netifyahy       netifyahz       netifyaia       netifyaib
# ...   netifyaic      netifyaid       netifyaie       netifyaif       netifyaig       netifyaih    netifyaii       netifyaij       netifyaik       netifyail       netifyaim
# ...   netifyain      netifyaio       netifyaip       netifyaiq       netifyair       netifyais    netifyait       netifyaiu       netifyaiv       netifyaiw       netifyaix
# ...   netifyaiy      netifyaiz       netifyaja       netifyajb       netifyajc       netifyajd    netifyaje       netifyajf       netifyajg       netifyajh       netifyaji
# ...   netifyajj      netifyajk       netifyajl       netifyajm       netifyajn       netifyajo    netifyajp       netifyajq       netifyajr       netifyajs       netifyajt
# ...   netifyaju      netifyajv       netifyajw       netifyajx       netifyajy       netifyajz    netifyaka       netifyakb       netifyakc       netifyakd       netifyake
# ...   netifyakf      netifyakg       netifyakh       netifyaki       netifyakj       netifyakk    netifyakl       netifyakm       netifyakn       netifyako       netifyakp
# ...   netifyakq      netifyakr       netifyaks       netifyakt       netifyaku       netifyakv    netifyakw       netifyakx       netifyaky       netifyakz       netifyala
# ...   netifyalb      netifyalc       netifyald       netifyale       netifyalf       netifyalg    netifyalh       netifyali       netifyalj       netifyalk       netifyall
# ...   netifyalm      netifyaln       netifyalo       netifyalp       netifyalq       netifyalr    netifyals       netifyalt       netifyalu       netifyalv       netifyalw
# ...   netifyalx      netifyaly       netifyalz       netifyama       netifyamb       netifyamc    netifyamd       netifyame       netifyamf       netifyamg       netifyamh
# ...   netifyami      netifyamj       netifyamk       netifyaml       netifyamm       netifyamn    netifyamo       netifyamp       netifyamq       netifyamr       netifyams
# ...   netifyamt      netifyamu       netifyamv       netifyamw       netifyamx       netifyamy    netifyamz       netifyana       netifyanb       netifyanc       netifyand
# ...   netifyane      netifyanf       netifyang       netifyanh       netifyani       netifyanj    netifyank       netifyanl       netifyanm       netifyann       netifyano
# ...   netifyanp      netifyanq       netifyanr       netifyans       netifyant       netifyanu    netifyanv       netifyanw       netifyanx       netifyany       netifyanz
# ...   netifyaoa        netifyaob       netifyaoc       netifyaod       netifyaoe       netifyaof       netifyaog       netifyaoh       netifyaoi       netifyaoj       netifyaok       netifyaol       netifyaom       netifyaon       netifyaoo       netifyaop       netifyaoq    netifyaor       netifyaos       netifyaot       netifyaou       netifyaov       netifyaow       netifyaox       netifyaoy       netifyaoz       netifyapa       netifyapb       netifyapc       netifyapd       netifyape       netifyapf       netifyapg   netifyaph        netifyapi       netifyapj       netifyapk       netifyapl       netifyapm       netifyapn       netifyapo       netifyapp       netifyapq       netifyapr       netifyaps       netifyapt       netifyapu       netifyapv       netifyapw       netifyapx    netifyapy       netifyapz       netifyaqa       netifyaqb       netifyaqc       netifyaqd       netifyaqe       netifyaqf       netifyaqg       netifyaqh       netifyaqi       netifyaqj       netifyaqk       netifyaql       netifyaqm       netifyaqn   netifyaqo        netifyaqp       netifyaqq       netifyaqr       netifyaqs       netifyaqt       netifyaqu       netifyaqv       netifyaqw       netifyaqx       netifyaqy       netifyaqz       netifyara       netifyarb       netifyarc       netifyard       netifyare    netifyarf       netifyarg       netifyarh       netifyari       netifyarj       netifyark       netifyarl       netifyarm       netifyarn       netifyaro       netifyarp       netifyarq       netifyarr       netifyars       netifyart       netifyaru   netifyarv        netifyarw       netifyarx       netifyary       netifyarz       netifyasa       netifyasb       netifyasc       netifyasd       netifyase       netifyasf       netifyasg       netifyash       netifyasi       netifyasj       netifyask       netifyasl    netifyasm       netifyasn       netifyaso       netifyasp       netifyasq       netifyasr       netifyass       netifyast       netifyasu       netifyasv       netifyasw       netifyasx       netifyasy       netifyasz       netifyata       netifyatb   netifyatc        netifyatd       netifyate       netifyatf       netifyatg       netifyath       netifyati       netifyatj       netifyatk       netifyatl       netifyatm       netifyatn       netifyato       netifyatp       netifyatq       netifyatr       netifyats    netifyatt       netifyatu       netifyatv       netifyatw       netifyatx       netifyaty       netifyatz       netifyaua       netifyaub       netifyauc       netifyaud       netifyaue       netifyauf       netifyaug       netifyauh       netifyaui   netifyauj        netifyauk       netifyaul       netifyaum       netifyaun       netifyauo       netifyaup       netifyauq       netifyaur       netifyaus       netifyaut       netifyauu       netifyauv       netifyauw       netifyaux       netifyauy       netifyauz    netifyava       netifyavb       netifyavc       netifyavd       netifyave       netifyavf       netifyavg       netifyavh       netifyavi       netifyavj       netifyavk       netifyavl       netifyavm       netifyavn       netifyavo       netifyavp   netifyavq        netifyavr       netifyavs       netifyavt       netifyavu       netifyavv       netifyavw       netifyavx       netifyavy       netifyavz       netifyawa       netifyawb       netifyawc       netifyawd       netifyawe       netifyawf       netifyawg    netifyawh       netifyawi       netifyawj       netifyawk       netifyawl       netifyawm       netifyawn       netifyawo       netifyawp       netifyawq       netifyawr       netifyaws       netifyawt       netifyawu       netifyawv       netifyaww   netifyawx        netifyawy       netifyawz       netifyaxa       netifyaxb       netifyaxc       netifyaxd       netifyaxe       netifyaxf       netifyaxg       netifyaxh       netifyaxi       netifyaxj       netifyaxk       netifyaxl       netifyaxm       netifyaxn    netifyaxo       netifyaxp       netifyaxq       netifyaxr       netifyaxs       netifyaxt       netifyaxu       netifyaxv       netifyaxw       netifyaxx       netifyaxy       netifyaxz       netifyaya       netifyayb       netifyayc       netifyayd   netifyaye        netifyayf       netifyayg       netifyayh       netifyayi       netifyayj       netifyayk       netifyayl       netifyaym       netifyayn       netifyayo       netifyayp       netifyayq       netifyayr       netifyays       netifyayt       netifyayu    netifyayv       netifyayw       netifyayx       netifyayy       netifyayz       netifyaza       netifyazb       netifyazc       netifyazd       netifyaze       netifyazf       netifyazg       netifyazh       netifyazi       netifyazj       netifyazk   netifyazl        netifyazm       netifyazn       netifyazo       netifyazp       netifyazq       netifyazr       netifyazs       netifyazt       netifyazu       netifyazv       netifyazw       netifyazx       netifyazy       netifyazz
# ...       netifyaoe       netifyaof       netifyaog       netifyaoh       netifyaoi       netifyaoj       netifyaok       netifyaol       netifyaom       netifyaon
# ...       netifyaoo       netifyaop       netifyaoq       netifyaor       netifyaos    netifyaot       netifyaou       netifyaov       netifyaow
# ...       netifyaox       netifyaoy       netifyaoz       netifyapa       netifyapb       netifyapc       netifyapd       netifyape       netifyapf
# ...       netifyapg       netifyaph       netifyapi   netifyapj        netifyapk

*** Test Cases ***
Check
    Login Netify Mail Website
    FOR    ${account}    IN    @{Check}
        Login To Check Account Is Registered    ${account}
        Log To Console    ${account} login success.
    END

test
    FOR    ${account}    IN    @{accounts}
        Register Account    ${account}
        Log To Console    ${account} register success.
    END
    # Input Sex    1
    # Input Birthday    2000    02    04
    # Input Address    桃園市敬三街
    # Input Phone Nubmer    0912345789
    # Input Education    大學
    # Input Vocation    學生
    # Input Email    asd30135931@gmail.com
    # Reload Page


*** Keywords ***
Register Account
    [Arguments]    ${account}
    Register Netify Mail Website
    Input Account    ${account}
    # Sleep    0.5s
    Input Password1    Netify@99
    # Sleep    0.5s
    Input Password2    Netify@99
    # Sleep    0.5s
    Input Name    ${account}
    # Sleep    1s
    Register    ${account}

Register Netify Mail Website
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Create WebDriver    Chrome    chrome_options=${options}
    Go To    ${regisWeb}
    Maximize Browser Window

Login Netify Mail Website
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Create WebDriver    Chrome    chrome_options=${options}
    Go To    https://mail.mycat.tw/
    Maximize Browser Window

Input Account
    [Arguments]    ${account}
    Input Text After It Is Visible    //*[@name='account']    ${account}

Input Password1
    [Arguments]    ${password}
    Input Text After It Is Visible    //*[@name='password1']    ${password}

Input Password2
    [Arguments]    ${password}
    Input Text After It Is Visible    //*[@name='password2']    ${password}

Input Name
    [Arguments]    ${name}
    Input Text After It Is Visible    //*[@name='fullname']    ${name}

Input Sex
    [Arguments]    ${sex}
    Click Element After It Is Visible    //*[@name='sex' and @value='${sex}']

Input Birthday
    [Arguments]    ${year}    ${month}    ${day}
    Input Text After It Is Visible    //*[@name='year']    ${year}
    Click Element After It Is Visible    //*[@name='month']
    Click Element After It Is Visible    //*[@name='month']//*[@value='${month}']
    Click Element After It Is Visible    //*[@name='day']
    Click Element After It Is Visible    //*[@name='day']//*[@value='${day}']

Input Address
    [Arguments]    ${address}
    Input Text After It Is Visible    //*[@name='address']    ${address}

Input Phone Nubmer
    [Arguments]    ${phoneNumber}
    Input Text After It Is Visible    //*[@name='tel']    ${phoneNumber}

Input Education
    [Arguments]    ${education}
    Click Element After It Is Visible    //*[@name='education']
    Click Element After It Is Visible    //*[@value='${education}']

Input Vocation
    [Arguments]    ${vocation}
    Input Text After It Is Visible    //*[@name='vocation']    ${vocation}
    
Input Email
    [Arguments]    ${email}
    Input Text After It Is Visible    //*[@name='email']    ${email}

Register
    [Arguments]    ${account}
    Click Element After It Is Visible    //*[@name='senddata']
    ${success} =    Run Keyword And Return Status    Wait Until Element Is Visible    //*[normalize-space()='申請帳號成功']    timeout=1.5s
    Run Keyword If    not ${success}    Run Keywords    Close Browser
    ...                                          AND    Register Account    ${account}
    # Run Keyword If    not ${success}    Run Keywords    Close Browser
    # ...                                          AND    Sleep    10s
    # ...                                          AND    Login Netify Mail Website
    # ...                                          AND    Input Account    ${account}
    # ...                                          AND    Input Password1    Netify@99
    # ...                                          AND    Input Password2    Netify@99
    # ...                                          AND    Input Name    ${account}
    # ...                                          AND    Sleep    3s
    # ...                                          AND    Click Element After It Is Visible    //*[@name='senddata']
    # ...                                          AND    Wait Until Element Is Visible    //*[normalize-space()='申請帳號成功']
    Close Browser
    # Close Browser
    # Sleep    1s

Login To Check Account Is Registered
    [Arguments]    ${account}
    Input Text After It Is Visible    //*[@name='loginid']    ${account}
    Input Text After It Is Visible    //*[@name='loginpass']    Netify@99
    Click Element After It Is Visible    //*[@value='登入']
    Select Frame    right
    Wait Until Element Is Visible  //*[@value='切換選取']
    Sleep    0.5s
    Unselect Frame
    Go Back

Click Element After It Is Visible
    [Arguments]    ${path}    ${timeout}=5s    ${error}=Element should be visible before click.
    Wait Until Page Contains Element    ${path}    timeout=${timeout}    error=${error}
    Wait Until Element Is Visible    ${path}    timeout=${timeout}    error=${error}
    Click Element    ${path}

Input Text After It Is Visible
    [Arguments]    ${path}    ${text}    ${timeout}=5s    ${error}=Element should be visible before input.
    Wait Until Page Contains Element    ${path}    timeout=${timeout}    error=${error}
    Wait Until Element Is Visible    ${path}    timeout=${timeout}    error=${error}
    Input Text    ${path}    ${text}