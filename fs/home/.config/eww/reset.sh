#!/usr/bin/env bash

killall eww
eww daemon --debug
eww open-many bar_center_0 bar_center_1 
eww open-many bar_left_0 bar_left_1 bar_right_0 bar_right_1

