#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.23
# Description:Display battery status and capacity on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh

    ## Global setting variables
        ### Set directory that storage battery file 
        power_supply_dir="/sys/class/power_supply"

    ## Render format options
        ### change icons absolute format by using "font_desc"
        ### Options: font number
        icon_format_absolute="12"
        ### change text absolute format by using "font_desc"
        ### Options: font name & font number
        text_format_absolute="JetBrainsMonoNerdFont-Bold.ttf 11"
        ### change text relative size by using "size"
        ### Options: xx-small,x-small,small,medium,large,x-large,xx-large
        text_size_relative="medium"
        ### change icons and text color by using "color"
        color="$normal"
        ### Unicode space (U+2009)
        thin_space=""       


  
# Functions
    ## Function - get battery file dir
    get_battery_file_dir() {
        ### Get all battery files dirs
        local battery_files_dirs=("$power_supply_dir"/BAT*)
        ### If the battery files path not exist 
        if [[ ${#battery_files_dirs[@]} -eq 0 ]] || ! [[ -d "${battery_files_dirs[0]}" ]]; then
            local icon="󱟩"
            echo "<span font_desc='$icon_format_absolute' color='$danger'>$icon</span>"
            exit 1
        fi    
        ### Get the frist battery file path
        battery_file_dir="${battery_files_dirs[0]}"    
    }

    ## Function - get battery information from battery file
    get_battery_info() {
        ## Get battery basic information 
        battery_status=$(<"$battery_file_dir/status")
        battery_capacity=$(<"$battery_file_dir/capacity")
        ## Set level number be in 0~100
        ((battery_capacity = battery_capacity > 100 ? 100 : battery_capacity))
        ((battery_capacity = battery_capacity < 0 ? 0 : battery_capacity))
    }


    
# Main
    ## Get battery file dir
    get_battery_file_dir

    ## Get battery information from battery file 
    get_battery_info

    ## Set display icon and color based on the battery_status and battery_capacity
    case "$battery_status" in
        "Discharging")
            if ((battery_capacity <= 5)); then
                icon="󰂎" color="$danger"
            elif ((battery_capacity <= 30)); then
                icon="󰁺" color="$attention"  
            else
                icon="󰂁" color="$normal"
            fi
        ;; 
        "Not charging")
            icon="" color="$normal"
        ;;   
        "Charging"|"Full")
            icon="󰂄" color="$better"
        ;;  
        *)  # Unknown status
            icon="󱟩" color="$danger"
        ;;
    esac

    ## Render battery information
    echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
         "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$battery_capacity%</span>"
