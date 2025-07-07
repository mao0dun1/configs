#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.23
# Description:Display wifi status and signal strength on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh
    
    ## Global setting variables
        ### Set directory that storage wifi interface information
        net_dir="/sys/class/net"
        ### Set directory that storage wireless information
        wireless_dir="/proc/net/wireless"

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
    ## Function - get wifi interface name
    get_wifi_interface_name() {
        wifi_interface_name="$(ip link show | awk '/^[0-9]+: w/ {print $2}' | sed 's/://')"
    }

    ## Function - get wifi interface status
    get_wifi_interface_status() {
        wifi_interface_status="$(cat $net_dir/$wifi_interface_name/operstate 2>/dev/null)"
    }


    ## Fuction - get wifi signal strength
    get_wifi_signal_strength() {
        ### Percent = (current_dBm - weakest_dBm(-100) ) / (strongest_dBm(-30) - weakest_dBm(-100)) * 100
        wifi_signal_strength=$(awk -v intf="$wifi_interface_name" '$0 ~ "^"intf {print int($3 * 100 / 70)"%"}' /proc/net/wireless 2>/dev/null)
    }



# Main
    ## Get wifi interface name
    get_wifi_interface_name

    ## Get wifi interface status
    get_wifi_interface_status

    ## Get wifi signal strength
    get_wifi_signal_strength

    ## Set display icon and color based on the interface_status and signal_strength
    case "$wifi_interface_status" in
        "down")
            icon="󰖪" color="$normal"
        ;; 
        "up")
            icon="󰖩" color="$normal"
        ;;
        *)  # Unknown status
            icon="󰖪" color="$danger"
        ;;
    esac

    ## Render wifi information
    echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
         "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$wifi_signal_strength</span>"
