#!/usr/bin/env bash

# function:对jpeg图片进行图片质量压缩
# $1:压缩百分比

function image_compress_quality {
	for img in *.jepg;do
	        [[ -e "$img" ]] || break  # handle the case of no *.jepg files
	        convert "$img" -quality "$1" "$img"
		echo "$img is successfully compressed of quality $1"
	done
}

# function:对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
# $1:压缩百分比

function  image_compress_resolution {
	for img in *.jepg *.png *.svg;do
	    [[ -e "$img" ]] || break  
		convert "$img" -resize "$1" "$img"
		echo "$img is successfully compressed of resolution $1"
	done
}

# function:对图片批量添加自定义文本水印
# $1:水印文本

function add_watermark {
	while IFS= read -r -d '' img
	do
	    [[ -e "$img" ]] || break  
		mogrify -pointsize 16 -fill black -weight bolder -gravity southeast \
			-annotate +5+5 "$1" "$img"
		echo "watermark $1 is successfully added on $img"
	done <   <(find ../image -iname '*.*' -print0)
}

# function:批量添加文件名前缀
# $1:文件名前缀
!
function add_prefix {
	while IFS= read -r -d '' img
	do
		mv "$img" "$1""$img"
		echo "$img is renamed as $1$img"
	done <   <(find ../image -iname '*.*' -print0)
}

# function:批量添加文件名后缀
# $1:文件名后缀

function add_suffix {
        while IFS= read -r -d '' img
		do
                mv "$img" "$img""$1"
                echo "$img is renamed as $img$1"
        done <   <(find ../image -iname '*.*' -print0)

}

# function:将png/svg图片转换为jpg图片

function image_transform {
	while IFS= read -r -d '' img
		do
		type=${img##*.}
		if [[ $type == "png"||$type == "svg" ]];then
			covert "$img" "${img%%.*}".jpg
			echo "$img is successfully converted to ${img%%.*}.jpg"
		fi
	done <   <(find ../image -iname '*.*' -print0)
}

# function:帮助信息

function help {
	echo "HELP INFORMATION OF PARAMETER:"
	echo "-a               对jpeg格式图片进行图片质量压缩"
        echo "-b               对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率"
        echo "-m               批量添加自定义文本水印"
        echo "-p               统一添加文件名前缀"
        echo "-s               统一添加文件名后缀"
        echo "-t               将png/svg图片统一转换为jpg格式图片"
        echo "-h               帮助文档"
}

if [[ $# -lt 1 ]];then
	echo "没有输入值"
	exit 1
else
	array=("$@")
	i=0
	while [[ $i -lt $# ]];do
		if [[ ${array[$i]} == "$1" ]];then
			cd "$1" || exit
		else
			case ${array[$i]} in
				-a)
					image_compress_quality "${array[$((i+1))]}";;
				-b)
					image_compress_resolution "${array[$((i+1))]}";;
                                -m)
                                        add_watermark "${array[$((i+1))]}";;
                                -p)
                                        add_prefix "${array[$((i+1))]}";;
                                -s)
                                        add_suffix "${array[$((i+1))]}";;
                                -t)
                                        image_transform;;
                                -h)
                                        help;;
                        esac
                fi
                echo "${array[$((i+1))]}"
        done
        exit 0
fi
