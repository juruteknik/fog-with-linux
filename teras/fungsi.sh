#
#  Penambahbaikan sistem pemulihan FOG by Chuck Syperski & Jian Zhang
#  untuk Projek Sarjana Muda 
#
#   Pemulihan Komputer dengan Imej Backup di Rangkaian

#   Nama : Shaharudin bin Ahmad
#   Kursus : Sarjana Muda Teknologi Maklumat dengan Pengkomputeran Rangkaian 
#            Dengan Kepujian

#   Pemasangan FOG diperlukan sebelum pemasangan sistem ini
#
#
#
#

clearScreen()
{
	echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
}

salinData()  #salin direktori
{
	echo -n "  * Menyalin direktori berkaitan";
	cp -f ${fogtsrc} ${fogtdst}      #fog system agent logo sekolah
	mkdir -p /tftpboot/skb/ >/dev/null 2>&1;
	mkdir -p /tftpboot/skb/menus/ >/dev/null 2>&1;
	mkdir -p /tftpboot/skb/pics/ >/dev/null 2>&1;
	mkdir -p /tftpboot/skb/linux/ >/dev/null 2>&1;
	mkdir -p /tftpboot/skb/linux/zorin/ >/dev/null 2>&1;
	cp -f ${bgsrc} ${bgdst}       #gambar bg
	echo "...OK";	
}

konfigTFTPPXE()
{
	echo -n "  * Mengkonfigurasi TFTP dan PXE berkaitan";
	mv /tftpboot/pxelinux.cfg/default /tftpboot/pxelinux.cfg/backup.default
	cp -f ${defsrc} ${defdst}   #salin /tftpboot/pxelinux.cfg/default
	cp -f ${tplsrc} ${tpldst}   #salin /tftpboot/skb/menus/template.cfg

	echo "MENU BACKGROUND skb/pics/bg.png

	menu color screen	37;40	#80ffffff #00000000 std
	menu color border	30;44	#0ef40a #00000000 std
	menu color title	1;36;44	#0ef40a #00000000 std
	menu color unsel	37;44	#ffffffff #00000000 std
	menu color hotkey	1;37;44	#ffffffff #00000000 std
	menu color select	7;37;40 #000000 #0ef40a all
	menu color hotsel	1;7;37;40	#e0400000 #20ff8000 all
	menu color disabled	1;30;44	#60cccccc #00000000 std
	menu color scrollbar	30;44	#40000000 #00000000 std
	menu color tabmsg	31;40	#90ffff00 #00000000 std
	menu color cmdmark	1;36;40	#c000ffff #00000000 std
	menu color cmdline	37;40	#c0ffffff #00000000 std
	menu color pwdborder	30;47	#80ffffff #20ffffff std
	menu color pwdheader	31;47	#80ff8080 #20ffffff std
	menu color pwdentry	30;47	#80ffffff #20ffffff std
	menu color timeout_msg	37;40	#80ffffff #00000000 std
	menu color timeout	1;37;40	#c0ffffff #00000000 std
	menu color help		37;40	#c0ffffff #00000000 std
	menu color msg07	37;40	#90ffffff #00000000 std" > "/tftpboot/pxelinux.cfg/master.cfg";

	echo "DEFAULT vesamenu.c32
MENU TITLE Sistem Pemulihan FOG
MENU BACKGROUND skb/pics/bg.png
MENU MASTER PASSWD $1$0123456789
\n
menu color title	1;36;44    #0ef40a #00000000 std
menu color border	36;44	#0ef40a #00000000 std
menu color help		36;44	#0ef40a	#00000000 std
menu color unsel	36;44	#0ef40a #00000000 std
menu color sel		36;44	#000000 #0ef40a all
menu color pwdborder	30;47	#0ef40a #00000000 std
menu color pwdheader	31;47	#0ef40a #00000000 std
menu color pwdentry	30;47	#0ef40a #00000000 std
menu color timeout_msg	37;40	#0ef40a #00000000 std
menu color timeout	37;40	#0ef40a #00000000 std

LABEL back
	MENU LABEL ..
	KERNEL vesamenu.c32
	APPEND pxelinux.cfg/default
	TEXT HELP
	Kembali ke Menu Utama
	ENDTEXT
\n
LABEL fog.reg
	kernel fog/kernel/bzImage
	append initrd=fog/images/init.gz root=/dev/ram0 rw ramdisk_size=127000 ip=dhcp dns=${alamatDNS} mode=autoreg web=${alamatIP}/fog/ loglevel=4
	MENU LABEL Pendaftaran Ringkas Komputer
	TEXT HELP
	Daftar komputer klien secara ringkas
	ke dalam pangkalan data FOG.
	ENDTEXT
\n
LABEL fog.reginput
	kernel fog/kernel/bzImage
	append initrd=fog/images/init.gz root=/dev/ram0 rw ramdisk_size=127000 ip=dhcp dns=${alamatDNS} mode=manreg web=${alamatIP}/fog/ loglevel=4
	MENU LABEL Pendaftaran Komputer Terperinci
	TEXT HELP
	Daftar komputer klien secara terperinci
	ke dalam pangkalan data FOG dan
	seterusnya memuatturun imej backup.
	ENDTEXT
\n
LABEL fog.quickimage
	MENU PASSWD $1$0123456789
	kernel fog/kernel/bzImage
	append initrd=fog/images/init.gz  root=/dev/ram0 rw ramdisk_size=127000 ip=dhcp dns=${alamatDNS} mode=quickimage keymap= web=${alamatIP}/fog/ loglevel=4
	MENU LABEL Muatturun Imej Backup
	TEXT HELP
	Muatturun imej backup untuk pemulihan secara manual.
	ENDTEXT		
\n
LABEL fog.sysinfo
	kernel fog/kernel/bzImage
	append initrd=fog/images/init.gz  root=/dev/ram0 rw ramdisk_size=127000 ip=dhcp dns=${alamatDNS} mode=sysinfo loglevel=4
	MENU LABEL Info Komputer Klien
	TEXT HELP
	Memaparkan info tentang komputer klien yang diboot.
	ENDTEXT	

LABEL fog.debug
	MENU PASSWD $1$0123456789
	kernel fog/kernel/bzImage
	append initrd=fog/images/init.gz  root=/dev/ram0 rw ramdisk_size=127000 ip=dhcp dns=${alamatDNS} mode=onlydebug
	MENU LABEL Mod Admin
	TEXT HELP
	Command Line Interface.
	ENDTEXT
\n" > "/tftpboot/skb/menus/fog.cfg";

	echo "MENU TITLE Sistem Operasi Sementara
MENU BACKGROUND skb/pics/bg.png


menu color title        1;36;44    #0ef40a #00000000 std
menu color border       36;44   #0ef40a #00000000 std
menu color help         36;44   #0ef40a #00000000 std
menu color unsel        36;44   #0ef40a #00000000 std
menu color sel          36;44   #000000 #0ef40a all
menu color pwdborder    30;47   #0ef40a #00000000 std
menu color pwdheader    31;47   #0ef40a #00000000 std
menu color pwdentry     30;47   #0ef40a #00000000 std
menu color timeout_msg  37;40   #0ef40a #00000000 std
menu color timeout      37;40   #0ef40a #00000000 std



LABEL back
	MENU LABEL ..
	KERNEL vesamenu.c32
	APPEND pxelinux.cfg/default

LABEL Zorin OS Lite x86
	MENU LABEL Zorin OS Lite 6.1 x86
	KERNEL skb/linux/zorin/casper/vmlinuz
	APPEND root=/dev/nfs boot=casper netboot=nfs nfsroot=${alamatIP}:/tftpboot/skb/linux/zorin initrd=skb/linux/zorin/casper/initrd.gz quiet splash --
" > "/tftpboot/skb/menus/linux.cfg";
	echo "...OK";
}

konfigNFS()
{
	echo -n "  * Berikan akses direktori NFS Server"; 
	mv /etc/exports /etc/backup.exports
	cp -f ${nfscfgsrc} ${nfscfgdst}
	/etc/init.d/nfs-kernel-server stop >/dev/null 2>&1;
	/etc/init.d/nfs-kernel-server start >/dev/null 2>&1;
	if [ "$?" != "0" ]
	then
		echo "...Failed!";
		exit 1;	
	else
		echo "...OK";
	fi		
}

salinISO()
{
	echo -n "  * Menyalin Zorin ISO ke dalam pelayan";
	mkdir -p /mnt/iso
	mount -o loop ${isosrc} /mnt/iso
	cp -rf /mnt/iso/* ${isodst}
	umount -f /mnt/iso
	echo "";
	echo "  * Salinan...OK";
}
