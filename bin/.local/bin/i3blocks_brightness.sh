#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.25
# Description:Display screen brightness on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh
    
    ## Global setting variables
        ### Set directory that storage brightness file 
        backlight_dir="/sys/class/backlight"

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
        ### Set default icon
        icon=""
        ### Unicode space (U+2009)
        thin_space=""
                              

      
# Functions
    ## Function - get brightness by tool "brightnesctl"
    get_brightness() {
        brightness="$(brightnessctl | awk '/%/{gsub("[()]", "", $4); print $4}')"
    }


      
# Main
    ## Get current brightness
    get_brightness

    ## Render brightness information
    echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
         "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$brightness</span>"
         
