#!/bin/bash


function resize_image() {
    local input=${1?usage input res output}
    local res=${2?usage input res output}
    local output=${3?usage input res output}

    if [ -f "$output" ]; then
#        echo "skip - $input $output"
        return 1
    fi

    echo convert $input -resize ${res}x $output
    convert $input -resize ${res}x $output
}

################################################################################
# 620
# 980

if [ -n "$1" ]; then
    input="$1"
    res2=${2-980}
    output="${input%.*}-${res2}.${input##*.}"
    resize_image $input $res2 $output
fi

echo 'disabled'; exit 0


if /bin/false; then

cd images

for i in $(find .. -name '*.md'); do 
    input=$(grep teaser $i|sed 's/\s*teaser: //')

    if [ ! -f "$input" ]; then
        continue
    fi

    res1=620
    out1="${input%.*}-${res1}.${input##*.}"
    resize_image "$input" "$res1" "$out1"

#    sed -i 's#teaser: '$input'#teaser: '$out1'#' $i


    input="$(grep feature $i|sed 's/\s*feature: //')"

    if [ ! -f "$input" ]; then
        continue
    fi

    res2=980
    out2="${input%.*}-${res2}.${input##*.}"
    resize_image "$input" "$res2" "$out2"

#    sed -i 's#feature: '$input'#feature: '$out2'#' $i


done

fi

regex="!\[([^]]*)\]\(([^)]*)\)"
MD=qtquickcontrols-nemo.md
res=160
MD=glacier-home.md
res=325

IFS=$'\n'
for i in $(grep images "$MD"); do
    if [[ "$i" =~ $regex ]]; then
        input=${BASH_REMATCH[2]}
        out="${input%.*}-${res}.${input##*.}"

#        sed  's#'$input'#'$out'#' -i "$MD"
#        resize_image "./$input" "$res" "./$out"
#        optipng "./$out"
    else 
        echo not match $i
    fi
done

#find . -name "*.png" -exec optipng '{}' \;
#find . -name "*.jpg" -exec jpegoptim '{}' \;