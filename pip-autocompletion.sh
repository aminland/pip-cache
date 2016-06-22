# pip bash completion start

_pip_completion() {
        local cur prev first
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[@]:0:${COMP_CWORD}}"
        first="${COMP_WORDS[0]}"


        if [[ ${cur} == -* ]] ; then
                local command_opts var_name

                var_name="_pip_completion_global_opts_${COMP_WORDS// /_}"
                if [ -z ${!var_name} ]; then

                        command_opts=$(${prev} "--help" \
                                \grep -E -o "((-\w{1}|--(\w|-)*=?)){1,2}")

                        declare ${var_name}="${command_opts}"
                fi

                command_opts=${!var_name}

                COMPREPLY=( $(compgen -W "${command_opts}" -- ${cur}) )
                return 0
        fi

        if [[ "${COMP_WORDS[@]:1:1}" == "install" ]] ; then
                COMPREPLY=( $(pip-cache "pkgnames" "${cur}" ) )
                return 0
        fi

        COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                        COMP_CWORD=$COMP_CWORD \
                        PIP_AUTO_COMPLETE=1 $first ) )
        return 0
}

complete -o default -F _pip_completion pip
complete -o default -F _pip_completion pip2
complete -o default -F _pip_completion pip3

# /* vim: set filetype=sh ts=8: */
