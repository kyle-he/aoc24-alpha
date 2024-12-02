#!/bin/bash

# this was honestly pretty fun, not much else to say

# Open the input file
part1=0
while IFS= read -r line; do
    prev=-1

    all_in_range_1_3=true
    all_in_range_neg1_neg3=true

    for number in $line; do
        if [ "$prev" -eq -1 ]; then
            prev=$number
        else
            diff=$((number - prev))
            if ! (( diff >= 1 && diff <= 3 )); then
                all_in_range_1_3=false
            fi

            if ! (( diff <= -1 && diff >= -3 )); then
                all_in_range_neg1_neg3=false
            fi
        fi
        prev=$number
    done

    if $all_in_range_1_3 || $all_in_range_neg1_neg3; then
        ((part1++))
    fi
done < input.txt

echo "Part 1: $part1"

part2=0
while IFS= read -r line; do
    numbers=($line)

    for ((i = 0; i < ${#numbers[@]}; i++)); do
        modified_line=("${numbers[@]:0:$i}" "${numbers[@]:$((i + 1))}")
        
        prev=-1
        all_in_range_1_3=true
        all_in_range_neg1_neg3=true

        for number in "${modified_line[@]}"; do
            if [ "$prev" -eq -1 ]; then
                prev=$number
            else
                diff=$((number - prev))
                if ! (( diff >= 1 && diff <= 3 )); then
                    all_in_range_1_3=false
                fi

                if ! (( diff <= -1 && diff >= -3 )); then
                    all_in_range_neg1_neg3=false
                fi
            fi
            prev=$number
        done

        if $all_in_range_1_3 || $all_in_range_neg1_neg3; then
            ((part2++))
            break 
        fi
    done
done < input.txt

echo "Part 2: $part2"