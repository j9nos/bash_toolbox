#!/bin/bash
# author: j9nos

streamcp_id=$(date +%s)
streamcp_file="f_$streamcp_id"
streamcp_dir="d_$streamcp_id"

terminate_streamcp() {
    rm "$streamcp_file"
    exit 1
}

xargs file \
| grep text \
| cut -d: -f1 \
| xargs tail -n +1 > "$streamcp_file"
if [ $(wc -l < "$streamcp_file") -lt 1 ]; then
    terminate_streamcp
fi
mkdir "$streamcp_dir"
mv "$streamcp_file" "$streamcp_dir" 
(
    cd "$streamcp_dir"
    awk '/^==> .* <==$/ {
  		filewpath=$2
  		n=split(filewpath, filearr, "/")
  		next
		}{
      print > filearr[n]
    }' "$streamcp_file"
    rm "$streamcp_file"
)
