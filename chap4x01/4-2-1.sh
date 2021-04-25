#!/usr/bin/env bash

# function:统计不同年龄（20岁以下、20-30岁、30岁以上）的球员数量及百分比
# $1:数据文件

function count_age {
awk -F "\t" 'BEGIN{a=0;b=0;c=0;sum=-1}{sum++;if($6<20){a++} else if($6>=20&&$6<=30){b++} else{c++}}END{printf "players aged in [0,20): %d(%.2f%%)\nplayers aged in [20,30]: %d(%.2f%%)\nplayers aged in (30,+inf): %d(%.2f%%)\n",a,a*100/sum,b,b*100/sum,c,c*100/sum}' $1

}

# function:统计不同位置的球员数量、百分比
# $1:数据文件

function count_position {
awk -F "\t" 'BEGIN{sum=-1}{sum++;a[$5]++}END{for(i in a){if(i!="Position"){printf "players of %s: %d(%.2f%%)\n",i,a[i],a[i]*100/sum}}}' $1
}

# fuction:求名字最长和名字最短的球员
# $1:数据文件

function count_name{
	len=$(awk -F "\t" '{if($9!="Player"){print length($9)}}' $1)
	min=100
	max=0

	for i in $len;do
		if [[ $i -lt $min ]];then
			min=$i
		fi
		if [[ $i -gt $max ]];then
			max=$i
		fi
	done
	echo "player who has the longest name:$max"
	echo "player who has the shortest name:$min"
}

# function:求年龄最大和年龄最小的球员
# $1:数据文件

function count_oldest_youngest{
	age=$(awk -F "\t" '{if($6!="Age"){print $6}}' $1)
	min=100
	max=0

	for i in $age;do
		if [[ $i -lt $min ]];then
			min=$i
		fi
		if [[ $i -gt $max ]];then
			max=$i
		fi
	done
	awk -F "\t" 'BEGIN{printf "the oldest player:\n"}{if($6=="'"$max"'"){printf "%s: %d\n",$9,$6}}' $1
        awk -F "\t" 'BEGIN{printf "the youngest player:\n"}{if($6=="'"$min"'"){printf "%s: %d\n",$9,$6}}' $1
}

# function:帮助信息

function help{
	echo "HELP INFORMATION OF PARAMETERS"
        echo "-a [data_file]      统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比"
        echo "-b [data_file]    统计不同场上位置的球员数量、百分比"
        echo "-c [data_file]    得到名字最长的球员与名字最短的球员"
        echo "-d [data_file]    得到年龄最大的球员与年龄最小的球员"
        echo "-h                帮助文档"
}

if [[ $# -lt 1 ]];then
        echo "无输入信息"
        exit 1
else
        case $2 in
                -a)
                        count_age $1
                        exit 0;;
                -b)
                        count_position $1
                        exit 0;;
                -c)
                        count_name $1
                        exit 0;;
                -d)
                        count_oldest_youngest $1
                        exit 0;;
                -h)
                        help
                        exit 0;;
        esac
fi

