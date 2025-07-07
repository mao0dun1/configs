#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.25
# Description:Display bluetooth status and battery capacity on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh
    
    ## Global setting variables
        ### Set directory that storage bluetooth file
        bluetooth_dir="/sys/class/bluetooth"
    
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
    ## Function - get bluetooth status
    get_bluetooth_status() {
        if bluetoothctl info | grep -q "Connected: yes"; then
            bluetooth_status="yes"
        else
            bluetooth_status="no"
        fi   
    }

    ## Fuction - get bluetooth battery capacity by tool "bluetoothctl"
    get_bluetooth_battery_capacity() {
        bluetooth_battery_capacity=$(bluetoothctl info | grep -m1 'Battery Percentage' | awk -F'[()]' '{print $2}')
    }



# Main
    ## Get bluetooth status
    get_bluetooth_status
    
    ## Set display icons and color based on the bluetooth_status and bluetooth_battery_capacity
    ## Echo icons and bluetooth_battery_capacity
    case "$bluetooth_status" in
        "no")
            icon="󰂲" color="$normal"
            echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"   
        ;;
        "yes")
            get_bluetooth_battery_capacity
            if ((bluetooth_battery_capacity <= 5)); then
                icon="󰂯" color="$danger"
            elif ((bluetooth_battery_capacity <=30)); then
                icon="󰂯" color="$attention"
            else
                icon="󰂯" color="$normal"
            fi
            echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
                 "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$bluetooth_battery_capacity%</span>"
        ;;
    esac

