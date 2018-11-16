# QCMMKVTest
根据网友的mmkv包，自己pod了Protobuf,用一个反向传值，做了测试，写了一个demo

拿包地址https://github.com/alexlee002/mmkv

自己帮原包主人做了测试修改，可以直接用此demo中的包，已将问题告诉原作者并修改，之后自己也会进一步完善

# 微信官方文档
地址：https://github.com/Tencent/MMKV/blob/master/readme_cn.md

用微信的官方文档，我是通过ios静态库的方式加载的，但是有一个问题
Other Linker Flags 除了添加 -all_load 和 -ObjC，必要的时候还需要添加-lc++
