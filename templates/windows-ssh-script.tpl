add-content -path c:/users/richa/.ssh/config -value @'

Host ${hostname}
    Hostname ${hostname}
    User ${user}
    IdentityFile ${Identityfile}
'@