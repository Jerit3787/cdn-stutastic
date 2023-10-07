#!/bin/bash

downloadFiles=("img-2.jpg" "img-3.jpg" "img-4.jpg" "img-5.jpg")
#downloadFiles=("banner-2.jpg" "banner-3.jpg" "banner-4.jpg" "banner-5.jpg")

localFiles=("banner-2.jpg" "banner-3.jpg" "banner-4.jpg" "banner-5.jpg")

sudo mkdir cache

for i in ${!downloadFiles[@]}; do
    echo "Downloading file from the main server..."
    sudo wget -q -P ./cache http://tgb.mrsm.edu.my/data/index/slider-1/${downloadFiles[$i]}

    if [ $? -ne 0 ]; then 
        # The command failed, print an error message 
        echo "The download failed with exit status $?" 
        # Exit the script with a non-zero exit status to indicate failure 
        exit 1 
    else 
        # The command was successful, print a success message 
        echo "The download succeeded with exit status $?" 

        echo "Comparing file contents..."
        if cmp --silent -- "./cache/${downloadFiles[$i]}" "./assets/img/${localFiles[$i]}"; then
            echo -e "File content is identical. No file replacement needed \n\n"
        else
            echo "File content is not identical. Replacing files"
            cp ./cache/${downloadFiles[$i]} ./assets/img/${localFiles[$i]}
            if [ $? -ne 0 ]; then 
                # The command failed, print an error message 
                echo "The download failed with exit status $?" 
                # Exit the script with a non-zero exit status to indicate failure 
                exit 1
            else 
            # The command was successful, print a success message 
                echo -e "The file replacement succeeded with exit status $? \n\n" 
            fi
        fi
    fi
done

rm -r cache

echo "Files successfully synced!"


