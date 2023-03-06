# TCP Simulation

![](https://www.ibm.com/docs/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.halu101/dwgl0004.gif)

https://www.ibm.com/docs/en/zos/2.1.0?topic=SSLTBW_2.1.0/com.ibm.zos.v2r1.halu101/constatus.html


### Server
| Count | State    | Received | Sent    | Comment                                                             |
|-------|----------|----------|---------|---------------------------------------------------------------------|
| 1     | Closed   |          |         |                                                                     |
| 2     | Listen   |          |         | Server received "listen" call and now it is waiting for connection. |
| 3     | SynRcvd  | SYN      | SYN,ACK | Server received SYN when listening and sent  SYN,ACK                |
| 4     | Estblsh  | ACK      |         | Server Received ACK and the connection is established.              |

### Client
| Count | State   | Sent | Received | Comment                                                                                     |
|-------|---------|------|----------|---------------------------------------------------------------------------------------------|
| 1     | Closed  |      |          |                                                                                             |
| 2     | SynSent | SYN  | SYN,ACK  | The client is in "SynSent" state while waiting for SYN,ACK after a SYN sent for the server. |
| 3     | Estblsh | ACK  |          | Client received the SYN,ACK and sent the ACK. Now the connection is established.            |

### Both after conection
