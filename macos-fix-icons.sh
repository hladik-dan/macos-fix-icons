#!/usr/bin/env zsh

fix_icon()
{
    path_current_icon="/Applications/${1}.app/Contents/Resources/${2}.icns"
    path_new_icon="${0:A:h}/icons/${1:l}.icns"

    shasum_current_icon=$(shasum --algorithm 256 ${path_current_icon} | cut -d " " -f 1 )
    shasum_new_icon=$(shasum --algorithm 256 ${path_new_icon} | cut -d " " -f 1 )

    if [[ ${shasum_current_icon} = ${shasum_new_icon} ]] then
        echo "${1} - Skipped - Already replaced"
    else
        cp "${path_new_icon}" "${path_current_icon}"
        touch "/Applications/${1}.app"

        echo "${1} - Replaced"
    fi
}

fix_icon "Opera" "app"
fix_icon "Plex" "Desktop"
fix_icon "Spotify" "Icon"
