#!/usr/bin/bash

# Author:maodun
# Modifydate:2025.6.25
# Description:Display cpu usage on swaybar
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html
#          https://docs.gtk.org.cn/Pango/pango_markup.html



# Config
    ## Exec other shellscripts to refer variables or functions
    . $HOME/.local/bin/i3blocks_colors.sh
    
    ## Global setting variables
        ### Set directory that storage cpu information 
        stat_dir="/proc/stat"

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
        icon=""
        ### Unicode space (U+2009)
        thin_space=""
     
 
   
# Functions
    ## Function - get cpu usage
    get_cpu_usage() {
        ### Firstly get current accumulated CPU time for each component
        read -r cpu user nice system idle iowait irq softirq steal _ < $stat_dir
        ### Firstly caculate total time and idle time
        local total1=$((user + nice + system + idle + iowait + irq + softirq + steal))    
        local idle1=$((idle + iowait))
        ### Delay 1 s
        sleep 1
        ### Secondly get current accumulated CPU time for each component
        read -r cpu user nice system idle iowait irq softirq steal _ < $stat_dir
        ### Secondly caculate total time and idle time
        local total2=$((user + nice + system + idle + iowait + irq + softirq + steal))
        local idle2=$((idle + iowait))
        ### Caculate total time and idle time during 1 s
        local total_diff=$((total2 - total1))
        local idle_diff=$((idle2 - idle1))
        ### Caculate cpu usage percent during 1 s
        cpu_usage=$((100 * (total_diff - idle_diff) / total_diff)) 
    }
    

      
# Main
    ## Get Cpu usage
    get_cpu_usage
 
    ## Set colors based on cpu_usage
    if [ "$cpu_usage" -ge 95 ]; then
        color="$danger"  
    elif [ "$cpu_usage" -ge 70 ]; then
        color="$attention"  
    fi        

    ## Render cpu information
    echo "<span font_desc='$icon_format_absolute'                            color='$color'>$icon</span>"\
         "<span font_desc='$text_format_absolute' size='$text_size_relative' color='$color'>$thin_space$cpu_usage%</span>"
