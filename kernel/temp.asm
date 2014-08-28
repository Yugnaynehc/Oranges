00000000  7F45              jg 0x47
00000002  4C                dec sp
00000003  46                inc si
00000004  0101              add [bx+di],ax
00000006  0100              add [bx+si],ax
00000008  0000              add [bx+si],al
0000000A  0000              add [bx+si],al
0000000C  0000              add [bx+si],al
0000000E  0000              add [bx+si],al
00000010  0100              add [bx+si],ax
00000012  0300              add ax,[bx+si]
00000014  0100              add [bx+si],ax
00000016  0000              add [bx+si],al
00000018  0000              add [bx+si],al
0000001A  0000              add [bx+si],al
0000001C  0000              add [bx+si],al
0000001E  0000              add [bx+si],al
00000020  40                inc ax
00000021  0000              add [bx+si],al
00000023  0000              add [bx+si],al
00000025  0000              add [bx+si],al
00000027  0034              add [si],dh
00000029  0000              add [bx+si],al
0000002B  0000              add [bx+si],al
0000002D  0028              add [bx+si],ch
0000002F  0007              add [bx],al
00000031  0003              add [bp+di],al
00000033  0000              add [bx+si],al
00000035  0000              add [bx+si],al
00000037  0000              add [bx+si],al
00000039  0000              add [bx+si],al
0000003B  0000              add [bx+si],al
0000003D  0000              add [bx+si],al
0000003F  0000              add [bx+si],al
00000041  0000              add [bx+si],al
00000043  0000              add [bx+si],al
00000045  0000              add [bx+si],al
00000047  0000              add [bx+si],al
00000049  0000              add [bx+si],al
0000004B  0000              add [bx+si],al
0000004D  0000              add [bx+si],al
0000004F  0000              add [bx+si],al
00000051  0000              add [bx+si],al
00000053  0000              add [bx+si],al
00000055  0000              add [bx+si],al
00000057  0000              add [bx+si],al
00000059  0000              add [bx+si],al
0000005B  0000              add [bx+si],al
0000005D  0000              add [bx+si],al
0000005F  0000              add [bx+si],al
00000061  0000              add [bx+si],al
00000063  0000              add [bx+si],al
00000065  0000              add [bx+si],al
00000067  0001              add [bx+di],al
00000069  0000              add [bx+si],al
0000006B  0008              add [bx+si],cl
0000006D  0000              add [bx+si],al
0000006F  0003              add [bp+di],al
00000071  0000              add [bx+si],al
00000073  0000              add [bx+si],al
00000075  0000              add [bx+si],al
00000077  006001            add [bx+si+0x1],ah
0000007A  0000              add [bx+si],al
0000007C  0008              add [bx+si],cl
0000007E  0000              add [bx+si],al
00000080  0000              add [bx+si],al
00000082  0000              add [bx+si],al
00000084  0000              add [bx+si],al
00000086  0000              add [bx+si],al
00000088  0400              add al,0x0
0000008A  0000              add [bx+si],al
0000008C  0000              add [bx+si],al
0000008E  0000              add [bx+si],al
00000090  06                push es
00000091  0000              add [bx+si],al
00000093  0001              add [bx+di],al
00000095  0000              add [bx+si],al
00000097  00060000          add [0x0],al
0000009B  0000              add [bx+si],al
0000009D  0000              add [bx+si],al
0000009F  006001            add [bx+si+0x1],ah
000000A2  0000              add [bx+si],al
000000A4  98                cbw
000000A5  0100              add [bx+si],ax
000000A7  0000              add [bx+si],al
000000A9  0000              add [bx+si],al
000000AB  0000              add [bx+si],al
000000AD  0000              add [bx+si],al
000000AF  0010              add [bx+si],dl
000000B1  0000              add [bx+si],al
000000B3  0000              add [bx+si],al
000000B5  0000              add [bx+si],al
000000B7  000C              add [si],cl
000000B9  0000              add [bx+si],al
000000BB  0003              add [bp+di],al
000000BD  0000              add [bx+si],al
000000BF  0000              add [bx+si],al
000000C1  0000              add [bx+si],al
000000C3  0000              add [bx+si],al
000000C5  0000              add [bx+si],al
000000C7  0000              add [bx+si],al
000000C9  0300              add ax,[bx+si]
000000CB  0030              add [bx+si],dh
000000CD  0000              add [bx+si],al
000000CF  0000              add [bx+si],al
000000D1  0000              add [bx+si],al
000000D3  0000              add [bx+si],al
000000D5  0000              add [bx+si],al
000000D7  0001              add [bx+di],al
000000D9  0000              add [bx+si],al
000000DB  0000              add [bx+si],al
000000DD  0000              add [bx+si],al
000000DF  00160000          add [0x0],dl
000000E3  0002              add [bp+si],al
000000E5  0000              add [bx+si],al
000000E7  0000              add [bx+si],al
000000E9  0000              add [bx+si],al
000000EB  0000              add [bx+si],al
000000ED  0000              add [bx+si],al
000000EF  0030              add [bx+si],dh
000000F1  0300              add ax,[bx+si]
000000F3  0000              add [bx+si],al
000000F5  0300              add ax,[bx+si]
000000F7  0005              add [di],al
000000F9  0000              add [bx+si],al
000000FB  0009              add [bx+di],cl
000000FD  0000              add [bx+si],al
000000FF  0004              add [si],al
00000101  0000              add [bx+si],al
00000103  0010              add [bx+si],dl
00000105  0000              add [bx+si],al
00000107  001E0000          add [0x0],bl
0000010B  0003              add [bp+di],al
0000010D  0000              add [bx+si],al
0000010F  0000              add [bx+si],al
00000111  0000              add [bx+si],al
00000113  0000              add [bx+si],al
00000115  0000              add [bx+si],al
00000117  0030              add [bx+si],dh
00000119  06                push es
0000011A  0000              add [bx+si],al
0000011C  F20100            repne add [bx+si],ax
0000011F  0000              add [bx+si],al
00000121  0000              add [bx+si],al
00000123  0000              add [bx+si],al
00000125  0000              add [bx+si],al
00000127  0001              add [bx+di],al
00000129  0000              add [bx+si],al
0000012B  0000              add [bx+si],al
0000012D  0000              add [bx+si],al
0000012F  00260000          add [0x0],ah
00000133  0009              add [bx+di],cl
00000135  0000              add [bx+si],al
00000137  0000              add [bx+si],al
00000139  0000              add [bx+si],al
0000013B  0000              add [bx+si],al
0000013D  0000              add [bx+si],al
0000013F  0030              add [bx+si],dh
00000141  0800              or [bx+si],al
00000143  00C0              add al,al
00000145  0000              add [bx+si],al
00000147  0004              add [si],al
00000149  0000              add [bx+si],al
0000014B  0002              add [bp+si],al
0000014D  0000              add [bx+si],al
0000014F  0004              add [si],al
00000151  0000              add [bx+si],al
00000153  0008              add [bx+si],cl
00000155  0000              add [bx+si],al
00000157  0000              add [bx+si],al
00000159  0000              add [bx+si],al
0000015B  0000              add [bx+si],al
0000015D  0000              add [bx+si],al
0000015F  00BC0008          add [si+0x800],bh
00000163  0000              add [bx+si],al
00000165  C7050000          mov word [di],0x0
00000169  0000              add [bx+si],al
0000016B  0000              add [bx+si],al
0000016D  0000              add [bx+si],al
0000016F  0F0105            sgdt [di]
00000172  0000              add [bx+si],al
00000174  0000              add [bx+si],al
00000176  E8FCFF            call word 0x175
00000179  FF                db 0xff
0000017A  FF0F              dec word [bx]
0000017C  0115              add [di],dx
0000017E  0000              add [bx+si],al
00000180  0000              add [bx+si],al
00000182  0F011D            lidt [di]
00000185  0000              add [bx+si],al
00000187  0000              add [bx+si],al
00000189  EA30000000        jmp word 0x0:0x30
0000018E  0800              or [bx+si],al
00000190  FB                sti
00000191  F4                hlt
00000192  90                nop
00000193  90                nop
00000194  90                nop
00000195  90                nop
00000196  90                nop
00000197  90                nop
00000198  90                nop
00000199  90                nop
0000019A  90                nop
0000019B  90                nop
0000019C  90                nop
0000019D  90                nop
0000019E  90                nop
0000019F  90                nop
000001A0  6A00              push byte +0x0
000001A2  E8FCFF            call word 0x1a1
000001A5  FF                db 0xff
000001A6  FF83C404          inc word [bp+di+0x4c4]
000001AA  F4                hlt
000001AB  90                nop
000001AC  90                nop
000001AD  90                nop
000001AE  90                nop
000001AF  90                nop
000001B0  6A01              push byte +0x1
000001B2  E8FCFF            call word 0x1b1
000001B5  FF                db 0xff
000001B6  FF83C404          inc word [bp+di+0x4c4]
000001BA  F4                hlt
000001BB  90                nop
000001BC  90                nop
000001BD  90                nop
000001BE  90                nop
000001BF  90                nop
000001C0  6A02              push byte +0x2
000001C2  E8FCFF            call word 0x1c1
000001C5  FF                db 0xff
000001C6  FF83C404          inc word [bp+di+0x4c4]
000001CA  F4                hlt
000001CB  90                nop
000001CC  90                nop
000001CD  90                nop
000001CE  90                nop
000001CF  90                nop
000001D0  6A03              push byte +0x3
000001D2  E8FCFF            call word 0x1d1
000001D5  FF                db 0xff
000001D6  FF83C404          inc word [bp+di+0x4c4]
000001DA  F4                hlt
000001DB  90                nop
000001DC  90                nop
000001DD  90                nop
000001DE  90                nop
000001DF  90                nop
000001E0  6A04              push byte +0x4
000001E2  E8FCFF            call word 0x1e1
000001E5  FF                db 0xff
000001E6  FF83C404          inc word [bp+di+0x4c4]
000001EA  F4                hlt
000001EB  90                nop
000001EC  90                nop
000001ED  90                nop
000001EE  90                nop
000001EF  90                nop
000001F0  6A05              push byte +0x5
000001F2  E8FCFF            call word 0x1f1
000001F5  FF                db 0xff
000001F6  FF83C404          inc word [bp+di+0x4c4]
000001FA  F4                hlt
000001FB  90                nop
000001FC  90                nop
000001FD  90                nop
000001FE  90                nop
000001FF  90                nop
00000200  6A06              push byte +0x6
00000202  E8FCFF            call word 0x201
00000205  FF                db 0xff
00000206  FF83C404          inc word [bp+di+0x4c4]
0000020A  F4                hlt
0000020B  90                nop
0000020C  90                nop
0000020D  90                nop
0000020E  90                nop
0000020F  90                nop
00000210  6A07              push byte +0x7
00000212  E8FCFF            call word 0x211
00000215  FF                db 0xff
00000216  FF83C404          inc word [bp+di+0x4c4]
0000021A  F4                hlt
0000021B  90                nop
0000021C  90                nop
0000021D  90                nop
0000021E  90                nop
0000021F  90                nop
00000220  6A08              push byte +0x8
00000222  E8FCFF            call word 0x221
00000225  FF                db 0xff
00000226  FF83C404          inc word [bp+di+0x4c4]
0000022A  F4                hlt
0000022B  90                nop
0000022C  90                nop
0000022D  90                nop
0000022E  90                nop
0000022F  90                nop
00000230  6A09              push byte +0x9
00000232  E8FCFF            call word 0x231
00000235  FF                db 0xff
00000236  FF83C404          inc word [bp+di+0x4c4]
0000023A  F4                hlt
0000023B  90                nop
0000023C  90                nop
0000023D  90                nop
0000023E  90                nop
0000023F  90                nop
00000240  6A0A              push byte +0xa
00000242  E8FCFF            call word 0x241
00000245  FF                db 0xff
00000246  FF83C404          inc word [bp+di+0x4c4]
0000024A  F4                hlt
0000024B  90                nop
0000024C  90                nop
0000024D  90                nop
0000024E  90                nop
0000024F  90                nop
00000250  6A0B              push byte +0xb
00000252  E8FCFF            call word 0x251
00000255  FF                db 0xff
00000256  FF83C404          inc word [bp+di+0x4c4]
0000025A  F4                hlt
0000025B  90                nop
0000025C  90                nop
0000025D  90                nop
0000025E  90                nop
0000025F  90                nop
00000260  6A0C              push byte +0xc
00000262  E8FCFF            call word 0x261
00000265  FF                db 0xff
00000266  FF83C404          inc word [bp+di+0x4c4]
0000026A  F4                hlt
0000026B  90                nop
0000026C  90                nop
0000026D  90                nop
0000026E  90                nop
0000026F  90                nop
00000270  6A0D              push byte +0xd
00000272  E8FCFF            call word 0x271
00000275  FF                db 0xff
00000276  FF83C404          inc word [bp+di+0x4c4]
0000027A  F4                hlt
0000027B  90                nop
0000027C  90                nop
0000027D  90                nop
0000027E  90                nop
0000027F  90                nop
00000280  6A0E              push byte +0xe
00000282  E8FCFF            call word 0x281
00000285  FF                db 0xff
00000286  FF83C404          inc word [bp+di+0x4c4]
0000028A  F4                hlt
0000028B  90                nop
0000028C  90                nop
0000028D  90                nop
0000028E  90                nop
0000028F  90                nop
00000290  6A0F              push byte +0xf
00000292  E8FCFF            call word 0x291
00000295  FF                db 0xff
00000296  FF83C404          inc word [bp+di+0x4c4]
0000029A  F4                hlt
0000029B  6AFF              push byte -0x1
0000029D  6A00              push byte +0x0
0000029F  EB4E              jmp short 0x2ef
000002A1  6AFF              push byte -0x1
000002A3  6A01              push byte +0x1
000002A5  EB48              jmp short 0x2ef
000002A7  6AFF              push byte -0x1
000002A9  6A02              push byte +0x2
000002AB  EB42              jmp short 0x2ef
000002AD  6AFF              push byte -0x1
000002AF  6A03              push byte +0x3
000002B1  EB3C              jmp short 0x2ef
000002B3  6AFF              push byte -0x1
000002B5  6A04              push byte +0x4
000002B7  EB36              jmp short 0x2ef
000002B9  6AFF              push byte -0x1
000002BB  6A05              push byte +0x5
000002BD  EB30              jmp short 0x2ef
000002BF  6AFF              push byte -0x1
000002C1  6A06              push byte +0x6
000002C3  EB2A              jmp short 0x2ef
000002C5  6AFF              push byte -0x1
000002C7  6A07              push byte +0x7
000002C9  EB24              jmp short 0x2ef
000002CB  6A08              push byte +0x8
000002CD  EB20              jmp short 0x2ef
000002CF  6AFF              push byte -0x1
000002D1  6A09              push byte +0x9
000002D3  EB1A              jmp short 0x2ef
000002D5  6A0A              push byte +0xa
000002D7  EB16              jmp short 0x2ef
000002D9  6A0B              push byte +0xb
000002DB  EB12              jmp short 0x2ef
000002DD  6A0C              push byte +0xc
000002DF  EB0E              jmp short 0x2ef
000002E1  6A0D              push byte +0xd
000002E3  EB0A              jmp short 0x2ef
000002E5  6A0E              push byte +0xe
000002E7  EB06              jmp short 0x2ef
000002E9  6AFF              push byte -0x1
000002EB  6A10              push byte +0x10
000002ED  EB00              jmp short 0x2ef
000002EF  E8FCFF            call word 0x2ee
000002F2  FF                db 0xff
000002F3  FF83C408          inc word [bp+di+0x8c4]
000002F7  F4                hlt
000002F8  0000              add [bx+si],al
000002FA  0000              add [bx+si],al
000002FC  0000              add [bx+si],al
000002FE  0000              add [bx+si],al
00000300  002E6273          add [0x7362],ch
00000304  7300              jnc 0x306
00000306  2E7465            cs jz 0x36e
00000309  7874              js 0x37f
0000030B  002E7368          add [0x6873],ch
0000030F  7374              jnc 0x385
00000311  7274              jc 0x387
00000313  61                popaw
00000314  6200              bound ax,[bx+si]
00000316  2E7379            cs jnc 0x392
00000319  6D                insw
0000031A  7461              jz 0x37d
0000031C  6200              bound ax,[bx+si]
0000031E  2E7374            cs jnc 0x395
00000321  7274              jc 0x397
00000323  61                popaw
00000324  6200              bound ax,[bx+si]
00000326  2E7265            cs jc 0x38e
00000329  6C                insb
0000032A  2E7465            cs jz 0x392
0000032D  7874              js 0x3a3
0000032F  0000              add [bx+si],al
00000331  0000              add [bx+si],al
00000333  0000              add [bx+si],al
00000335  0000              add [bx+si],al
00000337  0000              add [bx+si],al
00000339  0000              add [bx+si],al
0000033B  0000              add [bx+si],al
0000033D  0000              add [bx+si],al
0000033F  0001              add [bx+di],al
00000341  0000              add [bx+si],al
00000343  0000              add [bx+si],al
00000345  0000              add [bx+si],al
00000347  0000              add [bx+si],al
00000349  0000              add [bx+si],al
0000034B  0004              add [si],al
0000034D  00F1              add cl,dh
0000034F  FF00              inc word [bx+si]
00000351  0000              add [bx+si],al
00000353  0000              add [bx+si],al
00000355  0000              add [bx+si],al
00000357  0000              add [bx+si],al
00000359  0000              add [bx+si],al
0000035B  0003              add [bp+di],al
0000035D  0001              add [bx+di],al
0000035F  0000              add [bx+si],al
00000361  0000              add [bx+si],al
00000363  0000              add [bx+si],al
00000365  0000              add [bx+si],al
00000367  0000              add [bx+si],al
00000369  0000              add [bx+si],al
0000036B  0003              add [bp+di],al
0000036D  0002              add [bp+si],al
0000036F  004C00            add [si+0x0],cl
00000372  0000              add [bx+si],al
00000374  0800              or [bx+si],al
00000376  0000              add [bx+si],al
00000378  0000              add [bx+si],al
0000037A  0000              add [bx+si],al
0000037C  0000              add [bx+si],al
0000037E  F1                int1
0000037F  FF5F00            call word far [bx+0x0]
00000382  0000              add [bx+si],al
00000384  0000              add [bx+si],al
00000386  0000              add [bx+si],al
00000388  0000              add [bx+si],al
0000038A  0000              add [bx+si],al
0000038C  0000              add [bx+si],al
0000038E  0100              add [bx+si],ax
00000390  6A00              push byte +0x0
00000392  0000              add [bx+si],al
00000394  0008              add [bx+si],cl
00000396  0000              add [bx+si],al
00000398  0000              add [bx+si],al
0000039A  0000              add [bx+si],al
0000039C  0000              add [bx+si],al
0000039E  0100              add [bx+si],ax
000003A0  7A00              jpe 0x3a2
000003A2  0000              add [bx+si],al
000003A4  3000              xor [bx+si],al
000003A6  0000              add [bx+si],al
000003A8  0000              add [bx+si],al
000003AA  0000              add [bx+si],al
000003AC  0000              add [bx+si],al
000003AE  0200              add al,[bx+si]
000003B0  E80100            call word 0x3b4
000003B3  008F0100          add [bx+0x1],cl
000003B7  0000              add [bx+si],al
000003B9  0000              add [bx+si],al
000003BB  0000              add [bx+si],al
000003BD  0002              add [bp+si],al
000003BF  000C              add [si],cl
000003C1  0000              add [bx+si],al
000003C3  0000              add [bx+si],al
000003C5  0000              add [bx+si],al
000003C7  0000              add [bx+si],al
000003C9  0000              add [bx+si],al
000003CB  0010              add [bx+si],dl
000003CD  0000              add [bx+si],al
000003CF  0013              add [bp+di],dl
000003D1  0000              add [bx+si],al
000003D3  0000              add [bx+si],al
000003D5  0000              add [bx+si],al
000003D7  0000              add [bx+si],al
000003D9  0000              add [bx+si],al
000003DB  0010              add [bx+si],dl
000003DD  0000              add [bx+si],al
000003DF  0025              add [di],ah
000003E1  0000              add [bx+si],al
000003E3  0000              add [bx+si],al
000003E5  0000              add [bx+si],al
000003E7  0000              add [bx+si],al
000003E9  0000              add [bx+si],al
000003EB  0010              add [bx+si],dl
000003ED  0000              add [bx+si],al
000003EF  0033              add [bp+di],dh
000003F1  0000              add [bx+si],al
000003F3  0000              add [bx+si],al
000003F5  0000              add [bx+si],al
000003F7  0000              add [bx+si],al
000003F9  0000              add [bx+si],al
000003FB  0010              add [bx+si],dl
000003FD  0000              add [bx+si],al
000003FF  003B              add [bp+di],bh
00000401  0000              add [bx+si],al
00000403  0000              add [bx+si],al
00000405  0000              add [bx+si],al
00000407  0000              add [bx+si],al
00000409  0000              add [bx+si],al
0000040B  0010              add [bx+si],dl
0000040D  0000              add [bx+si],al
0000040F  004300            add [bp+di+0x0],al
00000412  0000              add [bx+si],al
00000414  0000              add [bx+si],al
00000416  0000              add [bx+si],al
00000418  0000              add [bx+si],al
0000041A  0000              add [bx+si],al
0000041C  1000              adc [bx+si],al
0000041E  0000              add [bx+si],al
00000420  7300              jnc 0x422
00000422  0000              add [bx+si],al
00000424  0000              add [bx+si],al
00000426  0000              add [bx+si],al
00000428  0000              add [bx+si],al
0000042A  0000              add [bx+si],al
0000042C  1000              adc [bx+si],al
0000042E  0200              add al,[bx+si]
00000430  81000000          add word [bx+si],0x0
00000434  40                inc ax
00000435  0000              add [bx+si],al
00000437  0000              add [bx+si],al
00000439  0000              add [bx+si],al
0000043B  0010              add [bx+si],dl
0000043D  0002              add [bp+si],al
0000043F  00890000          add [bx+di+0x0],cl
00000443  005000            add [bx+si+0x0],dl
00000446  0000              add [bx+si],al
00000448  0000              add [bx+si],al
0000044A  0000              add [bx+si],al
0000044C  1000              adc [bx+si],al
0000044E  0200              add al,[bx+si]
00000450  91                xchg ax,cx
00000451  0000              add [bx+si],al
00000453  006000            add [bx+si+0x0],ah
00000456  0000              add [bx+si],al
00000458  0000              add [bx+si],al
0000045A  0000              add [bx+si],al
0000045C  1000              adc [bx+si],al
0000045E  0200              add al,[bx+si]
00000460  99                cwd
00000461  0000              add [bx+si],al
00000463  007000            add [bx+si+0x0],dh
00000466  0000              add [bx+si],al
00000468  0000              add [bx+si],al
0000046A  0000              add [bx+si],al
0000046C  1000              adc [bx+si],al
0000046E  0200              add al,[bx+si]
00000470  A10000            mov ax,[0x0]
00000473  00800000          add [bx+si+0x0],al
00000477  0000              add [bx+si],al
00000479  0000              add [bx+si],al
0000047B  0010              add [bx+si],dl
0000047D  0002              add [bp+si],al
0000047F  00A90000          add [bx+di+0x0],ch
00000483  00900000          add [bx+si+0x0],dl
00000487  0000              add [bx+si],al
00000489  0000              add [bx+si],al
0000048B  0010              add [bx+si],dl
0000048D  0002              add [bp+si],al
0000048F  00B10000          add [bx+di+0x0],dh
00000493  00A00000          add [bx+si+0x0],ah
00000497  0000              add [bx+si],al
00000499  0000              add [bx+si],al
0000049B  0010              add [bx+si],dl
0000049D  0002              add [bp+si],al
0000049F  00B90000          add [bx+di+0x0],bh
000004A3  00B00000          add [bx+si+0x0],dh
000004A7  0000              add [bx+si],al
000004A9  0000              add [bx+si],al
000004AB  0010              add [bx+si],dl
000004AD  0002              add [bp+si],al
000004AF  00C1              add cl,al
000004B1  0000              add [bx+si],al
000004B3  00C0              add al,al
000004B5  0000              add [bx+si],al
000004B7  0000              add [bx+si],al
000004B9  0000              add [bx+si],al
000004BB  0010              add [bx+si],dl
000004BD  0002              add [bp+si],al
000004BF  00C9              add cl,cl
000004C1  0000              add [bx+si],al
000004C3  00D0              add al,dl
000004C5  0000              add [bx+si],al
000004C7  0000              add [bx+si],al
000004C9  0000              add [bx+si],al
000004CB  0010              add [bx+si],dl
000004CD  0002              add [bp+si],al
000004CF  00D1              add cl,dl
000004D1  0000              add [bx+si],al
000004D3  00E0              add al,ah
000004D5  0000              add [bx+si],al
000004D7  0000              add [bx+si],al
000004D9  0000              add [bx+si],al
000004DB  0010              add [bx+si],dl
000004DD  0002              add [bp+si],al
000004DF  00D9              add cl,bl
000004E1  0000              add [bx+si],al
000004E3  00F0              add al,dh
000004E5  0000              add [bx+si],al
000004E7  0000              add [bx+si],al
000004E9  0000              add [bx+si],al
000004EB  0010              add [bx+si],dl
000004ED  0002              add [bp+si],al
000004EF  00E1              add cl,ah
000004F1  0000              add [bx+si],al
000004F3  0000              add [bx+si],al
000004F5  0100              add [bx+si],ax
000004F7  0000              add [bx+si],al
000004F9  0000              add [bx+si],al
000004FB  0010              add [bx+si],dl
000004FD  0002              add [bp+si],al
000004FF  00E9              add cl,ch
00000501  0000              add [bx+si],al
00000503  0010              add [bx+si],dl
00000505  0100              add [bx+si],ax
00000507  0000              add [bx+si],al
00000509  0000              add [bx+si],al
0000050B  0010              add [bx+si],dl
0000050D  0002              add [bp+si],al
0000050F  00F1              add cl,dh
00000511  0000              add [bx+si],al
00000513  0020              add [bx+si],ah
00000515  0100              add [bx+si],ax
00000517  0000              add [bx+si],al
00000519  0000              add [bx+si],al
0000051B  0010              add [bx+si],dl
0000051D  0002              add [bp+si],al
0000051F  00F9              add cl,bh
00000521  0000              add [bx+si],al
00000523  0030              add [bx+si],dh
00000525  0100              add [bx+si],ax
00000527  0000              add [bx+si],al
00000529  0000              add [bx+si],al
0000052B  0010              add [bx+si],dl
0000052D  0002              add [bp+si],al
0000052F  0001              add [bx+di],al
00000531  0100              add [bx+si],ax
00000533  003B              add [bp+di],bh
00000535  0100              add [bx+si],ax
00000537  0000              add [bx+si],al
00000539  0000              add [bx+si],al
0000053B  0010              add [bx+si],dl
0000053D  0002              add [bp+si],al
0000053F  000E0100          add [0x1],cl
00000543  004101            add [bx+di+0x1],al
00000546  0000              add [bx+si],al
00000548  0000              add [bx+si],al
0000054A  0000              add [bx+si],al
0000054C  1000              adc [bx+si],al
0000054E  0200              add al,[bx+si]
00000550  2401              and al,0x1
00000552  0000              add [bx+si],al
00000554  47                inc di
00000555  0100              add [bx+si],ax
00000557  0000              add [bx+si],al
00000559  0000              add [bx+si],al
0000055B  0010              add [bx+si],dl
0000055D  0002              add [bp+si],al
0000055F  0028              add [bx+si],ch
00000561  0100              add [bx+si],ax
00000563  004D01            add [di+0x1],cl
00000566  0000              add [bx+si],al
00000568  0000              add [bx+si],al
0000056A  0000              add [bx+si],al
0000056C  1000              adc [bx+si],al
0000056E  0200              add al,[bx+si]
00000570  3D0100            cmp ax,0x1
00000573  005301            add [bp+di+0x1],dl
00000576  0000              add [bx+si],al
00000578  0000              add [bx+si],al
0000057A  0000              add [bx+si],al
0000057C  1000              adc [bx+si],al
0000057E  0200              add al,[bx+si]
00000580  46                inc si
00000581  0100              add [bx+si],ax
00000583  005901            add [bx+di+0x1],bl
00000586  0000              add [bx+si],al
00000588  0000              add [bx+si],al
0000058A  0000              add [bx+si],al
0000058C  1000              adc [bx+si],al
0000058E  0200              add al,[bx+si]
00000590  53                push bx
00000591  0100              add [bx+si],ax
00000593  005F01            add [bx+0x1],bl
00000596  0000              add [bx+si],al
00000598  0000              add [bx+si],al
0000059A  0000              add [bx+si],al
0000059C  1000              adc [bx+si],al
0000059E  0200              add al,[bx+si]
000005A0  60                pushaw
000005A1  0100              add [bx+si],ax
000005A3  006501            add [di+0x1],ah
000005A6  0000              add [bx+si],al
000005A8  0000              add [bx+si],al
000005AA  0000              add [bx+si],al
000005AC  1000              adc [bx+si],al
000005AE  0200              add al,[bx+si]
000005B0  7301              jnc 0x5b3
000005B2  0000              add [bx+si],al
000005B4  6B0100            imul ax,[bx+di],byte +0x0
000005B7  0000              add [bx+si],al
000005B9  0000              add [bx+si],al
000005BB  0010              add [bx+si],dl
000005BD  0002              add [bp+si],al
000005BF  00800100          add [bx+si+0x1],al
000005C3  006F01            add [bx+0x1],ch
000005C6  0000              add [bx+si],al
000005C8  0000              add [bx+si],al
000005CA  0000              add [bx+si],al
000005CC  1000              adc [bx+si],al
000005CE  0200              add al,[bx+si]
000005D0  91                xchg ax,cx
000005D1  0100              add [bx+si],ax
000005D3  007501            add [di+0x1],dh
000005D6  0000              add [bx+si],al
000005D8  0000              add [bx+si],al
000005DA  0000              add [bx+si],al
000005DC  1000              adc [bx+si],al
000005DE  0200              add al,[bx+si]
000005E0  9B0100            wait add [bx+si],ax
000005E3  007901            add [bx+di+0x1],bh
000005E6  0000              add [bx+si],al
000005E8  0000              add [bx+si],al
000005EA  0000              add [bx+si],al
000005EC  1000              adc [bx+si],al
000005EE  0200              add al,[bx+si]
000005F0  AF                scasw
000005F1  0100              add [bx+si],ax
000005F3  007D01            add [di+0x1],bh
000005F6  0000              add [bx+si],al
000005F8  0000              add [bx+si],al
000005FA  0000              add [bx+si],al
000005FC  1000              adc [bx+si],al
000005FE  0200              add al,[bx+si]
00000600  BF0100            mov di,0x1
00000603  00810100          add [bx+di+0x1],al
00000607  0000              add [bx+si],al
00000609  0000              add [bx+si],al
0000060B  0010              add [bx+si],dl
0000060D  0002              add [bp+si],al
0000060F  00D2              add dl,dl
00000611  0100              add [bx+si],ax
00000613  00850100          add [di+0x1],al
00000617  0000              add [bx+si],al
00000619  0000              add [bx+si],al
0000061B  0010              add [bx+si],dl
0000061D  0002              add [bp+si],al
0000061F  00DD              add ch,bl
00000621  0100              add [bx+si],ax
00000623  00890100          add [bx+di+0x1],cl
00000627  0000              add [bx+si],al
00000629  0000              add [bx+si],al
0000062B  0010              add [bx+si],dl
0000062D  0002              add [bp+si],al
0000062F  0000              add [bx+si],al
00000631  6B65726E          imul sp,[di+0x72],byte +0x6e
00000635  656C              gs insb
00000637  2E61              cs popaw
00000639  736D              jnc 0x6a8
0000063B  006373            add [bp+di+0x73],ah
0000063E  7461              jz 0x6a1
00000640  7274              jc 0x6b6
00000642  006578            add [di+0x78],ah
00000645  636570            arpl [di+0x70],sp
00000648  7469              jz 0x6b3
0000064A  6F                outsw
0000064B  6E                outsb
0000064C  5F                pop di
0000064D  68616E            push word 0x6e61
00000650  646C              fs insb
00000652  657200            gs jc 0x655
00000655  7375              jnc 0x6cc
00000657  7075              jo 0x6ce
00000659  7269              jc 0x6c4
0000065B  6F                outsw
0000065C  7573              jnz 0x6d1
0000065E  5F                pop di
0000065F  6972710067        imul si,[bp+si+0x71],word 0x6700
00000664  64745F            fs jz 0x6c6
00000667  7074              jo 0x6dd
00000669  7200              jc 0x66b
0000066B  6964745F70        imul sp,[si+0x74],word 0x705f
00000670  7472              jz 0x6e4
00000672  006469            add [si+0x69],ah
00000675  7370              jnc 0x6e7
00000677  5F                pop di
00000678  706F              jo 0x6e9
0000067A  7300              jnc 0x67c
0000067C  53                push bx
0000067D  45                inc bp
0000067E  4C                dec sp
0000067F  45                inc bp
00000680  43                inc bx
00000681  54                push sp
00000682  4F                dec di
00000683  52                push dx
00000684  5F                pop di
00000685  4B                dec bx
00000686  45                inc bp
00000687  52                push dx
00000688  4E                dec si
00000689  45                inc bp
0000068A  4C                dec sp
0000068B  5F                pop di
0000068C  43                inc bx
0000068D  53                push bx
0000068E  005374            add [bp+di+0x74],dl
00000691  61                popaw
00000692  636B53            arpl [bp+di+0x53],bp
00000695  7061              jo 0x6f8
00000697  636500            arpl [di+0x0],sp
0000069A  53                push bx
0000069B  7461              jz 0x6fe
0000069D  636B54            arpl [bp+di+0x54],bp
000006A0  6F                outsw
000006A1  7000              jo 0x6a3
000006A3  5F                pop di
000006A4  7374              jnc 0x71a
000006A6  61                popaw
000006A7  7274              jc 0x71d
000006A9  006373            add [bp+di+0x73],ah
000006AC  696E697400        imul bp,[bp+0x69],word 0x74
000006B1  687769            push word 0x6977
000006B4  6E                outsb
000006B5  7430              jz 0x6e7
000006B7  3000              xor [bx+si],al
000006B9  687769            push word 0x6977
000006BC  6E                outsb
000006BD  7430              jz 0x6ef
000006BF  3100              xor [bx+si],ax
000006C1  687769            push word 0x6977
000006C4  6E                outsb
000006C5  7430              jz 0x6f7
000006C7  3200              xor al,[bx+si]
000006C9  687769            push word 0x6977
000006CC  6E                outsb
000006CD  7430              jz 0x6ff
000006CF  3300              xor ax,[bx+si]
000006D1  687769            push word 0x6977
000006D4  6E                outsb
000006D5  7430              jz 0x707
000006D7  3400              xor al,0x0
000006D9  687769            push word 0x6977
000006DC  6E                outsb
000006DD  7430              jz 0x70f
000006DF  350068            xor ax,0x6800
000006E2  7769              ja 0x74d
000006E4  6E                outsb
000006E5  7430              jz 0x717
000006E7  36006877          add [ss:bx+si+0x77],ch
000006EB  696E743037        imul bp,[bp+0x74],word 0x3730
000006F0  006877            add [bx+si+0x77],ch
000006F3  696E743038        imul bp,[bp+0x74],word 0x3830
000006F8  006877            add [bx+si+0x77],ch
000006FB  696E743039        imul bp,[bp+0x74],word 0x3930
00000700  006877            add [bx+si+0x77],ch
00000703  696E743130        imul bp,[bp+0x74],word 0x3031
00000708  006877            add [bx+si+0x77],ch
0000070B  696E743131        imul bp,[bp+0x74],word 0x3131
00000710  006877            add [bx+si+0x77],ch
00000713  696E743132        imul bp,[bp+0x74],word 0x3231
00000718  006877            add [bx+si+0x77],ch
0000071B  696E743133        imul bp,[bp+0x74],word 0x3331
00000720  006877            add [bx+si+0x77],ch
00000723  696E743134        imul bp,[bp+0x74],word 0x3431
00000728  006877            add [bx+si+0x77],ch
0000072B  696E743135        imul bp,[bp+0x74],word 0x3531
00000730  006469            add [si+0x69],ah
00000733  7669              jna 0x79e
00000735  64655F            gs pop di
00000738  657272            gs jc 0x7ad
0000073B  6F                outsw
0000073C  7200              jc 0x73e
0000073E  7369              jnc 0x7a9
00000740  6E                outsb
00000741  676C              a32 insb
00000743  655F              gs pop di
00000745  7374              jnc 0x7bb
00000747  65705F            gs jo 0x7a9
0000074A  657863            gs js 0x7b0
0000074D  657074            gs jo 0x7c4
00000750  696F6E006E        imul bp,[bx+0x6e],word 0x6e00
00000755  6D                insw
00000756  69006272          imul ax,[bx+si],word 0x7262
0000075A  6561              gs popaw
0000075C  6B706F69          imul si,[bx+si+0x6f],byte +0x69
00000760  6E                outsb
00000761  745F              jz 0x7c2
00000763  657863            gs js 0x7c9
00000766  657074            gs jo 0x7dd
00000769  696F6E006F        imul bp,[bx+0x6e],word 0x6f00
0000076E  7665              jna 0x7d5
00000770  7266              jc 0x7d8
00000772  6C                insb
00000773  6F                outsw
00000774  7700              ja 0x776
00000776  626F75            bound bp,[bx+0x75]
00000779  6E                outsb
0000077A  64735F            fs jnc 0x7dc
0000077D  636865            arpl [bx+si+0x65],bp
00000780  636B00            arpl [bp+di+0x0],bp
00000783  696E76616C        imul bp,[bp+0x76],word 0x6c61
00000788  5F                pop di
00000789  6F                outsw
0000078A  7063              jo 0x7ef
0000078C  6F                outsw
0000078D  646500636F        add [gs:bp+di+0x6f],ah
00000792  7072              jo 0x806
00000794  5F                pop di
00000795  6E                outsb
00000796  6F                outsw
00000797  745F              jz 0x7f8
00000799  61                popaw
0000079A  7661              jna 0x7fd
0000079C  696C61626C        imul bp,[si+0x61],word 0x6c62
000007A1  6500646F          add [gs:si+0x6f],ah
000007A5  7562              jnz 0x809
000007A7  6C                insb
000007A8  655F              gs pop di
000007AA  6661              popad
000007AC  756C              jnz 0x81a
000007AE  7400              jz 0x7b0
000007B0  636F70            arpl [bx+0x70],bp
000007B3  725F              jc 0x814
000007B5  7365              jnc 0x81c
000007B7  675F              a32 pop di
000007B9  6F                outsw
000007BA  7665              jna 0x821
000007BC  7272              jc 0x830
000007BE  756E              jnz 0x82e
000007C0  00696E            add [bx+di+0x6e],ch
000007C3  7661              jna 0x826
000007C5  6C                insb
000007C6  5F                pop di
000007C7  7473              jz 0x83c
000007C9  7300              jnc 0x7cb
000007CB  7365              jnc 0x832
000007CD  676D              a32 insw
000007CF  656E              gs outsb
000007D1  745F              jz 0x832
000007D3  6E                outsb
000007D4  6F                outsw
000007D5  745F              jz 0x836
000007D7  7072              jo 0x84b
000007D9  657365            gs jnc 0x841
000007DC  6E                outsb
000007DD  7400              jz 0x7df
000007DF  7374              jnc 0x855
000007E1  61                popaw
000007E2  636B5F            arpl [bp+di+0x5f],bp
000007E5  657863            gs js 0x84b
000007E8  657074            gs jo 0x85f
000007EB  696F6E0067        imul bp,[bx+0x6e],word 0x6700
000007F0  656E              gs outsb
000007F2  657261            gs jc 0x856
000007F5  6C                insb
000007F6  5F                pop di
000007F7  7072              jo 0x86b
000007F9  6F                outsw
000007FA  7465              jz 0x861
000007FC  637469            arpl [si+0x69],si
000007FF  6F                outsw
00000800  6E                outsb
00000801  007061            add [bx+si+0x61],dh
00000804  67655F            gs a32 pop di
00000807  6661              popad
00000809  756C              jnz 0x877
0000080B  7400              jz 0x80d
0000080D  636F70            arpl [bx+0x70],bp
00000810  725F              jc 0x871
00000812  657272            gs jc 0x887
00000815  6F                outsw
00000816  7200              jc 0x818
00000818  657863            gs js 0x87e
0000081B  657074            gs jo 0x892
0000081E  696F6E0000        imul bp,[bx+0x6e],word 0x0
00000823  0000              add [bx+si],al
00000825  0000              add [bx+si],al
00000827  0000              add [bx+si],al
00000829  0000              add [bx+si],al
0000082B  0000              add [bx+si],al
0000082D  0000              add [bx+si],al
0000082F  0001              add [bx+di],al
00000831  0000              add [bx+si],al
00000833  0001              add [bx+di],al
00000835  0200              add al,[bx+si]
00000837  0007              add [bx],al
00000839  0000              add [bx+si],al
0000083B  0001              add [bx+di],al
0000083D  0E                push cs
0000083E  0000              add [bx+si],al
00000840  1200              adc al,[bx+si]
00000842  0000              add [bx+si],al
00000844  010C              add [si],cx
00000846  0000              add [bx+si],al
00000848  17                pop ss
00000849  0000              add [bx+si],al
0000084B  0002              add [bp+si],al
0000084D  0900              or [bx+si],ax
0000084F  001E0000          add [0x0],bl
00000853  0001              add [bx+di],al
00000855  0C00              or al,0x0
00000857  0025              add [di],ah
00000859  0000              add [bx+si],al
0000085B  0001              add [bx+di],al
0000085D  0D0000            or ax,0x0
00000860  2A00              sub al,[bx+si]
00000862  0000              add [bx+si],al
00000864  0103              add [bp+di],ax
00000866  0000              add [bx+si],al
00000868  43                inc bx
00000869  0000              add [bx+si],al
0000086B  0002              add [bp+si],al
0000086D  0B00              or ax,[bx+si]
0000086F  005300            add [bp+di+0x0],dl
00000872  0000              add [bx+si],al
00000874  020B              add cl,[bp+di]
00000876  0000              add [bx+si],al
00000878  6300              arpl [bx+si],ax
0000087A  0000              add [bx+si],al
0000087C  020B              add cl,[bp+di]
0000087E  0000              add [bx+si],al
00000880  7300              jnc 0x882
00000882  0000              add [bx+si],al
00000884  020B              add cl,[bp+di]
00000886  0000              add [bx+si],al
00000888  830000            add word [bx+si],byte +0x0
0000088B  0002              add [bp+si],al
0000088D  0B00              or ax,[bx+si]
0000088F  00930000          add [bp+di+0x0],dl
00000893  0002              add [bp+si],al
00000895  0B00              or ax,[bx+si]
00000897  00A30000          add [bp+di+0x0],ah
0000089B  0002              add [bp+si],al
0000089D  0B00              or ax,[bx+si]
0000089F  00B30000          add [bp+di+0x0],dh
000008A3  0002              add [bp+si],al
000008A5  0B00              or ax,[bx+si]
000008A7  00C3              add bl,al
000008A9  0000              add [bx+si],al
000008AB  0002              add [bp+si],al
000008AD  0B00              or ax,[bx+si]
000008AF  00D3              add bl,dl
000008B1  0000              add [bx+si],al
000008B3  0002              add [bp+si],al
000008B5  0B00              or ax,[bx+si]
000008B7  00E3              add bl,ah
000008B9  0000              add [bx+si],al
000008BB  0002              add [bp+si],al
000008BD  0B00              or ax,[bx+si]
000008BF  00F3              add bl,dh
000008C1  0000              add [bx+si],al
000008C3  0002              add [bp+si],al
000008C5  0B00              or ax,[bx+si]
000008C7  0003              add [bp+di],al
000008C9  0100              add [bx+si],ax
000008CB  0002              add [bp+si],al
000008CD  0B00              or ax,[bx+si]
000008CF  0013              add [bp+di],dl
000008D1  0100              add [bx+si],ax
000008D3  0002              add [bp+si],al
000008D5  0B00              or ax,[bx+si]
000008D7  0023              add [bp+di],ah
000008D9  0100              add [bx+si],ax
000008DB  0002              add [bp+si],al
000008DD  0B00              or ax,[bx+si]
000008DF  0033              add [bp+di],dh
000008E1  0100              add [bx+si],ax
000008E3  0002              add [bp+si],al
000008E5  0B00              or ax,[bx+si]
000008E7  00900100          add [bx+si+0x1],dl
000008EB  0002              add [bp+si],al
000008ED  0A00              or al,[bx+si]
000008EF  00                db 0x00
