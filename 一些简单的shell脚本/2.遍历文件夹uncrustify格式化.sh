
#!/bin/sh
function scandir() {
local cur_dir parent_dir workdir
workdir=$1
cd ${workdir}
if [ ${workdir} = "/" ]
then
cur_dir=""
else
cur_dir=$(pwd)
fi

#echo $cur_dir"/"
/usr/local/bin/uncrustify -c ~/.uncrustify_obj_c.cfg -l OC+ $cur_dir"/"*.h --no-backup --mtime
/usr/local/bin/uncrustify -c ~/.uncrustify_obj_c.cfg -l OC+ $cur_dir"/"*.m --no-backup --mtime


for dirlist in $(ls ${cur_dir})
do
if test -d ${dirlist};then
cd ${dirlist}
scandir ${cur_dir}/${dirlist}
cd ..
fi
done
}


scandir $1
