#!/usr/bin/env zsh

# $1 - Required - App name
# $2 - Required - Icon name
# $3 - Optional - Custom path
fix_icon()
{
    path_current_icon=${$(compgen -G "${${3#0}:-"/Applications"}/${1}.app/Contents/Resources/${2}.icns")//'\n'/}
    path_new_icon="${script_folder}/icons/${${${1:l}//[ .]/_}//\*/}.icns"

    if [[ ! -f ${path_current_icon} ]] then
        # echo "${1//\*/} - Skipped - Does not exist"
        return
    fi

    shasum_current_icon=$(shasum --algorithm 256 ${path_current_icon} | cut -d " " -f 1 )
    shasum_new_icon=$(shasum --algorithm 256 ${path_new_icon} | cut -d " " -f 1 )

    if [[ ${shasum_current_icon} = ${shasum_new_icon} ]] then
        echo "${1//\*/} - Skipped - Already replaced"
        return
    fi

    cp "${path_new_icon}" "${path_current_icon}"
    touch "/Applications/${1//\*/}.app"

    echo "${1//\*/} - Replaced"
}

script_folder="${0:A:h}"

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

fix_icon "Battle.net" "default"
fix_icon "Firefox" "firefox"
fix_icon "HandBrake" "HandBrake"
fix_icon "MKVToolNix*" "MKVToolNix"
fix_icon "Opera" "app"
fix_icon "Plex" "Desktop"
fix_icon "Spotify" "Icon"
fix_icon "The Unarchiver" "unarchiver"
fix_icon "Transmission" "Transmission"
fix_icon "World of Warcraft" "wow" "/Applications/World of Warcraft/_retail_"
