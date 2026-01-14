ps -ef | grep "idf.py monitor" | awk 'NR==1 {print $2}' | xargs -I {} kill -9 {}

