#!/bin/bash
echo 'Starting Teamviewer autoclose script'
while [ true ]; do
	#Build array of teamview class windows
	arr=($(xdotool search --onlyvisible --class teamviewer))
	length=${#arr[@]}
	i=0
	echo "Currently $length running instances"
	while [ $i -lt $length ]; do
		name=$(xdotool getwindowname ${arr[i]} | sed 's/[\x01-\x1f\x7f]//g');
		WIDTH=$(xdotool getwindowgeometry --shell ${arr[i]} | grep WIDTH | sed 's/[^0-9]*//g')
		HEIGHT=$(xdotool getwindowgeometry --shell ${arr[i]} | grep HEIGHT | sed 's/[^0-9]*//g')
		area=$(($WIDTH*$HEIGHT))
		echo "Examining window with dimensions $WIDTHx$HEIGHT"

		# Kill the annoying windows by name comparison
		if [[ $name == 'Change random password?' ]] || [[ $name == 'Sponsored session' ]]; then
			xdotool windowunmap ${arr[i]};
			echo "Killed window $name"
		
		# Leave ID/Password window untouched
		elif [ $area -gt 100000 ]; then
			temp=1
		
		# Lower other windows
		else
		arr2=($(wmctrl -l -x | grep 'TeamViewer' | awk '{ print $1 }'))
		length2=${#arr2[@]}
	        j=0
        	while [ $j -lt $length2 ]; do
			wmctrl -i -r ${arr2[j]} -b add,below
			let j+=1;
		done
		fi
	let i+=1;
	done
	sleep 1;
done
