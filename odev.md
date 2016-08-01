

#VPN ve OpenVPN nedir?

**VPN(Virtual Private Network/Sanal Özel Ağ)** internet üzerinden şifreli ve güvenli olarak veri iletişimi sağlanılmasına ortam hazırlayan bir teknolojidir. Aynı zamanda IIS tarafından yasaklanan sitelere erişilmesini sağlar. 90‘ ların ortalarında internetin ucuzlaması ve yükselişi bu gibi yeni teknolojilerin önünü açtı. VPN sayesinde internet kullanılarak kurumsal ağların birbirine bağlanması daha düşük maliyetlerde gerçekleştirilmektedir. VPN sayesinde kurumsal ağlarda firewall arkasında çalışanlar güvenli bir iletişim ortamı elde etmişlerdir.

İki tip VPN teknolojisi bulunmaktadır. Bunlar “Remote Access VPN” ve Site-to-site VPN” olarak geçer. Remote Access VPN’i, farklı lokasyonlardaki şubeleri merkeze bağlamak ya da farklı yerlerde bulunan çalışanları kurum ya da firma ağına istedikleri her yerden güvenli iletişim elde etmeleri için kullanırız.

Site-to-site VPN ise farklı firmaların birbirleri ile güvenli iletişim kurmaları amacıyla oluşturulmuştur. Aynı zamanda Remote Access VPN de olduğu gibi kurum şubelerinin merkez ağa bağlanması sağlanır bu VPN yapısında iki tarafta VPN sunucu bulunur.

OpenVPN açık kod yazılımı olarak gerçekleştirilmiş bir VPN yazılımıdır. Birçok platformda çalışabilmektedir. GPL ile lisanslanmıştır. Sunucu ve istemci tarafı bulunmaktadır. SSL/TLS protokollerini kullanarak OSI 2. Ve 3. Katman seviyesinde şifreli ağ erişimi sağlar. Noktadan noktaya ya da köprü modu ile çalışabilmektedir. OpenSSL kütüphanesinin sağladığı şifreleme, yetkilendirme, sertifika oluşturma özelliklerinden faydalanırız. Aktif ve pasif saldırılara karşı güvenliği sağlamaktadır. Tüm güvenlik duvarları, vekil sunucular, nat üzerinden sorunsuz olarak tünelleme imkânı sağlar. İstenildiği takdirde GUI ile yönetim imkânı sağlar. Hem kolay kurulur hem de birçok işletim sistemi ile uyumlu olarak çalışan modüler bir yapısı bulunur. Tüm trafik LZO Kütüphanesi kullanılark gerçek zamanlı olarak sıkıştırılmaktadır. Kablosuz ağlar için güvenli erişim imkânı sağlar. Mobil ve gömülü sistemleri de desteklemektedir. Kısa süreli bağlantı kesilmelerinde ve IP değişimlerinde kullanılan uygulamaya bağlı olarak bağlantılar devam ettirilmektedir. Bağlantı sağlanabilmesi için güvenlik duvarında tek bir port’un açık olması yeterlidir. Scripting imkânlarıyla yüksek esneklik sağlanabilmektedir. OpenVPN SSL/TLS protokollerini kullandığı için Ipsec gibi işletim sisteminin çekirdeğinde temel değişiklikler gerektirmez.

#OpenVPN Nasıl Çalışır?

OpenVPN’i kurduğunuz ve çalıştırdığınız anda sisteminize tuno adında bir ağ arabirimi eklenir. Tuno sanal bir ağ arabirimidir. Bu ara birim üzerinden gönderilen paketler şifrelenir ve kullanılmakta olan gerçek ağ arabirimlerine yönlendirilir. OpenVPN OSI 2.ve 3. Katmanlarında çalışır ve paketleri bu katmanlardayken şifreleyebilir. OpenVPN kurulumu sunucu-istemci ya da noktadan noktaya olmak üzere iki şekilde yapılabilir. İki cihaz arasında güvenli bağlantı kurulması isteniyorsa, noktadan noktaya tercih edilir. Sertifika kullanılmadan sadece noktadan noktaya bağlantıda sadece iki uçta kullanılan parola bilgisi ile iletişim sağlanabilir. Sunucu ve istemci modelinden ise birden fazla bilgisayarların sunucu ile bağlantısı gerçekleştirilir. İstemciler izin verildiği takdirde aralarında sunucu üzerinden iletişim sağlanır. Her istemci ve sunucu arasındaki bağlantılar yapılırken sertifika kontrolü yapılır. Sertifika kullanımı güvenliği arttırır.

#Kali üzerine OPENVPN Kurulum

Kali üzerine OPENVPN’nin nasıl kurulduğu, kullanıcı ve sunucular için nasıl sertifika ve key oluşturulduğundan aşağıda bahsedilmiştir.

*1.* İlk önce sistemi updateliyelim.
```
$ sudo apt-get update
$ sudo apt-get upgrade
```
Not: Bundan sonra çalıştıracağımız tüm komutları root kullanıcısı olarak çalıştıralım.

*2.* OpenVPN yazılımının gerek duyduğu paketler aşağıdaki komut ile kurulur.
```
$ sudo apt-get install openvpn easy-rsa
```
# Sertifikalı Bağlantı Kullanımı

Sertifikalı bağlantılar sayesinde birden fazla bilgisayar birbirine güvenilir olarak bağlanabilir. Trafiğin SSL ile şifreli olarak gönderilebilmesi içinde sertifikaya ihtiyaç duyulmaktadır.

**Sertifikalı Bağlantı Çalışma Mekanızması:**
* Her bir cihazın sertifikası tek bir **sertifika otoritesi (certificate authority-CA)** tarafından imzalanır. 

* Bağlantı kuracak cihazlar birbirlerine sertifikalarını gönderir.

* Sertifikayı alan tarafk sertifika otoritesin bakar ve sertifikanın gerçek olup olmadığını anlar.

* Eğer sertifika gerçekse bundan sonra  gönderilen veriler bu sertifika kullanılarak şifrelenir.

* Şifrelenmiş verileri de sertifika sahibi yani özel anahtarı bulunan kişi açabilir.

#Sertifikaların Oluşturulması ve  Sertifika ile Yetkilendirme

Sertifika oluşturmak için kullanılacak dosyaları */etc/openvpn* dizini altına taşıyalım.

 *2.* adımda gerçekleştirilen *openvpn* ve *easy-rsa* paket kurulumları tamamlandığına göre aşağıdaki adımları gerçekleştirebiliriz. 
 
Openvpn içerisinde sertifikaların kolaylıkla oluşturulabilmesi için bazı kodlar hazır olarak bulunmaktadır. Bu kodlar Ubuntu içerisinde */usr/share/doc/openvpn/examples/easy-rsa* ya *da/usr/share/easy-rsa/* *dizininde bulunurlar.

*3.*
```
$ sudo su

$ mkdir /etc/openvpn/easy-rsa/

$ sudo cp -R /usr/share/easy-rsa/* /etc/openvpn/easy-rsa
```

Root kullanıcısına geçilerek işlemler artık root yetkisi ile yapılır. */etc/openvpn/easy-rsa/* dizini oluşturulur ve */usr/share/easy-rsa/* dizininde bulunan içeriği oluşturduğumuz dizine kopyalarız. Dosyalar kopyalandıktan sonra easy-rsa dizinine gidiyoruz.
Bu komutların çalışması esnasında aşağıdaki gibi hata alınırsa *easy-rsa* klasörünü içeren dosyalar sistemde bulunmamaktadır.

*cannot stat `/usr/share/easy-rsa/`: No such file or directory*

Böyle bir hata aldığınızda *easy-rsa* içeriklerini tekrardan indiriniz ve */etc/openvpn* klasörü altına kopyalayınız.

*4.*
```
$ cd  ~/easy-rsa
```
Bu dizin altında bulunan vars dosyasını bir metin düzenleyici ile açarız ve aşağıda bulunan parametrelere gerekli değişiklikleri yaparız. Sadece dosyanın sonunda yer alan ön tanımlı değerleri değiştirmek yeterli olacaktır. Sertifika oluşumunda içerisine gömülecek verilerin hızlı bir şekilde oluşturulabilmesi için kullanılan değerlerdir. İsterseniz her sertifika için farklı değerlerde girebilirsiniz. Değişiklik işleminiz bittikten sonra sayfayı kaydedin.
Aşağıda görülen */etc/openvpn/easy-rsa/vars* dosyasındaki sertifika için gerekli bilgiler, örnekteki gibi düzenlenmelidir.
```
$nano /etc/openvpn/easy-rsa/vars

export KEY_COUNTRY=”TR”
export KEY_PROVINCE=” Network Defense”
export KEY_CITY=”ANKARA”
export KEY_ORG=” TOBB ETU”
export KEY_EMAIL=networkdefense@gmail.com
export KEY_CN=”NetworkDefense”
#x509 Subject Field
export KEY_NAME= NetworkDefense”
export KEY_OU=”NetworkDefense”
```
* **Country Name:** Ülke bilgisi, doldurmak istemezseniz Enter’a basarak geçebilirsiniz.
* **State or Province Name:** Bölge bilgisi, doldurmak istemezseniz Enter’a basarak geçebilirsiniz.
* **City:** Şehir bilgisi, doldurmak istemezseniz Enter’a basarak geçebilirsiniz.
* **Org Name:** Organizasyon ismi, doldurmak istemezseniz Enter’a basarak geçebilirsiniz.
* **Org Unit Name:** Ogranizasyon Birim adı, doldurmak istemezseniz Enter’a basarak geçebilirsiniz.
* **Common Name:** Sunucu Hostname bilgisi (hakancakiroglu.com gibi)
* **Email Address:** E-mail adresi bilgisi, doldurmak istemezseniz Enter’a basarak geçebilirsiniz.
* Makinedeki openssl sürümüne göre */etc/openvpn/easy-rsa/* dizinindeki openssl yapılandırma dosyasına yine aynı dizinde openssl.cnf adıyla kısayol verilmelidir.

*5.* Yukarıdaki alanlar doldurulduktan sonra aşağıdaki komutlar sırası ile çalıştırılır ve sertifika otoritesi oluşturma aşaması gerçekleştirilir. En son aşamada ise oluşturulan sertifikalarda ilgili dizinlere kopyalanır.
```
$ sudo su

$ cd /etc/openvpn/easy-rsa

$ source vars 

$ ./clean-all

$ ./build-ca
```
*build-ca* komutunu verdiğiniz zaman, vars dosyasında tanımladığımız değişkenlere uygun olarak ca anahtarları oluşturulacak ve çıktı aşağıdaki gibi olacaktır.

**RESIM EKLE**

#SUNUCU (Server) SERTİFİKASI HAZIRLAMA

Sertifika otoritresini yapılandırdıktan sonra, OpenVPN sunucusuna ait anahtarları oluşturuyoruz.

```
$ ./build-key-server testserver
```

**Not:** * /build-key-server* komutunda kullandığımız testserver ismi, server.conf dosyasında server, cert ve key parametrelerini *testserver.crt* ve *testserver.key* olarak set ettiğimiz için girilmektedir. Dosyada bu parametreleri kendinize göre düzenlediyseniz, bu komutta verdiğiniz key ismi de aynı olmalıdır. Bu komutun çıktısı ise gene vars dosyasında belirtiğimiz değişkenlere uygun olarak aşağıdaki gibi olacaktır (en sonda sorulan iki soruya “y” olarak cevap vermeniz gerekmektedir.):
*/etc/openvpn/easy-rsa/vars* dosyasına girdiğimiz "TR, Network Defense, TOBBETÜ"gibi alanları "Enter"la geçiyoruz.
```
“Sign the certificate? [y/n]” ve “1 out of certificate requests certified, commit? [y/n] alanlarına ise "y" yazarak cevaplamamız gerekmekte. 
```

Server sertifikaları oluştuğuna göre, aşağıdaki komutlarla oluşan sertifikaları */etc/openvpn/* patine taşımaya sıra geldi. Bu işlem için aşağıdaki komutları terminal konsolda çalıştırmalıyız.

```
$ cd keys/

#$ openvpn --genkey --secret ta.key

$ sudo  cp testserver.crt testserver.key ca.crt dh2048.pem  /etc/openvpn
```
Sonra, anahtar değiş tokuşu için kullanılacak Diffie Hellman dosyasını oluşturuyoruz.

Vars dosyasını değiştirmediğimiz için anahtar dizini *~/easy-rsa/key* dizini olacaktır. Bundan sonra oluşturulacak anahtar ve sertifika dosyaları bu dizin altında bulunacaktır. *.key* uzantılı dosyalar gizli dosyalardır ve özel anahtarı içerirler. *.crt* uzantılı dosyalar ise dağıtılabilir.

```
$ ./build-dh
```
Verdiğimiz komutları açıklayayım:
```
1. Sertifikaları ve anahtarları oluşturmadan önce karşılıklı şifrelemenin gerçekleşebilmesi için bazı parametrelerin belirlenmesi gerekmektedir. Bu değişim parametreleri Diffie Hellman adı verilen teknik ile sağlanmaktadır.

2. CA sertifikasını ve anahtarını oluşturur.

3. Sunucu için gerekli sertifika/anahtar çiftini oluşturur. Sunucumuzun adı bundan sonra iyiSunucu olarak anılır.

4. istemci1 istemcisi için gerekli sertifika/anahtar çiftini oluşturur.
```

Crt,key,pem dosyalarını *"/etc/openvpn/"* pathine kopyaladıktan sonra istemci client sertifikası hazırlamamız gerekmekte.

Böylece, CA, sunucu ve istemci için sertifika/anahtarı oluşturmuş olduk. Bundan sonra her hangi bir istemci için sertifika/anahtar üretmek için:
```
$  source vars 

$ ./build-key  testclient
```

komutlarını vermek yeterli olacaktır. Dikkat edilmesi gereken oluşturma işlemi sırasında keys dizini altında ca.keys ve ca.crt dosyalarının bulunmasıdır. Bütünlüğü bozmamak ve dosyaların taşınarak güvenliklerinin tehlikeye atılmaması için bütün oluşturma işlemlerinin tek bir bilgisayar üzerinde yapılması tavsiye edilir.

#İSTEMCİ (Client) SERTİFİKASI HAZIRLAMA
Öncelikle sunucu üzerinde istemci için serticikaların oluşturulması gerekiyor.
```
$ cd /etc/openvpn/easy-rsa

$ source vars 

$ ./build-key  testclient
```
Bu komut ile yine “keys” klasörü içinde client.crt ve client.key isimli dosyalar oluşuyor. Bu iki dosyayı ve ilk başta oluşturduğumuz ca.crt dosyasını, uzak lokasyonda bulunan client pc’nin config klasörü içine kopyalamamız gerekiyor. Zip’leyip mail ile gönderebilirsiniz. Aynı yöntemle birden fazla değişik isimlerde client oluşturabilirsiniz bunu unutmayın.

sertifika ile yetkilendirme yapılacaksa aşağıdaki dosyaların istemciye kopyalanması gerekmektedir.
```
1. /etc/openvpn/ca.crt
2. /etc/openvpn/easy-rsa/testserver.crt
3. /etc/openvpn/easy-rsa/testserver.key
```

İlk olarak dosyaları bir grup haline getirelim,bunun için tar komutu kullanılabilir *"tar –cf istemcisertifika.tar /etc/openvpn/ca.crt /etc/openvpn/easy-rsa/keys/ testclient.crt
/etc/openvpn/easy-rsa/keys/ testclient.key”* .istemcisertifika.tar dosyasını sftp yada scp ile istemci makineye gönderebiliriz.
```
/etc/openvpn/ca.crt
/etc/openvpn/easy-rsa/keys/ testclient.crt
/etc/openvpn/easy-rsa/keys/ testclient.key
```
**NOT:** Taşıma işleminden sonra testclient.crt ve testclient.key dosyalarını sunucudan kaldırmamız gerekmekte. Silme işlemi yerine uzantısını değiştirmemizde yeterli olacaktır.Aşağıdaki komutlar dosyaların uzantılarını değiştirecektir.
```
mv /etc/openvpn/easy-rsa/keys/ testclient.crt etc/openvpn/easy-rsa/keys/ testclient.crt_yedek
mv /etc/openvpn/easy-rsa/keys/ testclient.key etc/openvpn/easy-rsa/keys/ testclient.key_yedek
```

#Ayar Dosyaları

Sertifikalar oluşturulduktan sonra bu sertifika ve anahtarları kullanacak ayar dosyalarının da yaratılması gerekmektedir. Örnek ayar dosyalarının birer kopyasını */usr/share/doc/openvpn/examples/sample-config-files* dizininde bulabilirsiniz. *client.conf* ve *server.conf.gz* dosyalarını uygun bir dizine kopyalayıp, gz'yi açtıktan sonra server.conf dosyasını sunucu.conf ve client.conf dosyasını istemci1.conf  olarak kopyalayalım ve sunucu.conf dosyasını ayarlamakla işe başlayalım.
```
$ mkdir ~/openvpn
$ cd ~/openvpn
$ cp /usr/share/doc/openvpn/examples/sample-config-files/{client.conf,server.conf.gz}  .
$ gunzip server.conf.gz
$ cp {server,sunucu}.conf
$ cp {client,istemci1}.conf
```
Aşağıda sunucu.conf dosyası içerisinde mutlaka bulunması gereken satırları yazıyorum. Bunun dışındaki satırlar için dosya içinde bulunan yorumlara ve açıklamalara başvurabilirsiniz.

###Sunucunun Yapılandırılması

Örnek sunucu yapılandırma dosyalarının kopyalanması için aşağıdaki komutlar uygulamlıdır.

*"/usr/share/doc/openvpn/examples/sample-config-files/"* pathinde bulunan *"server.conf.gz"* dosyasını *"/etc/openvpn/"* pathine taşıyıp bu sıkıştırılmış dosyayı  "/etc/openvpn/" dizininde açmamız gerekmekte.
Bu işlem için aşağıdaki komutları çalıştırmalıyız.
```
$ sudo cp /usr/share/doc/openvpn/examples/sample-config-files/ server.conf.gz /etc/openvpn
$ sudo gzip –d /etc/openvpn/server.conf.gz
```
Gzip dosyasını *"server.conf.gz”* *"/etc/openvpn/"* dizininde açtığımızda *"server.conf"* dosyası oluştu *"server.conf"* dosyası Openvpn sunucumuzun konfigürasyon dosyası olduğu için dikkatli bir şekilde aşağıda listelediğim alanların örnekteki gibi doldurulması gerekmektedir.

Yanlış bir işlem openvpn servisin hata almasına ve başlatılamamasına neden olacaktır.
```
$sudo su
$nano /etc/openvpn/server.conf
```
**ÖRNEK:** *"server.conf"* dosyasında tanımlı olması gereken alanlar;

UDP protokolünün 1194 nolu portundan gelen bağlantıları kabul et.
```
port 1194
proto udp
```
Katman 3 bir tünel oluştur (dev tun).
oluşturulan sanal ağ bağdaştıcısının tip routedd vpn yapacağımız için tun diyoruz
```
dev tun
```
CA sertifikası ca.crt, sunucu sertifikan testserver.crt ve sunucu anahtarın testserver.key dosyasındadır.

```
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/testserver.crt
key /etc/openvpn/easy-rsa/keys/testserver.key 
```
Diffie-Hellman için dh1024.pem dosyasını kullan.

```
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
```
Ağdaki IP adreslerini 10.8.0.0 - 10.8.0.254 arasında dağıt kendine de 10.8.0.1 adresini al.
client ile server arasında kurulacak ağ’da kullanılacak IP blogu, 
dilediğiniz şekilde subnetleyebilirsiniz 

```
server 10.8.0.0 255.255.255.0
```
Ek olarak şu ayarları yapabilirsiniz:

Sunucuya bağlanan bilgisayarların IP adreslerini korunması ve her seferinde aynı kalması için aşağıdaki komutu verebilirsiniz. eğer bazı clientlara hep aynı IP adresinin atanmasını istiyorsak, 
gerekli bilgileri ipp.txt dosyasına yazıp, bu dosyayı da config dizine

```
ifconfig-pool-persist ipp.txt
```
Bağlanan istemcilerin birbirini görebilmesi için:
```
client-to-client 
```
## bant genişliğini dilersek sınırlayabiliriz ##
```
shaper n 
```
n değeri 100 bps ile 100 Mbps arasında olabilir. Ancak çok düşük hızlarda TCP protokolü kullanırsak geçikme sürekli artıyor ve connecion time out oluyor. Bunun çözümü ise MTU'u biraz düşürmektir. 
İstemcilerin bütün İnternet trafiklerinin sunucu üzerinden olmasını istiyorsanız, sunucu ayarları içine komutunu koymanız gerekir. Bu durumda sunucu üzerinden İnternet'e çıkış ayarlarını da ayrıca yapmanız gerekir. *"redirect-gateway"* komutu bütün trafiği yönlendirdiği için DHCP adresi alamama gibi sorunlara da yol açabilmektedir.  push “redirect-gateway def1 bypass-dhcp” ifadesi ile clientların default gateway olarak OpenVPN sunucusunu kullanabileceklerni belirtiyoruz. Bu şekilde client tarafından üretilen tüm trafik tünel içerisinden geçerek OpenVPN üzerinden pass ediliyo
```
push "redirect-gateway def1 bypass-dhcp"

push “dhcp-option DNS 8.8.8.8” ve push “dhcp-option DNS 8.8.4.4” 

ifadeleri ile de clientlara atanacak dns sunucuların hangileri olduğunu set ediyoruz
```
Diğer direktiflerle ilgili tüm açıklamalar için */usr/share/doc/openvpn-2.3.2/sample/sample-config-files/server.conf* yolunda bulunan örnek yapılandırma dosyasını inceleyebilirsiniz.

```
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
```
bağlantı kurulduktan sonra, belli bir süre hatta veri aktarımı olmama durumunda 
bağlantının kesilmemesi için 
```
keepalive 10 120 

reneg-sec 0
```
bağlantılarda sıkıştırma kullanılması için:

```
comp-lzo
```
Sürekli kendini terkarlayan mesajların susturulması için:

```
mute 20
```

server’a aynı anda bağlanabilecek client sayış
```
max-clients 4
```
Ayar dosyası ile çalıştırmak için aşağıdaki bölüme bakabilirsiniz. Şimdi istemci cihazın da ayar dosyasını yapalım.
```
user nobody
group nogroup
```
user ve group parametlerinin nobody ve nogroup olarak ayarlanması openvpn servisinin nobody veya nogroup yetkilerine sahip diğer servislerde oluşabilecek açıklıklardan etkilenmemesi için tavsiye edilmez. OpenVPN için farklı bir kullanıcı ve grup oluşturulabilir.
```
persist-key
persist-tun
status openvpn-status.log
verb 3
```
verb modları 0- 6 arasında değişebilir 1-4 normal kullanım içindir#

Bu ayarlar elzem olanlardır. Çalışması için yeterlidir. Ancak buraya daha bir çok detay girebiliriz. Kaydederek çıkıyoruz ve ismini server.ovpn olarak değiştiriyoruz. Uzantı .txt olmasın dikkat!! Bunun olmaması için yukarıda bir yerlerde yapmamız gereken işlemi yazdık.
```
log-append openvpn.log 
client-config-dir client-configs
```

Eğer her bir sertifika içine farklı bilgiler gömmek isterseniz pkitool komutlarını --interact parametresi ile çalıştırabilirsiniz.
VPN'in IP adresleri ile yerel ağ bağlantılarının adreslerinin çakışmamasına (aynı alt ağda olmamasına) dikkat ediniz.
IPv4 ve yönelnedirmeler hakkında biraz bilgi edinmeniz işinizi kolaylaştıracaktır.
Sunucu üzerinde;

Sunucu.conf dosyasının son hali:

```
$ sudo cp sunucu.conf /etc/openvpn/
$ sudo mkdir /root/openvpn
$ sudo chmod 600 /root/openvpn
$ sudo mv ca.crt iyiSunucu.crt iyiSunucu.key dh1024.pem /root/openvpn
$ sudo /etc/init.d/openvpn restart
```
#OpenVPN İSTEMCİ (Client) BAĞLANTI YAPILANDIRILMASI

İstemciler için birçok yetkilendirme yöntemi kullanılabilmektedir. Burada sertifika tabanlı ve shell script tabanlı iki yöntem anlatılacaktır. Öncelikle istemciye OpenVPN kurulmalıdır. Ubuntu üzerinde openvpn kurulumu ve yapılandırma dosyasının oluşturulması için aşağıda komutlar uygulanmalıdır. Windows ve MAC için farklı istemci yazılımları da bulunmaktadır. Fakat yapılandırma dosyası içeriği tüm işletim sistemlerinde aynıdır.
İstemci makinede aşağıdaki komutlar çalıştırılarak openvpn client kurulumu yapılmalıdır.
```
$ sudo apt-get update
$ sudo apt-get install openvpn
$ cd /etc/openvpn
$ cp /usr/share/doc/openvpn/examples/sample-config/client.conf client.con

```
Sertifika tabanlı yetkilendirme için istemci yapılandırma dosyasında düzenlenmesi gerekli parametreler şunlardır.
```
Remote SERVER_IP 1194
ca ca.crt
cert testclient.crt
key testclient.key
```

Windows bir makineden bağlanılacak ise aşağıdaki web adresinden uygun olan istemci versiyonu indirilip kurulmalıdır.
https://openvpn.net/index.php/open-source/downloads.html

Anlatıma linux istemci ile devam ediyorum,istemci makineye openvpn client kurulumu yapıldıktan sonra aşağıda belirttiğim dizinden *"client.conf"* dosyası *"/etc/openvpn/"* dizinine kopyalanır.
Ayrıca sunucu üzerinde daha önce "tar"layıp oluşturduğumuz "istencisertifika.tar"dosyasında bulunan sertifikalarıda yine bu dizine *"/etc/openvpn"* çıkarmalıyız. Bu işlemleri yapabilmek için aşağıda verdiğim komutları terminalde çalıştırmalıyız.
```
cd /usr/share/doc/openvpn/examples/sample-config-files
sudo cp client.conf /etc/openvpn/.
```
*"Client.conf"* dosyasını *"/etc/openvpn/"* dizinine kopyaladıktan sonra *client.conf* dosyasında bulunan aşağıda belirtiğim alanların düzenlemesi gerekmekte,
bu işlem için aşağıdaki örnek client.conf dosyasından faydalanabilirsiniz.
```
cd /etc/openvpn
sudo nano client.conf 
```
```
client
dev tun
proto udp
remote SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ca /etc/openvpn/ca.crt
cert /etc/openvpn/ testclient.crt
keys /etc/openvpn/ testclient.crt
ns-cert-type server
comp-lzo yes
verb 3
```

*Client.conf* dosyamızı oluşturduğumuza göre openvpn sunucumuza bağlanmaya sıra geldi.Aşağıdaki komutla vpn bağlantıyı gerçekleştiriyoruz.
```
sudo openvpn /etc/openvpn/client.conf
```
#Ağ Trafiğinin Yönlendirilmesi
İstemci üzerindeki tüm trafiğin vpn üzerinden aktarılması için istemci yapılandırma dosyasına (*/etc/openvpn/client.conf*) aşağıdaki parametre eklenmedir.
```
push "redirect-gateway def1"
```
benzer bir parametrenin de sunucu yapılandırma dosyasına  (*/etc/openvpn/server.conf*) eklenmesi gerekmektedir.
```
push "redirect-gateway def1 bypass-dhcp"
```
Bu şekilde istemci vpn sunucusuna bağlandığında 10.9.0.0 ağına dahil olacak ve istemcideki tüm trafik bu ağa yönlendirilecektir. Sunucu makinenin fiziksel olarak bağlı olduğu ağdaki diğer makinelere bağlanmak için sunucu üzerinde nat ayarları yapılmalı ve yapılandırma dosyasına aşağıdaki parametre eklenmelidir. Sunucu makinenin 192.168.1.0 ağına bağlı olduğunu varasyarsak sunucu yapılandırma dosyasına (*/etc/openvpn/server.conf*) şu parametre eklenmelidir.
```
push "route 192.168.1.0 255.255.255.0"
```

Server ve client kurulumu bitti. Yapmamız gereken işlem adımı port yönlendirmek.

Modemlerde wan 1194 udp portuna gelen istekleri içerideki VPN serverin statik ip adresine ve 1194 portuna yönlendireceksiniz. Airties vb modemlerde Nat menüsü altında port forwarding kısmından kolayca yapabilirsiniz.

Eğer router varsa ve mevcut nat yapılandırması doğru ise , mesela cisco ise :

ip nat inside source static udp a.b.c.d 1194 (wan_int) 1194 komutu ile bu işi halledersiniz.

Arada firewall varsa oradada aynı işlem yapılmalıdır. Herhangi bir unix firewall üzerinde iptables için :
```
# echo 1 > /proc/sys/net/ipv4/ip_forward
# iptables -t nat -A PREROUTING -p udp -d x.y.x.j --dport 1194 -j DNAT --to-destination a.b.c.d
# iptables -A FORWARD -p udp --dport 1194 -j ACCEPT
# iptables -A INPUT -p udp --dport 1194 -j ACCEPT
# iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
# service iptables save
```
a.b.c.d : VPN server WAN ip adresidir. x.y.z.j ise firewall Lan side ip adresidir. 
Sunucu üzerindeki nat ayarları için aşağıdaki komutlar uygulanmalıdır. Komutlar aynı zamanda /etc/rc.local dosyasına eklenirse makine yeniden başlatıldığında da nat ayarları etkinleştirilecektir.
```
echo "1" > /proc/sys/net/ipv4/ip_forward 
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT
iptables-save 
exit 0
```
Bu bölümde farklı iptables kuralları yazılabilir örneğin sadece aşağıdaki komutun uygulanması da yeterli olacaktır. VPN erişimi internet üzerindeki herhangi bir VPS sunucu ile gerçekleşiyorsa VPS'in IP adresine bağlı olarak şu şekilde nat yapılabilir.
```
echo "1" > /proc/sys/net/ipv4/ip_forward 
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source VPS_IP_ADDRESS
iptables-save 
exit 0
```
Sunucu üzerinde OpenVPN yeniden başlatılmalıdır.
```
#/etc/init.d/openvpn restart
```
#Programın Çalıştırılması

"server.conf" dosyasındaki alanları örnekteki gibi doldurduktan sonra openvpn servisi başlatmaya sıra geldi.Bu işlem için aşağıdaki komutu terminalde çalıştırmalıyız.
```
$sudo service openvpn restart
Or 
/etc/init.d/openvpn restart 
```

Ubuntu'nun paket deposundan yüklediğinizde program daemon olarak çalışmaya başlar. Ve kendini her açılışta çalıştırmak üzere ayarlar. Otomatik olarak başlarken okuması gereken ayar dosyalarını /etc/openvpn dizini altına koyabilirsiniz. Böylece her açılışta doğru ayarlar ile başlayacaktır. Şu anda cihazı açıp kapatma gibi bir lüksümüz olmadığı için öncelikle deamon'ı sonlandıralım.
```
$ sudo /etc/init.d/openvpn stop
```
Şimdi deneme amaçlı başlatacağımız ve belki çıkacak sorunları çözmemiz gerekeceği için programı;
```
$sudo openvpn ayarDosyasi.conf 
```

komutunu vererek başlatalım. Böylece programın üreteceği çıktılar direk olarak ekrana yazılacak, böylece log dosyalarını takip etmemiz gerekmeyecektir. Öncelikle sunucuyu etkin hale getirmemiz gerekiyor.
```
$sudo openvpn sunucu.conf 
```

komutunu verdiğimizde sunucu ayarlamalarını yapacak, gerekli dosyaları okuyacak ve UDP 1194 potunu dinlemeye başlayacaktır. Kalabalık çıktıları okumaya çalışın. Eğer en sonda

```
Initialization Sequence Completed
```

yazısını görürseniz sorun yok demektir. Eğer bu satırı göremediyseniz, dosyalarınızın yerlerini ve ayar dosyalarınızı tekrar kontrol edin. Kalabalık yazılar arasında sorunun nedeni yazacaktır.

Şimdi de istemci tarafına geçip buradaki dosyayı çalıştıralım:
```
$sudo openvpn istemci1.conf 
```

Yine kalabalık olan çıktılar arasında aşağıdaki satırları görürseniz işlem tamamlanmış demektir.


Peer Connection Initiated with sunucu.adresi:1194
...
Initialization Sequence Completed


Bu sırada sunucu tarafındaki ekranı da takip ederseniz bağlantı detaylarının ekrana yazıldığını görebilirsiniz. İstemci tarafında yeni bir uçbirim açıp;
```
$ifconfig
```

komutunu verirseniz tun0 arabirimi için atanmış bir inet adresi görmeniz gerekir. Yukarıdaki ayarları aynen uyguladı iseniz bu adres büyük olasılıkla 10.8.0.6 olacaktır. İstemciden sunucu'ya yani 10.8.0.5 adresine (*) ping atarak;
```
$ping 10.8.0.5
```

bağlantıyı test edebilirsiniz. Aklınızda bulunsun, testin çalışabilmesi için sunucunun ping isteklerine cevap vermesi gereklidir.

(*) openVPN Ubuntu üzerinde çalışırken adresleri teker teker dağıtmamakta her bir istemci için bir alt-ağ oluşturabilmektedir. Bu yüzden bağlanan her bir istemcinin adresinin 1 eksiği sunucunun adresi olacaktır. Detaylar için yönlendirme tablosuna (route komutu ile) bakabilirsiniz.

###Son ayarlar ve toparlama

Eğer aradaki bağlantıyı sorunsuz olarak kurabildiyseniz, çalıştığı ekranlarda Ctrl - C ile openVPN uygulamalarını kapatabilirsiniz. İsterseniz her bağlanma için komutları yukarıda tarif edilen şekilde verebilirsiniz. Fakat sunucu için bu pek uygun olmayacaktır. Sunucu tarafında bulunan sunucu.conf dosyasını /etc/openvpn dizininin altına kopyalayalım. ca.crt, sunucu.key, sunucu.crt ve dh1024.pem  dosyalarını da /root/openvpn  dizinine kopyalayalım. İlgili dizin için de görünürlüğü kısıtlayalım. Yeri değişen dosyalar için conf dosyamızı ayarlayalım. openVPN'in yetkilerini düşürelim. Böylece güvenliğimizi artıralım. Sonra da sunucumuzu yeniden başlatalım.

#OPENVPN SUNUCU FIREWALL (Ateş duvarı) ve ROUTING (Yönlendirme) KONFİGÜRASYONU

Not: Openvpn sunucumuzda firewall çalışıyorsa;aşağıdaki komut ile firewall'da 1194 numaralı portu açmalıyız.
```
$sudo ufw allow 1194
$ufq status
```


Firewall'dan 1194 porta izin verdiğimize göre openvpn'nin "tun0" adaptörü ile fiziksel network adaptörü"eth0"'ın birbirleri ile haberleşmesini yani NAT'lamayı yapmamız  gerekmekte.Bu işlem için ilk olarak  "sysctl.conf" dosyasında "net.ipv4.ip_forward=1" tanımını kontrol etmeliyiz.
```
$ sudo nano /etc/ sysctl.conf
“net.ipv4.ip_forward=1” olmalı
```
*"sysctl.conf"* dosyasında alanı kontrol ettikten sonra aşağıdaki komut ile *"10.8.0.0/24 subnetinden"* *"tun0"* dan gelen paketler fiziksel network cihazına "eth0"'a yönlenecektir.Yani "Postrouting" işlemi yapıyoruz.
```
$ sudo /sbin/iptable –t nat –A POSTROUTING –s 10.8.0.0/24 –o eth0 –j MASQUERADE

$ sudo /sbin/iptables –A FORWARD –i eth0 –o tun0 –m state --state RELATED,ESTABLISH –j ACCEPT

$ sudo /sbin/iptables –A FORWARD –i tun0 –o eth0 –j ACCEPT
```
***Not:***  Openvpn servisi sunucu başladığında otomatik çalışması için aşağıdaki komutu kullanmalıyız.Run level 2345 on olarak yapılandırılır.
```
$ update-rc.d –f openvpn defaults 
```
#KAYNAKLAR

[1] http://www.olympos.org/howto-nasil/openvpn/openvpn-ile-vpn-uygulamalari-20220.html

[2] http://penguence.linux.org.tr/?~p=dergi&action=show&which=77

[3] http://openvpn.net/index.php/documentation/howto.html

http://www. linuxakademi.org/2012/11/openvpn-sunucu-kurulumu-ve-istemci-yapilandirmasi.html
