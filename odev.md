

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
export KEY_EMAIL=ayseselcuk77@gmail.com
export KEY_CN=”NetworkDefense”
#x509 Subject Field
export KEY_NAME= NetworkDefense”
export KEY_OU=”NetworkDefense”
```
