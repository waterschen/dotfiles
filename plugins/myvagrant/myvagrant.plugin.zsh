# aliases
alias vup='vagrant up'
alias vh='vagrant halt'
# alias vssh='vagrant ssh'
alias vdstr='vagrant destroy'

# ssh into vagrant devbox
function vssh() {
    cd $HOME/Developer/vagrant
    if [[ $(vagrant status) =~ "running" ]]; then
        vagrant ssh
    else
        vagrant up && vagrant ssh
    fi
}
