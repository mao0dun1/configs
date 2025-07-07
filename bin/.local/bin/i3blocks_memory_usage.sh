#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.25
# Description:Display memory usage on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh
    
    ## Global setting variables
        ### Set directory that storage memory information 
        meminfo_dir="/proc/meminfo"

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
        icon=""
        ### Unicode space (U+2009)
        thin_space=""
     


# Functions
    ## Function - get current memory usage percent
    get_memory_usage() {
        memory_usage="$(free | awk '/Mem:/ {printf "%.0f\n", $3/$2 * 100}')"
    }

  
      
# Main
    ## Get memory usage
    get_memory_usage

    ## Set colors based on memory_usage
    if [ "$memory_usage" -ge 95 ]; then
        color="$danger"  
    elif [ "$memory_usage" -ge 70 ]; then
        color="$attention"  
    fi        

    ## Render cpu information
    echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
         "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$memory_usage%</span>"
         
