#/bin/sh
ABSTRACT
本发明提供一种定制Linux系统制作ISO镜像方法，属于Linux系统的安装领域，本发明根据用户需求来定制化Linux系统，包括定制Linux系统启动信息、安装界面本文标题信息、安装rpm包与启动过程的背景图片信息等；涉及到定制的几个主要步骤如：1、定制安装主控文件ks.cfg；2、定制安装界面文本标题；3、定制安装光盘背景图片。本发明可及时用户需求随时变更，也能根据变更很快地做出响应，重新制作出ISO镜像，从而实现了实时地满足用户需求。
CLAIMS(4)
1.一种定制Linux系统制作ISO镜像方法，其特征在于包括: O定制安装主控文件ks.cfg ； 2)定制安装界面文本标题； 3)定制安装光盘背景图片。
2.根据权利要求1所述的方法，其特征在于， 安装主控文件ks.cfg,指可根据ks.cfg安装主控文件来进行以下三方面的工作:1)定制Linux系统安装及配置；2)定制Linux系统自定义安装准备；3)定制Linux系统用户自定义安装；系统安装及配置一般写在ks.cfg文件最前面，以“%post —nochroot”为结束标志；自定义安装准备以“％post —nochroot”作为开始，以“%post”为结束标志；用户自定义安装以“％post”作为开始；ks.cfg主控文件可用vim直接进行修改，也可以用system-config-kickstart图形化工具进行修改。
3.根据权利要求1所述的方法，其特征在于， 安装界面文本标题控制文件.buildstamp,指可根据.buiIdstamp控制文件来修改Linux系统安装界面文本标题,从而来满足用户的需求；.buildstamp文件位于initrd.1mg文件中，安装光盘运行时进行读取；initrd.1mg是压缩文件,通常是采用cp1压缩或LZMA压缩，不能直接通过vim进行修改,也无法使用mount - o loop挂载；要想对.buildstamp文件进行修改，必须先将initrd.1mg进行解压,然后重新制作initrd.1mg。
4.根据权利要求1所述的方法，其特征在于， 安装光盘背景图片控制文件splash, jpg、install, img,指可修改splash, jpg和install, img文件来定制Linux系统启动过程和安装rpm包时的背景图片,进而来满足用户的需求；splash.jpg位于isolinux目录下,要定制Linux系统启动过程背景图片,直接替换 splash, jpg 即可;install.1mg 位于 images 目录下，是 Squashfs filesystem,可使用mount -ο loop进行挂载,但挂载后其权限是Read-only,要想替换安装rpm包时的背景图片，必须先将其挂载的目录复制到另一目录才行，修改完成后重新制作install, img即可。
DESCRIPTION
—种定制Linux系统制作ISO镜像方法
技术领域
https://www.google.com/patents/CN104375867A?cl=zh
[0001]	本发明涉及计算机领域，尤其是操作系统领域，具体涉及一种定制Linux系统制作ISO镜像方法。

背景技术

[0002]	要实现定制Linux系统制作ISO镜像,首先需要了解Linux启动过程以及Linux启动文件，同时要对Linux发行版本的光盘结构以及软件包的结构进行了解分析。从主机加电到系统服务加载运行，Linux的启动大致需要经历如下的过程:

1、第一阶段

1)加载b1s的硬件信息，并获取第一个启动的设备的代号；

2)读取第一个启动设备的mbr的引导加载程序(Iilo或grub)的启动信息；

3)加载核心操作系统的核心信息，核心开始解压缩，并且尝试驱动所有硬件设备。

[0003]	分析此阶段非常必要，即便是Linux系统的安装也需要加载内核并解压内核、力口载各类外设的驱动信息，构建一个最小化的Linux的文件系统以执行第二阶段的进程。

[0004]	2、第二阶段

1)核心执行init程序并获取运行信息；

2)	init 执行 /etc/rc.d/rc.sysinit 文件；

3)启动核心的外挂模块(/etc/modprobe.conf)；

4)	init执行运行的各个批处理文件(Scripts)；

5)	init 执行 /etc/rc.d/rc.local 文件；

6)执行/bin/login程序，等待用户登陆；

7)登陆之后开始以shell控制主机。

[0005]	通俗的说，Linux的光盘安装就是在第一阶段由install, img构建产生的最小化的Linux文件系统之上运行anaconda之类的安装程序,完成Linux系统的安装过程。在Linux安装过程中第二阶段就是运行anaconda并配合系统安装预设选项完成对系统安装。

[0006]	构建Base Centos Distribut1n的Linux发行版可以简单分为两种方式,第一种是通过结合Kickstart安装预配置文件对Centos系统安装的软件包并结合Kickstart的post及pre的脚本对安装的系统进行初始化的配置；第二种方式是通过添加修改install,img所生成的Linux文件系统达到定制内核、在安装过程添加定义的向导信息等。第一种方式实现便捷、Kickstart有X界面工具操作也相对简单,如要略去光盘中不安装不需要的软件包，并添加第三方的rpm或者tar.gz源码包,就需要深入研究repodata中的comps,xml的基于yum的软件包依赖关系的定义,并能够有基本的shell脚本的累加能力,将要安装的软件包及设置通过脚本实现。相对第二种方式的不足之处就是还是使用Centos的系统并没有对内核或其他参数做明确的发布调整，故此第二种方式就深入修改install, img及anaconda相关的配置实现，以达到发布独立有别于Base Centos Distribut1n的Linux版本。

[0007]	基于Cenotos的Linux发行版的目的是为了在系统中能够快速，正确地建立Linux系统环境。实现的方式以分析Centos的安装光盘为起点，在掌握对应的技巧方法，同时建立相应的测试环境。

[0008]	以centos 6的DVD介质为例，光盘中包含的主要与定制相关的目录如下:

1)	isolinux目录存放光盘启动时的安装界面信息；

2)	repodata目录是与RPM包安装相关的依赖信息；

3)	images目录包括了必要启动映像文件；

4)	Packages目录存放安装软件包信息；

5).discinfo文件是安装介质的识别信息,此文件不可缺少。

发明内容

[0009]	本发明所要解决的技术问题是能够根据用户需求来定制化Linux系统，包括定制Linux系统启动信息、安装界面本文标题信息、安装rpm包与启动过程的背景图片信息等。

[0010]	为了解决上述技术问题，本发明提供了一种定制Linux系统制作ISO镜像方法，该方法中涉及到定制的几个主要步骤如下:

1、定制安装主控文件ks.cfgo ks.cfg文件主要分为三个部分:

1)系统安装及配置；

2)自定义安装准备(％post	—nochroot)；

3)用户自定义安装(％post)；

在系统安装与配置部分，可以通过为选项(如:语言、键盘等)指定参数的形式来进行系统的设置，进而实现系统一步式自动安装；在自定义安装准备部分，可以使用bash语法来添加相应脚本，将用户自己的安装包从安装光盘复制到已经安装好的系统上；在用户自定义安装部分，可以添加相应脚本，来实现文件的下载、软件包的编译以及系统配置文件的修改等工作。按照用户需求来修改ks.cfg文件，从而达到发布定制的目的。

[0011]	2、定制安装界面文本标题。.buildstamp文件可以实现定制Linux系统安装界面文本标题。.buildstamp是隐藏文件,位于initrd.1mg文件中，安装光盘运行时进行读取。initrd.1mg是压缩文件,通常是采用cp1压缩或LZMA压缩,不能直接通过vim进行修改，也无法使用mount - ο loop挂载。要想对.buildstamp文件进行修改,必须先将initrd.1mg进行解压,然后编辑.buildstamp文件,修改为我们所需的文字,最后重新制作initrd.1mg并替换原来的即可。

[0012]	3、定制安装光盘背景图片。启动时的grub背景图片为splash, jpg文件,位于isolinux目录下,可根据用户需求直接更换此图片，以达到定制的要求。安装rpm包时的背景图片在images目录下的install, img文件中，所有安装过程的图片都存在于/usr/share/anaconda/pixmaps目录下,按照用户需求修改此目录下的图片文件即可达到定制的效果。install, img文件是Squashfs filesystem,可使用mount - o loop进行挂载,但挂载后其权限是Read-only，要想修改背景图片，必须先将其挂载的目录复制到另一目录才行，修改完成后重新制作install, img替换原来的即可。

[0013]	本发明的有益效果是:

I)可根据用户需求来定制化Linux系统，及时用户需求随时变更，也能根据变更很快地做出响应，重新制作出ISO镜像，从而实现了实时地满足用户需求；

2)可根据企业公司办公需求来定制化Linux系统，对于需要Linux系统来办公的企业公司来说，其Linux系统功能应尽可能地全面，界面尽可能地方便操作，本发明就可以根据具体需求来定制化Linux系统所需的rpm包，从而实现了方便快捷地服务企业公司办公需求；

3)可根据个人爱好来定制化Linux系统，对于Linux系统爱好者来说，可根据自己喜好来定制个性化的Linux系统，从而达到了永久舒适地满足个人爱好需求。

附图说明

[0014]	图1是本发明实施例的制作步骤流程图。

具体实施方式

[0015]	以下将结合图1及实施例子来详细说明本发明的实施方式，借此对本发明如何应用技术手段来解决技术问题，并达成技术效果的实现过程能充分理解并据以实施。

[0016]	实施例:基于CentOS的Linux发行版来定制Linux系统制作ISO镜像,定制用户自定义压缩文件ufs.tar.gz，定制安装启动时界面文本标题为UFS，定制安装启动时背景图片为 imagel.jpg、image2.png 等。

[0017]	下面是具体定制Linux系统制作ISO镜像实施步骤:
#1、安装制作发行版所需的基本软件包

#yum -y install anaconda ananconda-runtime repodata createrepo mkisofs
2、创建/disk目录，挂载光盘镜像文件，并将其复制到/disk目录

#	mkdir /disk # mkdir /mnt/cdrom

Il挂载iso文件，此处的XXX是CentOS-6.5_x86—64-minimal.1so文件所在的绝对路径。

[0018]	# mount _t iso9660 - o loop /xxx/CentOS-6.5_χ86—64-minimal.1so /mnt/cdrom

#	cd /mnt/cdrom

# tar -cf -.1 ( cd /disk ; tar -xvpf -)。

[0019]	3、拷贝系统所需rpm包

#	cd /disk; awk J/Installing/{print $2}’ 〜/install, log | xargs -1 cp /mnt/cdrom/Packages/{}.rpm Packages/。

[0020]	4、定制安装主控文件ks.cfg %post —nochroot

cp -f /mnt/source/ufs.tar.gz /mnt/sysimage/

%post

cd / && tar -zxvf ufs.tar.gz && chmod +x /ufs/usr/binA rm /ufs.tar.gz

cp -rf /ufs/usr/binA /usr/bin/ cp -rf /ufs/etc/木 /etc/

sed -1 〃s/CentOS/UFS/g〃 /etc/rc.d/rc.sysinit

以上截取的是ks.cfg文件的一小部分，添加了用户自定义压缩文件，修改了 Linux系统启动后显示信息，达到定制效果。

[0021]	5、修改isolinux目录下的isolinux.cfg文件，添加如下内容: default ks

label ks kernel vmlinuz

append ks=cdrom:/ks.cfg initrd=initrd.1mg。

[0022]	6、定制安装界面文本标题

将安装过程中的CentOS字样替换为UFS，需修改initrd.1mg文件中的.buildstamp文件。

[0023]	I)解压initrd.1mg文件(通过file initrd.1mg查看其压缩文件格式)

A)	cp1压缩格式

#	cd /disk/isolinux/

#	cp initrd.1mg /tmp/initrd.1mg.gz

#	cd /tmp

#	gunzip initrd.1mg.gz

#	mkdir initrd

#	mv initrd.1mg initrd

#	cd initrd

#	cp1 -1vmd < initrd.1mg

#	rm - f initrd.1mg

然后修改.buildstamp文件，将CentOS改为UFS即可

B)	LZMA压缩格式

#	cd /disk/isolinux/

#	cp initrd.1mg /tmp/

#	cd /tmp

#	mkdir initrd

#	mv initrd.1mg initrd

#	cd initrd

#	xz - cd initrd.1mg | cp1 -1d

#	rm - f initrd.1mg

然后修改.buildstamp文件，将CentOS改为UFS即可

2)制作initrd.1mg文件

#	find.1 cp1 -c -ο | xz _9 —format=lzma >../initrd.1mg

#	cp initrd.1mg /disk/isolinux/。

[0024]	7、定制安装启动时背景图片

将启动时grub背景图片splash, jpg替换为imagel.jpg,安装rpm包时背景图片progress—first, png 替换为 image2.png。

[0025]	splash, jpg 位于/disk/isolinux/ 目录下，直接替换即可。progress—first, png位于/disk/images/install, img镜像文件中，需将其mount后才能替换。

[0026]	I)挂载 install, img 镜像文件

#	mkdir /media/intall

#	mount - o loop /disk/images/install, img /media/intall

#	cp - ar /media/intall /tmp

将 /tmp/install/usr/share/anaconda/pixmaps/ 目录下的 progress—first, png 替换为 image2.png

2)制作install, img镜像文件

#	mksquashfs /tmp/anaconda /tmp/stage2.1mg -all-root -noF

#	cp /tmp/install, img /disk/images/。

[0027]	8、生成 comps, xml

先进入 /disk/repodata 目录，将 “*-x86—64-comps.xml ” 文件改为 “comps, xml”，并且将其他文件删除。

[0028]	# cd /disk/ repodata

#	mv 氺—comps, xml comps, xml

#	Is.|grep -v “comps, xml，，| xargs _i rm -f {}

然后返回到/disk根目录，就可以重新开始生成comps, xml文件了。

[0029]	# cd /disk/

#	createrepo -g repodata/comps, xml./

#	declare -χ discinfo= head -1.discinfo

#	createrepo _u 〃media://$discinfo〃 -g repodata/comps, xml /disk/

此时，comps, xml文件和其他相关联的文件已被重新生成到repodata目录下。

[0030]	注意:如果你新增或删除了 Packages目录的rpm包，请重新生成comps, xml文件。

[0031]	9、生成iso镜像文件

#	cd /disk/

#	mkisofs -ο UFS.1so _b isolinux/isolinux.bin _c isolinux/boot.cat-no-emul-boot -boot-load-size 4 -boot-1nfo-table -R -J -v -T /disk/。

[0032]	由本发明的实施例子可见，本发明可以通过基于已发行的Linux系统来制作ISO镜像定制化自己的Linux系统，可定制的方面有很多，并不局限于本发明中所提及的。