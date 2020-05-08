####################
# functions
####################

# print available colors and their numbers
function colours() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# Custom make command
mk() {
    output="${1%.c}"
    echo "gcc -ggdb -std=c99 -Wall -Werror ${@} -o $output";
    gcc -ggdb -std=c99 -Wall -Wextra -Werror ${@} -o $output;
}

# My custom alias for CS50 By Harvard University
mk50() {
    output="${1%.c}"
    echo "cc -ggdb -std=c99 -Wall -Werror .c -lcrypt -lcs50 -lm ${@} -o $output";
    cc -ggdb -std=c99 -Wall -Werror .c -lcrypt -lcs50 -lm ${@} -o $output;
}
