#!/bin/bash
#
#  Penambahbaikan sistem pemulihan FOG by Chuck Syperski & Jian Zhang
#  untuk Projek Sarjana Muda 
#
#   Pemulihan Komputer dengan Imej Backup di Rangkaian

#   Pemasangan FOG diperlukan sebelum pemasangan sistem ini

# 

. ./teras/fungsi.sh

clearScreen;
	echo "";                                        
	echo "  ###########################################";
	echo "  #     Pemulihan Komputer dengan           #";
	echo "  #     Imej Backup di Rangkaian            #";
	echo "  #                                         #";
	echo "  #     Nama : Shaharudin bin Ahmad         #";
	echo "  #     Kursus : BITN                       #";
	echo "  #                                         #";
	echo "  #     Projek ini dikemukakan sebagai      #";	
	echo "  #     memenuhi sebahagian daripada        #";
	echo "  #     syarat penganugerahan Ijazah        #";	
	echo "  #     Sarjana Muda Teknologi Maklumat     #";		
	echo "  #     dengan Pengkomputeran Rangkaian     #";
	echo "  #     dengan Kepujian.                    #";
	echo "  #                                         #";
	echo "  #     Universiti Terbuka Malaysia         #";
	echo "  #     2013                                #";		
	echo "  ###########################################";
	echo "";
	echo "   Pastikan anda telah memasang perisian FOG ";
	echo "   dan telah membuat konfigurasi sistem FOG. ";
	echo "   ";
	echo "     !!Arahan hendaklah menggunakan sudo!!";
	echo "     taipkan sudo ./pasang.sh di terminal";
	echo "";
	echo "";

alamatIP=`ifconfig | grep "inet addr:" | head -n 1  | cut -d':' -f2 | cut -d' ' -f1`;
alamatDNS=` cat /etc/resolv.conf | grep "nameserver" | head -n 1 | tr -d "nameserver" | tr -d [:blank:] | grep "^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$"`

. ./teras/umum.sh
salinData;
konfigTFTPPXE;  
konfigNFS; 
salinISO;  

	echo "";
	echo "Pemasangan selesai.";

