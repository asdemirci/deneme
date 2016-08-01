

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

Crt,key,pem dosyalarını "/etc/openvpn/" pathine kopyaladıktan sonra istemci client sertifikası hazırlamamız gerekmekte.


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

1. /etc/openvpn/ca.crt
2. /etc/openvpn/easy-rsa/testserver.crt
3. /etc/openvpn/easy-rsa/testserver.key

İlk olarak dosyaları bir grup haline getirelim,bunun için tar komutu kullanılabilir *"tar –cf istemcisertifika.tar /etc/openvpn/ca.crt /etc/openvpn/easy-rsa/keys/ testclient.crt
/etc/openvpn/easy-rsa/keys/ testclient.key”* .istemcisertifika.tar dosyasını sftp yada scp ile istemci makineye gönderebiliriz.
