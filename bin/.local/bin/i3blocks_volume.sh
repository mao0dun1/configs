#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.25
# Description:Display volumn status and level on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh

    ## Global setting variales
        ### Custom volume max limit
        volume_max_limit=150 
        ### Set directory that storage sound file 
        sound_dir="/sys/class/sound"
        
    ## Render format options
        ### change icons absolute format by using "font_desc"
        ### Options: font number
        icon_format_absolute="11"
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
    ## Function - get current sink whether muted
    get_current_sink_is_muted() {
        is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    }
    
    ## Function - get current sink volume
    get_current_sink_volume_level() {
        volume_level=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/front-left:/ {print $5}' | tr -d '%')
    }
    

      
# Main    
    ## Get whether current sink is muted
    get_current_sink_is_muted

    ## Get current sink volume level
    get_current_sink_volume_level

    ## Set display icons and colors based on is_muted and volume_level
    case "$is_muted" in
        "yes")
            icon="" 
        ;;
        "no")
            icon=""
            ### Detech whether volume_level get the max
            if ((volume_level >= "$volume_max_limit")); then
                #### Reset current sink volume to 100% 
                pactl set-sink-volume \@DEFAULT_SINK@ 100%
                #### Update volume_level variable
                get_current_sink_volume_level
            elif ((volume_level > 100)); then
                color="$attention"
            else
                color="$normal"
            fi
        ;;
    esac

    ## Render volume information
    echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
         "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$volume_level%</span>"
         
