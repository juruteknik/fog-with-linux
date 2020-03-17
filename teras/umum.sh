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

# dimana FOGTray.exe berasal?
fogtsrc="./fail/FOGTray.exe";

# kemana FOGTray.exe akan disalin?
fogtdst="/var/www/fog/client/";

# dimana gambar bg berasal?
bgsrc="./fail/bg.png";

# kemana gambar bg akan disalin?
bgdst="/tftpboot/skb/pics/";

# fail default berasal?
defsrc="./fail/default";

# kemana default akan disalin?
defdst="/tftpboot/pxelinux.cfg/";

# fail template config berasal?
tplsrc="./fail/template.cfg";

# kemana template config akan disalin?
tpldst="/tftpboot/skb/menus/";

# fail akses nfs berasal?
nfscfgsrc="./fail/exports";

# kemana akses nfs akan disalin?
nfscfgdst="/etc/";

# fail iso berasal?
isosrc="./iso/zorinlite.iso";

# kemana iso akan disalin?
isodst="/tftpboot/skb/linux/zorin/";
