#! /bin/sh
function initdir(){
for i in {0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}
 do
        for j in {0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}
        do
                str=$i$j
                case $str in
                00)
                        for m in {0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}
                        do
                                for l in {0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}
                                do
                                        rts=$m$l
                                        mkdir -p $dirname/$str/$rts $dirname/tmp/$str/$rts
                                done
                        done
                        ;;
                *)
                        mkdir -p $dirname/$str $dirname/tmp/$str 
                        cp -r $dirname/00/* $dirname/$str/
                        cp -r $dirname/00/* $dirname/tmp/$str/
                        ;;
                esac
        done
done
echo "目录初始化完成！"
}
echo "请输入初始化的存储目录路径(根路径必须是/surfs):"
read dirname
if [ ! -d "$dirname" ];then
	mkdir -p  $dirname
	echo "正在进行目录初始化，大概需要40s时间......."
	initdir
else
	num=`ls $dirname|wc -l`
	case $num in
		0)
			initdir
			;;
		*)
			echo "$dirname 目录下不为空，需要确认并清空目录然后再初始化"
			exit 0
			;;
	esac
fi
datestr=`date  "+%Y%m%d%H%M%S"`
echo "volumeID=$datestr">$dirname/volume.cfg
