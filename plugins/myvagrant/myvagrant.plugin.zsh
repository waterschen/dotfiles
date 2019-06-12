# aliases
alias vup='vagrant up'
alias vh='vagrant halt'
alias vssh='vagrant ssh'
alias vdstr='vagrant destroy'

# ssh into ubuntu box
function ussh() {
    cd $HOME/Developer/ubuntu
    if [[ $(vagrant status) =~ "running" ]]; then
        vagrant ssh
    else
        vagrant up && vagrant ssh
    fi
}
