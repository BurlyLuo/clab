# containerlab
![](https://github.com/BurlyLuo/clab/blob/master/CONTAINERlab.png)
```
c39652e4abc2   kindest/node:v1.24.0         "/usr/local/bin/entr…"   43 hours ago   Up 43 hours   127.0.0.1:38735->6443/tcp   clab-bgp-cplane-demo-control-plane
a193156099ea   kindest/node:v1.24.0         "/usr/local/bin/entr…"   43 hours ago   Up 43 hours                               clab-bgp-cplane-demo-worker
cca5d298355e   kindest/node:v1.24.0         "/usr/local/bin/entr…"   43 hours ago   Up 43 hours                               clab-bgp-cplane-demo-worker3
b2200ea3a330   kindest/node:v1.24.0         "/usr/local/bin/entr…"   43 hours ago   Up 43 hours                               clab-bgp-cplane-demo-worker2

+---+------------------------------+--------------+----------------------------+-------+---------+----------------+----------------------+
| # |             Name             | Container ID |           Image            | Kind  |  State  |  IPv4 Address  |     IPv6 Address     |
+---+------------------------------+--------------+----------------------------+-------+---------+----------------+----------------------+
| 1 | clab-bgp-cplane-demo-leaf0   | 25d7cb9d2e15 | vyos/vyos:1.2.8            | linux | running | 172.20.20.3/24 | 2001:172:20:20::3/64 |
| 2 | clab-bgp-cplane-demo-leaf1   | ddb2957173ed | vyos/vyos:1.2.8            | linux | running | 172.20.20.5/24 | 2001:172:20:20::5/64 |
| 3 | clab-bgp-cplane-demo-server1 | 9faf8ac4c502 | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 4 | clab-bgp-cplane-demo-server2 | 55f50ab78d5f | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 5 | clab-bgp-cplane-demo-server3 | a383f737c178 | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 6 | clab-bgp-cplane-demo-server4 | 29e945617f9c | burlyluo/nettoolbox:latest | linux | running | N/A            | N/A                  |
| 7 | clab-bgp-cplane-demo-spine0  | d42c70e1bdbe | vyos/vyos:1.2.8            | linux | running | 172.20.20.2/24 | 2001:172:20:20::2/64 |
| 8 | clab-bgp-cplane-demo-spine1  | 11b2871d7435 | vyos/vyos:1.2.8            | linux | running | 172.20.20.4/24 | 2001:172:20:20::4/64 |
+---+------------------------------+--------------+----------------------------+-------+---------+----------------+----------------------+
```
